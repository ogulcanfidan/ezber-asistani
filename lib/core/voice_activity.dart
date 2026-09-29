import 'dart:math';
import 'dart:typed_data';

enum ListenOutcome {
  /// Kullanıcı konuştu ve sustu: repliğini söyledi.
  spoke,

  /// Hiç konuşmadı: takıldı, suflör devreye girer.
  silent,

  /// Prova durduruldu.
  cancelled,
}

class ListenResult {
  const ListenResult(this.outcome, {this.transcripts});

  final ListenOutcome outcome;

  /// Doğruluk kontrolü açıksa tanıyıcının duyduğu olası metinler; ses
  /// seviyesiyle çalışan dinleyicide null.
  final List<String>? transcripts;

  static const spoke = ListenResult(ListenOutcome.spoke);
  static const silent = ListenResult(ListenOutcome.silent);
  static const cancelled = ListenResult(ListenOutcome.cancelled);
}

/// Eller serbest mod: kullanıcının sırasında dinler.
abstract class LineListener {
  Future<bool> ensurePermission();

  Future<ListenResult> listen({
    required String language,
    required Duration promptAfter,
    required Duration endSilence,
  });

  /// Dinlemeyi verilen sonuçla bitirir (ör. kullanıcı yine de Devam'a bastı).
  void finish(ListenOutcome outcome);
}

/// Ses seviyesinden konuşmanın başlayıp bittiğini anlar. Konuşmayı yazıya
/// çevirmez, sesi saklamaz; yalnızca anlık seviyeye bakar. Bu sayede her
/// dilde aynı çalışır ve ses telefondan dışarı çıkmaz.
class VoiceActivityDetector {
  VoiceActivityDetector({
    required this.promptAfter,
    required this.endSilence,
    this.calibration = const Duration(milliseconds: 300),
    this.minSpeech = const Duration(milliseconds: 250),
    this.maxLine = const Duration(seconds: 90),
    this.marginDb = 12,
    this.minThresholdDb = -50,
  });

  final Duration promptAfter;
  final Duration endSilence;
  final Duration calibration;
  final Duration minSpeech;
  final Duration maxLine;

  /// Konuşma, ortam gürültüsünden en az bu kadar yüksek olmalı.
  final double marginDb;

  /// Çok sessiz ortamda nefes sesinin konuşma sanılmaması için alt sınır.
  final double minThresholdDb;

  final _calibrationLevels = <double>[];
  Duration _elapsed = Duration.zero;
  Duration _loud = Duration.zero;
  Duration _quiet = Duration.zero;
  double? _threshold;
  bool _speaking = false;

  bool get speechStarted => _speaking;
  double? get threshold => _threshold;

  /// Bir ölçüm ekler; karar verildiyse sonucu döner.
  ListenOutcome? add(double levelDb, Duration frame) {
    _elapsed += frame;

    if (_threshold == null) {
      _calibrationLevels.add(levelDb);
      if (_elapsed < calibration) return null;
      // Kullanıcı hemen konuşmaya başlamış olabilir: ortamı en sessiz
      // ölçümlerden tahmin et.
      final sorted = [..._calibrationLevels]..sort();
      final noise = sorted[(sorted.length * 0.2).floor()];
      _threshold = max(noise + marginDb, minThresholdDb);
      return null;
    }

    if (levelDb >= _threshold!) {
      _loud += frame;
      _quiet = Duration.zero;
      if (_loud >= minSpeech) _speaking = true;
    } else {
      _quiet += frame;
      if (!_speaking) _loud = Duration.zero;
    }

    if (_speaking && (_quiet >= endSilence || _elapsed >= maxLine)) return ListenOutcome.spoke;
    if (!_speaking && _elapsed >= promptAfter) return ListenOutcome.silent;
    return null;
  }

  /// 16 bit PCM (little-endian, mono) parçası ekler.
  ListenOutcome? addPcm16(Uint8List bytes, int sampleRate) {
    final samples = bytes.length ~/ 2;
    if (samples == 0) return null;
    final data = ByteData.sublistView(bytes);
    var sum = 0.0;
    for (var i = 0; i < samples; i++) {
      final s = data.getInt16(i * 2, Endian.little) / 32768.0;
      sum += s * s;
    }
    final rms = sqrt(sum / samples);
    final db = rms <= 0 ? -100.0 : 20 * log(rms) / ln10;
    return add(db, Duration(microseconds: samples * 1000000 ~/ sampleRate));
  }
}
