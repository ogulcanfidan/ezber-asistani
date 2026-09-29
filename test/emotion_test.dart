import 'package:ezber_asistani/core/emotion.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:flutter_test/flutter_test.dart';

class _VoiceSpy implements Speaker {
  final voices = <String, VoiceSettings>{};

  @override
  Future<void> speak(String text, {required String language, required VoiceSettings voice}) async =>
      voices[text] = voice;

  @override
  Future<void> stop() async {}
}

void main() {
  test('yönergeden duygu, çok dilli ve kelime başında', () {
    expect(emotionFromDirection('öfkeyle'), Emotion.angry);
    expect(emotionFromDirection('ağlayarak'), Emotion.sad);
    expect(emotionFromDirection('Kapıya gidip fısıldar'), Emotion.whisper);
    expect(emotionFromDirection('laughing'), Emotion.happy);
    expect(emotionFromDirection('wütend'), Emotion.angry);
    expect(emotionFromDirection('sadece pencereye bakar'), Emotion.neutral, reason: '"sad" kelime başı değil');
    expect(emotionFromDirection('girer'), Emotion.neutral);
  });

  test('ayrıştırıcı "AD (öfkeyle):" ve önceki yönergeden tonu alır', () {
    final p = const ScriptParser().parse(
      text: 'AHMET (öfkeyle): Çık dışarı!\nZEYNEP: Gitmiyorum.\n(ağlayarak)\nAHMET: Lütfen.',
      title: 't',
      kind: PieceKind.play,
      language: 'tr-TR',
    );
    final dialogue = p.lines.where((l) => l.kind == LineKind.dialogue).toList();
    expect(dialogue.map((l) => l.emotion), [Emotion.angry, Emotion.neutral, Emotion.sad]);
    // Kaydedilip geri yüklenince korunur.
    expect(Piece.fromJson(p.toJson()).lines.firstWhere((l) => l.text == 'Lütfen.').emotion, Emotion.sad);
  });

  test('ton karakterin sesine uygulanır: üzgün yavaş ve alçak, fısıltı kısık', () async {
    final p = const ScriptParser().parse(
      text: 'ALİ (ağlayarak): Neden?\nVELİ (fısıldar): Sus.\nALİ: Tamam.',
      title: 't',
      kind: PieceKind.play,
      language: 'tr-TR',
    );
    final spy = _VoiceSpy();
    await RehearsalController(
      piece: p,
      speaker: spy,
      settings: const RehearsalSettings(mode: RehearsalMode.listen),
      wait: (_) async {},
    ).play(from: 0);
    final base = const VoiceSettings();
    expect(spy.voices['Neden?']!.rate, lessThan(base.rate));
    expect(spy.voices['Neden?']!.pitch, lessThan(base.pitch));
    expect(spy.voices['Sus.']!.volume, lessThan(0.5));
    expect(spy.voices['Tamam.']!.rate, base.rate);
    expect(spy.voices['Tamam.']!.volume, 1.0);
  });
}
