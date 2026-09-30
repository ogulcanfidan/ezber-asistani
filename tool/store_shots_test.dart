// Mağaza görselleri: her dil için 3 ekran görüntüsü (1080x1920) ve öne çıkan
// görsel (1024x500). Uygulamanın gerçek ekranları o dilde çizilir.
//
//   flutter test tool/store_shots_test.dart   →   store/shots/<dil>/*.png
//
// Yazı tipleri Flutter SDK'sından (Roboto, simgeler) ve Windows'tan alınır.
import 'dart:io';
import 'dart:ui' as ui;

import 'package:ezber_asistani/app_state.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/data/pro.dart';
import 'package:ezber_asistani/l10n/app_localizations.dart';
import 'package:ezber_asistani/screens/editor_screen.dart';
import 'package:ezber_asistani/screens/rehearsal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test/app_test.dart' show MemoryRepository;
import '../test/core_test.dart' show FakeSpeaker;

class Shot {
  const Shot(this.code, this.voice, this.title, this.names, this.lines, this.captions, this.feature, [this.fallback]);

  /// Uygulama dili ve seslendirme dili.
  final String code, voice;
  final String title;
  final List<String> names;
  final List<String> lines;
  final List<String> captions;

  /// Öne çıkan görsel: ad, iki alt satır.
  final List<String> feature;

  /// Latin/Kiril/Arap dışı yazılar için yedek yazı tipi.
  final String? fallback;
}

const shots = <String, Shot>{
  'en-US': Shot('en', 'en-US', 'Romeo and Juliet', ['ROMEO', 'JULIET'], [
    'But soft, what light through yonder window breaks?',
    'O Romeo, Romeo, wherefore art thou Romeo?',
    'Deny thy father and refuse thy name.',
    'Shall I hear more, or speak?',
  ], ['Rehearse hands-free', 'A voice for every character', 'A mode for every text'],
      ['Memorize', 'Learn lines, poems and speeches', 'Hands-free • Prompter • 14 languages']),
  'tr-TR': Shot('tr', 'tr-TR', 'Romeo ve Juliet', ['ROMEO', 'JULIET'], [
    'Ama dur, şu pencereden süzülen ışık da ne?',
    'Ah Romeo, Romeo, neden Romeo\'sun sen?',
    'Babanı inkâr et, adını reddet.',
    'Dinleyeyim mi, konuşayım mı?',
  ], ['Eller serbest prova', 'Her karaktere ayrı ses', 'Her metne uygun çalışma modu'],
      ['Ezber Asistanı', 'Replik, şiir ve sunum ezberle', 'Eller serbest • Suflör • 14 dil']),
  'de-DE': Shot('de', 'de-DE', 'Romeo und Julia', ['ROMEO', 'JULIA'], [
    'Doch still, was schimmert durch das Fenster dort?',
    'O Romeo, Romeo, warum bist du Romeo?',
    'Verleugne deinen Vater, deinen Namen.',
    'Hör ich zu, oder spreche ich?',
  ], ['Freihändig proben', 'Für jede Figur eine Stimme', 'Für jeden Text der passende Modus'],
      ['Auswendig', 'Rollen, Gedichte und Reden lernen', 'Freihändig • Souffleur • 14 Sprachen']),
  'fr-FR': Shot('fr', 'fr-FR', 'Roméo et Juliette', ['ROMÉO', 'JULIETTE'], [
    'Mais doucement, quelle lumière brille à cette fenêtre ?',
    'Ô Roméo, Roméo, pourquoi es-tu Roméo ?',
    'Renie ton père et refuse ton nom.',
    'Dois-je écouter, ou répondre ?',
  ], ['Répétez mains libres', 'Une voix pour chaque personnage', 'Un mode pour chaque texte'],
      ['Par cœur', 'Rôles, poèmes et discours', 'Mains libres • Souffleur • 14 langues']),
  'es-419': Shot('es', 'es-MX', 'Romeo y Julieta', ['ROMEO', 'JULIETA'], [
    'Pero, silencio, ¿qué luz brilla en aquella ventana?',
    'Oh Romeo, Romeo, ¿por qué eres tú Romeo?',
    'Niega a tu padre y rechaza tu nombre.',
    '¿Sigo escuchando, o le hablo ahora?',
  ], ['Ensaya a manos libres', 'Una voz para cada personaje', 'Un modo para cada texto'],
      ['Memoriza', 'Guiones, poemas y discursos', 'Manos libres • Apuntador • 14 idiomas']),
  'pt-BR': Shot('pt', 'pt-BR', 'Romeu e Julieta', ['ROMEU', 'JULIETA'], [
    'Mas, silêncio, que luz brilha naquela janela?',
    'Ó Romeu, Romeu, por que és tu Romeu?',
    'Renega teu pai e recusa teu nome.',
    'Devo ouvir mais, ou falar agora?',
  ], ['Ensaie com as mãos livres', 'Uma voz para cada personagem', 'Um modo para cada texto'],
      ['Decorar', 'Falas, poemas e discursos', 'Mãos livres • Ponto • 14 idiomas']),
  'it-IT': Shot('it', 'it-IT', 'Romeo e Giulietta', ['ROMEO', 'GIULIETTA'], [
    'Ma piano, quale luce spunta da quella finestra?',
    'O Romeo, Romeo, perché sei tu Romeo?',
    'Rinnega tuo padre e rifiuta il tuo nome.',
    'Ascolto ancora, o parlo?',
  ], ['Prova a mani libere', 'Una voce per ogni personaggio', 'Una modalità per ogni testo'],
      ['A memoria', 'Battute, poesie e discorsi', 'Mani libere • Suggeritore • 14 lingue']),
  'ru-RU': Shot('ru', 'ru-RU', 'Ромео и Джульетта', ['РОМЕО', 'ДЖУЛЬЕТТА'], [
    'Но тише, что за свет блеснул в окне?',
    'О Ромео, Ромео, зачем же ты Ромео?',
    'Отринь отца и откажись от имени.',
    'Мне слушать дальше или ответить ей?',
  ], ['Репетиция без рук', 'Свой голос у каждого героя', 'Режим для любого текста'],
      ['Наизусть', 'Роли, стихи и речи', 'Без рук • Суфлёр • 14 языков']),
  'id': Shot('id', 'id-ID', 'Romeo dan Juliet', ['ROMEO', 'JULIET'], [
    'Tapi diam, cahaya apa itu di jendela sana?',
    'O Romeo, Romeo, mengapa engkau Romeo?',
    'Tinggalkan ayahmu dan tolak namamu.',
    'Terus mendengar, atau bicara?',
  ], ['Latihan tanpa sentuh', 'Satu suara untuk tiap tokoh', 'Mode untuk setiap teks'],
      ['Hafalan', 'Hafalkan dialog, puisi, dan pidato', 'Tanpa sentuh • Pembisik • 14 bahasa']),
  'ar': Shot('ar', 'ar-SA', 'روميو وجولييت', ['روميو', 'جولييت'], [
    'لكن مهلاً، أي نور يشرق من تلك النافذة؟',
    'يا روميو، يا روميو، لماذا أنت روميو؟',
    'تنكّر لأبيك وارفض اسمك.',
    'أأستمع أكثر، أم أتكلم الآن؟',
  ], ['تدرّب دون استخدام اليدين', 'صوت لكل شخصية', 'وضع لكل نص'],
      ['الحفظ', 'احفظ الأدوار والقصائد والخطابات', 'دون يدين • ملقّن • 14 لغة']),
  'hi-IN': Shot('hi', 'hi-IN', 'रोमियो और जूलियट', ['रोमियो', 'जूलियट'], [
    'पर ठहरो, उस खिड़की से यह कैसी रोशनी आ रही है?',
    'ओ रोमियो, रोमियो, तुम रोमियो क्यों हो?',
    'अपने पिता को छोड़ दो और अपना नाम त्याग दो।',
    'क्या मैं और सुनूँ, या अब बोलूँ?',
  ], ['हैंड्स-फ़्री अभ्यास', 'हर पात्र की अलग आवाज़', 'हर पाठ के लिए एक मोड'],
      ['याद सहायक', 'संवाद, कविता और भाषण याद करें', 'हैंड्स-फ़्री • प्रॉम्प्टर • 14 भाषाएँ'], 'FbHi'),
  'zh-CN': Shot('zh', 'zh-CN', '罗密欧与朱丽叶', ['罗密欧', '朱丽叶'], [
    '轻声！那边窗子里亮起来的是什么光？',
    '罗密欧啊，罗密欧！为什么你偏偏是罗密欧呢？',
    '否认你的父亲，抛弃你的姓名吧。',
    '我是继续听下去呢，还是现在就开口？',
  ], ['免提排练', '每个角色都有自己的声音', '每种文本都有合适的模式'],
      ['背诵助手', '背台词、诗歌和演讲', '免提 • 提词 • 14 种语言'], 'FbZh'),
  'ja-JP': Shot('ja', 'ja-JP', 'ロミオとジュリエット', ['ロミオ', 'ジュリエット'], [
    '待て、あの窓からもれる光は何だろう？',
    'ああロミオ、ロミオ、どうしてあなたはロミオなの？',
    'お父様と縁を切り、その名を捨ててください。',
    'もっと聞いていようか、それとも今話しかけようか？',
  ], ['ハンズフリーで稽古', '役ごとに違う声', 'どんなテキストにも合うモード'],
      ['暗記アシスタント', 'セリフ・詩・スピーチを暗記', 'ハンズフリー • プロンプター • 14言語'], 'FbJa'),
  'ko-KR': Shot('ko', 'ko-KR', '로미오와 줄리엣', ['로미오', '줄리엣'], [
    '가만, 저 창문에서 비치는 빛은 무엇일까?',
    '오 로미오, 로미오, 왜 그대는 로미오인가요?',
    '아버지를 버리고 그 이름을 거부하세요.',
    '더 들어야 할까, 아니면 지금 말을 걸까?',
  ], ['핸즈프리 연습', '인물마다 다른 목소리', '텍스트마다 맞는 모드'],
      ['암기 도우미', '대사, 시, 발표 암기', '핸즈프리 • 프롬프터 • 14개 언어'], 'FbKo'),
};

const _top = Color(0xFF106E7C);
const _bottom = Color(0xFF2BC0A0);
const _allFallbacks = ['FbZh', 'FbJa', 'FbKo', 'FbHi', 'Symbols'];

List<String> _fallbackFor(Shot s) => [if (s.fallback != null) s.fallback!, ..._allFallbacks];

/// Marka degradesi: soldan sağa %35, yukarıdan aşağı %65 ağırlıkla.
class _Gradient extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final g = Offset(0.35 / size.width, 0.65 / size.height);
    final to = g / g.distanceSquared;
    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = ui.Gradient.linear(Offset.zero, to, [_top, _bottom]),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Mikrofon ve konuşma satırları (uygulama simgesindeki çizim).
class _Logo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final u = size.width;
    final white = Paint()..color = Colors.white;
    final faded = Paint()..color = Colors.white.withValues(alpha: 140 / 255);
    final mx = u * 0.36, my = u * 0.44, mw = u * 0.16, mh = u * 0.30;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(mx, my), width: mw, height: mh), Radius.circular(mw / 2)),
      white,
    );
    final lw = u * 0.028;
    final stroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = lw;
    canvas.drawArc(
      Rect.fromLTRB(mx - mw * 0.95, my - mh * 0.15, mx + mw * 0.95, my + mh * 0.62).deflate(lw / 2),
      0,
      3.14159265,
      false,
      stroke,
    );
    canvas.drawLine(Offset(mx, my + mh * 0.62 - lw / 2), Offset(mx, my + mh * 0.82), stroke);
    canvas.drawLine(Offset(mx - mw * 0.55, my + mh * 0.82), Offset(mx + mw * 0.55, my + mh * 0.82), stroke);

    final h = u * 0.05;
    void bar(double a, double y, double b, Paint p) => canvas.drawRRect(
          RRect.fromRectAndRadius(Rect.fromLTRB(u * a, u * y - h / 2, u * b, u * y + h / 2), Radius.circular(h / 2)),
          p,
        );
    bar(0.52, 0.36, 0.80, white);
    bar(0.52, 0.47, 0.72, white);
    for (final (a, b) in [(0.52, 0.58), (0.62, 0.68), (0.72, 0.78)]) {
      bar(a, 0.58, b, faded);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Yazı tipi koleksiyonundan (.ttc) tek bir yazı tipini ayrı dosya olarak
/// çıkarır; motor koleksiyonun yalnızca ilkini yükleyebiliyor.
Uint8List _ttcFace(Uint8List ttc, int index) {
  final src = ByteData.sublistView(ttc);
  final start = src.getUint32(12 + 4 * index);
  final count = src.getUint16(start + 4);
  final header = 12 + 16 * count;
  final out = BytesBuilder()..add(ttc.sublist(start, start + header));
  final records = <(int, int)>[];
  var offset = header;
  for (var i = 0; i < count; i++) {
    final rec = start + 12 + 16 * i;
    final from = src.getUint32(rec + 8), length = src.getUint32(rec + 12);
    final padded = (length + 3) & ~3;
    out
      ..add(ttc.sublist(from, from + length))
      ..add(Uint8List(padded - length));
    records.add((rec - start + 8, offset));
    offset += padded;
  }
  final bytes = out.toBytes();
  final dst = ByteData.sublistView(bytes);
  for (final (at, value) in records) {
    dst.setUint32(at, value);
  }
  return bytes;
}

void main() {
  final root = Directory.current.path;
  final boundaryKey = GlobalKey();

  setUpAll(() async {
    // flutter_tester: <sdk>/bin/cache/artifacts/engine/<platform>/
    final artifacts = File(Platform.resolvedExecutable).parent.parent.parent.path;
    final material = '$artifacts/material_fonts';
    const win = 'C:/Windows/Fonts';
    Future<void> load(String family, List<String> files) async {
      final loader = FontLoader(family);
      for (final f in files) {
        // "dosya.ttc#1": koleksiyonun ikinci yazı tipi.
        final parts = f.split('#');
        var bytes = File(parts[0]).readAsBytesSync();
        if (parts.length > 1) bytes = _ttcFace(bytes, int.parse(parts[1]));
        loader.addFont(Future.value(ByteData.sublistView(bytes)));
      }
      await loader.load();
    }

    await load('Roboto', [
      '$material/roboto-regular.ttf',
      '$material/roboto-medium.ttf',
      '$material/roboto-bold.ttf',
    ]);
    await load('MaterialIcons', ['$material/materialicons-regular.otf']);
    await load('Segoe', ['$win/segoeui.ttf', '$win/segoeuib.ttf']);
    await load('FbZh', ['$win/msyh.ttc', '$win/msyhbd.ttc']);
    await load('FbJa', ['$win/YuGothM.ttc', '$win/YuGothB.ttc']);
    await load('FbKo', ['$win/malgun.ttf', '$win/malgunbd.ttf']);
    await load('FbHi', ['$win/Nirmala.ttc#0', '$win/Nirmala.ttc#1']);
    await load('Symbols', ['$win/seguisym.ttf']);
  });

  setUp(() {
    // ignore: invalid_use_of_visible_for_testing_member
    SharedPreferences.setMockInitialValues({});
  });

  Future<void> save(WidgetTester tester, String path) async {
    final boundary = boundaryKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    await tester.runAsync(() async {
      final image = await boundary.toImage();
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      File(path)
        ..createSync(recursive: true)
        ..writeAsBytesSync(data!.buffer.asUint8List());
    });
  }

  void voices(WidgetTester tester, String language) {
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(const MethodChannel('flutter_tts'), (call) async {
      if (call.method == 'getVoices') {
        return [for (var i = 1; i <= 8; i++) {'name': 'ses$i-local', 'locale': language}];
      }
      return 1;
    });
    // Mikrofon ve oynatıcı testte yok.
    for (final channel in ['com.llfbandit.record/messages', 'com.ryanheise.just_audio.methods']) {
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(MethodChannel(channel), (call) async => null);
    }
  }

  Piece pieceFor(Shot s) {
    final piece = const ScriptParser().parse(
      text: '${s.names[0]}: ${s.lines[0]}\n${s.names[1]}: ${s.lines[1]}\n'
          '${s.names[1]}: ${s.lines[2]}\n${s.names[0]}: ${s.lines[3]}',
      title: s.title,
      kind: PieceKind.play,
      language: s.voice,
    );
    piece.myCharacterIds.add(piece.characters[1].id);
    return piece;
  }

  /// Telefon ekranı: 360 mantıksal piksel genişlik, çerçeveye büyütülür.
  Widget framed(Shot s, AppState state, String caption) {
    const sh = 1600.0, sw = 755.0;
    const screen = Size(360, 360 * sh / sw);
    ThemeData theme(Brightness b) => ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5B3E96), brightness: b),
          fontFamily: 'Roboto',
          fontFamilyFallback: ['Segoe', ..._fallbackFor(s)],
        );
    return RepaintBoundary(
      key: boundaryKey,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(children: [
          Positioned.fill(child: CustomPaint(painter: _Gradient())),
          Positioned(
            top: 84,
            left: 40,
            right: 40,
            height: 100,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                caption,
                textDirection: textDirectionFor(s.code),
                style: TextStyle(
                  fontFamily: 'Segoe',
                  fontFamilyFallback: _fallbackFor(s),
                  fontWeight: FontWeight.w700,
                  fontSize: 68,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            left: (1080 - sw) / 2 - 6,
            top: 254,
            width: sw + 12,
            height: sh + 12,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(46))),
            ),
          ),
          Positioned(
            left: (1080 - sw) / 2,
            top: 260,
            width: sw,
            height: sh,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: FittedBox(
                fit: BoxFit.fill,
                child: SizedBox.fromSize(
                  size: screen,
                  child: MediaQuery(
                    data: const MediaQueryData(size: screen, devicePixelRatio: 3, platformBrightness: Brightness.dark),
                    child: AppScope(
                      state: state,
                      child: MaterialApp(
                        key: ValueKey(caption),
                        debugShowCheckedModeBanner: false,
                        locale: Locale(s.code),
                        supportedLocales: L.supportedLocales,
                        localizationsDelegates: L.localizationsDelegates,
                        theme: theme(Brightness.light),
                        darkTheme: theme(Brightness.dark),
                        themeMode: ThemeMode.dark,
                        home: const Scaffold(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  /// Ekranı bir önceki sayfanın üstüne açar (geri oku görünsün).
  Future<void> open(WidgetTester tester, Shot s, AppState state, String caption, Widget screen) async {
    await tester.pumpWidget(framed(s, state, caption));
    await tester.pumpAndSettle();
    tester.state<NavigatorState>(find.byType(Navigator)).push(MaterialPageRoute<void>(builder: (_) => screen));
    await tester.pumpAndSettle();
  }

  for (final entry in shots.entries) {
    final s = entry.value;
    final out = '$root/store/shots/${entry.key}';

    testWidgets('${entry.key}: ekran görüntüleri', (tester) async {
      tester.view
        ..physicalSize = const Size(1080, 1920)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      debugDisableShadows = false;
      voices(tester, s.voice);
      final l = lookupL(Locale(s.code));
      final state = await AppState.load(repository: MemoryRepository(), pro: FakeProStore(pro: true));

      // 1) Prova: sıra bende, baş harf ipucu.
      await open(tester, s, state, s.captions[0], RehearsalScreen(piece: pieceFor(s), speaker: FakeSpeaker()));
      await tester.tap(find.byTooltip(l.play));
      await tester.pumpAndSettle();
      // Liste sıradaki repliğe kayar; ilk replik de tam görünsün.
      await tester.drag(find.text(s.lines[0]), const Offset(0, 200));
      await tester.pumpAndSettle();
      await save(tester, '$out/${entry.key}-1.png');

      // 2) Karakterler ve sesler: kendi karakterimin ses ayarları açık.
      final piece = pieceFor(s);
      await open(tester, s, state, s.captions[1], EditorScreen(piece: piece));
      final mine = find.ancestor(of: find.text(s.names[1]).first, matching: find.byType(ListTile));
      await tester.tap(find.descendant(of: mine, matching: find.byTooltip(l.voice)));
      await tester.pumpAndSettle();
      await save(tester, '$out/${entry.key}-2.png');

      // 3) Çalışma modları.
      await open(tester, s, state, s.captions[2], RehearsalScreen(piece: pieceFor(s), speaker: FakeSpeaker()));
      await tester.tap(find.byTooltip(l.settings));
      await tester.pumpAndSettle();
      await save(tester, '$out/${entry.key}-3.png');

      await tester.pumpWidget(const SizedBox());
      await tester.pumpAndSettle();
      debugDisableShadows = true;
    });

    testWidgets('${entry.key}: öne çıkan görsel', (tester) async {
      tester.view
        ..physicalSize = const Size(1024, 500)
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      const w = 1024.0, h = 500.0;
      const tx = w * 0.40, maxW = w * 0.94 - tx;
      final dir = textDirectionFor(s.code);

      TextStyle style(double size, FontWeight weight, Color color) => TextStyle(
            fontFamily: 'Segoe',
            fontFamilyFallback: _fallbackFor(s),
            fontWeight: weight,
            fontSize: size,
            height: 1.33,
            color: color,
          );
      // Uzun dillerde yazı taşmasın: sığana kadar küçült.
      double fit(double size, FontWeight weight, List<String> texts) {
        while (true) {
          final widest = texts.map((t) {
            final p = TextPainter(text: TextSpan(text: t, style: style(size, weight, Colors.white)), textDirection: dir)
              ..layout();
            return p.width;
          }).reduce((a, b) => a > b ? a : b);
          if (widest <= maxW) return size;
          size *= 0.95;
        }
      }

      final title = fit(h * 0.16, FontWeight.w700, [s.feature[0]]);
      final sub = fit(h * 0.075, FontWeight.w400, s.feature.sublist(1));
      const soft = Color(0xFFE6FFF8);
      Widget line(double top, String text, TextStyle st) => Positioned(
            left: tx,
            top: top,
            width: maxW,
            child: Text(text, textDirection: dir, textAlign: TextAlign.left, maxLines: 1, style: st),
          );

      await tester.pumpWidget(RepaintBoundary(
        key: boundaryKey,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Stack(children: [
            Positioned.fill(child: CustomPaint(painter: _Gradient())),
            Positioned(left: 0, top: h * 0.05, width: h * 0.9, height: h * 0.9, child: CustomPaint(painter: _Logo())),
            line(h * 0.28, s.feature[0], style(title, FontWeight.w700, Colors.white)),
            line(h * 0.50, s.feature[1], style(sub, FontWeight.w400, soft)),
            line(h * 0.61, s.feature[2], style(sub, FontWeight.w400, soft)),
          ]),
        ),
      ));
      await tester.pumpAndSettle();
      await save(tester, '$out/${entry.key}-feature.png');
    });
  }
}
