import 'dart:io';

import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/data/piece_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_test.dart' show FakeSpeaker;

class _Recs implements RecordedLines {
  final played = <String>[];
  final missing = <String>{};

  @override
  Future<bool> play(Piece piece, Line line) async {
    if (missing.contains(line.text)) return false;
    played.add(line.text);
    return true;
  }

  @override
  Future<void> stopPlaying() async {}
}

void main() {
  test('kayıtlı karşı replik yapay ses yerine çalınır; dosyası yoksa yapay ses', () async {
    final p = const ScriptParser().parse(
      text: 'ALİ: Merhaba.\nVELİ: Selam.\nALİ: Nasılsın?\nVELİ: İyiyim.',
      title: 't',
      kind: PieceKind.play,
      language: 'tr-TR',
    );
    p.myCharacterIds.add(p.characters[1].id);
    p.lines[0].recorded = true;
    p.lines[2].recorded = true;
    final recs = _Recs()..missing.add('Nasılsın?');
    final speaker = FakeSpeaker();
    await RehearsalController(
      piece: p,
      speaker: speaker,
      recordings: recs,
      settings: const RehearsalSettings(mode: RehearsalMode.runThrough),
      wait: (_) async {},
    ).play(from: 0);
    expect(recs.played, ['Merhaba.']);
    expect(speaker.said, ['Nasılsın?'], reason: 'kayıt dosyası silinmiş: yapay sese düşer');
    expect(Piece.fromJson(p.toJson()).lines[0].recorded, isTrue);
  });

  test('metin silinince ses kayıtları da silinir', () async {
    final tmp = Directory.systemTemp.createTempSync('ezber_rec');
    addTearDown(() => tmp.deleteSync(recursive: true));
    final repo = PieceRepository(tmp);
    final p = const ScriptParser().parse(text: 'A: Bir.', title: 't', kind: PieceKind.play, language: 'tr-TR');
    await repo.save(p);
    final dir = await repo.recordingsDir(p.id);
    await File('${dir.path}/x.m4a').create(recursive: true);
    await repo.delete(p.id);
    expect(await dir.exists(), isFalse);
  });
}
