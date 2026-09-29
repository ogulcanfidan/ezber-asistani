import 'dart:async';

import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/core/speech_pages.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_test.dart' show FakeSpeaker;

Piece speech(String text, {int? target}) {
  final p = const ScriptParser().parse(text: text, title: 't', kind: PieceKind.speech, language: 'tr-TR');
  p.targetSeconds = target;
  return p;
}

const cues = SpeechCues(page: _page, timeUp: 'Süre doldu.', done: 'Sunum bitti.');
String _page(int n, String? title) => title == null ? 'Sayfa $n' : 'Sayfa $n. $title';

void main() {
  group('speechPages', () {
    test('başlık yoksa her paragraf bir sayfa', () {
      final p = speech('Birinci paragraf burada.\n\nİkinci paragraf daha uzun bir cümle.');
      final pages = speechPages(p);
      expect(pages, hasLength(2));
      expect(pages.map((x) => x.title), [null, null]);
      expect(pages.map((x) => x.words), [3, 6]);
    });

    test('başlıklar sayfaları böler, süre hedefe göre paylaşılır', () {
      final p = speech('BÖLÜM 1\nBir iki üç dört beş altı yedi sekiz dokuz on.\nBÖLÜM 2\nBir iki üç dört beş.', target: 90);
      final pages = speechPages(p);
      expect(pages.map((x) => x.title), ['BÖLÜM 1', 'BÖLÜM 2']);
      expect(pageSecondsFor(p, pages), [60, 30]);
      p.pageSeconds = [45, 45];
      expect(pageSecondsFor(p, pages), [45, 45], reason: 'kullanıcının ayarı korunur');
    });

    test('sunumda "Sayfa 2" / "Slayt 3" sayfa başıdır, silinmez', () {
      final p = speech('Sayfa 1\nMerhaba herkese.\nSayfa 2\nBugün konumuz ezber.\nSlayt 3: Sonuç\nTeşekkürler.');
      expect(speechPages(p).map((x) => x.title), ['Sayfa 1', 'Sayfa 2', 'Slayt 3: Sonuç']);
      final play = const ScriptParser()
          .parse(text: 'ALİ: Merhaba.\nSayfa 2\nVELİ: Selam.', title: 't', kind: PieceKind.play, language: 'tr-TR');
      expect(play.lines.map((l) => l.text), ['Merhaba.', 'Selam.'], reason: 'oyunda sayfa numarası silinir');
    });

    test('sayfa süreleri kaydedilir', () {
      final p = speech('Bir.\n\nİki.')..pageSeconds = [20, 30];
      expect(Piece.fromJson(p.toJson()).pageSeconds, [20, 30]);
    });
  });

  group('sayfa sayfa prova', () {
    late Piece p;
    late FakeSpeaker speaker;

    setUp(() {
      p = speech('Giriş cümlesi burada.\n\nAsıl konu anlatılıyor.\n\nKapanış.');
      p.myCharacterIds.addAll(p.characters.map((c) => c.id));
      p.pageSeconds = [30, 40, 20];
      speaker = FakeSpeaker();
    });

    test('süre dolunca "Süre doldu. Sayfa 2", sonda "Sunum bitti"', () async {
      final waited = <Duration>[];
      final c = RehearsalController(
        piece: p,
        speaker: speaker,
        settings: const RehearsalSettings(mode: RehearsalMode.pages),
        cues: cues,
        wait: (d) async => waited.add(d),
      );
      await c.play(from: 0);
      expect(speaker.said, [
        'Sayfa 1',
        'Süre doldu. Sayfa 2',
        'Süre doldu. Sayfa 3',
        'Süre doldu. Sunum bitti.',
      ]);
      expect(waited, const [Duration(seconds: 30), Duration(seconds: 40), Duration(seconds: 20)]);
      expect(c.pageTimes.keys, [0, 1, 2]);
      expect(c.status, RehearsalStatus.finished);
      expect(c.outcome, RehearsalOutcome.neutral, reason: 'serbest anlatım ölçülmez, sahte "Tebrikler" yok');
    });

    test('erken biten "Sonraki sayfa" ile geçer, "Süre doldu" denmez', () async {
      final never = Completer<void>();
      final c = RehearsalController(
        piece: p,
        speaker: speaker,
        settings: const RehearsalSettings(mode: RehearsalMode.pages),
        cues: cues,
        wait: (_) => never.future,
      );
      final done = c.play(from: 0);
      for (var i = 0; i < 3; i++) {
        await pumpEventQueue();
        expect(c.awaitingUser, isTrue);
        expect(c.pageIndex, i);
        expect(c.pageRemaining, isNotNull);
        c.userContinue();
      }
      await done;
      expect(speaker.said, ['Sayfa 1', 'Sayfa 2', 'Sayfa 3', 'Sunum bitti.']);
    });

    test('duraklatınca durur, ortadan başlatınca o sayfadan devam eder', () async {
      final never = Completer<void>();
      final c = RehearsalController(
        piece: p,
        speaker: speaker,
        settings: const RehearsalSettings(mode: RehearsalMode.pages),
        cues: cues,
        wait: (_) => never.future,
      );
      final done = c.play(from: 0);
      await pumpEventQueue();
      await c.pause();
      await done;
      expect(c.status, RehearsalStatus.idle);

      speaker.said.clear();
      final second = speechPages(p)[1].start;
      final again = c.play(from: second);
      await pumpEventQueue();
      expect(speaker.said, ['Sayfa 2']);
      await c.pause();
      await again;
    });
  });
}
