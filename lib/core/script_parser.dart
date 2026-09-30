import 'emotion.dart';
import 'models.dart';

/// Yapıştırılan veya dosyadan okunan metni satırlara ayırır.
///
/// Rakip uygulamaların en çok şikâyet edilen noktası buydu: replikler yanlış
/// karaktere atanıyor, sayfa başlıkları replik sanılıyor. Bu yüzden ayrıştırıcı
/// temkinlidir; emin olamadığı satırı bir önceki repliğin devamı sayar ve
/// kullanıcı düzeltme ekranında tek dokunuşla düzeltir.
class ScriptParser {
  const ScriptParser();

  static final _pageNumber = RegExp(
    r'^\s*((page|sayfa|seite|página|pagina|page|страница|halaman|صفحة|पृष्ठ|पेज|第|ページ|페이지)\s*)?\d{1,4}\s*(/\s*\d{1,4})?\s*(页|頁|ページ|페이지|쪽)?\.?\s*$',
    caseSensitive: false,
    unicode: true,
  );

  // "Birinci Perde", "Scene 2", "Akt III" — anahtar kelime satırın herhangi
  // bir yerinde. \b ASCII dışı harflerde çalışmadığı için lookaround.
  static final _heading = RegExp(
    r'(?<!\p{L})(act|scene|perde|sahne|bölüm|akt|szene|acte|scène|acto|escena|ato|cena|atto|действие|сцена|явление|babak|adegan|الفصل|المشهد|अंक|दृश्य|シーン|장면)(?!\p{L})',
    caseSensitive: false,
    unicode: true,
  );

  // Çince, Japonca ve Korecede sayı ortada ya da başta: "第一幕", "第2场",
  // "제1막", "2장".
  static final _cjkHeading = RegExp(
    r'^\s*(第\s*[0-9０-９一二三四五六七八九十百]+\s*[幕场場景]|제?\s*[0-9]+\s*[막장](?!\p{L}))',
    unicode: true,
  );

  /// Sunumda sayfa/slayt işareti: "Sayfa 2", "Slayt 3: Sonuç", "Slide 4".
  /// Oyunlarda sayfa numarası silinir; sunumda sayfa başıdır.
  static final _speechPage = RegExp(
    r'^\s*((sayfa|slayt|page|slide|seite|folie|página|pagina|diapositiva|diapo|страница|слайд|halaman|salindia|صفحة|شريحة|पृष्ठ|पेज|स्लाइड|幻灯片|投影片|スライド|ページ|슬라이드|페이지)\s*\d{1,3}(?!\d)|第?\s*\d{1,3}\s*(页|頁|张|張|ページ|枚目|페이지|쪽)目?\s*([:：.。\-–—]|$))',
    caseSensitive: false,
    unicode: true,
  );

  static final _screenplaySlug = RegExp(r'^\s*(INT\.|EXT\.|İÇ\.|DIŞ\.)', unicode: true);

  // AD: replik  |  AD - replik  |  AD. replik (AD kısa ve ilk harfi büyük)
  static final _inlineSpeaker = RegExp(
    r'^\s*([^\s:：().\[\]（）【】\-–—][^:：()\[\]（）【】]{0,30}?)\s*([(（][^)）]*[)）])?\s*[:：]\s*(.+)$',
    unicode: true,
  );

  static final _direction = RegExp(r'^\s*[(\[（【][^)\]）】]*[)\]）】]\s*$', unicode: true);

  Piece parse({
    required String text,
    required String title,
    required PieceKind kind,
    required String language,
  }) {
    final piece = Piece(title: title, kind: kind, language: language);
    final lines = _normalize(text, keepPageMarks: kind == PieceKind.speech);

    if (kind != PieceKind.play) {
      _parseMonologue(piece, lines);
    } else {
      _parsePlay(piece, lines);
      _emotionsFromDirections(piece);
    }
    return piece;
  }

  /// "AHMET (öfkeyle): ..." ya da replikten hemen önceki "(ağlayarak)"
  /// yönergesi repliğin seslendirme tonunu belirler.
  void _emotionsFromDirections(Piece piece) {
    for (var i = 1; i < piece.lines.length; i++) {
      final prev = piece.lines[i - 1];
      final line = piece.lines[i];
      if (line.kind == LineKind.dialogue && prev.kind == LineKind.direction) {
        line.emotion = emotionFromDirection(prev.text);
      }
    }
  }

  /// Satır sonlarını, görünmez karakterleri ve tekrar eden sayfa
  /// başlıklarını/altlıklarını temizler.
  List<String> _normalize(String text, {bool keepPageMarks = false}) {
    final raw = text
        .replaceAll('\r\n', '\n')
        .replaceAll('\r', '\n')
        .replaceAll(RegExp('[​-‏﻿­]'), '')
        .replaceAll(' ', ' ')
        .replaceAll('\t', ' ')
        .split('\n')
        .map((l) => l.trimRight())
        .toList();

    // Aynı metinle 3+ kez tekrar eden, konuşmacı biçiminde olmayan kısa
    // satırlar sayfa başlığı/altlığıdır ("Sides by ..." gibi).
    final counts = <String, int>{};
    for (final l in raw) {
      final t = l.trim();
      if (t.isEmpty) continue;
      counts[t] = (counts[t] ?? 0) + 1;
    }
    final repeatedFurniture = counts.entries
        .where((e) => e.value >= 3 && e.key.length <= 80 && !_inlineSpeaker.hasMatch(e.key))
        .map((e) => e.key)
        .toSet();

    return _joinOpenBrackets(raw
        .where((l) => !_pageNumber.hasMatch(l) || (keepPageMarks && _speechPage.hasMatch(l)))
        .where((l) => !repeatedFurniture.contains(l.trim()))
        .toList());
  }

  /// PDF'lerde uzun yönergeler satıra bölünür: "(Bir oturma odası. Akşam"
  /// / "Zeynep bekliyor.)". Açılan parantez kapanana kadar (en çok 8 satır)
  /// satırlar birleştirilir.
  List<String> _joinOpenBrackets(List<String> lines) {
    final out = <String>[];
    for (var i = 0; i < lines.length; i++) {
      final t = lines[i].trim();
      final opens = const {'(': ')', '[': ']', '（': '）', '【': '】'}[t.isEmpty ? '' : t[0]];
      if (opens == null || t.contains(opens)) {
        out.add(lines[i]);
        continue;
      }
      var joined = t;
      var j = i + 1;
      while (j < lines.length && j - i <= 8 && lines[j].trim().isNotEmpty) {
        joined = '$joined ${lines[j].trim()}';
        if (lines[j].contains(opens)) break;
        j++;
      }
      if (joined.contains(opens)) {
        out.add(joined);
        i = j;
      } else {
        out.add(lines[i]); // Kapanmıyorsa dokunma.
      }
    }
    return out;
  }

  void _parseMonologue(Piece piece, List<String> lines) {
    final me = Character(name: piece.kind == PieceKind.poem ? '♪' : '●');
    piece.characters.add(me);
    piece.myCharacterIds.add(me.id);

    for (final l in lines) {
      final t = l.trim();
      if (t.isEmpty) continue;
      if (_direction.hasMatch(t)) {
        piece.lines.add(Line(kind: LineKind.direction, text: _stripBrackets(t)));
      } else if (piece.kind == PieceKind.speech && (_speechPage.hasMatch(t) || _isHeading(t))) {
        // Sunumda sayfa/bölüm başı: sayfa sayfa provada sınır olur.
        piece.lines.add(Line(kind: LineKind.heading, text: t));
      } else {
        // Şiirde her dize ayrı ezber birimidir.
        piece.lines.add(Line(kind: LineKind.dialogue, characterId: me.id, text: t));
      }
    }
  }

  void _parsePlay(Piece piece, List<String> lines) {
    final recurring = _recurringNames(lines);
    // Metin, tekrar eden konuşmacıları hep BÜYÜK harfle yazıyorsa bu bir
    // biçim kuralıdır: tek seferlik "Not: ..." gibi satırlar konuşmacı değil.
    final capsConvention = recurring.length >= 2 &&
        recurring.every((k) => k == _upper(k) && k != _lower(k));
    final byName = <String, Character>{};
    Character speaker(String name) {
      final key = _speakerKey(name);
      return byName.putIfAbsent(key, () {
        final c = Character(name: _displayName(name));
        piece.characters.add(c);
        return c;
      });
    }

    Line? current; // Devam satırlarının ekleneceği replik.
    Character? pendingSpeaker; // Senaryo biçimi: ad tek başına bir satırda.

    for (var i = 0; i < lines.length; i++) {
      final t = lines[i].trim();
      if (t.isEmpty) {
        current = null;
        pendingSpeaker = null;
        continue;
      }

      if (_isHeading(t) || _screenplaySlug.hasMatch(t)) {
        piece.lines.add(Line(kind: LineKind.heading, text: t));
        current = null;
        pendingSpeaker = null;
        continue;
      }

      if (_direction.hasMatch(t)) {
        piece.lines.add(Line(kind: LineKind.direction, text: _stripBrackets(t)));
        // Senaryoda ad ile replik arasındaki (duraksar) gibi yönergeler
        // konuşmacıyı sıfırlamaz.
        if (pendingSpeaker == null) current = null;
        continue;
      }

      final inline = _inlineSpeaker.firstMatch(t);
      if (inline != null && _acceptSpeaker(inline.group(1)!, recurring, capsConvention)) {
        final c = speaker(inline.group(1)!);
        final paren = inline.group(2);
        if (paren != null) {
          piece.lines.add(Line(kind: LineKind.direction, text: _stripBrackets(paren)));
        }
        current = Line(kind: LineKind.dialogue, characterId: c.id, text: inline.group(3)!.trim());
        piece.lines.add(current);
        pendingSpeaker = null;
        continue;
      }

      // "X: ..." biçiminde ama konuşmacı sayılmadı ("Not: ..."): önceki
      // repliğin devamı da değildir, kullanıcıya sorulmak üzere işaretlenir.
      if (inline != null && capsConvention) {
        piece.lines.add(Line(kind: LineKind.direction, text: t, unsure: true));
        current = null;
        pendingSpeaker = null;
        continue;
      }

      // "AHMET. Replik" / "AHMET — Replik": yalnızca ad tamamen büyük
      // harfse (yoksa "Evet. Gidelim." gibi cümleler konuşmacı sanılır).
      final caps = _capsSpeaker.firstMatch(t);
      if (caps != null && _isCueName(caps.group(1)!)) {
        final c = speaker(caps.group(1)!);
        final paren = caps.group(2);
        if (paren != null) {
          piece.lines.add(Line(kind: LineKind.direction, text: _stripBrackets(paren)));
        }
        current = Line(kind: LineKind.dialogue, characterId: c.id, text: caps.group(3)!.trim());
        piece.lines.add(current);
        pendingSpeaker = null;
        continue;
      }

      if (_isCueName(t) && _nextNonEmptyIsText(lines, i)) {
        pendingSpeaker = speaker(t);
        current = null;
        continue;
      }

      if (pendingSpeaker != null) {
        current = Line(kind: LineKind.dialogue, characterId: pendingSpeaker.id, text: t);
        piece.lines.add(current);
        pendingSpeaker = null;
        continue;
      }

      if (current != null) {
        current.text = '${current.text} $t';
        continue;
      }

      // Kime ait olduğu bilinmeyen metin: yönerge olarak işaretlenir ve
      // "emin değilim" diye vurgulanır; kullanıcı tek dokunuşla atar.
      piece.lines.add(Line(kind: LineKind.direction, text: t, unsure: true));
    }
  }

  bool _acceptSpeaker(String candidate, Set<String> recurring, bool capsConvention) {
    final key = _speakerKey(candidate);
    if (recurring.contains(key)) return true;
    if (!_looksLikeName(candidate)) return false;
    if (capsConvention && !_isCueName(candidate)) return false;
    return true;
  }

  static final _capsSpeaker = RegExp(
    r'^\s*([^\s.:\-–—(\[][^.:\-–—()\[\]]{0,29}?)\s*(\([^)]*\))?\s*(?:\.|—|–|-)\s+(.+)$',
    unicode: true,
  );

  /// Küçük harfle yazılmış ama en az iki kez "ad: ..." biçiminde geçen
  /// adlar da konuşmacıdır ("ahmet: nereye?"). Tek seferlik "Not: ..."
  /// gibi satırlar ise konuşmacı sayılmaz.
  Set<String> _recurringNames(List<String> lines) {
    final counts = <String, int>{};
    for (final l in lines) {
      final t = l.trim();
      // "AHMET. …" / "AHMET — …" biçimi de konuşmacı kuralına dahil.
      final caps = _capsSpeaker.firstMatch(t);
      if (caps != null && _isCueName(caps.group(1)!)) {
        final key = _speakerKey(caps.group(1)!);
        counts[key] = (counts[key] ?? 0) + 1;
        continue;
      }
      final m = _inlineSpeaker.firstMatch(t);
      if (m == null) continue;
      final name = m.group(1)!.trim();
      if (name.isEmpty || name.length > 30 || name.split(RegExp(r'\s+')).length > 3) continue;
      if (RegExp(r'[0-9!?.,;"«»。、，！？「」]').hasMatch(name)) continue;
      final key = _speakerKey(name);
      counts[key] = (counts[key] ?? 0) + 1;
    }
    return {for (final e in counts.entries) if (e.value >= 2) e.key};
  }

  bool _nextNonEmptyIsText(List<String> lines, int i) {
    for (var j = i + 1; j < lines.length; j++) {
      final t = lines[j].trim();
      if (t.isEmpty) return false;
      if (_direction.hasMatch(t)) continue;
      return !_isCueName(t);
    }
    return false;
  }

  /// Senaryo biçimindeki tek başına ad satırı: tamamı büyük harf, kısa.
  bool _isCueName(String t) {
    final name = t.replaceAll(RegExp(r'\s*[(（].*[)）]\s*$'), '').trim();
    if (name.isEmpty || name.length > 30) return false;
    if (!RegExp(r'\p{L}', unicode: true).hasMatch(name)) return false;
    if (name.split(RegExp(r'\s+')).length > 3) return false;
    return name == _upper(name) && name != _lower(name);
  }

  bool _looksLikeName(String candidate) {
    final name = candidate.trim();
    if (name.isEmpty || name.length > 30) return false;
    if (name.split(RegExp(r'\s+')).length > 3) return false;
    if (RegExp(r'[0-9!?.,;"«»。、，！？「」]').hasMatch(name)) return false;
    final first = name.characters0;
    // Büyük harfle başlamalı. Harf ayrımı olmayan alfabelerde (Arapça)
    // upper(x) == x olduğundan her kısa ad kabul edilir.
    return first == _upper(first);
  }

  static final _ordinal = RegExp(
    r'(?<!\p{L})(birinci|ikinci|üçüncü|dördüncü|beşinci|altıncı|one|two|three|four|five|first|second|third|fourth|fifth|erste[rs]?|zweite[rs]?|dritte[rs]?|premi[eè]re?|deuxième|troisième|primer[ao]?|segund[ao]|tercer[ao]?|prim[ao]|second[ao]|terz[ao]|первое|второе|третье|pertama|kedua|ketiga)(?!\p{L})',
    caseSensitive: false,
    unicode: true,
  );

  /// Sahne başlığı: anahtar kelime + numara, roma rakamı veya sıra sayısı.
  /// "SAHNE AMİRİ" gibi karakter adları başlık sayılmaz.
  bool _isHeading(String t) {
    if (t.length > 60) return false;
    if (_cjkHeading.hasMatch(t)) return true;
    if (!_heading.hasMatch(_fold(t))) return false;
    // "SAHNE 1: Ev" başlıktır; "SAHNE AMİRİ: Işıklar hazır." bir repliktir.
    final inline = _inlineSpeaker.firstMatch(t);
    if (inline != null && _looksLikeName(inline.group(1)!) && !_hasNumbering(inline.group(1)!)) {
      return false;
    }
    return _hasNumbering(t);
  }

  bool _hasNumbering(String t) =>
      RegExp(r'\d|(?<![A-Za-z])[IVXLC]+(?![A-Za-z])').hasMatch(t) || _ordinal.hasMatch(_fold(t));

  /// Dil bağımsız küçük harf: Dart'ın harf duyarsız eşleşmesi Türkçe İ'yi
  /// i ile eşlemez, "BİRİNCİ" → "birinci" olmalı.
  static String _fold(String s) => s.replaceAll('İ', 'i').toLowerCase();

  /// "Juliet" ve "JULIET" (veya Türkçe "Alİ"/"ALI") aynı karakterdir.
  String _speakerKey(String name) => name
      .replaceAll(RegExp(r'\s*[(（].*[)）]\s*$'), '')
      .trim()
      .toUpperCase()
      .replaceAll('İ', 'I')
      .replaceAll(RegExp(r'\s+'), ' ');

  String _displayName(String name) =>
      name.replaceAll(RegExp(r'\s*[(（].*[)）]\s*$'), '').trim().replaceAll(RegExp(r'\s+'), ' ');

  String _stripBrackets(String t) =>
      t.trim().replaceAll(RegExp(r'^[(\[（【]\s*|\s*[)\]）】]$'), '');

  // Türkçe i/İ, ı/I dönüşümleri dahil.
  static String _upper(String s) =>
      s.replaceAll('i', 'İ').replaceAll('ı', 'I').toUpperCase();
  static String _lower(String s) =>
      s.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();
}

extension on String {
  String get characters0 => isEmpty ? '' : String.fromCharCode(runes.first);
}
