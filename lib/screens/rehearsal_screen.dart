import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../app_state.dart';
import '../core/hints.dart';
import '../core/line_check.dart';
import '../core/models.dart';
import '../core/rehearsal.dart';
import '../core/speech_pages.dart';
import '../core/voice_activity.dart';
import '../data/mic_listener.dart';
import '../l10n/app_localizations.dart';
import '../widgets/character_panel.dart';
import 'editor_screen.dart';
import 'pro_screen.dart';
import 'recite_screen.dart';

class _ProBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: scheme.primary, borderRadius: BorderRadius.circular(4)),
      child: Text('PRO', style: TextStyle(color: scheme.onPrimary, fontSize: 11, fontWeight: FontWeight.bold)),
    );
  }
}

class RehearsalScreen extends StatefulWidget {
  const RehearsalScreen({
    super.key,
    required this.piece,
    this.speaker,
    this.listener,
    this.checkingListener,
  });

  final Piece piece;

  /// Testler için; verilmezse cihazın ses motoru ve mikrofonu kullanılır.
  final Speaker? speaker;
  final LineListener? listener;
  final LineListener? checkingListener;

  @override
  State<RehearsalScreen> createState() => _RehearsalScreenState();
}

class _RehearsalScreenState extends State<RehearsalScreen> {
  RehearsalController? _ctrl;
  final _keys = <String, GlobalKey>{};
  int _lastScrolled = -1;
  bool _wakeOn = false;

  Piece get piece => widget.piece;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _state = AppScope.of(context);
    if (_ctrl == null) {
      final state = _state;
      _ctrl = RehearsalController(
        piece: piece,
        speaker: widget.speaker ?? state.speaker,
        listener: widget.listener ?? state.listener,
        checkingListener: widget.checkingListener ?? (widget.speaker == null ? state.checkingListener : null),
        settings: state.rehearsalSettings,
        cues: _cuesFor(piece.language, L.of(context)),
        recordings: widget.speaker == null ? state.recordings : null,
        // Satır istatistikleri (zorlandıklarım) her replikten sonra kaydedilir.
        onPieceChanged: () => state.repository.save(piece),
      )..addListener(_onChange);
      if (widget.speaker == null) {
        state.sttFailedLanguages.addListener(_onSttFailed);
        state.speaker.voicesFor(piece.language).then((v) {
          if (piece.assignDistinctVoices([for (final x in v) x.name])) state.repository.save(piece);
        });
      }
    }
  }

  late AppState _state;

  /// Sayfa duyuruları metnin dilinde okunur (Türkçe arayüzde İngilizce sunum
  /// "Page 2" der); metnin dili desteklenmiyorsa arayüz dili.
  static SpeechCues _cuesFor(String language, L fallback) {
    L l;
    try {
      l = lookupL(Locale(language.split(RegExp('[-_]')).first));
    } catch (_) {
      l = fallback;
    }
    return SpeechCues(
      page: (n, title) => title == null ? l.pageCue(n) : l.pageCueTitled(n, title),
      timeUp: l.timeUp,
      done: l.presentationDone,
    );
  }

  @override
  void dispose() {
    if (widget.speaker == null) _state.sttFailedLanguages.removeListener(_onSttFailed);
    _ctrl?.removeListener(_onChange);
    _ctrl?.dispose();
    _ticker?.cancel();
    _setWake(false);
    super.dispose();
  }

  /// Prova süresini ekranda saniye saniye güncellemek için.
  Timer? _ticker;

  void _setTicker(bool on) {
    if (on && _ticker == null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    } else if (!on) {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  /// Bu dilde tanıma çalışmadı: doğruluk kontrolünü kapat ve söyle. Prova
  /// ses seviyesiyle kesintisiz sürer.
  void _onSttFailed() {
    final ctrl = _ctrl;
    if (!mounted || ctrl == null) return;
    if (!_state.sttFailedLanguages.value.contains(piece.language) || !ctrl.settings.checkAccuracy) return;
    ctrl.settings = ctrl.settings.copyWith(checkAccuracy: false);
    _state.saveRehearsalSettings(ctrl.settings);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(L.of(context).sttLanguageMissing), duration: const Duration(seconds: 6)),
    );
  }

  /// Eller serbest provada telefon elde değil: ekran kararmasın.
  void _setWake(bool on) {
    if (on == _wakeOn) return;
    _wakeOn = on;
    unawaited(WakelockPlus.toggle(enable: on).catchError((_) {}));
  }

  Future<void> _play() async {
    final ctrl = _ctrl!;
    final state = AppScope.of(context);
    final l = L.of(context);
    final messenger = ScaffoldMessenger.of(context);
    // Ezberden okuma kendi ekranında (konuşma tanıma modeli orada yüklenir).
    if (ctrl.settings.mode == RehearsalMode.recite) {
      await Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => ReciteScreen(piece: piece)));
      if (mounted) setState(() {});
      return;
    }
    // Abonelik bittiyse kayıtlı eller serbest ayarı sessizce çalışmasın.
    if (ctrl.settings.mode == RehearsalMode.handsFree && !state.pro.isPro.value) {
      ctrl.settings = ctrl.settings.copyWith(mode: RehearsalMode.waitForMe);
      await state.saveRehearsalSettings(ctrl.settings);
      messenger.showSnackBar(SnackBar(content: Text(l.proHandsFreeLocked)));
    }
    if (ctrl.settings.usesMic) {
      final ok = await (ctrl.listener?.ensurePermission() ?? Future.value(false));
      if (!ok) {
        ctrl.settings = ctrl.settings.copyWith(mode: RehearsalMode.waitForMe);
        await state.saveRehearsalSettings(ctrl.settings);
        messenger.showSnackBar(SnackBar(content: Text(l.micDenied)));
      }
    }
    await ctrl.play(from: ctrl.status == RehearsalStatus.finished ? 0 : null);
  }

  void _onChange() {
    if (!mounted) return;
    final ctrl = _ctrl!;
    _setWake(ctrl.isPlaying);
    _setTicker(ctrl.isPlaying);
    // Kademeli silme: hatasız tur → sonraki turda daha çok kelime gizli.
    final up = ctrl.leveledUpTo;
    if (up != null) {
      ctrl.leveledUpTo = null;
      _state.saveRehearsalSettings(ctrl.settings);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(L.of(context).levelUp((up * 100).round()))),
      );
    }
    setState(() {});
    final i = _ctrl!.index;
    if (i != _lastScrolled && i < piece.lines.length) {
      _lastScrolled = i;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final ctx = _keys[piece.lines[i].id]?.currentContext;
        if (ctx != null) {
          Scrollable.ensureVisible(ctx, alignment: 0.3, duration: const Duration(milliseconds: 250));
        }
      });
    }
  }

  Future<void> _openSettings() async {
    final ctrl = _ctrl!;
    final wasPlaying = ctrl.isPlaying;
    if (wasPlaying) await ctrl.pause();
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => _SettingsSheet(
        settings: ctrl.settings,
        piece: piece,
        speech: widget.speaker == null ? AppScope.of(context).speech : null,
        onPieceChanged: () => _state.repository.save(piece),
        onChanged: (s) {
          setState(() => ctrl.settings = s);
          AppScope.of(context).saveRehearsalSettings(s);
        },
      ),
    );
    if (mounted) setState(() {});
  }

  static String _clock(Duration d) =>
      '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  /// Prova sonu başlığı: "Tebrikler" yalnızca yardım almadan bitince.
  String _finishedTitle(L l, RehearsalController ctrl) => switch (ctrl.outcome) {
        RehearsalOutcome.perfect => l.finishedPerfect,
        RehearsalOutcome.good => l.finishedGood,
        RehearsalOutcome.needsPractice => l.finishedPractice,
        RehearsalOutcome.neutral => l.finished,
      };

  /// Yalnızca gerçekten olanlar: kaç replik, doğruluk (anlaşılanlar
  /// üzerinden), suflör/düzeltme/anlaşılamayan sayıları.
  Widget? _summary(L l, RehearsalController ctrl) {
    final measured = ctrl.outcome != RehearsalOutcome.neutral;
    final isSpeech = piece.kind == PieceKind.speech;
    final target = piece.targetSeconds;
    final elapsed = ctrl.elapsed;
    final parts = [
      if (measured) l.summaryLines(ctrl.practiced.length),
      if (ctrl.averageScore != null) l.summaryAccuracy(ctrl.averageScore!),
      if (ctrl.prompted.isNotEmpty) l.summaryPrompted(ctrl.prompted.length),
      if (ctrl.corrected.isNotEmpty) l.summaryCorrected(ctrl.corrected.length),
      if (ctrl.unclear.isNotEmpty) l.summaryUnclear(ctrl.unclear.length),
      // Sunumda süre ve hız asıl ölçüt: hedefle karşılaştırılır.
      if (isSpeech || target != null) l.elapsed(_clock(elapsed)),
      if (target != null && elapsed.inSeconds > target + 5)
        l.overTarget(_clock(Duration(seconds: elapsed.inSeconds - target))),
      if (target != null && elapsed.inSeconds < target - 5)
        l.underTarget(_clock(Duration(seconds: target - elapsed.inSeconds))),
      if (isSpeech && ctrl.wordsPerMinute != null) l.wpm(ctrl.wordsPerMinute!),
      for (final e in ctrl.pageTimes.entries)
        l.pageSummary(e.key + 1, _clock(e.value), _clock(ctrl.plannedFor(e.key))),
    ];
    return parts.isEmpty ? null : Text(parts.join(' · '));
  }

  IconData _finishedIcon(RehearsalOutcome o) => switch (o) {
        RehearsalOutcome.perfect => Icons.celebration_outlined,
        RehearsalOutcome.good => Icons.thumb_up_alt_outlined,
        RehearsalOutcome.needsPractice => Icons.replay,
        RehearsalOutcome.neutral => Icons.check_circle_outline,
      };

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final ctrl = _ctrl!;
    final theme = Theme.of(context);

    if (piece.myCharacterIds.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(piece.title)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(l.noMyCharacter, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => EditorScreen(piece: piece)),
                ),
                child: Text(l.whoAmI),
              ),
            ]),
          ),
        ),
      );
    }

    final headings = ctrl.headingIndexes;
    final myTurn = ctrl.status == RehearsalStatus.myTurn && ctrl.awaitingUser;

    final step = ctrl.buildStep;
    final showClock = piece.kind == PieceKind.speech || piece.targetSeconds != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(piece.title),
        // Üst üste eklemede ilerleme: "Adım 3/12".
        bottom: step == null
            ? null
            : PreferredSize(
                preferredSize: const Size.fromHeight(28),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: Row(children: [
                    Text(l.stepOf(step, ctrl.buildTotal), style: theme.textTheme.labelMedium),
                    const SizedBox(width: 12),
                    Expanded(child: LinearProgressIndicator(value: step / ctrl.buildTotal)),
                  ]),
                ),
              ),
        actions: [
          // Sunumda süre sürekli görünür; hedefi aşınca kırmızı.
          if (showClock)
            Center(
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 4),
                child: Text(
                  _clock(ctrl.elapsed),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontFeatures: const [FontFeature.tabularFigures()],
                    color: piece.targetSeconds != null && ctrl.elapsed.inSeconds > piece.targetSeconds!
                        ? theme.colorScheme.error
                        : null,
                  ),
                ),
              ),
            ),
          IconButton(
            tooltip: l.charactersAndVoices,
            icon: const Icon(Icons.people_outline),
            onPressed: () async {
              if (ctrl.isPlaying) await ctrl.pause();
              if (!context.mounted) return;
              await showCharacterSheet(context, piece, () => _state.repository.save(piece));
              if (mounted) setState(() {});
            },
          ),
          PopupMenuButton<int>(
            tooltip: l.jumpToScene,
            icon: const Icon(Icons.format_list_bulleted),
            onSelected: (i) => ctrl.jumpTo(i),
            itemBuilder: (context) => [
              PopupMenuItem(value: 0, child: Text(l.fromStart)),
              for (final i in headings)
                PopupMenuItem(value: i, child: Text(piece.lines[i].text)),
            ],
          ),
          IconButton(
            tooltip: l.settings,
            icon: const Icon(Icons.tune),
            onPressed: _openSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: piece.lines.length,
              itemBuilder: (context, i) {
                final line = piece.lines[i];
                final key = _keys.putIfAbsent(line.id, GlobalKey.new);
                final current = i == ctrl.index && ctrl.status != RehearsalStatus.finished;
                return _RehearsalLine(
                  key: key,
                  piece: piece,
                  line: line,
                  text: ctrl.textFor(i),
                  current: current,
                  check: ctrl.checks[line.id],
                  onTap: () => ctrl.jumpTo(i),
                );
              },
            ),
          ),
          if (ctrl.listening)
            _ListeningPanel(
              onShow: ctrl.revealed ? null : ctrl.reveal,
              onHint: ctrl.revealed ? null : ctrl.giveHint,
              onContinue: ctrl.userContinue,
            )
          else if (myTurn && ctrl.settings.mode == RehearsalMode.pages)
            _PagePanel(
              title: l.pageOf(ctrl.pageIndex + 1, ctrl.pages.length),
              remaining: ctrl.pageRemaining ?? Duration.zero,
              onNext: ctrl.userContinue,
            )
          else if (myTurn)
            _MyTurnPanel(
              onShow: ctrl.revealed ? null : ctrl.reveal,
              onHint: ctrl.revealed ? null : ctrl.giveHint,
              onContinue: ctrl.userContinue,
            )
          else if (ctrl.status == RehearsalStatus.finished)
            Material(
              color: theme.colorScheme.primaryContainer,
              child: ListTile(
                leading: Icon(_finishedIcon(ctrl.outcome)),
                title: Text(_finishedTitle(l, ctrl)),
                subtitle: _summary(l, ctrl),
                trailing: FilledButton(
                  onPressed: _play,
                  child: Text(l.restart),
                ),
              ),
            ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              // Medya kontrolleri zamanı gösterir, sağdan sola dillerde de
              // ters çevrilmez (Material yönergesi).
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: l.previousLine,
                    iconSize: 32,
                    icon: const Icon(Icons.skip_previous),
                    onPressed: ctrl.index > 0 ? ctrl.previous : null,
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    tooltip: ctrl.isPlaying ? l.pause : l.play,
                    onPressed: () => ctrl.isPlaying ? ctrl.pause() : _play(),
                    child: Icon(ctrl.isPlaying ? Icons.pause : Icons.play_arrow, size: 32),
                  ),
                  IconButton(
                    tooltip: l.nextLine,
                    iconSize: 32,
                    icon: const Icon(Icons.skip_next),
                    onPressed: ctrl.index < piece.lines.length - 1 ? ctrl.next : null,
                  ),
                ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RehearsalLine extends StatelessWidget {
  const _RehearsalLine({
    super.key,
    required this.piece,
    required this.line,
    required this.text,
    required this.current,
    required this.onTap,
    this.check,
  });

  final Piece piece;
  final Line line;
  final String text;
  final bool current;
  final VoidCallback onTap;
  final LineCheck? check;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mine = piece.isMine(line);
    final scheme = theme.colorScheme;

    Widget body;
    switch (line.kind) {
      case LineKind.heading:
        body = Text(text, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold));
      case LineKind.direction:
        body = Text('($text)',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontStyle: FontStyle.italic,
              color: scheme.onSurfaceVariant,
            ));
      case LineKind.dialogue:
        body = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (piece.kind == PieceKind.play)
              Text(
                piece.characterById(line.characterId)?.name ?? '',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: mine ? scheme.primary : scheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            Text(text, style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              fontWeight: mine ? FontWeight.w600 : null,
            )),
            if (check != null) _CheckResult(check: check!),
          ],
        );
    }

    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: current ? scheme.secondaryContainer : null,
          borderRadius: BorderRadius.circular(12),
        ),
        // Yuvarlak köşeli kutuda tek kenarlık kıvrık çiziliyordu; düz şerit.
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(width: 4, color: mine ? scheme.primary : Colors.transparent),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  // Metnin yönü metnin dilinden gelir (Arapça arayüzde
                  // Türkçe metin soldan sağa kalmalı).
                  child: Directionality(textDirection: textDirectionFor(piece.language), child: body),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// "Beni bekle" modunda sıra kullanıcıya gelince açılan panel. Rakipte küçük
/// "devam" düğmesine bakmak zorunda kalmak şikâyet konusuydu: burada ekranın
/// büyük bir kısmı düğmedir, telefona bakmadan dokunulabilir.
/// Doğruluk kontrolü sonucu: puan ve atlanan kelimeler.
class _CheckResult extends StatelessWidget {
  const _CheckResult({required this.check});

  final LineCheck check;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final scheme = Theme.of(context).colorScheme;
    final understood = check.heard.trim().isNotEmpty;
    final score = check.score;
    final color = !understood
        ? scheme.onSurfaceVariant
        : score >= 90
            ? scheme.primary
            : score >= RehearsalController.correctionThreshold
                ? scheme.tertiary
                : scheme.error;
    final icon = !understood
        ? Icons.hearing_disabled_outlined
        : score >= 90
            ? Icons.check_circle
            : Icons.error_outline;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              !understood
                  ? l.notUnderstood
                  : [
                      l.accuracyScore(score),
                      if (check.missed.isNotEmpty) l.missedWords(check.missed.join(', ')),
                    ].join(' · '),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// Sayfa modunda: kalan süre büyük yazılır, süre aşılınca kırmızı; erken
/// bitiren "Sonraki sayfa"ya basar.
class _PagePanel extends StatelessWidget {
  const _PagePanel({required this.title, required this.remaining, required this.onNext});

  final String title;
  final Duration remaining;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final theme = Theme.of(context);
    final secs = remaining.inSeconds.clamp(0, 99999);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Column(
        children: [
          Row(children: [
            Expanded(child: Text(title, style: theme.textTheme.titleMedium)),
            Text(
              '${secs ~/ 60}:${(secs % 60).toString().padLeft(2, '0')}',
              style: theme.textTheme.displaySmall?.copyWith(
                fontFeatures: const [FontFeature.tabularFigures()],
                color: secs <= 10 ? theme.colorScheme.error : null,
              ),
            ),
          ]),
          const SizedBox(height: 8),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.18,
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.skip_next),
              label: Text(l.nextPage),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                textStyle: theme.textTheme.headlineSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MyTurnPanel extends StatelessWidget {
  const _MyTurnPanel({required this.onShow, required this.onHint, required this.onContinue});

  final VoidCallback? onShow;
  final VoidCallback? onHint;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final height = MediaQuery.sizeOf(context).height * 0.28;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text(l.yourTurn, style: Theme.of(context).textTheme.titleMedium)),
              // Kademeli ipucu: her dokunuşta bir kelime daha açılır.
              TextButton.icon(
                onPressed: onHint,
                icon: const Icon(Icons.lightbulb_outline),
                label: Text(l.hintWord),
              ),
              TextButton.icon(
                onPressed: onShow,
                icon: const Icon(Icons.visibility_outlined),
                label: Text(l.show),
              ),
            ],
          ),
          SizedBox(
            height: height,
            width: double.infinity,
            child: FilledButton(
              onPressed: onContinue,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                textStyle: Theme.of(context).textTheme.headlineSmall,
              ),
              child: Text(l.continueAction),
            ),
          ),
        ],
      ),
    );
  }
}

/// Eller serbest modda dinlerken: telefona dokunmak gerekmez, ama yine de
/// istenirse repliği görmek veya elle devam etmek mümkün.
class _ListeningPanel extends StatelessWidget {
  const _ListeningPanel({required this.onShow, required this.onHint, required this.onContinue});

  final VoidCallback? onShow;
  final VoidCallback? onHint;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const _PulsingMic(),
          const SizedBox(width: 12),
          Expanded(
            child: Text(l.listening,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: scheme.onTertiaryContainer)),
          ),
          IconButton(tooltip: l.hintWord, onPressed: onHint, icon: const Icon(Icons.lightbulb_outline)),
          IconButton(tooltip: l.show, onPressed: onShow, icon: const Icon(Icons.visibility_outlined)),
          IconButton.filledTonal(tooltip: l.continueAction, onPressed: onContinue, icon: const Icon(Icons.skip_next)),
        ],
      ),
    );
  }
}

class _PulsingMic extends StatefulWidget {
  const _PulsingMic();

  @override
  State<_PulsingMic> createState() => _PulsingMicState();
}

class _PulsingMicState extends State<_PulsingMic> with SingleTickerProviderStateMixin {
  late final _anim = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
    ..repeat(reverse: true);

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ScaleTransition(
      scale: Tween(begin: 0.85, end: 1.15).animate(_anim),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: scheme.tertiary,
        child: Icon(Icons.mic, color: scheme.onTertiary),
      ),
    );
  }
}

class _SettingsSheet extends StatefulWidget {
  const _SettingsSheet({
    required this.settings,
    required this.onChanged,
    required this.piece,
    required this.onPieceChanged,
    required this.speech,
  });

  final RehearsalSettings settings;
  final ValueChanged<RehearsalSettings> onChanged;
  final Piece piece;
  final VoidCallback onPieceChanged;
  String get language => piece.language;

  /// Cihaz üzerinde ses tanıma (testlerde null).
  final OnDeviceSpeech? speech;

  @override
  State<_SettingsSheet> createState() => _SettingsSheetState();
}

class _SettingsSheetState extends State<_SettingsSheet> {
  late RehearsalSettings s = widget.settings;
  SpeechSupport? _support;

  @override
  void initState() {
    super.initState();
    // AppScope initState içinde okunamaz: ilk kareden sonra kontrol et.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _checkSupport();
    });
  }

  Future<void> _checkSupport() async {
    final speech = widget.speech;
    if (speech == null) return setState(() => _support = SpeechSupport.unavailable);
    // Daha önce bu dilde denenip çalışmadıysa, telefon "var" dese de yok say.
    if (AppScope.of(context).sttFailedLanguages.value.contains(widget.language)) {
      return setState(() => _support = SpeechSupport.unsupported);
    }
    final support = await speech.support(widget.language);
    if (mounted) setState(() => _support = support);
  }

  Future<void> _download() async {
    setState(() => _support = SpeechSupport.downloading);
    await widget.speech?.download(widget.language);
  }

  /// Sayfa başına süre: 5 sn adımlarla; "Otomatik dağıt" hedef süreye döner.
  List<Widget> _pageTimesSection(L l, ThemeData theme) {
    final piece = widget.piece;
    final pages = speechPages(piece);
    final secs = pageSecondsFor(piece, pages);
    String clock(int s) => '${s ~/ 60}:${(s % 60).toString().padLeft(2, '0')}';
    void change(int i, int delta) {
      setState(() => piece.pageSeconds = [...secs]..[i] = (secs[i] + delta).clamp(10, 3600));
      widget.onPieceChanged();
    }

    return [
      const SizedBox(height: 8),
      Text(l.pageTimes, style: theme.textTheme.titleMedium),
      Text(l.pageTimesHelp, style: theme.textTheme.bodySmall),
      for (var i = 0; i < pages.length; i++)
        Row(children: [
          Expanded(
            child: Text(
              pages[i].title ?? l.pageCue(i + 1),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(icon: const Icon(Icons.remove), onPressed: () => change(i, -5)),
          Text(clock(secs[i]), style: const TextStyle(fontFeatures: [FontFeature.tabularFigures()])),
          IconButton(icon: const Icon(Icons.add), onPressed: () => change(i, 5)),
        ]),
      if (piece.pageSeconds != null)
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton(
            onPressed: () {
              setState(() => piece.pageSeconds = null);
              widget.onPieceChanged();
            },
            child: Text(l.pageTimesAuto),
          ),
        ),
      const SizedBox(height: 8),
    ];
  }

  void _set(RehearsalSettings next) {
    setState(() => s = next);
    widget.onChanged(next);
  }

  /// "Söylediğimi kontrol et" bölümü: yalnızca cihaz üzerinde tanıma
  /// varsa açılabilir; dil paketi yoksa indirme önerilir.
  List<Widget> _accuracySection(L l, ThemeData theme) {
    final support = _support;
    if (support == null) return const [LinearProgressIndicator()];
    final usable = support == SpeechSupport.installed || support == SpeechSupport.unknown;
    final note = switch (support) {
      SpeechSupport.unavailable => l.sttUnavailable,
      SpeechSupport.unsupported => l.sttLanguageMissing,
      SpeechSupport.downloading => l.sttDownloading,
      _ => l.checkAccuracyHelp,
    };
    return [
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(l.checkAccuracy),
        subtitle: Text(note),
        value: usable && s.checkAccuracy,
        onChanged: usable ? (v) => _set(s.copyWith(checkAccuracy: v)) : null,
      ),
      if (support == SpeechSupport.downloadable)
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: OutlinedButton.icon(
            onPressed: _download,
            icon: const Icon(Icons.download),
            label: Text(l.sttDownload),
          ),
        ),
      if (usable && s.checkAccuracy)
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(l.readCorrection),
          value: s.readCorrection,
          onChanged: (v) => _set(s.copyWith(readCorrection: v)),
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final theme = Theme.of(context);
    final piece = widget.piece;
    final isPlay = piece.kind == PieceKind.play;
    final buildUp = (l.modeBuildUp, l.modeBuildUpHelp);
    // Şiir/metinde "üst üste ekle" en üstte: bu türün asıl ezber yöntemi.
    final modes = {
      if (!isPlay) RehearsalMode.recite: (l.modeRecite, l.modeReciteHelp),
      if (piece.kind == PieceKind.speech) RehearsalMode.pages: (l.modePages, l.modePagesHelp),
      if (!isPlay) RehearsalMode.buildUp: buildUp,
      RehearsalMode.handsFree: (l.modeHandsFree, l.modeHandsFreeHelp),
      if (isPlay) RehearsalMode.buildUp: buildUp,
      RehearsalMode.listen: (l.modeListen, l.modeListenHelp),
      RehearsalMode.waitForMe: (l.modeWait, l.modeWaitHelp),
      RehearsalMode.checkMe: (l.modeCheck, l.modeCheckHelp),
      RehearsalMode.runThrough: (l.modeRun, l.modeRunHelp),
    };
    final hints = [
      (HintLevel.progressive, l.hintProgressive),
      (HintLevel.firstLetters, l.hintFirst),
      (HintLevel.keywords, l.hintKeywords),
      (HintLevel.full, l.hintFull),
      (HintLevel.hidden, l.hintHidden),
    ];
    final weak = piece.weakCount;
    final target = piece.targetSeconds;
    final isPro = AppScope.of(context).pro.isPro.value;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l.mode, style: theme.textTheme.titleMedium),
            RadioGroup<RehearsalMode>(
              groupValue: s.mode,
              onChanged: (m) async {
                // Eller serbest Pro: seçilince abonelik sayfası açılır.
                if (m == RehearsalMode.handsFree && !isPro && !await showProScreen(context)) return;
                if (mounted) _set(s.copyWith(mode: m));
              },
              child: Column(
                children: [
                  for (final e in modes.entries)
                    RadioListTile<RehearsalMode>(
                      value: e.key,
                      title: e.key == RehearsalMode.handsFree && !isPro
                          ? Row(children: [
                              Flexible(child: Text(e.value.$1)),
                              const SizedBox(width: 8),
                              _ProBadge(),
                            ])
                          : Text(e.value.$1),
                      subtitle: Text(e.value.$2),
                      contentPadding: EdgeInsets.zero,
                    ),
                ],
              ),
            ),
            // Zorlandıklarım: yalnızca geçmişte yardım alınan satırlar.
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.fitness_center_outlined),
              title: Text(l.onlyWeak),
              subtitle: Text(weak == 0 ? l.noWeak : '${l.weakCount(weak)} · ${l.onlyWeakHelp}'),
              value: weak > 0 && s.onlyWeak,
              onChanged: weak == 0 ? null : (v) => _set(s.copyWith(onlyWeak: v)),
            ),
            const SizedBox(height: 8),
            Text(l.hint, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            // Beş seviye segment düğmeye sığmıyor: çipler alta taşar.
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                for (final (level, label) in hints)
                  ChoiceChip(
                    label: Text(label),
                    selected: s.hint == level,
                    onSelected: (_) => _set(s.copyWith(hint: level)),
                  ),
              ],
            ),
            if (s.hint == HintLevel.progressive) ...[
              const SizedBox(height: 8),
              Text(l.hideRatio((s.hideRatio * 100).round())),
              Slider(
                value: s.hideRatio,
                min: 0.2,
                max: 1.0,
                divisions: 4,
                label: '%${(s.hideRatio * 100).round()}',
                onChanged: (v) => _set(s.copyWith(hideRatio: v)),
              ),
            ],
            // Sunum: hedef süre (0 = hedef yok).
            if (piece.kind == PieceKind.speech) ...[
              const SizedBox(height: 8),
              Text('${l.targetTime}: ${target == null ? l.targetNone : '${target ~/ 60}:${(target % 60).toString().padLeft(2, '0')}'}'),
              Slider(
                value: ((target ?? 0) / 60).clamp(0, 30).toDouble(),
                min: 0,
                max: 30,
                divisions: 60,
                label: target == null ? l.targetNone : '${(target / 60).toStringAsFixed(1)} min',
                // Hedef değişince sayfa süreleri yeniden paylaştırılır.
                onChanged: (v) => setState(() {
                  piece.targetSeconds = v == 0 ? null : (v * 60).round();
                  piece.pageSeconds = null;
                }),
                onChangeEnd: (_) => widget.onPieceChanged(),
              ),
            ],
            if (s.mode == RehearsalMode.pages) ..._pageTimesSection(l, theme),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.readDirections),
              value: s.readDirections,
              onChanged: (v) => _set(s.copyWith(readDirections: v)),
            ),
            Text(l.pauseLength),
            Slider(
              value: s.gapFactor,
              min: 0.5,
              max: 3.0,
              divisions: 10,
              label: '×${s.gapFactor.toStringAsFixed(2)}',
              onChanged: (v) => _set(s.copyWith(gapFactor: v)),
            ),
            if (s.usesMic) ...[
              Text(l.endSilence),
              Slider(
                value: s.endSilenceSeconds,
                min: 0.4,
                max: 3.0,
                divisions: 13,
                label: '${s.endSilenceSeconds.toStringAsFixed(1)} s',
                onChanged: (v) => _set(s.copyWith(endSilenceSeconds: v)),
              ),
              ..._accuracySection(l, theme),
            ],
          ],
        ),
      ),
    );
  }
}
