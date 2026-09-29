import 'hints.dart' show wordCount;
import 'models.dart';

/// Sunumun bir sayfası (slayt): [start]..[end) satırları.
class SpeechPage {
  const SpeechPage({required this.start, required this.end, this.title, required this.words});

  final int start;
  final int end;

  /// Metindeki başlık ("Giriş", "Slayt 2"); yoksa null ("Sayfa N" denir).
  final String? title;
  final int words;
}

/// Sayfalar metindeki başlıklardan, başlık yoksa paragraflardan oluşur.
List<SpeechPage> speechPages(Piece piece) {
  final lines = piece.lines;
  final hasHeadings = lines.any((l) => l.kind == LineKind.heading);
  final pages = <SpeechPage>[];
  int words(int a, int b) => [for (var i = a; i < b; i++) if (lines[i].kind != LineKind.heading) wordCount(lines[i].text)]
      .fold(0, (x, y) => x + y);

  if (hasHeadings) {
    // Başlıktan önceki giriş metni de bir sayfa.
    var start = 0;
    String? title;
    for (var i = 0; i <= lines.length; i++) {
      final boundary = i == lines.length || lines[i].kind == LineKind.heading;
      if (!boundary) continue;
      if (i > start && words(start, i) > 0) {
        pages.add(SpeechPage(start: start, end: i, title: title, words: words(start, i)));
      }
      if (i < lines.length) {
        start = i;
        title = lines[i].text;
      }
    }
    return pages;
  }
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].kind != LineKind.dialogue) continue;
    pages.add(SpeechPage(start: i, end: i + 1, words: wordCount(lines[i].text)));
  }
  return pages;
}

/// Ortalama sunum hızı (kelime/dakika).
const speechWordsPerMinute = 130;

/// Sayfaların süreleri (saniye): kullanıcı ayarladıysa o, yoksa hedef süre
/// kelime sayısına göre paylaştırılır, hedef de yoksa ortalama hızla.
List<int> pageSecondsFor(Piece piece, List<SpeechPage> pages) {
  final saved = piece.pageSeconds;
  if (saved != null && saved.length == pages.length) return saved;
  final total = pages.fold(0, (a, p) => a + p.words);
  final target = piece.targetSeconds;
  return [
    for (final p in pages)
      _round5(target != null && total > 0
          ? target * p.words / total
          : p.words * 60 / speechWordsPerMinute),
  ];
}

int _round5(num s) => ((s / 5).round() * 5).clamp(10, 3600).toInt();
