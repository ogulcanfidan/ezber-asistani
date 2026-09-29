import 'package:ezber_asistani/core/hints.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/core/voice_activity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_test.dart' show FakeSpeaker;
import 'hands_free_test.dart' show FakeListener;

Piece poem(String text) => const ScriptParser()
    .parse(text: text, title: 'şiir', kind: PieceKind.poem, language: 'tr-TR');

void main() {
  group('Kademeli silme', () {
    const line = 'Korkma sönmez bu şafaklarda yüzen al sancak';

    int hiddenCount(double ratio) =>
        applyHint(line, HintLevel.progressive, hideRatio: ratio, seed: 'x').split(' ').where((w) => w.startsWith('_')).length;

    test('oran arttıkça daha çok kelime gizlenir, %100 hepsi', () {
      final counts = [0.2, 0.4, 0.6, 0.8, 1.0].map(hiddenCount).toList();
      for (var i = 1; i < counts.length; i++) {
        expect(counts[i], greaterThanOrEqualTo(counts[i - 1]));
      }
      expect(counts.last, 7);
    });

    test('oran artınca önceden gizlenenler gizli kalır (üst küme)', () {
      for (var i = 0; i < 7; i++) {
        if (wordHidden('x', i, 0.4)) expect(wordHidden('x', i, 0.6), isTrue);
      }
    });

    test('aynı satır her turda aynı kelimeleri gizler', () {
      expect(applyHint(line, HintLevel.progressive, hideRatio: 0.4, seed: 'a'),
          applyHint(line, HintLevel.progressive, hideRatio: 0.4, seed: 'a'));
    });
  });

  test('anahtar kelimeler: kısa kelimeler tek "…" ile toplanır', () {
    expect(applyHint('Bugün size yeni projemizi anlatacağım', HintLevel.keywords),
        'Bugün … projemizi anlatacağım');
    expect(applyHint('Satışlar 2025 yılında %40 arttı', HintLevel.keywords), 'Satışlar 2025 yılında %40 arttı');
  });

  group('Üst üste ekleme', () {
    test('1, 1–2, 1–3: her yeni satır önce okunur, sonra baştan söylenir', () async {
      final p = poem('Bir\nİki\nÜç');
      final speaker = FakeSpeaker();
      final mic = FakeListener();
      final c = RehearsalController(
        piece: p,
        speaker: speaker,
        listener: mic,
        settings: const RehearsalSettings(mode: RehearsalMode.buildUp),
        wait: (_) async {},
      );
      await c.play(from: 0);
      // Okunanlar: yeni satırların tanıtımı. Kullanıcı 1+2+3 = 6 kez söyledi.
      expect(speaker.said, ['Bir', 'İki', 'Üç']);
      expect(mic.calls, 6);
      expect(c.buildTotal, 3);
      expect(c.outcome, RehearsalOutcome.perfect);
    });

    test('oyunda karşı replik ipucu olarak her adımda okunur', () async {
      final p = const ScriptParser().parse(
          text: 'ALİ: Merhaba.\nVELİ: Selam.\nALİ: Nasılsın?\nVELİ: İyiyim.',
          title: 't',
          kind: PieceKind.play,
          language: 'tr-TR');
      p.myCharacterIds.add(p.characters[1].id);
      final speaker = FakeSpeaker();
      final c = RehearsalController(
        piece: p,
        speaker: speaker,
        listener: FakeListener(),
        settings: const RehearsalSettings(mode: RehearsalMode.buildUp),
        wait: (_) async {},
      );
      await c.play(from: 0);
      expect(speaker.said, [
        'Selam.', 'Merhaba.', // adım 1: tanıtım, sonra ALİ ipucu, ben
        'İyiyim.', 'Merhaba.', 'Nasılsın?', // adım 2
      ]);
    });
  });

  group('Zorlandıklarım', () {
    late Piece p;
    setUp(() {
      p = const ScriptParser().parse(
          text: 'ALİ: Bir.\nVELİ: İki.\nALİ: Üç.\nVELİ: Dört.\nALİ: Beş.\nVELİ: Altı.',
          title: 't',
          kind: PieceKind.play,
          language: 'tr-TR');
      p.myCharacterIds.add(p.characters[1].id);
    });

    test('suflör alınan satır zor olarak kaydedilir ve yedekte korunur', () async {
      final mic = FakeListener()..queue.addAll([ListenResult.spoke, ListenResult.silent, ListenResult.spoke, ListenResult.spoke]);
      var saves = 0;
      final c = RehearsalController(
        piece: p,
        speaker: FakeSpeaker(),
        listener: mic,
        settings: const RehearsalSettings(mode: RehearsalMode.handsFree),
        onPieceChanged: () => saves++,
        wait: (_) async {},
      );
      await c.play(from: 0);
      expect(p.weakCount, 1);
      expect(p.isWeak(p.lines[3]), isTrue, reason: '"Dört." satırında suflör alındı');
      expect(saves, 3);
      expect(Piece.fromJson(p.toJson()).weakCount, 1);
    });

    test('yalnızca zor satır ve öncesindeki ipucu çalınır', () async {
      p.recordAttempt(p.lines[3].id, helped: true);
      final speaker = FakeSpeaker();
      final mic = FakeListener();
      final c = RehearsalController(
        piece: p,
        speaker: speaker,
        listener: mic,
        settings: const RehearsalSettings(mode: RehearsalMode.handsFree, onlyWeak: true),
        wait: (_) async {},
      );
      await c.play(from: 0);
      expect(speaker.said, ['Üç.'], reason: 'yalnızca ipucu replik');
      expect(mic.calls, 1, reason: 'yalnızca zor satır');
    });

    test('düzeltince satır artık zor sayılmaz', () {
      p.recordAttempt(p.lines[3].id, helped: true);
      expect(p.weakCount, 1);
      p.recordAttempt(p.lines[3].id, helped: false, score: 95);
      expect(p.weakCount, 0);
    });

    test('Beni bekle: Göster/İpucu kullanılırsa yardım alınmış sayılır', () async {
      final c = RehearsalController(piece: p, speaker: FakeSpeaker(), wait: (_) async {});
      final done = c.play(from: 0);
      await pumpEventQueue();
      c.giveHint();
      c.userContinue();
      await pumpEventQueue();
      c.userContinue();
      await pumpEventQueue();
      c.userContinue();
      await done;
      expect(p.isWeak(p.lines[1]), isTrue);
      expect(p.isWeak(p.lines[3]), isFalse);
      expect(c.outcome, isNot(RehearsalOutcome.perfect));
    });
  });

  test('kademeli silmede hatasız tur seviyeyi artırır', () async {
    final p = poem('Bir iki\nÜç dört');
    final c = RehearsalController(
      piece: p,
      speaker: FakeSpeaker(),
      listener: FakeListener(),
      settings: const RehearsalSettings(mode: RehearsalMode.handsFree, hint: HintLevel.progressive, hideRatio: 0.4),
      wait: (_) async {},
    );
    await c.play(from: 0);
    expect(c.leveledUpTo, 0.6);
    expect(c.settings.hideRatio, 0.6);
  });

  test('takılınca seviye artmaz', () async {
    final p = poem('Bir iki\nÜç dört');
    final c = RehearsalController(
      piece: p,
      speaker: FakeSpeaker(),
      listener: FakeListener()..queue.addAll([ListenResult.silent, ListenResult.spoke, ListenResult.spoke]),
      settings: const RehearsalSettings(mode: RehearsalMode.handsFree, hint: HintLevel.progressive, hideRatio: 0.4),
      wait: (_) async {},
    );
    await c.play(from: 0);
    expect(c.leveledUpTo, isNull);
    expect(c.settings.hideRatio, 0.4);
  });

  test('ayarların yeni alanları JSON\'da korunur', () {
    const s = RehearsalSettings(mode: RehearsalMode.buildUp, hint: HintLevel.keywords, hideRatio: 0.6, onlyWeak: true);
    final back = RehearsalSettings.fromJson(s.toJson());
    expect(back.mode, RehearsalMode.buildUp);
    expect(back.hint, HintLevel.keywords);
    expect(back.hideRatio, 0.6);
    expect(back.onlyWeak, isTrue);
    expect(back.usesMic, isTrue);
  });

  test('sunum hedef süresi yedekte korunur', () {
    final p = poem('Merhaba');
    p.targetSeconds = 300;
    expect(Piece.fromJson(p.toJson()).targetSeconds, 300);
  });
}
