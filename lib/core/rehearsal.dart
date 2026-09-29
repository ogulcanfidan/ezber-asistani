import 'dart:async';

import 'package:flutter/foundation.dart';

import 'emotion.dart';
import 'hints.dart';
import 'line_check.dart';
import 'models.dart';
import 'speech_pages.dart';
import 'voice_activity.dart';

enum RehearsalMode {
  /// Her şey sesli okunur, siz dinlersiniz.
  listen,

  /// Sıra size gelince durur; hazır olunca "Devam"a basarsınız.
  waitForMe,

  /// Size süre tanınır, ardından repliğiniz doğrulama için okunur.
  checkMe,

  /// Size süre tanınır, repliğiniz okunmadan devam edilir.
  runThrough,

  /// Mikrofon dinlenir: repliğinizi söyleyip susunca devam edilir, takılırsanız
  /// suflör yardım eder. Telefona dokunmak gerekmez.
  handsFree,

  /// Üst üste ekleyerek ezber: 1. satır, sonra 1–2, sonra 1–3… Her yeni
  /// satır önce size okunur, sonra baştan söylersiniz. Şiir/kısa metin için.
  buildUp,

  /// Sunum: sayfa sayfa (slayt slayt) süre tutar. "Sayfa 1" der, süre dolunca
  /// "Süre doldu. Sayfa 2" diye geçer; kullanıcı erken bitirip geçebilir.
  pages,

  /// Ezberden okuma: metin baştan sona söylenir, telefonda çalışan tanıyıcı
  /// hatayı bulunca durur (ayrı ekran: ReciteScreen).
  recite,
}

/// Kullanıcının kendi sesiyle kaydettiği replikler (yoksa yapay ses).
abstract class RecordedLines {
  /// Kaydı sonuna kadar çalar; kayıt yoksa false.
  Future<bool> play(Piece piece, Line line);
  Future<void> stopPlaying();
}

/// Sayfa modunda sesli yönlendirmeler (metnin dilinde).
class SpeechCues {
  const SpeechCues({this.page = _defaultPage, this.timeUp = 'Time is up.', this.done = 'End of presentation.'});

  final String Function(int number, String? title) page;
  final String timeUp;
  final String done;

  static String _defaultPage(int n, String? title) => title == null ? 'Page $n' : 'Page $n. $title';
}

enum RehearsalStatus { idle, speaking, myTurn, finished }

/// Prova sonu değerlendirmesi: "Tebrikler" yalnızca hak edildiğinde.
enum RehearsalOutcome { neutral, perfect, good, needsPractice }

/// Ses motoru soyutlaması: testlerde sahte, uygulamada flutter_tts.
abstract class Speaker {
  Future<void> speak(String text, {required String language, required VoiceSettings voice});
  Future<void> stop();
}

class RehearsalSettings {
  const RehearsalSettings({
    this.mode = RehearsalMode.waitForMe,
    this.hint = HintLevel.firstLetters,
    this.readDirections = false,
    this.gapFactor = 1.0,
    this.endSilenceSeconds = 0.8,
    this.checkAccuracy = false,
    this.readCorrection = true,
    this.hideRatio = 0.2,
    this.onlyWeak = false,
  });

  final RehearsalMode mode;
  final HintLevel hint;
  final bool readDirections;
  final double gapFactor;

  /// Eller serbest: bu kadar sessizlikten sonra repliğiniz bitmiş sayılır.
  /// Dramatik duraklamaları olan oyuncular artırabilir.
  final double endSilenceSeconds;

  /// Eller serbest: söyleneni cihazda yazıya çevirip replikle karşılaştır.
  /// İsteğe bağlı: telefonun ses tanıma hizmetini kullanır.
  final bool checkAccuracy;

  /// Doğruluk düşükse repliğin doğrusunu oku.
  final bool readCorrection;

  /// Kademeli silmede gizlenen kelime oranı (0.2 → 1.0).
  final double hideRatio;

  /// Yalnızca zorlandığım satırlar (ve öncesindeki ipucu replikleri).
  final bool onlyWeak;

  /// Mikrofonla dinlenen modlar.
  bool get usesMic => mode == RehearsalMode.handsFree || mode == RehearsalMode.buildUp;

  RehearsalSettings copyWith({
    RehearsalMode? mode,
    HintLevel? hint,
    bool? readDirections,
    double? gapFactor,
    double? endSilenceSeconds,
    bool? checkAccuracy,
    bool? readCorrection,
    double? hideRatio,
    bool? onlyWeak,
  }) =>
      RehearsalSettings(
        mode: mode ?? this.mode,
        hint: hint ?? this.hint,
        readDirections: readDirections ?? this.readDirections,
        gapFactor: gapFactor ?? this.gapFactor,
        endSilenceSeconds: endSilenceSeconds ?? this.endSilenceSeconds,
        checkAccuracy: checkAccuracy ?? this.checkAccuracy,
        readCorrection: readCorrection ?? this.readCorrection,
        hideRatio: hideRatio ?? this.hideRatio,
        onlyWeak: onlyWeak ?? this.onlyWeak,
      );

  Map<String, dynamic> toJson() => {
        'mode': mode.name,
        'hint': hint.name,
        'readDirections': readDirections,
        'gapFactor': gapFactor,
        'endSilence': endSilenceSeconds,
        'checkAccuracy': checkAccuracy,
        'readCorrection': readCorrection,
        'hideRatio': hideRatio,
        'onlyWeak': onlyWeak,
      };

  /// Bilinmeyen/eksik alanlar varsayılana düşer (eski sürüm ayarları).
  factory RehearsalSettings.fromJson(Map<String, dynamic> j) {
    T pick<T extends Enum>(List<T> values, Object? name, T fallback) =>
        values.where((v) => v.name == name).firstOrNull ?? fallback;
    return RehearsalSettings(
      mode: pick(RehearsalMode.values, j['mode'], RehearsalMode.waitForMe),
      hint: pick(HintLevel.values, j['hint'], HintLevel.firstLetters),
      readDirections: j['readDirections'] == true,
      gapFactor: (j['gapFactor'] as num?)?.toDouble() ?? 1.0,
      endSilenceSeconds: (j['endSilence'] as num?)?.toDouble() ?? 0.8,
      checkAccuracy: j['checkAccuracy'] == true,
      readCorrection: j['readCorrection'] != false,
      hideRatio: ((j['hideRatio'] as num?)?.toDouble() ?? 0.2).clamp(0.2, 1.0),
      onlyWeak: j['onlyWeak'] == true,
    );
  }
}

class RehearsalController extends ChangeNotifier {
  RehearsalController({
    required this.piece,
    required this.speaker,
    this.listener,
    this.checkingListener,
    this.settings = const RehearsalSettings(),
    this.onPieceChanged,
    this.cues = const SpeechCues(),
    this.recordings,
    Future<void> Function(Duration)? wait,
  }) : _wait = wait ?? ((d) => Future<void>.delayed(d));

  final SpeechCues cues;
  final RecordedLines? recordings;

  final Piece piece;
  final Speaker speaker;

  /// Ses seviyesiyle dinleyen (her zaman var).
  final LineListener? listener;

  /// Doğruluk kontrolü açıkken konuşmayı cihazda yazıya çeviren.
  final LineListener? checkingListener;
  RehearsalSettings settings;

  /// Satır istatistikleri değişince (kalıcı kayıt için).
  final VoidCallback? onPieceChanged;
  final Future<void> Function(Duration) _wait;

  static const correctionThreshold = 70;

  // ---- Durum ---------------------------------------------------------------

  int _index = 0;
  RehearsalStatus _status = RehearsalStatus.idle;
  bool _revealed = false;
  int _revealWords = 0;
  int _run = 0; // Her başlat/durdur/atla yeni bir çalıştırma; eskisi kendini bitirir.
  Completer<void>? _userContinue;
  bool _listening = false;
  LineListener? _activeListener;

  int get index => _index;
  RehearsalStatus get status => _status;
  bool get isPlaying => _status == RehearsalStatus.speaking || _status == RehearsalStatus.myTurn;

  /// "Bekle" modunda kullanıcının "Devam"ına basmasını bekliyor mu.
  bool get awaitingUser => _userContinue != null;

  /// Eller serbest modda mikrofon şu an kullanıcıyı dinliyor mu.
  bool get listening => _listening;

  /// Kullanıcı sırası geldiğinde repliği "Göster" ile açtı mı.
  bool get revealed => _revealed;

  /// Suflörün veya "İpucu" düğmesinin açtığı kelime sayısı.
  int get revealWords => _revealWords;

  Line? get currentLine => _index < piece.lines.length ? piece.lines[_index] : null;

  /// Sahne başlıklarının indeksleri: "sahneye atla" için.
  List<int> get headingIndexes => [
        for (var i = 0; i < piece.lines.length; i++)
          if (piece.lines[i].kind == LineKind.heading) i,
      ];

  // ---- Bu provanın sonuçları -----------------------------------------------

  /// Doğruluk kontrolü sonuçları (replik kimliği → sonuç).
  final checks = <String, LineCheck>{};

  /// Bu provada suflörün kaç kez yardım ettiği.
  int promptsUsed = 0;

  /// Bu provada sırası gelen kendi repliklerim ve başlarına gelenler.
  /// [prompted]: suflör, "İpucu" veya "Göster" ile yardım alınanlar.
  final practiced = <String>{};
  final prompted = <String>{};
  final corrected = <String>{};
  final unclear = <String>{};

  /// Kademeli silmede hatasız tur sonrası yükseltilen oran (bir kez okunur).
  double? leveledUpTo;

  final _watch = Stopwatch();
  final _myWatch = Stopwatch();
  int _myWords = 0;

  /// Provanın süresi (duraklatmalar hariç).
  Duration get elapsed => _watch.elapsed;

  /// Kendi repliklerimde konuşma hızı (kelime/dakika); yeterli veri yoksa null.
  int? get wordsPerMinute {
    final minutes = _myWatch.elapsed.inMilliseconds / 60000;
    if (_myWords < 5 || minutes < 0.05) return null;
    return (_myWords / minutes).round();
  }

  bool get _measured =>
      settings.mode == RehearsalMode.handsFree ||
      settings.mode == RehearsalMode.buildUp ||
      settings.mode == RehearsalMode.waitForMe;

  /// Prova sonu değerlendirmesi. Ölçüm yapılmayan modlarda nötr.
  RehearsalOutcome get outcome {
    if (!_measured || practiced.isEmpty) return RehearsalOutcome.neutral;
    final helped = prompted.union(corrected).length;
    final avg = averageScore;
    if (helped == 0 && unclear.isEmpty && (avg == null || avg >= 90)) return RehearsalOutcome.perfect;
    if (helped * 3 <= practiced.length && (avg == null || avg >= correctionThreshold)) {
      return RehearsalOutcome.good;
    }
    return RehearsalOutcome.needsPractice;
  }

  /// Doğruluk kontrolü yapılan repliklerin ortalaması.
  int? get averageScore {
    // "Anlaşılamadı" sonuçları ortalamaya katılmaz (%0 yanıltıcı olur).
    final scored = checks.values.where((c) => c.total > 0 && c.heard.trim().isNotEmpty).toList();
    if (scored.isEmpty) return null;
    return (scored.map((c) => c.score).reduce((a, b) => a + b) / scored.length).round();
  }

  // ---- Üst üste ekleme -------------------------------------------------------

  int _buildStart = 0;
  int _buildK = 0;
  int _buildTotal = 0;

  /// Üst üste eklemede bulunulan adım (1'den) ve toplam; diğer modlarda null.
  int? get buildStep => settings.mode == RehearsalMode.buildUp && _buildTotal > 0 ? _buildK + 1 : null;
  int get buildTotal => _buildTotal;

  // ---- Sunum sayfaları ----------------------------------------------------------

  List<SpeechPage> _pages = const [];
  List<int> _pageSeconds = const [];
  int _page = 0;
  final _pageWatch = Stopwatch();

  /// Bu provada her sayfada geçen süre (sayfa indeksi → süre).
  final pageTimes = <int, Duration>{};

  List<SpeechPage> get pages => _pages;
  int get pageIndex => _page;
  Duration plannedFor(int page) => Duration(seconds: _pageSeconds[page]);

  /// Sayfa modunda konuşurken o sayfanın kalan süresi (negatifse aşıldı).
  Duration? get pageRemaining => settings.mode == RehearsalMode.pages && _pageWatch.isRunning
      ? plannedFor(_page) - _pageWatch.elapsed
      : null;

  // ---- Görünüm ----------------------------------------------------------------

  /// [i]. satırın ekranda görünecek metni: kendi repliklerim sıraları
  /// geçene kadar ipucu seviyesine göre gizlenir.
  String textFor(int i) {
    final line = piece.lines[i];
    if (!piece.isMine(line)) return line.text;
    final passed = i < _index || (i == _index && _revealed);
    if (passed || _status == RehearsalStatus.finished) return line.text;
    final hinted = applyHint(
      line.text,
      settings.hint,
      revealWords: i == _index ? _revealWords : 0,
      hideRatio: settings.hideRatio,
      seed: line.id,
    );
    return hinted.isEmpty ? '• • •' : hinted;
  }

  String displayText(Line line) => textFor(piece.lines.indexOf(line));

  void reveal() {
    _revealed = true;
    notifyListeners();
  }

  /// "İpucu": repliğin bir kelimesini daha aç.
  void giveHint() {
    _revealWords++;
    notifyListeners();
  }

  // ---- Zorlandıklarım filtresi ------------------------------------------------

  Set<String> _weakSnapshot = {};

  bool get _filtering => settings.onlyWeak && _weakSnapshot.isNotEmpty;

  /// Zorlandıklarım açıkken: zor satırlarım ve hemen öncesindeki ipucu
  /// (karşı tarafın repliği) çalınır, gerisi atlanır.
  bool _included(int i) {
    if (!_filtering) return true;
    final line = piece.lines[i];
    if (_weakSnapshot.contains(line.id)) return true;
    if (line.kind != LineKind.dialogue || piece.isMine(line)) return false;
    for (var j = i + 1; j < piece.lines.length; j++) {
      final next = piece.lines[j];
      if (next.kind != LineKind.dialogue) continue;
      return _weakSnapshot.contains(next.id);
    }
    return false;
  }

  // ---- Oynatma ----------------------------------------------------------------

  Future<void> play({int? from}) async {
    final run = ++_run;
    if (from != null) {
      _index = from.clamp(0, piece.lines.length);
      _buildStart = _index;
      _buildK = 0;
    }
    if (from == 0) _resetResults();
    _weakSnapshot = {for (final l in piece.lines) if (piece.isMine(l) && piece.isWeak(l)) l.id};
    await speaker.stop();
    _watch.start();

    if (settings.mode == RehearsalMode.buildUp) {
      await _playBuildUp(run);
    } else if (settings.mode == RehearsalMode.pages) {
      await _playPages(run);
    } else {
      while (run == _run && _index < piece.lines.length) {
        if (_included(_index)) await _perform(piece.lines[_index], run);
        if (run != _run) return;
        _index++;
      }
    }
    if (run == _run) _finish();
  }

  void _resetResults() {
    checks.clear();
    promptsUsed = 0;
    practiced.clear();
    prompted.clear();
    corrected.clear();
    unclear.clear();
    leveledUpTo = null;
    _watch.reset();
    _myWatch.reset();
    _myWords = 0;
    pageTimes.clear();
  }

  void _finish() {
    _watch.stop();
    // Kademeli silme: hatasız turdan sonra bir sonraki turda daha çok gizle.
    if (settings.hint == HintLevel.progressive && outcome == RehearsalOutcome.perfect && settings.hideRatio < 1) {
      final next = (settings.hideRatio + 0.2).clamp(0.2, 1.0);
      settings = settings.copyWith(hideRatio: double.parse(next.toStringAsFixed(1)));
      leveledUpTo = settings.hideRatio;
    }
    _set(RehearsalStatus.finished);
  }

  /// Üst üste ekleme: her adımda yeni satır önce okunur, sonra baştan o
  /// satıra kadar prova edilir. Oyunlarda karşı replikler ipucu olarak kalır.
  Future<void> _playBuildUp(int run) async {
    final mine = [
      for (var i = _buildStart; i < piece.lines.length; i++)
        if (piece.isMine(piece.lines[i]) && _included(i)) i,
    ];
    _buildTotal = mine.length;
    while (run == _run && _buildK < mine.length) {
      final target = mine[_buildK];
      final line = piece.lines[target];

      // 1) Yeni satırı tanıt: göster ve oku.
      _index = target;
      _revealed = true;
      _revealWords = 0;
      _set(RehearsalStatus.speaking);
      await _sayLine(line, _voiceOf(line));
      if (run != _run) return;

      // 2) Baştan bu satıra kadar.
      for (var i = _buildStart; i <= target; i++) {
        if (!_included(i)) continue;
        _index = i;
        await _perform(piece.lines[i], run);
        if (run != _run) return;
      }
      _buildK++;
    }
    _index = piece.lines.length;
  }

  /// Sayfa sayfa sunum: her sayfa sesli duyurulur, süresi dolunca bir
  /// sonrakine geçilir; "Devam" ile erken geçilebilir.
  Future<void> _playPages(int run) async {
    _pages = speechPages(piece);
    _pageSeconds = pageSecondsFor(piece, _pages);
    var p = _pages.indexWhere((page) => _index < page.end);
    if (p < 0) {
      _index = piece.lines.length;
      return;
    }
    var timedOut = false;
    for (; p < _pages.length; p++) {
      final page = _pages[p];
      _page = p;
      _index = page.start;
      _revealed = false;
      _revealWords = 0;
      _set(RehearsalStatus.speaking);
      final cue = cues.page(p + 1, page.title);
      await _say(timedOut ? '${cues.timeUp} $cue' : cue, const VoiceSettings());
      if (run != _run) return;

      _pageWatch
        ..reset()
        ..start();
      _myWatch.start();
      final done = _userContinue = Completer<void>();
      _set(RehearsalStatus.myTurn);
      timedOut = await Future.any([
        _wait(plannedFor(p)).then((_) => true),
        done.future.then((_) => false),
      ]);
      _userContinue = null;
      _pageWatch.stop();
      _myWatch.stop();
      if (run != _run) return;
      pageTimes[p] = _pageWatch.elapsed;
      _myWords += page.words;
    }
    _set(RehearsalStatus.speaking);
    await _say(timedOut ? '${cues.timeUp} ${cues.done}' : cues.done, const VoiceSettings());
    _index = piece.lines.length;
  }

  VoiceSettings _voiceOf(Line line) =>
      (piece.characterById(line.characterId)?.voice ?? const VoiceSettings()).withEmotion(line.emotion);

  Future<void> _perform(Line line, int run) async {
    _revealed = false;
    _revealWords = 0;
    switch (line.kind) {
      case LineKind.heading:
        notifyListeners();
        return;
      case LineKind.direction:
        if (!settings.readDirections || _filtering) {
          notifyListeners();
          return;
        }
        _set(RehearsalStatus.speaking);
        await _say(line.text, const VoiceSettings());
        return;
      case LineKind.dialogue:
        final voice = _voiceOf(line);
        if (!piece.isMine(line) || settings.mode == RehearsalMode.listen) {
          _set(RehearsalStatus.speaking);
          await _sayLine(line, voice);
          return;
        }
        _set(RehearsalStatus.myTurn);
        _myWatch.start();
        switch (settings.mode) {
          case RehearsalMode.waitForMe:
            practiced.add(line.id);
            _userContinue = Completer<void>();
            notifyListeners();
            await _userContinue!.future;
            _userContinue = null;
            if (run != _run) break;
            final helped = _revealed || _revealWords > 0;
            if (helped) prompted.add(line.id);
            _record(line, helped: helped);
          case RehearsalMode.checkMe:
            await _wait(gapFor(line.text, factor: settings.gapFactor));
            _myWatch.stop();
            if (run != _run) return;
            _revealed = true;
            _set(RehearsalStatus.speaking);
            await _sayLine(line, voice);
          case RehearsalMode.runThrough:
            await _wait(gapFor(line.text, factor: settings.gapFactor));
          case RehearsalMode.handsFree:
          case RehearsalMode.buildUp:
            await _handsFree(line, voice, run);
          case RehearsalMode.listen:
          case RehearsalMode.pages: // Sayfa modu kendi döngüsünde çalışır.
          case RehearsalMode.recite: // Ayrı ekranda.
            break;
        }
        _myWatch.stop();
        if (run == _run) _myWords += wordCount(line.text);
    }
  }

  void _record(Line line, {required bool helped, int? score}) {
    piece.recordAttempt(line.id, helped: helped, score: score);
    onPieceChanged?.call();
  }

  /// Dinleyerek sıra: takılırsa suflör önce ilk kelimeleri fısıldar ve tekrar
  /// dinler, yine takılırsa repliği tamamen okur. Doğruluk kontrolü açıksa
  /// söyleneni replikle karşılaştırır. Mikrofon yoksa "Beni bekle" gibi.
  Future<void> _handsFree(Line line, VoiceSettings voice, int run) async {
    final mic = settings.checkAccuracy ? (checkingListener ?? listener) : listener;
    practiced.add(line.id);
    if (mic == null) {
      _userContinue = Completer<void>();
      notifyListeners();
      await _userContinue!.future;
      _userContinue = null;
      return;
    }
    var hasPrompted = false;
    while (true) {
      _activeListener = mic;
      _listening = true;
      _set(RehearsalStatus.myTurn);
      final result = await mic.listen(
        language: piece.language,
        // Hiç konuşmazsa: repliğin süresi + 3 sn sonra suflör.
        promptAfter: gapFor(line.text, factor: settings.gapFactor) + const Duration(seconds: 3),
        endSilence: Duration(milliseconds: (settings.endSilenceSeconds * 1000).round()),
      );
      _listening = false;
      _activeListener = null;
      if (run != _run || result.outcome == ListenOutcome.cancelled) return;

      if (result.outcome == ListenOutcome.spoke) {
        final heard = result.transcripts;
        int? score;
        var wasCorrected = false;
        if (heard != null) {
          final check = checkBest(line.text, heard);
          checks[line.id] = check;
          notifyListeners();
          // Anlaşılamadıysa kullanıcının yanlış söylediğini bilemeyiz:
          // doğrusunu okumak yersiz bir düzeltme olur.
          final understood = check.heard.trim().isNotEmpty;
          if (!understood) {
            unclear.add(line.id);
          } else {
            score = check.score;
          }
          if (understood && settings.readCorrection && check.score < correctionThreshold) {
            corrected.add(line.id);
            wasCorrected = true;
            // Hatalıydı: doğrusunu göster ve oku.
            _revealed = true;
            _set(RehearsalStatus.speaking);
            await _sayLine(line, voice);
          }
        }
        final helped = hasPrompted || wasCorrected || _revealed || _revealWords > 0;
        if (hasPrompted || (_revealWords > 0 && !wasCorrected)) prompted.add(line.id);
        _record(line, helped: helped, score: score);
        return;
      }

      // Sessiz kaldı: takıldı.
      promptsUsed++;
      prompted.add(line.id);
      final words = promptWordCount(line.text);
      // Tek kelimelik replikte ilk kelimeyi fısıldamak zaten repliğin tamamı.
      if (!hasPrompted && words < wordCount(line.text)) {
        // 1. adım: ilk kelimeleri fısılda, sonra devamını dinle.
        hasPrompted = true;
        _revealWords = words;
        _set(RehearsalStatus.speaking);
        await _say(firstWords(line.text, words), voice);
        if (run != _run) return;
        continue;
      }
      // 2. adım: repliğin tamamını göster ve oku.
      _revealed = true;
      _set(RehearsalStatus.speaking);
      await _sayLine(line, voice);
      _record(line, helped: true);
      return;
    }
  }

  /// Repliğin tamamı: kaydı varsa kullanıcının sesi, yoksa yapay ses.
  Future<void> _sayLine(Line line, VoiceSettings voice) async {
    final rec = recordings;
    if (rec != null && line.recorded && await rec.play(piece, line)) return;
    await _say(line.text, voice);
  }

  /// Bozuk bir ses yüzünden provanın sessizce durmaması için hata yutulur;
  /// ses motoru kendi içinde varsayılan sese düşer.
  Future<void> _say(String text, VoiceSettings voice) async {
    try {
      await speaker.speak(text, language: piece.language, voice: voice);
    } catch (e) {
      debugPrint('TTS hatası: $e');
    }
  }

  // ---- Kontroller ---------------------------------------------------------------

  /// "Devam" düğmesi: bekleme modunda sürdürür, dinlerken "söyledi" sayar.
  void userContinue() {
    final c = _userContinue;
    if (c != null && !c.isCompleted) c.complete();
    if (_listening) _activeListener?.finish(ListenOutcome.spoke);
  }

  Future<void> pause() async {
    _run++;
    final c = _userContinue;
    _userContinue = null;
    if (c != null && !c.isCompleted) c.complete();
    if (_listening) _activeListener?.finish(ListenOutcome.cancelled);
    _listening = false;
    _watch.stop();
    _myWatch.stop();
    _pageWatch.stop();
    await speaker.stop();
    await recordings?.stopPlaying();
    _set(RehearsalStatus.idle);
  }

  Future<void> jumpTo(int index) async {
    await pause();
    _index = index.clamp(0, piece.lines.length - 1);
    _buildStart = _index;
    _buildK = 0;
    notifyListeners();
  }

  Future<void> next() => jumpTo(_index + 1);
  Future<void> previous() => jumpTo(_index - 1);

  /// Bir önceki kendi repliğime / sonraki kendi repliğime atla.
  int? findMine({required bool forward}) {
    final step = forward ? 1 : -1;
    for (var i = _index + step; i >= 0 && i < piece.lines.length; i += step) {
      if (piece.isMine(piece.lines[i])) return i;
    }
    return null;
  }

  void _set(RehearsalStatus s) {
    _status = s;
    notifyListeners();
  }

  @override
  void dispose() {
    _run++;
    if (_listening) _activeListener?.finish(ListenOutcome.cancelled);
    speaker.stop();
    recordings?.stopPlaying();
    super.dispose();
  }
}
