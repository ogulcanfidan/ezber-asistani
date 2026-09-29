import 'package:ezber_asistani/app_state.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/data/pro.dart';
import 'package:ezber_asistani/l10n/app_localizations.dart';
import 'package:ezber_asistani/main.dart';
import 'package:ezber_asistani/screens/new_piece_screen.dart';
import 'package:ezber_asistani/screens/pro_screen.dart';
import 'package:ezber_asistani/screens/rehearsal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_test.dart' show MemoryRepository;
import 'core_test.dart' show FakeSpeaker;

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('flutter_tts'), (call) async {
      if (call.method == 'getVoices') return <Object>[];
      return 1;
    });
  });

  test('ISO süresi güne çevrilir', () {
    expect(isoDays('P3D'), 3);
    expect(isoDays('P1W'), 7);
    expect(isoDays('P1M'), isNull, reason: 'ay deneme olarak gösterilmez');
  });

  Future<AppState> stateWith(FakeProStore pro, {int pieces = 0}) async {
    final state = await AppState.load(repository: MemoryRepository(), pro: pro);
    await state.setLocale(const Locale('tr'));
    for (var i = 0; i < pieces; i++) {
      await state.repository.save(const ScriptParser()
          .parse(text: 'A: $i', title: 'Metin $i', kind: PieceKind.play, language: 'tr-TR'));
    }
    return state;
  }

  testWidgets('ücretsiz sürümde 3 metinden sonra Pro sayfası, abonelikle devam', (tester) async {
    final pro = FakeProStore();
    await tester.pumpWidget(EzberApp(state: await stateWith(pro, pieces: freePieceLimit)));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Yeni'));
    await tester.pumpAndSettle();
    expect(find.byType(ProScreen), findsOneWidget);
    expect(find.text('3 gün ücretsiz, sonra ₺28,99/ay'), findsOneWidget);

    await tester.tap(find.text('Ücretsiz denemeyi başlat'));
    await tester.pumpAndSettle();
    expect(pro.buys, 1);
    expect(find.byType(NewPieceScreen), findsOneWidget, reason: 'abone olunca yeni metne geçer');
  });

  testWidgets('sınırın altında ve Pro kullanıcıda doğrudan yeni metin', (tester) async {
    for (final (pro, pieces) in [(FakeProStore(), freePieceLimit - 1), (FakeProStore(pro: true), 10)]) {
      await tester.pumpWidget(EzberApp(key: UniqueKey(), state: await stateWith(pro, pieces: pieces)));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Yeni'));
      await tester.pumpAndSettle();
      expect(find.byType(NewPieceScreen), findsOneWidget);
      expect(find.byType(ProScreen), findsNothing);
    }
  });

  testWidgets('abonelik tanımlı değilse dürüst mesaj, satın alma düğmesi yok', (tester) async {
    await tester.pumpWidget(EzberApp(state: await stateWith(FakeProStore(available: false), pieces: freePieceLimit)));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yeni'));
    await tester.pumpAndSettle();
    expect(find.text('Abonelik şu anda kullanılamıyor. Daha sonra tekrar deneyin.'), findsOneWidget);
    expect(find.text('Ücretsiz denemeyi başlat'), findsNothing);
  });

  testWidgets('abonelik bitince kayıtlı eller serbest modu "Beni bekle"ye döner', (tester) async {
    final state = await stateWith(FakeProStore());
    await state.saveRehearsalSettings(const RehearsalSettings(mode: RehearsalMode.handsFree));
    final piece = const ScriptParser()
        .parse(text: 'ALİ: Merhaba.\nVELİ: Selam.', title: 'D', kind: PieceKind.play, language: 'tr-TR');
    piece.myCharacterIds.add(piece.characters[1].id);

    await tester.pumpWidget(AppScope(
      state: state,
      child: MaterialApp(
        locale: const Locale('tr'),
        supportedLocales: L.supportedLocales,
        localizationsDelegates: L.localizationsDelegates,
        home: RehearsalScreen(piece: piece, speaker: FakeSpeaker()),
      ),
    ));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Başlat'));
    await tester.pumpAndSettle();

    expect(state.rehearsalSettings.mode, RehearsalMode.waitForMe);
    expect(find.text('Eller serbest prova Pro özelliğidir. "Beni bekle" moduna geçildi.'), findsOneWidget);
    expect(find.text('Sıra sizde'), findsOneWidget);
  });
}
