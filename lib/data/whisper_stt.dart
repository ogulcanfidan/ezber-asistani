import 'dart:async';
import 'dart:io' show Platform;
import 'dart:math';
import 'dart:typed_data';

import 'package:record/record.dart';
import 'package:whisper_cpp_flutter_plus/whisper_cpp_flutter_plus.dart';

import '../core/recite_session.dart';

/// Ezberden okuma kontrolü için telefonda çalışan konuşma tanıma (Whisper,
/// whisper.cpp — MIT). Ücretsiz; model bir kez indirilir, ses telefondan
/// çıkmaz.

/// İndirilebilir modeller. Karma sağlama (SHA-256) indirilen dosyayı doğrular;
/// adresler değişmeyen bir sürüme sabitlenmiştir.
enum ReciteModel {
  /// ~60 MB: hızlı, çoğu telefon için.
  standard(
    WhisperModelDescriptor(
      id: 'base-q5_1',
      fileName: 'ggml-base-q5_1.bin',
      url: 'https://huggingface.co/ggerganov/whisper.cpp/resolve/'
          '5359861c739e955e79d9a303bcbc70fb988958b1/ggml-base-q5_1.bin',
      sha256: '422f1ae452ade6f30a004d7e5c6a43195e4433bc370bf23fac9cc591f01a8898',
      approximateBytes: 59707625,
      languageScope: WhisperModelLanguageScope.multilingual,
      purpose: WhisperModelPurpose.transcription,
    ),
  ),

  /// ~190 MB: daha doğru (özellikle Türkçe), daha yavaş.
  accurate(
    WhisperModelDescriptor(
      id: 'small-q5_1',
      fileName: 'ggml-small-q5_1.bin',
      url: 'https://huggingface.co/ggerganov/whisper.cpp/resolve/'
          '5359861c739e955e79d9a303bcbc70fb988958b1/ggml-small-q5_1.bin',
      sha256: 'ae85e4a935d7a567bd102fe55afc16bb595bdb618e11b2fc7591bc08120411bb',
      approximateBytes: 190085487,
      languageScope: WhisperModelLanguageScope.multilingual,
      purpose: WhisperModelPurpose.transcription,
    ),
  );

  const ReciteModel(this.descriptor);
  final WhisperModelDescriptor descriptor;

  int get megabytes => (descriptor.approximateBytes / 1e6).round();
}

/// Konuşma parçasını yazıya çeviren (testlerde sahte).
abstract class Transcriber {
  Future<String> transcribe(Float32List pcm16k, {required String language, String? prompt});
  Future<void> dispose();
}

class WhisperTranscriber implements Transcriber {
  WhisperTranscriber._(this._engine);

  final WhisperEngine _engine;

  static Future<WhisperTranscriber> load(String modelPath) async =>
      WhisperTranscriber._(await WhisperEngine.load(modelPath));

  @override
  Future<String> transcribe(Float32List pcm16k, {required String language, String? prompt}) async {
    final result = await _engine
        .transcribe(
          pcm16k,
          options: TranscribeOptions(
            language: language,
            threads: max(2, min(4, Platform.numberOfProcessors)),
            initialPrompt: (prompt == null || prompt.isEmpty) ? null : prompt,
            tokenTimestamps: false,
            noTimestamps: true,
            singleSegment: true,
            suppressNonSpeechTokens: true,
          ),
        )
        .result;
    return result.text.trim();
  }

  @override
  Future<void> dispose() async => _engine.dispose();
}

/// İndirme / kurulu mu / silme.
class ReciteModels {
  ReciteModels({WhisperModelManager? manager}) : _manager = manager ?? WhisperModelManager();

  final WhisperModelManager _manager;

  /// Kurulu model dosyasının yolu; yoksa null. (Tam doğrulama indirmede
  /// yapılır; her açılışta 60–190 MB dosyanın özetini almak yavaş olur.)
  Future<String?> installedPath(ReciteModel model) async =>
      (await _manager.find(model.descriptor.fileName))?.path;

  /// Kurulu olanların en iyisi.
  Future<(ReciteModel, String)?> best() async {
    for (final m in [ReciteModel.accurate, ReciteModel.standard]) {
      final p = await installedPath(m);
      if (p != null) return (m, p);
    }
    return null;
  }

  /// 0–1 ilerleme akışı; biterken doğrulanır.
  Stream<double> download(ReciteModel model) =>
      _manager.downloadCatalogModel(model.descriptor).map((p) => p.total == 0 ? 0 : p.received / p.total);

  Future<void> delete(ReciteModel model) => _manager.delete(model.descriptor.fileName);
}

/// Mikrofon akışını (16 kHz, 16 bit) konuşma parçalarına böler: kısa bir
/// duraklamada ya da parça uzayınca keser. Her parça ayrı tanınır ki hata
/// cümle bitmeden yakalansın.
class SpeechChunker {
  SpeechChunker({
    this.endSilence = const Duration(milliseconds: 700),
    this.maxChunk = const Duration(seconds: 12),
  });

  final Duration endSilence;
  final Duration maxChunk;

  static const _rate = 16000;
  static const _frame = 1600; // 100 ms

  final _pending = <int>[]; // Çerçeveye tamamlanmamış örnekler.
  final _chunk = <double>[];
  final _preRoll = <Float32List>[];
  double? _floor;
  final _calib = <double>[];
  bool _inSpeech = false;
  int _speechFrames = 0;
  int _silentMs = 0;

  /// Eşik: ortam gürültüsünün 12 dB üstü (en az -50 dBFS).
  double get threshold => max((_floor ?? -60) + 12, -50);

  /// PCM16 LE baytları ekler; biten parçaları döndürür.
  List<Float32List> addPcm16(Uint8List bytes) {
    final data = ByteData.sublistView(bytes);
    for (var i = 0; i + 1 < bytes.length; i += 2) {
      _pending.add(data.getInt16(i, Endian.little));
    }
    final out = <Float32List>[];
    while (_pending.length >= _frame) {
      final f = Float32List(_frame);
      for (var i = 0; i < _frame; i++) {
        f[i] = _pending[i] / 32768;
      }
      _pending.removeRange(0, _frame);
      final chunk = _addFrame(f);
      if (chunk != null) out.add(chunk);
    }
    return out;
  }

  /// Kalan konuşmayı bitmiş sayar (durdururken).
  Float32List? flush() {
    if (!_inSpeech || _chunk.isEmpty) return null;
    return _emit();
  }

  Float32List? _addFrame(Float32List f) {
    var sum = 0.0;
    for (final s in f) {
      sum += s * s;
    }
    final db = 10 * log(sum / f.length + 1e-12) / ln10;

    if (_floor == null) {
      _calib.add(db);
      if (_calib.length >= 3) _floor = _calib.reduce(min);
      return null;
    }
    final loud = db > threshold;

    if (!_inSpeech) {
      // Konuşma başlangıcı kaçmasın diye son 300 ms tutulur.
      _preRoll.add(f);
      if (_preRoll.length > 3) _preRoll.removeAt(0);
      _speechFrames = loud ? _speechFrames + 1 : 0;
      if (_speechFrames >= 2) {
        _inSpeech = true;
        _silentMs = 0;
        for (final p in _preRoll) {
          _chunk.addAll(p);
        }
        _preRoll.clear();
      } else if (!loud) {
        // Sessizken ortam seviyesini yavaşça izle.
        _floor = _floor! * 0.95 + db * 0.05;
      }
      return null;
    }

    _chunk.addAll(f);
    _silentMs = loud ? 0 : _silentMs + 100;
    final lengthMs = _chunk.length * 1000 ~/ _rate;
    final tooLong = lengthMs >= maxChunk.inMilliseconds;
    // Uzun parçada ilk kısa duraklamada (300 ms) kes; 15 sn'de her halükârda.
    if (_silentMs >= endSilence.inMilliseconds ||
        (tooLong && _silentMs >= 300) ||
        lengthMs >= maxChunk.inMilliseconds + 3000) {
      return _emit();
    }
    return null;
  }

  Float32List _emit() {
    final out = Float32List.fromList(_chunk);
    _chunk.clear();
    _inSpeech = false;
    _speechFrames = 0;
    _silentMs = 0;
    return out;
  }
}

/// Uygulamadaki mikrofon: 16 kHz PCM akışı parçalara bölünür.
class RecordReciteMic implements ReciteMic {
  final _recorder = AudioRecorder();
  StreamSubscription<Uint8List>? _sub;

  @override
  Future<bool> start(void Function(Float32List pcm16k) onChunk) async {
    if (!await _recorder.hasPermission()) return false;
    await stop();
    final chunker = SpeechChunker();
    final stream = await _recorder.startStream(const RecordConfig(
      encoder: AudioEncoder.pcm16bits,
      sampleRate: 16000,
      numChannels: 1,
    ));
    _sub = stream.listen((bytes) {
      for (final c in chunker.addPcm16(bytes)) {
        onChunk(c);
      }
    });
    return true;
  }

  @override
  Future<void> stop() async {
    await _sub?.cancel();
    _sub = null;
    try {
      await _recorder.stop();
    } catch (_) {}
  }
}
