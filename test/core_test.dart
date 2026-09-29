import 'package:ezber_asistani/core/hints.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:flutter_test/flutter_test.dart';

Piece play(String text, {String lang = 'tr-TR'}) => const ScriptParser()
    .parse(text: text, title: 't', kind: PieceKind.play, language: lang);

String? who(Piece p, Line l) => p.characterById(l.characterId)?.name;

void main() {
  group('ScriptParser — oyun', () {
    test('AD: replik biçimi, devam satırı, yönerge, başlık', () {
      final p = play('''
BİRİNCİ PERDE
AYŞE: Nereye gidiyorsun?
(kapıya yürür)
MEHMET: Dışarı.
Hemen dönerim.
Ayşe: Peki.
''');
      expect(p.lines.map((l) => l.kind).toList(), [
        LineKind.heading,
        LineKind.dialogue,
        LineKind.direction,
        LineKind.dialogue,
        LineKind.dialogue,
      ]);
      expect(p.lines[2].text, 'kapıya yürür');
      expect(p.lines[3].text, 'Dışarı. Hemen dönerim.');
      expect(p.characters.map((c) => c.name), ['AYŞE', 'MEHMET']);
      expect(who(p, p.lines[4]), 'AYŞE', reason: '"Ayşe" ve "AYŞE" aynı karakter');
    });

    test('senaryo biçimi: ad tek başına, altında replik', () {
      final p = play('''
HAMLET
To be, or not to be,
that is the question.

OPHELIA
(softly)
My lord?
''', lang: 'en-US');
      final dialogue = p.lines.where((l) => l.kind == LineKind.dialogue).toList();
      expect(dialogue.map((l) => l.text), ['To be, or not to be, that is the question.', 'My lord?']);
      expect(who(p, dialogue[1]), 'OPHELIA');
      expect(p.lines.any((l) => l.kind == LineKind.direction && l.text == 'softly'), isTrue);
    });

    test('İngilizce "Juliet" ve "JULIET" aynı karakter (Türkçe İ tuzağı)', () {
      final p = play('JULIET: Romeo!\nJuliet: Where art thou?', lang: 'en-US');
      expect(p.characters, hasLength(1));
    });

    test('sayfa numaraları ve tekrar eden sayfa başlıkları atılır', () {
      final p = play('''
Sides by Breakdown Services
ALİ: Bir.
12
Sides by Breakdown Services
VELİ: İki.
Sayfa 13
Sides by Breakdown Services
ALİ: Üç.
''');
      expect(p.lines.map((l) => l.text), ['Bir.', 'İki.', 'Üç.']);
    });

    test('"SAHNE AMİRİ" karakter adıdır, başlık değil', () {
      final p = play('SAHNE AMİRİ: Işıklar hazır.\nSahne 2\nALİ: Tamam.');
      expect(p.lines[0].kind, LineKind.dialogue);
      expect(who(p, p.lines[0]), 'SAHNE AMİRİ');
      expect(p.lines[1].kind, LineKind.heading);
    });

    test('Arapça (sağdan sola) AD: replik', () {
      final p = play('ليلى: مرحبا\nسمير: أهلا', lang: 'ar');
      expect(p.characters.map((c) => c.name), ['ليلى', 'سمير']);
    });

    test('Rusça başlık (Kiril harfleri)', () {
      final p = play('Сцена 1\nИВАН: Привет.', lang: 'ru-RU');
      expect(p.lines.first.kind, LineKind.heading);
    });

    test('gerçek PDF çıktısı: sayfa başlığı/numarası atılır, bölünmüş satırlar birleşir', () {
      // Chrome ile üretilen 3 sayfalık deneme PDF'inden çıkarılan metin.
      final p = play('''
Ezber Asistanı Deneme Metni — Prova Nüshası
BİRİNCİ PERDE
(Bir oturma odası. Akşam. Zeynep
pencerenin önünde bekliyor.)
AHMET: Nereye gidiyorsun bu saatte?
ZEYNEP: Dışarı. Hemen dönerim, merak etme.
AHMET: Yağmur yağıyor, şemsiyeni al bari.
ZEYNEP (gülerek): Sen hep böylesin, her
şeyi düşünürsün.
1
Ezber Asistanı Deneme Metni — Prova Nüshası
AHMET: Biri düşünmeli, değil mi?
(Zeynep kapıya yürür, durur.)
ZEYNEP: Bir saate kadar buradayım. Söz veriyorum.
İKİNCİ PERDE
AHMET: Saat on oldu. Hâlâ yok.
2
Ezber Asistanı Deneme Metni — Prova Nüshası
(Kapı açılır. Zeynep ıslak içeri girer.)
ZEYNEP: Şemsiyeyi almalıydım, haklıydın.
AHMET: Ben sana demiştim.
3
''');
      expect(p.lines.where((l) => l.text.contains('Prova Nüshası')), isEmpty);
      expect(p.lines.where((l) => RegExp(r'^\d+$').hasMatch(l.text)), isEmpty);
      expect(p.lines.first.kind, LineKind.heading);
      expect(p.lines[1].kind, LineKind.direction);
      expect(p.lines[1].text, 'Bir oturma odası. Akşam. Zeynep pencerenin önünde bekliyor.');
      final gulerek = p.lines.indexWhere((l) => l.text == 'gülerek');
      expect(gulerek, greaterThan(0));
      expect(p.lines[gulerek + 1].text, 'Sen hep böylesin, her şeyi düşünürsün.');
      expect(p.lines.where((l) => l.kind == LineKind.heading).map((l) => l.text), ['BİRİNCİ PERDE', 'İKİNCİ PERDE']);
      expect(p.characters.map((c) => c.name), ['AHMET', 'ZEYNEP']);
      expect(p.lines.where((l) => l.kind == LineKind.dialogue), hasLength(9));
    });

    test('kime ait olduğu bilinmeyen metin yönerge olur ve "emin değilim" işaretlenir', () {
      final p = play('Bir oda. Gece.\nALİ: Kim var orada?');
      expect(p.lines.first.kind, LineKind.direction);
      expect(p.lines.first.unsure, isTrue);
      expect(p.lines.last.unsure, isFalse);
    });

    test('düzensiz biçimler: "AHMET." ve "AHMET —" konuşmacıdır', () {
      final p = play('AHMET. Nereye gidiyorsun?\nZEYNEP — Dışarı.\nAHMET - Peki.');
      expect(p.characters.map((c) => c.name), ['AHMET', 'ZEYNEP']);
      expect(p.lines.map((l) => l.text), ['Nereye gidiyorsun?', 'Dışarı.', 'Peki.']);
    });

    test('büyük harfli olmayan "Evet. Gidelim." cümlesi konuşmacı sanılmaz', () {
      final p = play('ALİ: Hazır mısın?\nEvet. Gidelim.');
      expect(p.characters, hasLength(1));
      expect(p.lines.last.text, 'Hazır mısın? Evet. Gidelim.');
    });

    test('küçük harfle ama tekrar eden adlar konuşmacıdır, tek seferlik "not:" değil', () {
      final p = play('ahmet: nereye?\nzeynep: dışarı.\nahmet: peki.\nzeynep: sonra görüşürüz.');
      expect(p.characters, hasLength(2));
      // Konuşmacılar hep BÜYÜK harf: tek seferlik "Not:" konuşmacı değil.
      final q = play('ALİ: Başlıyoruz.\nVELİ: Tamam.\nNot: bu sahne kısaltıldı.\nALİ: Hadi.\nVELİ: Geldim.');
      expect(q.characters.map((c) => c.name), ['ALİ', 'VELİ']);
      expect(q.lines.where((l) => l.unsure).map((l) => l.text), ['Not: bu sahne kısaltıldı.']);
      // Ama büyük harf kuralı yoksa tek seferlik "Garson:" bir karakterdir.
      final r = play('Ahmet: Hesap lütfen.\nGarson: Hemen getiriyorum.');
      expect(r.characters.map((c) => c.name), ['Ahmet', 'Garson']);
    });

    test('telefonda denenecek dağınık metin', () {
      final p = play('''
Perde açılır. Bir mutfak.
ANNE. Yine mi geç kaldın?
OĞUL — Otobüs gelmedi anne.
Not: bu sahne okul gösterisi için kısaltıldı.
ANNE. Her gün aynı bahane.
OĞUL — Bu sefer gerçekten öyle
yarım saat bekledim durakta.
ANNE. Peki, peki. Yemeğin masada.
''');
      expect(p.characters.map((c) => c.name), ['ANNE', 'OĞUL']);
      expect(p.lines.where((l) => l.unsure).map((l) => l.text),
          ['Perde açılır. Bir mutfak.', 'Not: bu sahne okul gösterisi için kısaltıldı.']);
      expect(p.lines.firstWhere((l) => l.text.startsWith('Bu sefer')).text,
          'Bu sefer gerçekten öyle yarım saat bekledim durakta.');
      expect(p.lines.where((l) => l.kind == LineKind.dialogue), hasLength(5));
    });

    test('unsure bayrağı yedekte korunur', () {
      final p = play('Bilinmeyen satır.\nALİ: Merhaba.');
      final back = Piece.fromJson(p.toJson());
      expect(back.lines.first.unsure, isTrue);
    });
  });

  group('ScriptParser — şiir', () {
    test('her dize bana ait ayrı satır, boş satırlar atılır', () {
      final p = const ScriptParser().parse(
        text: 'Korkma, sönmez bu şafaklarda yüzen al sancak;\n\nSönmeden yurdumun üstünde tüten en son ocak.',
        title: 'İstiklal Marşı',
        kind: PieceKind.poem,
        language: 'tr-TR',
      );
      expect(p.lines, hasLength(2));
      expect(p.lines.every(p.isMine), isTrue);
    });
  });

  group('Piece', () {
    test('JSON gidiş-dönüş (yedekleme)', () {
      final p = play('ALİ: Bir.\nVELİ: İki.');
      p.myCharacterIds.add(p.characters.first.id);
      p.characters.first.voice = const VoiceSettings(voiceName: 'x', pitch: 1.3, rate: 0.4);
      final back = Piece.fromJson(p.toJson());
      expect(back.lines.map((l) => l.text), ['Bir.', 'İki.']);
      expect(back.myCharacterIds, p.myCharacterIds);
      expect(back.characters.first.voice.pitch, 1.3);
    });

    test('karakter birleştirme', () {
      final p = play('ALI: Bir.\nALİ: İki.');
      expect(p.characters, hasLength(1), reason: 'ALI ve ALİ zaten aynı');
      final q = play('ALİ: Bir.\nALİ BEY: İki.');
      q.mergeCharacters(q.characters[1].id, q.characters[0].id);
      expect(q.characters, hasLength(1));
      expect(q.lines.every((l) => l.characterId == q.characters[0].id), isTrue);
    });
  });

  group('İpuçları', () {
    test('baş harfler', () {
      expect(applyHint('To be or not', HintLevel.firstLetters), 'T_ b_ o_ n__');
      expect(applyHint('Nereye gidiyorsun?', HintLevel.firstLetters), 'N_____ g_________?');
      expect(applyHint('Привет, мир', HintLevel.firstLetters), 'П_____, м__');
    });

    test('gizli ve tam', () {
      expect(applyHint('abc', HintLevel.hidden), '');
      expect(applyHint('abc', HintLevel.full), 'abc');
    });

    test('süre kelime sayısıyla artar', () {
      expect(gapFor('bir iki üç'), greaterThan(gapFor('bir')));
      expect(gapFor('bir', factor: 2), gapFor('bir') * 2);
    });
  });

  group('RehearsalController', () {
    late Piece p;
    late FakeSpeaker speaker;

    setUp(() {
      p = play('ALİ: Merhaba.\n(güler)\nVELİ: Selam.\nALİ: Nasılsın?');
      p.myCharacterIds.add(p.characters.firstWhere((c) => c.name == 'VELİ').id);
      speaker = FakeSpeaker();
    });

    RehearsalController ctrl(RehearsalMode mode, {bool directions = false}) => RehearsalController(
          piece: p,
          speaker: speaker,
          settings: RehearsalSettings(mode: mode, readDirections: directions),
          wait: (_) async {},
        );

    test('dinle: her şey okunur, yönergeler ayara göre', () async {
      await ctrl(RehearsalMode.listen).play(from: 0);
      expect(speaker.said, ['Merhaba.', 'Selam.', 'Nasılsın?']);
      speaker.said.clear();
      await ctrl(RehearsalMode.listen, directions: true).play(from: 0);
      expect(speaker.said, ['Merhaba.', 'güler', 'Selam.', 'Nasılsın?']);
    });

    test('doğrula: benim repliğim süre tanındıktan sonra okunur', () async {
      await ctrl(RehearsalMode.checkMe).play(from: 0);
      expect(speaker.said, ['Merhaba.', 'Selam.', 'Nasılsın?']);
    });

    test('akış: benim repliğim okunmaz', () async {
      final c = ctrl(RehearsalMode.runThrough);
      await c.play(from: 0);
      expect(speaker.said, ['Merhaba.', 'Nasılsın?']);
      expect(c.status, RehearsalStatus.finished);
    });

    test('bekle: sıra bende durur, Devam ile sürer; ipucu gösterilir', () async {
      final c = ctrl(RehearsalMode.waitForMe);
      final done = c.play(from: 0);
      await pumpEventQueue();
      expect(c.status, RehearsalStatus.myTurn);
      expect(c.awaitingUser, isTrue);
      expect(c.displayText(c.currentLine!), 'S____.');
      c.reveal();
      expect(c.displayText(c.currentLine!), 'Selam.');
      c.userContinue();
      await done;
      expect(speaker.said, ['Merhaba.', 'Nasılsın?']);
    });

    test('duraklat beklemeyi iptal eder, sonra kaldığı yerden sürer', () async {
      final c = ctrl(RehearsalMode.waitForMe);
      final first = c.play(from: 0);
      await pumpEventQueue();
      await c.pause();
      await first;
      expect(c.status, RehearsalStatus.idle);
      expect(c.index, 2);
      final second = c.play();
      await pumpEventQueue();
      c.userContinue();
      await second;
      expect(c.status, RehearsalStatus.finished);
    });

    test('bozuk ses provayı durdurmaz', () async {
      speaker.failOn = 'Merhaba.';
      await ctrl(RehearsalMode.listen).play(from: 0);
      expect(speaker.said, ['Selam.', 'Nasılsın?']);
    });

    test('sonraki kendi replik araması', () {
      final c = ctrl(RehearsalMode.listen);
      expect(c.findMine(forward: true), 2);
    });
  });
}

class FakeSpeaker implements Speaker {
  final said = <String>[];
  String? failOn;

  @override
  Future<void> speak(String text, {required String language, required VoiceSettings voice}) async {
    if (text == failOn) throw Exception('ses bozuk');
    said.add(text);
  }

  @override
  Future<void> stop() async {}
}
