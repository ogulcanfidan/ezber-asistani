import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/recite.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:flutter_test/flutter_test.dart';

ReciteChecker checker(String text) => ReciteChecker.forPiece(
      const ScriptParser().parse(text: text, title: 't', kind: PieceKind.poem, language: 'tr-TR'),
    );

const poem = 'Korkma sönmez bu şafaklarda yüzen al sancak\n'
    'Sönmeden yurdumun üstünde tüten en son ocak';

void main() {
  test('doğru okunan parçalar ilerletir, sonda %100', () {
    final c = checker(poem);
    expect(c.feed('Korkma, sönmez bu şafaklarda yüzen').stop, isNull);
    expect(c.pos, 5);
    expect(c.feed('al sancak sönmeden yurdumun üstünde tüten en son ocak').stop, isNull);
    expect(c.done, isTrue);
    expect(c.accuracy, 100);
  });

  test('tanıyıcı hataları (aksan, bir harf) hata sayılmaz', () {
    final c = checker(poem);
    expect(c.feed('korkma sonmez bu safaklarda yuzen al sancak').stop, isNull);
    expect(c.pos, 7);
  });

  test('önemli bir kısım atlanınca durur, kullanıcı atlanan yerden devam eder', () {
    final c = checker(poem);
    final step = c.feed('Korkma sönmez bu al sancak');
    expect(step.stop?.kind, ReciteErrorKind.skipped);
    expect(c.textOf(step.stop!), 'şafaklarda yüzen');
    expect(c.pos, 3, reason: 'devam "şafaklarda"dan');
    expect(c.feed('şafaklarda yüzen al sancak').stop, isNull);
    expect(c.pos, 7);
  });

  test('yanlış söylenen kelime: ne dendiği raporlanır', () {
    final c = checker(poem);
    final step = c.feed('Korkma sönmez bu karanlıklarda yüzen al sancak');
    expect(step.stop?.kind, ReciteErrorKind.wrong);
    expect(c.textOf(step.stop!), 'şafaklarda');
    expect(step.stop!.heard, 'karanlıklarda');
    expect(c.pos, 3);
  });

  test('tek kısa kelime atlanırsa durmaz ama raporda görünür', () {
    final c = checker(poem);
    final step = c.feed('Korkma sönmez şafaklarda yüzen al sancak');
    expect(step.stop, isNull);
    expect(c.errors.single.minor, isTrue);
    expect(c.textOf(c.errors.single), 'bu');
    expect(c.accuracy, lessThan(100));
  });

  test('kısa anlamsız parça yok sayılır, uzun alakasız konuşma hata', () {
    final c = checker(poem);
    expect(c.feed('ıı').stop, isNull);
    expect(c.pos, 0);
    expect(c.feed('bugün hava çok güzel değil mi').stop?.kind, ReciteErrorKind.wrong);
  });

  test('bağlam yalnızca söylenmiş kelimelerden', () {
    final c = checker(poem);
    c.feed('Korkma sönmez bu');
    expect(c.contextPrompt(), 'Korkma sönmez bu');
  });
}
