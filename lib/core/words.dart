/// Çince ve Japoncada kelimeler boşlukla ayrılmaz; sözlük olmadan kelime
/// sınırı bulunamayacağı için her karakter ayrı bir birim sayılır.
const _cjk = r'\p{Script=Han}\p{Script=Hiragana}\p{Script=Katakana}ー';

const _letter = '(?:(?![$_cjk])[\\p{L}\\p{M}\\p{N}])';

/// Metnin kelimeleri: harf/rakam dizileri ("don't" tek kelime), Çince ve
/// Japoncada tek tek karakterler.
final wordRe = RegExp("[$_cjk]|$_letter+(?:['’]$_letter+)*", unicode: true);

final _cjkStart = RegExp('^[$_cjk]', unicode: true);

/// [wordRe] ile ayrılmış birim tek bir Çince/Japonca karakter mi.
bool isCjk(String word) => _cjkStart.hasMatch(word);

/// Kelimeleri gösterim için birleştirir: Çince/Japonca karakterlerin arasına
/// boşluk konmaz.
String joinWords(Iterable<String> words) {
  final sb = StringBuffer();
  String? prev;
  for (final w in words) {
    if (prev != null && !(isCjk(prev) && isCjk(w))) sb.write(' ');
    sb.write(w);
    prev = w;
  }
  return sb.toString();
}

/// Konuşma süresi hesabı için kelime sayısı: Çince/Japoncada iki karakter
/// yaklaşık bir kelime kadar sürer.
int spokenWordCount(String text) {
  var words = 0, chars = 0;
  for (final m in wordRe.allMatches(text)) {
    isCjk(m[0]!) ? chars++ : words++;
  }
  return words + (chars + 1) ~/ 2;
}
