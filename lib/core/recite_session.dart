import 'dart:async';

import 'package:flutter/foundation.dart';

import 'models.dart';
import 'recite.dart';

/// Konuşma parçalarını veren mikrofon (uygulamada record + SpeechChunker).
abstract class ReciteMic {
  Future<bool> start(void Function(Float32List pcm16k) onChunk);
  Future<void> stop();
}

/// Bir parçayı yazıya çeviren; [prompt] önceki doğru kelimeler (bağlam).
typedef Transcribe = Future<String> Function(Float32List pcm16k, String prompt);

enum ReciteState { idle, listening, stopped, finished }

/// Ezberden okuma oturumu: dinler, her parçayı tanır ve metinle karşılaştırır.
/// Önemli bir hata bulunca durur ([error]); "Devam" hatalı yerden sürdürür.
class ReciteSession extends ChangeNotifier {
  ReciteSession({required this.piece, required this.mic, required this.transcribe})
      : checker = ReciteChecker.forPiece(piece);

  final Piece piece;
  final ReciteMic mic;
  final Transcribe transcribe;
  final ReciteChecker checker;

  ReciteState _state = ReciteState.idle;
  ReciteState get state => _state;

  /// Durulan hata (state == stopped).
  ReciteError? error;

  /// Son duyulan metin (kullanıcıya "ne anladım" göstermek için).
  String lastHeard = '';

  /// Tanınmayı bekleyen parça sayısı (telefon yavaşsa gösterilir).
  int get pending => _queue.length + (_busy ? 1 : 0);

  final _queue = <Float32List>[];
  bool _busy = false;
  int _epoch = 0; // Durunca eski parçaların sonucu yok sayılır.
  final _watch = Stopwatch();
  Duration get elapsed => _watch.elapsed;

  /// Kullanıcının şu an söylemesi beklenen satır (vurgu/kaydırma).
  int? get currentLine => checker.done ? null : checker.words[checker.pos].line;

  Future<bool> start() async {
    if (checker.words.isEmpty) return false;
    final ok = await mic.start(_onChunk);
    if (!ok) return false;
    _watch.start();
    _set(ReciteState.listening);
    return true;
  }

  /// Hata sonrası "Devam".
  Future<void> resume() async {
    error = null;
    await start();
  }

  /// Kullanıcı bitirdi (ya da vazgeçti): o ana kadarki rapor.
  Future<void> finish() async {
    _epoch++;
    _queue.clear();
    await mic.stop();
    _watch.stop();
    _set(ReciteState.finished);
  }

  void _onChunk(Float32List pcm) {
    if (_state != ReciteState.listening) return;
    _queue.add(pcm);
    notifyListeners();
    _drain();
  }

  Future<void> _drain() async {
    if (_busy) return;
    _busy = true;
    while (_queue.isNotEmpty && _state == ReciteState.listening) {
      final epoch = _epoch;
      final pcm = _queue.removeAt(0);
      String text;
      try {
        text = await transcribe(pcm, checker.contextPrompt());
      } catch (e) {
        debugPrint('Tanıma hatası: $e');
        continue;
      }
      if (epoch != _epoch || _state != ReciteState.listening) break;
      lastHeard = text;
      final step = checker.feed(text);
      _record(step);
      if (checker.done) {
        _busy = false;
        await finish();
        return;
      }
      if (step.stop != null) {
        // Hatayı göster; sonraki parçalar zaten hatadan sonrası, atılır.
        _epoch++;
        _queue.clear();
        error = step.stop;
        _watch.stop();
        await mic.stop();
        _set(ReciteState.stopped);
        break;
      }
      notifyListeners();
    }
    _busy = false;
  }

  /// Hatalı satırlar "zorlandıklarım"a yazılır.
  void _record(ReciteStep step) {
    final e = step.stop;
    if (e == null) return;
    final line = checker.words[e.from].line;
    piece.recordAttempt(piece.lines[line].id, helped: true);
  }

  void _set(ReciteState s) {
    _state = s;
    notifyListeners();
  }

  @override
  void dispose() {
    _epoch++;
    mic.stop();
    super.dispose();
  }
}
