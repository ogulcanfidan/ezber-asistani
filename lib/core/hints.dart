import 'words.dart';

/// Kullanıcının kendi repliği prova sırasında nasıl gösterilir.
enum HintLevel {
  /// Tam metin.
  full,

  /// Her kelimenin yalnızca ilk harfi: "T___ o_ n__ t_ b_".
  firstLetters,

  /// Kademeli silme: kelimelerin belirli bir oranı gizlenir; her hatasız
  /// turda oran artar. Ezber araştırmalarının en etkili bulduğu yöntemlerden.
  progressive,

  /// Sunum notu gibi: yalnızca anlamlı (uzun) kelimeler ve sayılar görünür.
  keywords,

  /// Hiçbir şey gösterilmez, yalnızca sıranın size geldiği belirtilir.
  hidden,
}

final _word = wordRe;

/// [revealWords]: suflörün ya da "İpucu" düğmesinin açtığı ilk kelimeler
/// tam gösterilir, kalanı ipucu seviyesine göre.
/// [hideRatio] ve [seed] kademeli silme içindir: aynı satırda aynı kelimeler
/// gizlenir ve oran artınca öncekiler gizli kalır (üst küme).
String applyHint(
  String text,
  HintLevel level, {
  int revealWords = 0,
  double hideRatio = 0.4,
  String seed = '',
}) {
  if (level == HintLevel.full) return text;

  if (level == HintLevel.hidden) {
    if (revealWords == 0) return '';
    // Gizli seviyede yalnızca açılan kelimeler ve ardından "…" görünür.
    final matches = _word.allMatches(text).toList();
    if (revealWords >= matches.length) return text;
    return '${text.substring(0, matches[revealWords - 1].end)} …';
  }

  var index = 0;
  var prevEnd = -1;
  final out = text.replaceAllMapped(_word, (m) {
    final word = m[0]!;
    final i = index++;
    // Çince/Japoncada bitişik karakterler tek bir öbek gibi davranır:
    // öbeğin yalnızca ilk karakteri ipucu olarak kalır.
    final inRun = isCjk(word) && m.start == prevEnd;
    prevEnd = isCjk(word) ? m.end : -1;
    if (i < revealWords) return word;
    switch (level) {
      case HintLevel.firstLetters:
        return inRun ? '_' : _initial(word);
      case HintLevel.progressive:
        return wordHidden(seed, i, hideRatio) ? '_' * _letters(word) : word;
      case HintLevel.keywords:
        if (isCjk(word)) return inRun ? '\u0000' : word;
        return isKeyword(word) ? word : '\u0000';
      case HintLevel.full:
      case HintLevel.hidden:
        return word;
    }
  });
  if (level != HintLevel.keywords) return out;
  // Gizlenen kelimeleri tek "…" ile topla: "Bugün … projemizi anlatacağım".
  return out
      .replaceAll(RegExp('\u0000(?:[\\s,;:]*\u0000)*'), '…')
      .replaceAll(RegExp(r'…(\s*…)+'), '…');
}

String _initial(String word) {
  final runes = word.runes.toList();
  return String.fromCharCode(runes.first) + '_' * (_letters(word) - 1);
}

/// Birleşik işaretleri (ör. Arapça hareke) harf saymayız.
int _letters(String word) => word.runes.where((r) => !_isMark(r)).length;

bool _isMark(int rune) => RegExp(r'\p{M}', unicode: true).hasMatch(String.fromCharCode(rune));

/// Kademeli silmede kelime gizli mi: satır+kelime sırasından türetilen sabit
/// bir değer oranın altındaysa. Oran artınca gizliler gizli kalır.
bool wordHidden(String seed, int index, double ratio) {
  if (ratio >= 1) return true;
  if (ratio <= 0) return false;
  var h = 2166136261;
  for (final c in '$seed#$index'.codeUnits) {
    h = ((h ^ c) * 16777619) & 0xFFFFFFFF;
  }
  return (h % 1000) / 1000 < ratio;
}

/// Anahtar kelime: 5+ harf, sayı ya da cümle içinde büyük harfle başlayan
/// (özel ad). Kısa bağlaç/edatlar ("ve", "bir", "the", "und") gizlenir.
bool isKeyword(String word) {
  if (RegExp(r'\d').hasMatch(word)) return true;
  return _letters(word) >= _keywordLength(word);
}

/// Hece yazılarında kelimeler daha az harfle yazılır: Korecede 3 hece,
/// Hintçede 4 harf anlamlı bir kelimedir.
int _keywordLength(String word) {
  final first = word.runes.first;
  if (first >= 0xAC00 && first <= 0xD7A3) return 3;
  if (first >= 0x0900 && first <= 0x097F) return 4;
  return 5;
}

/// Kullanıcıya repliğini söylemesi için tanınan süre.
Duration gapFor(String text, {double factor = 1.0}) {
  final words = spokenWordCount(text);
  final ms = (1500 + words * 450) * factor;
  return Duration(milliseconds: ms.round());
}

int wordCount(String text) => spokenWordCount(text);
