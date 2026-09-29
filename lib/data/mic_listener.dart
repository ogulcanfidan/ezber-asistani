import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:record/record.dart';

import '../core/voice_activity.dart';

/// Mikrofonu yalnızca kullanıcının sırası geldiğinde açar. Ses verisi
/// dosyaya yazılmaz, bellekte anlık seviye hesaplanıp atılır.
class MicLineListener implements LineListener {
  static const _sampleRate = 16000;

  final _recorder = AudioRecorder();
  StreamSubscription<List<int>>? _sub;
  Completer<ListenOutcome>? _done;

  @override
  Future<bool> ensurePermission() => _recorder.hasPermission();

  @override
  Future<ListenResult> listen({
    required String language,
    required Duration promptAfter,
    required Duration endSilence,
  }) async {
    finish(ListenOutcome.cancelled);
    final done = _done = Completer<ListenOutcome>();
    final detector = VoiceActivityDetector(promptAfter: promptAfter, endSilence: endSilence);

    final stream = await _recorder.startStream(const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: _sampleRate,
      numChannels: 1,
      noiseSuppress: true,
      echoCancel: true,
    ));
    _sub = stream.listen((bytes) {
      final result = detector.addPcm16(bytes, _sampleRate);
      if (result != null) finish(result);
    });

    final outcome = await done.future;
    // Mikrofonun kapanmasını beklemeden dön: sonraki replik hemen başlasın.
    final sub = _sub;
    _sub = null;
    unawaited(() async {
      await sub?.cancel();
      await _recorder.stop();
    }());
    return ListenResult(outcome);
  }

  @override
  void finish(ListenOutcome outcome) {
    final d = _done;
    if (d != null && !d.isCompleted) d.complete(outcome);
  }
}

enum SpeechSupport { unavailable, unsupported, downloadable, downloading, installed, unknown }

/// Android'in CİHAZ ÜZERİNDE ses tanıyıcısı (MainActivity.kt). Sunucuya
/// giden tanıyıcıya asla düşmez; cihazda yoksa [available] false döner.
class OnDeviceSpeech {
  static const _channel = MethodChannel('ezber/stt');

  Future<bool> available() async {
    try {
      return await _channel.invokeMethod<bool>('available') ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }

  Future<SpeechSupport> support(String language) => _support('support', language);

  /// Yalnızca dil modelini indirtir; kullanıcının sesi gönderilmez.
  Future<SpeechSupport> download(String language) => _support('download', language);

  Future<SpeechSupport> _support(String method, String language) async {
    try {
      final s = await _channel.invokeMethod<String>(method, {'language': language});
      return SpeechSupport.values.where((v) => v.name == s).firstOrNull ?? SpeechSupport.unknown;
    } on PlatformException {
      return SpeechSupport.unavailable;
    } on MissingPluginException {
      return SpeechSupport.unavailable;
    }
  }

  Future<Map<Object?, Object?>> listen(String language, Duration endSilence) async =>
      await _channel.invokeMethod<Map<Object?, Object?>>(
        'listen',
        {'language': language, 'silenceMs': endSilence.inMilliseconds},
      ) ??
      const {'error': 'null'};

  Future<void> stop({required bool cancel}) async {
    try {
      await _channel.invokeMethod<void>(cancel ? 'cancel' : 'finish');
    } catch (_) {}
  }
}

/// Doğruluk kontrolü açıkken: konuşmayı cihazda yazıya çevirir. Tanıma bu
/// dilde/telefonda yoksa ses seviyesi dinleyicisine geri döner.
class CheckingLineListener implements LineListener {
  CheckingLineListener({
    required this.fallback,
    OnDeviceSpeech? speech,
    Set<String> failedLanguages = const {},
    this.onLanguageFailed,
  })  : speech = speech ?? OnDeviceSpeech(),
        _failedLanguages = {...failedLanguages};

  final LineListener fallback;
  final OnDeviceSpeech speech;

  /// Bir dilde tanıma çalışmadığı anlaşılınca (kalıcı kayıt ve kullanıcıya
  /// bilgi için).
  final void Function(String language)? onLanguageFailed;

  /// Tanımanın çalışmadığı diller: o dilde bir daha denenmez.
  final Set<String> _failedLanguages;

  /// Dil başına: hiç sonuç vermeden art arda "anlaşılamadı" sayısı.
  final _noMatchStreak = <String, int>{};
  final _everRecognized = <String>{};

  void _markFailed(String language) {
    if (_failedLanguages.add(language)) onLanguageFailed?.call(language);
  }
  bool _usingFallback = false;
  bool _active = false;

  @override
  Future<bool> ensurePermission() => fallback.ensurePermission();

  @override
  Future<ListenResult> listen({
    required String language,
    required Duration promptAfter,
    required Duration endSilence,
  }) async {
    if (_failedLanguages.contains(language)) {
      return _viaFallback(language, promptAfter, endSilence);
    }
    final started = DateTime.now();
    // Metin okuma sesi yeni bitti: hoparlörün yankısı tanıyıcıyı şaşırtmasın.
    await Future<void>.delayed(const Duration(milliseconds: 250));
    _active = true;
    final result = await speech.listen(language, endSilence);
    _active = false;
    // Söylenen metin yalnızca geliştirme sürümünde loglanır.
    if (kDebugMode) debugPrint('EzberSTT sonuç: $result');
    final error = result['error'] as String?;
    if (error == null) {
      final texts = (result['texts'] as List?)?.cast<String>() ?? const [];
      _everRecognized.add(language);
      _noMatchStreak[language] = 0;
      return ListenResult(ListenOutcome.spoke, transcripts: texts);
    }
    // Suflöre tanıyıcının kendi zaman aşımı değil, bizim bekleme süremiz
    // karar verir: tanıyıcı erken "sessiz" derse kalan süre ses seviyesiyle
    // dinlenir. (Telefonda tanıyıcı AHMET'in sesi biter bitmez "konuşma
    // yok" döndü ve suflör kullanıcı konuşamadan devreye girdi.)
    final remaining = promptAfter - DateTime.now().difference(started);
    switch (error) {
      case 'cancelled':
        return ListenResult.cancelled;
      case 'silent':
        if (remaining > const Duration(milliseconds: 500)) {
          return _viaFallback(language, remaining, endSilence);
        }
        return ListenResult.silent;
      case 'nomatch':
        // Honor/Android 13'te görüldü: tanıyıcı konuşmanın başladığını
        // duyup 0,1 sn sonra "anlaşılamadı" diyor — kullanıcı daha ilk
        // kelimedeyken. Replik atlanmaz: kullanıcı konuşmaya devam ediyor,
        // bitişi ses seviyesiyle beklenir. Hiç tanıma yapamadan iki kez
        // olursa bu dilde tanıma çalışmıyor demektir.
        final streak = (_noMatchStreak[language] ?? 0) + 1;
        _noMatchStreak[language] = streak;
        if (streak >= 2 && !_everRecognized.contains(language)) _markFailed(language);
        final r = await _viaFallback(language, promptAfter, endSilence);
        // Anlaşılamadı ama söyledi: puanlanmaz, "anlaşılamadı" gösterilir.
        return r.outcome == ListenOutcome.spoke
            ? const ListenResult(ListenOutcome.spoke, transcripts: [])
            : r;
      default:
        // Ses duymadan boş sonuç, dil paketi yok, tanıyıcı meşgul vb.: bu
        // dilde ses seviyesine geç ve bu repliği de öyle dinlemeye devam et.
        _markFailed(language);
        return _viaFallback(language, remaining > Duration.zero ? remaining : promptAfter, endSilence);
    }
  }

  Future<ListenResult> _viaFallback(String language, Duration promptAfter, Duration endSilence) async {
    _usingFallback = true;
    final r = await fallback.listen(language: language, promptAfter: promptAfter, endSilence: endSilence);
    _usingFallback = false;
    return r;
  }

  bool failedFor(String language) => _failedLanguages.contains(language);

  @override
  void finish(ListenOutcome outcome) {
    if (_usingFallback) return fallback.finish(outcome);
    if (!_active) return;
    // "Devam": tanıyıcıyı durdur, o ana kadar duyulanın sonucunu al.
    speech.stop(cancel: outcome == ListenOutcome.cancelled);
  }
}
