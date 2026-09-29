import 'package:ezber_asistani/core/voice_activity.dart';
import 'package:ezber_asistani/data/mic_listener.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'hands_free_test.dart' show FakeListener;

/// Telefonda görülen davranışları taklit eden sahte tanıyıcı kanalı.
void mockStt(List<Map<String, Object?>> replies) {
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(const MethodChannel('ezber/stt'), (call) async {
    if (call.method == 'listen') return replies.removeAt(0);
    return null;
  });
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const promptAfter = Duration(seconds: 5);
  const endSilence = Duration(milliseconds: 800);

  test('tanıma çalışırsa metinler döner', () async {
    mockStt([
      {'texts': ['dışarı hemen dönerim'], 'heard': true},
    ]);
    final l = CheckingLineListener(fallback: FakeListener());
    final r = await l.listen(language: 'tr-TR', promptAfter: promptAfter, endSilence: endSilence);
    expect(r.outcome, ListenOutcome.spoke);
    expect(r.transcripts, ['dışarı hemen dönerim']);
  });

  test('Honor hatası: konuşma başlar başlamaz "anlaşılamadı" → replik atlanmaz, ses seviyesiyle sürer', () async {
    mockStt([
      {'error': 'nomatch', 'heard': true},
      {'error': 'nomatch', 'heard': true},
    ]);
    final vad = FakeListener()..next = ListenOutcome.spoke;
    final failed = <String>[];
    final l = CheckingLineListener(fallback: vad, onLanguageFailed: failed.add);

    final r1 = await l.listen(language: 'tr-TR', promptAfter: promptAfter, endSilence: endSilence);
    expect(vad.calls, 1, reason: 'kullanıcı konuşmaya devam ediyor: bitişi ses seviyesi bekler');
    expect(r1.outcome, ListenOutcome.spoke);
    expect(r1.transcripts, isEmpty, reason: 'puanlanmaz, "anlaşılamadı"');
    expect(failed, isEmpty, reason: 'tek sefer yetmez');

    await l.listen(language: 'tr-TR', promptAfter: promptAfter, endSilence: endSilence);
    expect(failed, ['tr-TR'], reason: 'hiç tanıyamadan iki kez: bu dilde çalışmıyor');

    // Artık tanıyıcı hiç denenmez (mock'ta yanıt kalmadı; denense hata verirdi).
    final r3 = await l.listen(language: 'tr-TR', promptAfter: promptAfter, endSilence: endSilence);
    expect(r3.outcome, ListenOutcome.spoke);
    expect(vad.calls, 3);
  });

  test('tanıyıcı erken "sessiz" derse suflör hemen değil, kalan süre ses seviyesiyle dinlenir', () async {
    mockStt([
      {'error': 'silent', 'heard': false},
    ]);
    final vad = FakeListener()..next = ListenOutcome.spoke;
    final l = CheckingLineListener(fallback: vad);
    final r = await l.listen(language: 'tr-TR', promptAfter: promptAfter, endSilence: endSilence);
    expect(vad.calls, 1);
    expect(vad.lastPromptAfter, lessThan(promptAfter));
    expect(r.outcome, ListenOutcome.spoke);
  });

  test('ses duymadan boş sonuç: dil başarısız sayılır, ses seviyesine geçilir', () async {
    mockStt([
      {'error': 'empty', 'heard': false},
    ]);
    final vad = FakeListener();
    final failed = <String>[];
    final l = CheckingLineListener(fallback: vad, onLanguageFailed: failed.add);
    await l.listen(language: 'tr-TR', promptAfter: promptAfter, endSilence: endSilence);
    expect(failed, ['tr-TR']);
    expect(vad.calls, 1);
  });

  test('önceden başarısız diller hiç denenmez (kalıcı kayıt)', () async {
    mockStt([]);
    final vad = FakeListener();
    final l = CheckingLineListener(fallback: vad, failedLanguages: {'tr-TR'});
    await l.listen(language: 'tr-TR', promptAfter: promptAfter, endSilence: endSilence);
    expect(vad.calls, 1);
  });
}
