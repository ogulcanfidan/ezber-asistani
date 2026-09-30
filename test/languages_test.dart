import 'package:ezber_asistani/app_state.dart';
import 'package:ezber_asistani/core/emotion.dart';
import 'package:ezber_asistani/core/hints.dart';
import 'package:ezber_asistani/core/line_check.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/recite.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/core/speech_pages.dart';
import 'package:ezber_asistani/core/words.dart';
import 'package:ezber_asistani/data/doc_import.dart';
import 'package:ezber_asistani/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

Piece _parse(String text, PieceKind kind, String language) =>
    const ScriptParser().parse(text: text, title: 't', kind: kind, language: language);

void main() {
  test('14 dilin hepsinde çeviri ve seslendirme dili var', () {
    expect(supportedLanguages.length, 14);
    for (final code in supportedLanguages.keys) {
      final l = lookupL(Locale(code));
      expect(l.library, isNotEmpty, reason: code);
      expect(l.pageCue(2), contains('2'), reason: code);
      expect(defaultVoiceLanguageFor(Locale(code)), startsWith('$code-'), reason: code);
    }
  });

  test('Çince ve Japoncada her karakter bir kelime, Korece ve Hintçede boşluk ayırır', () {
    expect(splitWords('床前明月光，疑是地上霜。'), hasLength(10));
    expect(splitWords('こんにちは、世界'), hasLength(7));
    expect(splitWords('안녕하세요 여러분'), ['안녕하세요', '여러분']);
    expect(splitWords('नमस्ते दुनिया'), ['नमस्ते', 'दुनिया']);
    expect(splitWords("don't stop"), ["don't", 'stop']);
    expect(joinWords(['明', '月', 'moon', 'light']), '明月 moon light');
    // İki karakter yaklaşık bir kelime kadar sürer.
    expect(wordCount('床前明月光'), 3);
    expect(wordCount('bir iki üç'), 3);
  });

  test('Çince satırda ipuçları: öbeğin ilk karakteri kalır', () {
    const line = '床前明月光，疑是地上霜。';
    expect(applyHint(line, HintLevel.firstLetters), '床____，疑____。');
    expect(applyHint(line, HintLevel.keywords), '床…，疑…。');
    expect(applyHint(line, HintLevel.hidden, revealWords: 2), '床前 …');
    expect(firstWords(line, promptWordCount(line)), '床前明月');
  });

  test('söylenen metin karakter karakter karşılaştırılır', () {
    final c = checkLine('床前明月光', '床前明光');
    expect(c.missed, ['月']);
    expect(checkLine('学校へ行きます', '学校へ行きます').score, 100);
    // Hintçede ünlü işaretleri anlam taşır: atılmaz.
    expect(wordsMatch('की', 'का'), isFalse);
    expect(wordsMatch('नमस्ते', 'नमस्ते'), isTrue);
  });

  test('ezberden okuma Çince metinde atlanan yeri bulur', () {
    final p = _parse('床前明月光\n疑是地上霜\n举头望明月', PieceKind.poem, 'zh-CN');
    final checker = ReciteChecker.forPiece(p);
    expect(checker.words, hasLength(15));
    final step = checker.feed('床前明月光举头望明月');
    expect(step.stop, isNotNull);
    expect(checker.textOf(step.stop!), '疑是地上霜');
    expect(checker.contextPrompt(), '床前明月光');
  });

  test('tam genişlikte iki nokta ve parantezle yazılmış oyun', () {
    final p = _parse(
      '第一幕\n小明：你好。\n小红（生气地）：走开！\n（小明下）\n小红：终于走了。',
      PieceKind.play,
      'zh-CN',
    );
    expect(p.characters.map((c) => c.name), ['小明', '小红']);
    expect(p.lines.first.kind, LineKind.heading);
    final angry = p.lines.firstWhere((l) => l.text == '走开！');
    expect(angry.emotion, Emotion.angry);
    expect(p.lines.where((l) => l.kind == LineKind.direction).map((l) => l.text), ['生气地', '小明下']);
  });

  test('Korece ve Hintçe sahne başlıkları ve yönerge duyguları', () {
    final ko = _parse('제1막\n민수: 안녕.\n지영 (울면서): 가지 마.', PieceKind.play, 'ko-KR');
    expect(ko.lines.first.kind, LineKind.heading);
    expect(ko.lines.last.emotion, Emotion.sad);
    final hi = _parse('दृश्य 1\nराम: नमस्ते।\nसीता (गुस्से से): जाओ!', PieceKind.play, 'hi-IN');
    expect(hi.lines.first.kind, LineKind.heading);
    expect(hi.lines.last.emotion, Emotion.angry);
    expect(emotionFromDirection('小声'), Emotion.whisper);
    expect(emotionFromDirection('泣きながら'), Emotion.sad);
  });

  test('sunumda sayfa işaretleri: スライド, 第2页, 슬라이드', () {
    for (final text in [
      'スライド1\nこんにちは。\nスライド2\nありがとうございました。',
      '第1页\n大家好。\n第2页\n谢谢大家。',
      '슬라이드 1\n안녕하세요.\n슬라이드 2\n감사합니다.',
      'स्लाइड 1\nनमस्ते।\nस्लाइड 2\nधन्यवाद।',
    ]) {
      final p = _parse(text, PieceKind.speech, 'ja-JP');
      expect(speechPages(p), hasLength(2), reason: text);
    }
  });

  test('fotoğraftan okuma yalnızca Latin alfabesinde', () {
    for (final lang in ['hi-IN', 'zh-CN', 'ja-JP', 'ko-KR']) {
      expect(imageOcrSupports(lang), isFalse, reason: lang);
    }
    expect(imageOcrSupports('de-DE'), isTrue);
  });
}
