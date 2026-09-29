import 'dart:typed_data';

import 'package:ezber_asistani/app_state.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/recite_session.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/data/pro.dart';
import 'package:ezber_asistani/data/whisper_stt.dart';
import 'package:ezber_asistani/l10n/app_localizations.dart';
import 'package:ezber_asistani/screens/recite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_test.dart' show MemoryRepository;

class _Models extends ReciteModels {
  _Models({this.installed = false});
  bool installed;
  int downloads = 0;

  @override
  Future<String?> installedPath(ReciteModel model) async => installed ? '/m/${model.name}' : null;

  @override
  Future<(ReciteModel, String)?> best() async => installed ? (ReciteModel.standard, '/m/standard') : null;

  @override
  Stream<double> download(ReciteModel model) async* {
    downloads++;
    yield 0.5;
    installed = true;
    yield 1;
  }

  @override
  Future<void> delete(ReciteModel model) async => installed = false;
}

class _Transcriber implements Transcriber {
  final replies = <String>[];
  final prompts = <String?>[];

  @override
  Future<String> transcribe(Float32List pcm16k, {required String language, String? prompt}) async {
    prompts.add(prompt);
    return replies.removeAt(0);
  }

  @override
  Future<void> dispose() async {}
}

class _Mic implements ReciteMic {
  void Function(Float32List)? onChunk;
  bool running = false;

  @override
  Future<bool> start(void Function(Float32List pcm16k) cb) async {
    onChunk = cb;
    running = true;
    return true;
  }

  @override
  Future<void> stop() async => running = false;

  void say() => onChunk!(Float32List(1600));
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('dev.fluttercommunity.plus/wakelock'), (_) async => null);
  });

  Future<void> pump(WidgetTester tester, Widget screen) async {
    final state = await AppState.load(repository: MemoryRepository(), pro: FakeProStore());
    await tester.pumpWidget(AppScope(
      state: state,
      child: MaterialApp(
        locale: const Locale('tr'),
        supportedLocales: L.supportedLocales,
        localizationsDelegates: L.localizationsDelegates,
        home: screen,
      ),
    ));
    await tester.pumpAndSettle();
  }

  Piece poem() => const ScriptParser().parse(
        text: 'Korkma sönmez bu şafaklarda yüzen al sancak',
        title: 'İstiklal',
        kind: PieceKind.poem,
        language: 'tr-TR',
      );

  testWidgets('model yoksa indirme önerilir (ücretsiz, boyut yazılı), inince hazır', (tester) async {
    final models = _Models();
    await pump(tester, ReciteScreen(piece: poem(), models: models, loader: (_) async => _Transcriber(), mic: _Mic()));
    expect(find.text('Standart (60 MB) — hızlı'), findsOneWidget);
    expect(find.textContaining('Ücretsizdir'), findsOneWidget);
    await tester.tap(find.text('İndir'));
    await tester.pumpAndSettle();
    expect(models.downloads, 1);
    expect(find.text('Başla'), findsOneWidget);
  });

  testWidgets('atlanınca durur, hatayı gösterir, devam edince biter ve rapor verir', (tester) async {
    final t = _Transcriber();
    final mic = _Mic();
    final p = poem();
    await pump(tester, ReciteScreen(piece: p, models: _Models(installed: true), loader: (_) async => t, mic: mic));

    await tester.tap(find.text('Başla'));
    await tester.pumpAndSettle();
    expect(find.text('Dinliyorum… Metni baştan söyleyin.'), findsOneWidget);

    t.replies.add('Korkma sönmez bu al sancak');
    mic.say();
    await tester.pumpAndSettle();
    expect(find.text('Bir kısmı atladınız'), findsOneWidget);
    expect(find.text('Doğrusu: şafaklarda yüzen'), findsOneWidget);
    expect(mic.running, isFalse, reason: 'hata gösterilirken dinlenmez');
    expect(p.stats.values.single.lastHelped, isTrue, reason: 'zorlandıklarım listesine girer');

    await tester.tap(find.text('Buradan devam et'));
    await tester.pumpAndSettle();
    t.replies.add('şafaklarda yüzen al sancak');
    mic.say();
    await tester.pumpAndSettle();
    expect(t.prompts.last, 'Korkma sönmez bu', reason: 'bağlam yalnızca söylenenler');
    expect(find.textContaining('Doğruluk: %'), findsOneWidget);
    expect(find.textContaining('"şafaklarda yüzen"'), findsOneWidget);
    expect(find.text('Tekrar'), findsOneWidget);
  });
}
