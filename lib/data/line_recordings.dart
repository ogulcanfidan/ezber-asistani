import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';

import '../core/models.dart';
import '../core/rehearsal.dart' show RecordedLines;
import 'piece_repository.dart';

/// Replikleri kullanıcının (ya da bir arkadaşının) sesiyle kaydeder ve
/// provada çalar. Kayıtlar yalnızca telefonda, metnin klasöründe durur.
class LineRecordings implements RecordedLines {
  LineRecordings(this._repository);

  final PieceRepository _repository;
  final _recorder = AudioRecorder();
  AudioPlayer? _player;

  Future<File> fileFor(Piece piece, Line line) async {
    final dir = await _repository.recordingsDir(piece.id);
    await dir.create(recursive: true);
    return File('${dir.path}${Platform.pathSeparator}${line.id}.m4a');
  }

  Future<bool> ensurePermission() => _recorder.hasPermission();

  Future<bool> start(Piece piece, Line line) async {
    if (!await _recorder.hasPermission()) return false;
    await stopPlaying();
    final file = await fileFor(piece, line);
    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc, sampleRate: 44100, numChannels: 1, bitRate: 96000),
      path: file.path,
    );
    return true;
  }

  /// Kaydı bitirir; çok kısaysa (yanlışlıkla dokunma) silinir.
  Future<bool> stop(Piece piece, Line line, {required Duration length}) async {
    await _recorder.stop();
    final file = await fileFor(piece, line);
    if (length < const Duration(milliseconds: 500) || !await file.exists()) {
      if (await file.exists()) await file.delete();
      return false;
    }
    line.recorded = true;
    return true;
  }

  Future<void> delete(Piece piece, Line line) async {
    final file = await fileFor(piece, line);
    if (await file.exists()) await file.delete();
    line.recorded = false;
  }

  /// Kaydı sonuna kadar çalar; kayıt yoksa false (yapay ses kullanılır).
  @override
  Future<bool> play(Piece piece, Line line) async {
    if (!line.recorded) return false;
    final file = await fileFor(piece, line);
    if (!await file.exists()) return false;
    await stopPlaying();
    final player = _player = AudioPlayer();
    try {
      await player.setFilePath(file.path);
      final done = player.playerStateStream.firstWhere(
        (s) => s.processingState == ProcessingState.completed || !identical(_player, player),
      );
      unawaited(player.play());
      await done;
      return true;
    } catch (e) {
      debugPrint('Kayıt çalınamadı: $e');
      return false;
    } finally {
      if (identical(_player, player)) await stopPlaying();
    }
  }

  @override
  Future<void> stopPlaying() async {
    final p = _player;
    _player = null;
    if (p != null) {
      try {
        await p.stop();
        await p.dispose();
      } catch (_) {}
    }
  }
}
