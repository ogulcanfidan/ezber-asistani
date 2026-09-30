import 'hints.dart' show isKeyword;
import 'line_check.dart';
import 'models.dart';
import 'words.dart';

/// Ezberden okuma kontrolü (şiir/metin/sunum): kullanıcı metni baştan sona
/// söyler, telefonda çalışan tanıyıcı (Whisper) parça parça yazıya çevirir,
/// burada beklenen metinle hizalanır. Atlanan veya yanlış söylenen önemli bir
/// yer bulununca durulur; kullanıcı hatayı görüp kaldığı yerden devam eder.

/// Beklenen metnin bir kelimesi ve hangi satırda olduğu.
class ReciteWord {
  const ReciteWord(this.text, this.line);
  final String text;
  final int line;
}

enum ReciteErrorKind {
  /// Söylenmeden geçilen kelime(ler).
  skipped,

  /// Yerine başka kelime söylenen kelime(ler).
  wrong,
}

class ReciteError {
  const ReciteError({
    required this.kind,
    required this.from,
    required this.to,
    this.heard = '',
    this.minor = false,
  });

  final ReciteErrorKind kind;

  /// Beklenen kelimelerde [from, to) aralığı.
  final int from;
  final int to;

  /// Yanlışta kullanıcının söylediği (tanıyıcının duyduğu).
  final String heard;

  /// Küçük hata (tek kısa bağlaç atlandı vb.): durulmaz, raporda görünür.
  /// Tanıyıcı kısa kelimeleri sık düşürür; her birinde durmak haksız olur.
  final bool minor;
}

/// Bir parçanın sonucu.
class ReciteStep {
  const ReciteStep({required this.advancedTo, this.stop});

  /// İlerlenen konum (beklenen kelime indeksi).
  final int advancedTo;

  /// Durulacak hata; yoksa devam.
  final ReciteError? stop;
}

class ReciteChecker {
  ReciteChecker(this.words);

  /// Parçanın kendi satırlarından (başlık/yönerge hariç) beklenen kelimeler.
  factory ReciteChecker.forPiece(Piece piece) => ReciteChecker([
        for (var i = 0; i < piece.lines.length; i++)
          if (piece.lines[i].kind == LineKind.dialogue && piece.isMine(piece.lines[i]))
            for (final w in splitWords(piece.lines[i].text)) ReciteWord(w, i),
      ]);

  final List<ReciteWord> words;
  int pos = 0;
  final errors = <ReciteError>[];

  /// Doğru söylenen (hizalanan) kelime sayısı.
  int matched = 0;

  bool get done => pos >= words.length;

  /// Tanıyıcıya bağlam: son doğrulanan kelimeler (yalnızca geçmiş; önümüzdeki
  /// metni vermek tanıyıcıyı "doğru duymaya" zorlar, hatayı gizler).
  String contextPrompt({int count = 24}) =>
      joinWords(words.sublist((pos - count).clamp(0, pos), pos).map((w) => w.text));

  /// Hata sonrası "Devam": hatalı yerden (atlanan kısmın başından) sürdürülür.
  void resumeAt(int index) => pos = index.clamp(0, words.length);

  /// Tanıyıcının bir parçada duyduğu metni hizalar.
  ReciteStep feed(String heardText) {
    final heard = splitWords(heardText);
    if (heard.isEmpty || done) return ReciteStep(advancedTo: pos);

    final start = pos;
    final end = (pos + heard.length * 2 + 8).clamp(0, words.length);
    final expected = words.sublist(start, end);
    final pairs = _align(heard, expected);

    if (pairs.isEmpty) {
      // Hiçbir kelime tutmadı: kısa parça (öksürük, "ııı") yok sayılır,
      // uzunsa kullanıcı başka bir şey söylemiştir.
      if (heard.length < 3) return ReciteStep(advancedTo: pos);
      final e = ReciteError(
        kind: ReciteErrorKind.wrong,
        from: start,
        to: (start + 1).clamp(0, words.length),
        heard: joinWords(heard),
      );
      errors.add(e);
      return ReciteStep(advancedTo: pos, stop: e);
    }

    ReciteError? stop;
    var hPrev = -1;
    var ePrev = -1;
    for (final (h, e) in [...pairs, (heard.length, -1)]) {
      final isEnd = e == -1;
      final eFrom = ePrev + 1;
      final eTo = isEnd ? eFrom : e; // Sondaki beklenenler henüz söylenmedi.
      final heardGap = heard.sublist(hPrev + 1, h);
      if (eTo > eFrom) {
        final kind = heardGap.isEmpty ? ReciteErrorKind.skipped : ReciteErrorKind.wrong;
        final gapWords = expected.sublist(eFrom, eTo);
        final minor = gapWords.length == 1 && !isKeyword(gapWords.first.text);
        final err = ReciteError(
          kind: kind,
          from: start + eFrom,
          to: start + eTo,
          heard: joinWords(heardGap),
          minor: minor,
        );
        errors.add(err);
        if (!minor) {
          // Sonrası kullanıcı hatalı yerden tekrar söyleyince sayılır.
          stop = err;
          break;
        }
      }
      if (isEnd) break;
      matched++;
      hPrev = h;
      ePrev = e;
    }

    // Hata varsa kullanıcı hatalı yerden devam eder: sonrası söylenmiş sayılmaz.
    pos = stop?.from ?? start + ePrev + 1;
    return ReciteStep(advancedTo: pos, stop: stop);
  }

  /// En uzun ortak alt dizi (toleranslı kelime eşitliğiyle): (duyulan, beklenen)
  /// indeks çiftleri, sıralı.
  List<(int, int)> _align(List<String> heard, List<ReciteWord> expected) {
    final n = heard.length, m = expected.length;
    final dp = List.generate(n + 1, (_) => List<int>.filled(m + 1, 0));
    for (var i = n - 1; i >= 0; i--) {
      for (var j = m - 1; j >= 0; j--) {
        dp[i][j] = wordsMatch(heard[i], expected[j].text)
            ? dp[i + 1][j + 1] + 1
            : (dp[i + 1][j] > dp[i][j + 1] ? dp[i + 1][j] : dp[i][j + 1]);
      }
    }
    final pairs = <(int, int)>[];
    var i = 0, j = 0;
    while (i < n && j < m) {
      if (wordsMatch(heard[i], expected[j].text) && dp[i][j] == dp[i + 1][j + 1] + 1) {
        pairs.add((i, j));
        i++;
        j++;
      } else if (dp[i + 1][j] >= dp[i][j + 1]) {
        i++;
      } else {
        j++;
      }
    }
    return pairs;
  }

  /// Rapor için: doğruluk yüzdesi (söylenen kısım üzerinden).
  int get accuracy {
    final wrongWords = errors.fold(0, (a, e) => a + (e.to - e.from));
    final total = matched + wrongWords;
    return total == 0 ? 100 : (100 * matched / total).round();
  }

  String textOf(ReciteError e) => joinWords(words.sublist(e.from, e.to).map((w) => w.text));
}
