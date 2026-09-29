import 'dart:math';

enum WordStatus { ok, missed }

class CheckedWord {
  const CheckedWord(this.text, this.status);
  final String text;
  final WordStatus status;
}

/// Söylenen metnin replikle karşılaştırması.
class LineCheck {
  const LineCheck({required this.words, required this.extra, required this.heard, this.exact = 0});

  /// Repliğin kelimeleri, her biri söylendi/atlandı olarak işaretli.
  final List<CheckedWord> words;

  /// Replikte olmayan, fazladan söylenen kelimeler.
  final List<String> extra;

  /// Tanıyıcının duyduğu metin.
  final String heard;

  /// Esnek değil birebir eşleşen kelime sayısı (eşit puanda tercih için).
  final int exact;

  int get total => words.length;
  int get matched => words.where((w) => w.status == WordStatus.ok).length;

  /// 0–100. Fazladan kelimeler puanı düşürmez (oyuncu doğaçlama bir "eee"
  /// ekleyebilir), atlanan kelimeler düşürür.
  int get score => total == 0 ? 100 : (matched * 100 / total).round();

  List<String> get missed => [for (final w in words) if (w.status == WordStatus.missed) w.text];
}

final _wordRe = RegExp(r"[\p{L}\p{M}\p{N}]+(?:['’][\p{L}\p{M}]+)*", unicode: true);

/// Tanıyıcı birden çok olası metin döndürür: repliğe en uyanı seçilir.
LineCheck checkBest(String expected, List<String> heardAlternatives) {
  if (heardAlternatives.isEmpty) return checkLine(expected, '');
  return heardAlternatives
      .map((h) => checkLine(expected, h))
      .reduce((a, b) => b.score > a.score || (b.score == a.score && b.exact > a.exact) ? b : a);
}

LineCheck checkLine(String expected, String heard) {
  final exp = _wordRe.allMatches(expected).map((m) => m[0]!).toList();
  final got = _wordRe.allMatches(heard).map((m) => m[0]!).toList();
  final e = exp.map(_fold).toList();
  final g = got.map(_fold).toList();

  // En uzun ortak alt dizi (esnek kelime eşitliğiyle).
  final dp = List.generate(e.length + 1, (_) => List.filled(g.length + 1, 0));
  for (var i = e.length - 1; i >= 0; i--) {
    for (var j = g.length - 1; j >= 0; j--) {
      dp[i][j] = _same(e[i], g[j]) ? dp[i + 1][j + 1] + 1 : max(dp[i + 1][j], dp[i][j + 1]);
    }
  }

  final words = <CheckedWord>[];
  final extra = <String>[];
  var i = 0, j = 0, exact = 0;
  while (i < e.length && j < g.length) {
    if (_same(e[i], g[j])) {
      if (e[i] == g[j]) exact++;
      words.add(CheckedWord(exp[i], WordStatus.ok));
      i++;
      j++;
    } else if (dp[i + 1][j] >= dp[i][j + 1]) {
      words.add(CheckedWord(exp[i], WordStatus.missed));
      i++;
    } else {
      extra.add(got[j]);
      j++;
    }
  }
  for (; i < e.length; i++) {
    words.add(CheckedWord(exp[i], WordStatus.missed));
  }
  for (; j < g.length; j++) {
    extra.add(got[j]);
  }
  return LineCheck(words: words, extra: extra, heard: heard, exact: exact);
}

/// Karşılaştırma için sadeleştirme: küçük harf (Türkçe İ/I dahil) ve
/// aksan/şapka farkları yok sayılır — tanıyıcı "dönerim"i "donerim"
/// yazabilir, bu oyuncunun hatası değildir.
String _fold(String w) {
  final lower = w.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();
  final sb = StringBuffer();
  for (final r in lower.runes) {
    final ch = String.fromCharCode(r);
    if (RegExp(r'\p{M}', unicode: true).hasMatch(ch)) continue; // birleşik işaret
    sb.write(_plain[ch] ?? ch);
  }
  return sb.toString();
}

const _plain = {
  'ı': 'i', 'ş': 's', 'ğ': 'g', 'ç': 'c', 'ö': 'o', 'ü': 'u',
  'á': 'a', 'à': 'a', 'â': 'a', 'ä': 'a', 'ã': 'a', 'å': 'a',
  'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
  'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
  'ó': 'o', 'ò': 'o', 'ô': 'o', 'õ': 'o',
  'ú': 'u', 'ù': 'u', 'û': 'u',
  'ñ': 'n', 'ß': 'ss', 'ё': 'е', 'œ': 'oe', 'æ': 'ae',
  'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ة': 'ه', 'ى': 'ي',
};

/// Kısa kelimeler birebir, uzunlar bir-iki harf farkla eşit sayılır
/// (tanıyıcının ek/çekim hataları: "gidiyorsun" / "gidiyorsu").
bool _same(String a, String b) {
  if (a == b) return true;
  final len = max(a.length, b.length);
  if (len < 4) return false;
  final limit = len >= 8 ? 2 : 1;
  if ((a.length - b.length).abs() > limit) return false;
  return _levenshtein(a, b, limit) <= limit;
}

int _levenshtein(String a, String b, int limit) {
  var prev = List<int>.generate(b.length + 1, (j) => j);
  for (var i = 1; i <= a.length; i++) {
    final cur = List<int>.filled(b.length + 1, 0)..[0] = i;
    var rowMin = cur[0];
    for (var j = 1; j <= b.length; j++) {
      final cost = a.codeUnitAt(i - 1) == b.codeUnitAt(j - 1) ? 0 : 1;
      cur[j] = min(min(cur[j - 1] + 1, prev[j] + 1), prev[j - 1] + cost);
      rowMin = min(rowMin, cur[j]);
    }
    if (rowMin > limit) return rowMin;
    prev = cur;
  }
  return prev[b.length];
}

/// Suflörün fısıldayacağı ilk kelimeler: repliğin yaklaşık üçte biri,
/// en az 1, en çok 4 kelime.
int promptWordCount(String text) {
  final n = _wordRe.allMatches(text).length;
  return max(1, min(4, (n / 3).ceil()));
}

/// Metnin ilk [count] kelimesi (noktalamasıyla birlikte).
String firstWords(String text, int count) {
  final matches = _wordRe.allMatches(text).toList();
  if (count <= 0 || matches.isEmpty) return '';
  if (count >= matches.length) return text;
  return text.substring(0, matches[count - 1].end);
}

/// Metnin kelimeleri (noktalama hariç), karşılaştırma sırasıyla.
List<String> splitWords(String text) => [for (final m in _wordRe.allMatches(text)) m.group(0)!];

/// İki kelime tanıyıcı hatalarına toleranslı eşit mi (aksan, 1-2 harf).
bool wordsMatch(String a, String b) => _same(_fold(a), _fold(b));
