import 'package:ezber_asistani/core/hints.dart';
import 'package:ezber_asistani/core/line_check.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/core/voice_activity.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_test.dart' show FakeSpeaker;
import 'hands_free_test.dart' show FakeListener;

void main() {
  group('checkLine', () {
    test('birebir doğru', () {
      final c = checkLine('Dışarı. Hemen dönerim.', 'dışarı hemen dönerim');
      expect(c.score, 100);
      expect(c.missed, isEmpty);
    });

    test('tanıyıcının aksan ve büyük/küçük harf farkları hata sayılmaz', () {
      expect(checkLine('Dışarı. Hemen dönerim.', 'DISARI HEMEN DONERIM').score, 100);
      expect(checkLine('İstanbul çok güzel', 'istanbul cok guzel').score, 100);
      expect(checkLine('Où est la gare?', 'ou est la gare').score, 100);
    });

    test('küçük ek/harf hataları tolere edilir, kısa kelimeler birebir', () {
      expect(checkLine('Nereye gidiyorsun', 'nereye gidiyorsu').score, 100);
      expect(checkLine('bir iki', 'bir üç').score, 50);
    });

    test('atlanan kelimeler listelenir ve puanı düşürür', () {
      final c = checkLine('Dışarı. Hemen dönerim.', 'dışarı dönerim');
      expect(c.missed, ['Hemen']);
      expect(c.score, 67);
    });

    test('fazladan kelime puanı düşürmez ama kaydedilir', () {
      final c = checkLine('Bekle beni', 'eee bekle beni lütfen');
      expect(c.score, 100);
      expect(c.extra, ['eee', 'lütfen']);
    });

    test('sıra karışırsa hizalama en iyi eşleşmeyi bulur', () {
      final c = checkLine('bugün hava çok güzel', 'hava bugün çok güzel');
      expect(c.score, 75);
    });

    test('birden çok tanıma sonucundan en iyisi seçilir', () {
      final c = checkBest('Bekle beni', ['bekler peni', 'bekle beni', 'beklemeni']);
      expect(c.score, 100);
      expect(c.heard, 'bekle beni');
    });

    test('hiçbir şey duyulmadı', () {
      final c = checkBest('Bekle beni', const []);
      expect(c.score, 0);
      expect(c.heard, '');
    });
  });

  group('Suflör yardımcıları', () {
    test('fısıldanacak kelime sayısı', () {
      expect(promptWordCount('Bir'), 1);
      expect(promptWordCount('Dışarı. Hemen dönerim.'), 1);
      expect(promptWordCount('Bir iki üç dört beş altı'), 2);
      expect(promptWordCount(List.filled(30, 'kelime').join(' ')), 4);
    });

    test('ilk kelimeler noktalamasıyla', () {
      expect(firstWords('Dışarı. Hemen dönerim.', 1), 'Dışarı');
      expect(firstWords('Dışarı. Hemen dönerim.', 2), 'Dışarı. Hemen');
      expect(firstWords('Dışarı. Hemen dönerim.', 9), 'Dışarı. Hemen dönerim.');
    });

    test('açılan kelimeler ipucunda tam görünür', () {
      expect(applyHint('Dışarı. Hemen dönerim.', HintLevel.firstLetters, revealWords: 1), 'Dışarı. H____ d______.');
      expect(applyHint('Dışarı. Hemen dönerim.', HintLevel.hidden, revealWords: 2), 'Dışarı. Hemen …');
      expect(applyHint('Dışarı. Hemen dönerim.', HintLevel.hidden), '');
    });
  });

  group('Eller serbest — suflör ve doğruluk', () {
    late Piece p;
    late FakeSpeaker speaker;
    late FakeListener mic;
    late FakeListener checker;

    setUp(() {
      p = const ScriptParser().parse(
        text: 'ALİ: Nereye?\nVELİ: Dışarı. Hemen dönerim bir saate kadar.\nALİ: Tamam.',
        title: 't',
        kind: PieceKind.play,
        language: 'tr-TR',
      );
      p.myCharacterIds.add(p.characters[1].id);
      speaker = FakeSpeaker();
      mic = FakeListener();
      checker = FakeListener();
    });

    RehearsalController ctrl({bool check = false, bool correction = true}) => RehearsalController(
          piece: p,
          speaker: speaker,
          listener: mic,
          checkingListener: checker,
          settings: RehearsalSettings(
            mode: RehearsalMode.handsFree,
            checkAccuracy: check,
            readCorrection: correction,
          ),
          wait: (_) async {},
        );

    test('takılınca önce ilk kelimeler fısıldanır, sonra söylerse devam', () async {
      mic.queue.addAll([ListenResult.silent, ListenResult.spoke]);
      final c = ctrl();
      await c.play(from: 0);
      expect(speaker.said, ['Nereye?', 'Dışarı. Hemen', 'Tamam.']);
      expect(mic.calls, 2);
      expect(c.promptsUsed, 1);
    });

    test('suflörden sonra da takılırsa replik tamamen okunur', () async {
      mic.queue.addAll([ListenResult.silent, ListenResult.silent]);
      final c = ctrl();
      await c.play(from: 0);
      expect(speaker.said, ['Nereye?', 'Dışarı. Hemen', 'Dışarı. Hemen dönerim bir saate kadar.', 'Tamam.']);
      expect(c.promptsUsed, 2);
    });

    test('doğruluk kontrolü kapalıyken tanıyıcı kullanılmaz', () async {
      await ctrl().play(from: 0);
      expect(checker.calls, 0);
      expect(mic.calls, 1);
    });

    test('doğru söylenince puan kaydedilir, doğrusu okunmaz', () async {
      checker.queue.add(const ListenResult(ListenOutcome.spoke,
          transcripts: ['dışarı hemen dönerim bir saate kadar']));
      final c = ctrl(check: true);
      await c.play(from: 0);
      final line = p.lines[1];
      expect(c.checks[line.id]!.score, 100);
      expect(c.averageScore, 100);
      expect(speaker.said, ['Nereye?', 'Tamam.']);
      expect(checker.lastLanguage, 'tr-TR');
    });

    test('yanlış söylenince doğrusu okunur (ayar açıksa)', () async {
      checker.queue.add(const ListenResult(ListenOutcome.spoke, transcripts: ['dışarı çıkıyorum']));
      final c = ctrl(check: true);
      await c.play(from: 0);
      expect(c.checks[p.lines[1].id]!.score, lessThan(RehearsalController.correctionThreshold));
      expect(speaker.said, ['Nereye?', 'Dışarı. Hemen dönerim bir saate kadar.', 'Tamam.']);
    });

    test('düzeltme okuma kapalıysa yanlışta da okunmaz', () async {
      checker.queue.add(const ListenResult(ListenOutcome.spoke, transcripts: ['dışarı çıkıyorum']));
      await ctrl(check: true, correction: false).play(from: 0);
      expect(speaker.said, ['Nereye?', 'Tamam.']);
    });

    test('anlaşılamayınca doğrusu okunmaz ve ortalamaya katılmaz', () async {
      checker.queue.add(const ListenResult(ListenOutcome.spoke, transcripts: []));
      final c = ctrl(check: true);
      await c.play(from: 0);
      expect(c.checks[p.lines[1].id]!.heard, '');
      expect(c.averageScore, isNull);
      expect(speaker.said, ['Nereye?', 'Tamam.']);
    });

    test('prova sonu değerlendirmesi: "tebrikler" yalnızca yardımsız bitince', () async {
      checker.queue.add(const ListenResult(ListenOutcome.spoke,
          transcripts: ['dışarı hemen dönerim bir saate kadar']));
      final perfect = ctrl(check: true);
      await perfect.play(from: 0);
      expect(perfect.outcome, RehearsalOutcome.perfect);

      mic.queue.addAll([ListenResult.silent, ListenResult.spoke]);
      final helped = ctrl();
      await helped.play(from: 0);
      expect(helped.prompted, hasLength(1));
      expect(helped.outcome, RehearsalOutcome.needsPractice, reason: 'tek replikte yardım aldı');

      checker.queue.add(const ListenResult(ListenOutcome.spoke, transcripts: []));
      final unclear = ctrl(check: true);
      await unclear.play(from: 0);
      expect(unclear.unclear, hasLength(1));
      expect(unclear.outcome, isNot(RehearsalOutcome.perfect), reason: 'anlaşılamadıysa tebrik yok');

      final neutral = RehearsalController(piece: p, speaker: speaker, settings: const RehearsalSettings(mode: RehearsalMode.listen));
      await neutral.play(from: 0);
      expect(neutral.outcome, RehearsalOutcome.neutral);
    });

    test('baştan başlayınca sonuçlar sıfırlanır', () async {
      checker.queue.add(const ListenResult(ListenOutcome.spoke, transcripts: ['dışarı']));
      final c = ctrl(check: true);
      await c.play(from: 0);
      expect(c.checks, isNotEmpty);
      checker.queue.add(ListenResult.silent);
      checker.queue.add(ListenResult.spoke);
      await c.play(from: 0);
      expect(c.checks, isEmpty);
      expect(c.promptsUsed, 1);
    });
  });

  test('Beni bekle: İpucu her dokunuşta bir kelime açar', () async {
    final p = const ScriptParser()
        .parse(text: 'ALİ: Nereye?\nVELİ: Dışarı. Hemen dönerim.', title: 't', kind: PieceKind.play, language: 'tr-TR');
    p.myCharacterIds.add(p.characters[1].id);
    final c = RehearsalController(piece: p, speaker: FakeSpeaker(), wait: (_) async {});
    final done = c.play(from: 0);
    await pumpEventQueue();
    expect(c.displayText(c.currentLine!), 'D_____. H____ d______.');
    c.giveHint();
    expect(c.displayText(c.currentLine!), 'Dışarı. H____ d______.');
    c.giveHint();
    expect(c.displayText(c.currentLine!), 'Dışarı. Hemen d______.');
    c.userContinue();
    await done;
  });
}
