import 'dart:convert';
import 'dart:io';

import 'package:ezber_asistani/app_state.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/data/piece_repository.dart';
import 'package:ezber_asistani/data/pro.dart';
import 'package:ezber_asistani/l10n/app_localizations.dart';
import 'package:ezber_asistani/main.dart';
import 'package:ezber_asistani/data/doc_import.dart' show decodeText;
import 'package:ezber_asistani/screens/rehearsal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core_test.dart' show FakeSpeaker;

void main() {
  late Directory tmp;

  setUp(() {
    tmp = Directory.systemTemp.createTempSync('ezber_test');
    SharedPreferences.setMockInitialValues({});
    // Cihaz ses motoru testte yok: her çağrı başarılı dönsün.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), (call) async {
      if (call.method == 'getVoices') return <Object>[];
      return 1;
    });
  });

  tearDown(() => tmp.deleteSync(recursive: true));

  group('PieceRepository', () {
    test('kaydet, yükle, yedekle, geri yükle', () async {
      final repo = PieceRepository(tmp);
      final p = const ScriptParser()
          .parse(text: 'ALİ: Bir.\nVELİ: İki.', title: 'Deneme', kind: PieceKind.play, language: 'tr-TR');
      await repo.save(p);
      await repo.save(p); // Üzerine yazma (Windows'ta rename sorunu) çalışmalı.
      expect((await repo.loadAll()).single.title, 'Deneme');

      final backup = await repo.exportAll();
      await repo.delete(p.id);
      expect(await repo.loadAll(), isEmpty);

      expect(await repo.importAll(backup), 1);
      expect((await repo.loadAll()).single.lines.map((l) => l.text), ['Bir.', 'İki.']);
    });

    test('geçersiz yedek reddedilir, bozuk dosya kütüphaneyi bozmaz', () async {
      final repo = PieceRepository(tmp);
      expect(() => repo.importAll('{"foo": 1}'), throwsFormatException);
      File('${tmp.path}/pieces/bozuk.json')
        ..createSync(recursive: true)
        ..writeAsStringSync('{yarım');
      expect(await repo.loadAll(), isEmpty);
    });
  });

  test('metin dosyası kodlamaları', () {
    expect(decodeText([0xEF, 0xBB, 0xBF, ...utf8.encode('Şiir — uzun tire')]), 'Şiir — uzun tire');
    expect(decodeText([0xFF, 0xFE, 0x5E, 0x01, 0x69, 0x00]), 'Şi'); // UTF-16 LE
    expect(decodeText([0x63, 0x61, 0x66, 0xE9]), 'café'); // Latin-1 yedek
  });

  Future<AppState> appState({Locale? locale, ProStore? pro}) async {
    final state = await AppState.load(repository: MemoryRepository(), pro: pro ?? FakeProStore());
    if (locale != null) await state.setLocale(locale);
    return state;
  }

  testWidgets('10 dilin hepsinde kütüphane açılır, Arapça sağdan sola', (tester) async {
    for (final code in supportedLanguages.keys) {
      final state = await appState(locale: Locale(code));
      await tester.pumpWidget(EzberApp(key: ValueKey(code), state: state));
      await tester.pumpAndSettle();
      final l = L.of(tester.element(find.byType(Scaffold).first));
      expect(find.text(l.library), findsOneWidget, reason: code);
      expect(find.text(l.emptyLibrary), findsOneWidget, reason: code);
      final dir = Directionality.of(tester.element(find.byType(Scaffold).first));
      expect(dir, code == 'ar' ? TextDirection.rtl : TextDirection.ltr, reason: code);
    }
  });

  testWidgets('yeni metin → düzeltme → prova akışı', (tester) async {
    final state = await appState(locale: const Locale('tr'));
    await tester.pumpWidget(EzberApp(state: state));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Yeni'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Başlık'), 'Deneme');
    await tester.enterText(
      find.byWidgetPredicate((w) => w is TextField && w.decoration?.hintText != null),
      'AYŞE: Nereye?\nMEHMET: Dışarı.',
    );
    await tester.pump();
    final devam = find.widgetWithText(FilledButton, 'Devam');
    await tester.scrollUntilVisible(devam, 200, scrollable: find.byType(Scrollable).first);
    await tester.tap(devam);
    await tester.pumpAndSettle();

    // Düzeltme ekranı: karakter seçilmeden prova düğmesi kapalı.
    expect(find.text('Hangi karaktersiniz?'), findsOneWidget);
    expect(find.text('Provaya başlamadan önce en az bir karakteri kendiniz olarak seçin.'), findsOneWidget);
    // Karakter panelinde MEHMET satırındaki ⭐ (Ben) düğmesi.
    final mehmetRow = find.ancestor(of: find.text('MEHMET').first, matching: find.byType(ListTile));
    await tester.tap(find.descendant(of: mehmetRow, matching: find.byTooltip('Ben')));
    await tester.pumpAndSettle();

    // Yanlış atamayı tek dokunuşla düzelt: AYŞE'nin repliğini yönerge yap.
    await tester.tap(find.widgetWithText(ActionChip, 'AYŞE'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yönerge').last);
    await tester.pumpAndSettle();
    expect(find.text('(Nereye?)'), findsOneWidget);

    final saved = (await state.repository.loadAll()).single;
    expect(saved.lines.first.kind, LineKind.direction);
    expect(saved.characters.map((c) => c.name), ['MEHMET'], reason: 'kullanılmayan karakter silinir');
  });

  testWidgets('prova: sıra bende büyük Devam düğmesi, baş harf ipucu, sonda nötr bitiş', (tester) async {
    final piece = const ScriptParser()
        .parse(text: 'ALİ: Merhaba.\nVELİ: Selam dostum.', title: 'D', kind: PieceKind.play, language: 'tr-TR');
    piece.myCharacterIds.add(piece.characters[1].id);
    final speaker = FakeSpeaker();
    final state = await appState(locale: const Locale('tr'));

    await tester.pumpWidget(AppScope(
      state: state,
      child: MaterialApp(
        locale: const Locale('tr'),
        supportedLocales: L.supportedLocales,
        localizationsDelegates: L.localizationsDelegates,
        home: RehearsalScreen(piece: piece, speaker: speaker),
      ),
    ));
    await tester.pumpAndSettle();

    // Başlamadan önce kendi repliğim ipucuyla görünür, tamamı değil.
    expect(find.text('S____ d_____.'), findsOneWidget);
    expect(find.text('Selam dostum.'), findsNothing);

    await tester.tap(find.byTooltip('Başlat'));
    await tester.pumpAndSettle();
    expect(speaker.said, ['Merhaba.']);
    expect(find.text('Sıra sizde'), findsOneWidget);

    await tester.tap(find.text('Göster'));
    await tester.pumpAndSettle();
    expect(find.text('Selam dostum.'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Devam'));
    await tester.pumpAndSettle();
    // Ölçüm yapılmayan modda nötr bitiş (hak edilmemiş "Tebrikler" yok).
    // "Göster" ile yardım alındı: hak edilmemiş "Tebrikler" yok.
    expect(find.text('Prova bitti. Takıldığınız yerleri tekrar çalışın.'), findsOneWidget);
    expect(speaker.said, ['Merhaba.'], reason: '"Beni bekle" modunda benim repliğim okunmaz');
  });

  test('varsayılan seslendirme dili uygulama dilinden gelir', () {
    expect(defaultVoiceLanguageFor(const Locale('tr')), 'tr-TR');
    expect(defaultVoiceLanguageFor(const Locale('pt')), 'pt-BR');
    expect(defaultVoiceLanguageFor(const Locale('ar')), 'ar-SA');
    expect(defaultVoiceLanguageFor(const Locale('xx')), 'en-US');
    expect(RehearsalMode.values, hasLength(8));
  });
}

/// Widget testlerinde gerçek dosya G/Ç'si sahte zamanlayıcıyla tamamlanmaz;
/// JSON gidiş-dönüşüyle dosyaya yazmayı taklit eden bellek içi depo.
class MemoryRepository extends PieceRepository {
  final _store = <String, String>{};

  @override
  Future<List<Piece>> loadAll() async => _store.values
      .map((j) => Piece.fromJson(jsonDecode(j) as Map<String, dynamic>))
      .toList();

  @override
  Future<void> save(Piece piece) async => _store[piece.id] = jsonEncode(piece.toJson());

  @override
  Future<void> delete(String id) async => _store.remove(id);
}
