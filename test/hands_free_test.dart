import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:ezber_asistani/app_state.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/rehearsal.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/core/voice_activity.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'core_test.dart' show FakeSpeaker;

const frame = Duration(milliseconds: 100);

/// Ses seviyesi dizisini (dB, her biri 100 ms) algılayıcıya verir.
ListenOutcome? run(VoiceActivityDetector d, List<double> levels) {
  for (final db in levels) {
    final r = d.add(db, frame);
    if (r != null) return r;
  }
  return null;
}

List<double> repeat(double db, int ms) => List.filled(ms ~/ 100, db);

VoiceActivityDetector detector() => VoiceActivityDetector(
      promptAfter: const Duration(seconds: 5),
      endSilence: const Duration(milliseconds: 1200),
    );

void main() {
  group('VoiceActivityDetector', () {
    test('konuşup susunca "söyledi"', () {
      final r = run(detector(), [
        ...repeat(-60, 300), // ortam
        ...repeat(-30, 1500), // konuşma
        ...repeat(-60, 1300), // sessizlik
      ]);
      expect(r, ListenOutcome.spoke);
    });

    test('cümle içindeki kısa duraklama repliği bitirmez', () {
      final d = detector();
      final r = run(d, [
        ...repeat(-60, 300),
        ...repeat(-30, 800),
        ...repeat(-60, 600), // nefes
        ...repeat(-30, 800),
      ]);
      expect(r, isNull);
      expect(d.speechStarted, isTrue);
    });

    test('hiç konuşmazsa süre sonunda "sessiz" (takıldı)', () {
      expect(run(detector(), repeat(-60, 6000)), ListenOutcome.silent);
    });

    test('tek bir tık/öksürük konuşma sayılmaz', () {
      final r = run(detector(), [...repeat(-60, 300), -20, ...repeat(-60, 4900)]);
      expect(r, ListenOutcome.silent);
    });

    test('gürültülü ortamda eşik ortama göre yükselir', () {
      final d = detector();
      final r = run(d, [...repeat(-35, 300), ...repeat(-33, 2000), ...repeat(-35, 3000)]);
      expect(d.threshold, closeTo(-23, 0.01));
      expect(r, ListenOutcome.silent, reason: 'ortam uğultusu konuşma sanılmamalı');
    });

    test('hemen konuşmaya başlasa da kalibrasyon bozulmaz', () {
      // Kalibrasyonun 300 ms'nin 200'ü konuşma: en sessiz dilime bakılır.
      final r = run(detector(), [-60, -30, -30, ...repeat(-30, 1000), ...repeat(-60, 1300)]);
      expect(r, ListenOutcome.spoke);
    });

    test('16 bit PCM seviyesi', () {
      final d = VoiceActivityDetector(promptAfter: const Duration(seconds: 5), endSilence: const Duration(seconds: 1));
      // Genliği 0.1 olan sinüs: RMS ≈ 0.0707 → ≈ -23 dBFS.
      final bytes = ByteData(3200);
      for (var i = 0; i < 1600; i++) {
        bytes.setInt16(i * 2, (sin(i / 5) * 0.1 * 32767).round(), Endian.little);
      }
      for (var k = 0; k < 3; k++) {
        d.addPcm16(Uint8List.view(Uint8List(3200).buffer), 16000); // sessizlik: kalibrasyon
      }
      expect(d.threshold, isNotNull);
      d.addPcm16(bytes.buffer.asUint8List(), 16000);
      d.addPcm16(bytes.buffer.asUint8List(), 16000);
      d.addPcm16(bytes.buffer.asUint8List(), 16000);
      expect(d.speechStarted, isTrue);
    });
  });

  group('RehearsalController — eller serbest', () {
    late Piece p;
    late FakeSpeaker speaker;
    late FakeListener mic;

    setUp(() {
      p = const ScriptParser().parse(
          text: 'ALİ: Merhaba.\nVELİ: Selam.\nALİ: Nasılsın?', title: 't', kind: PieceKind.play, language: 'tr-TR');
      p.myCharacterIds.add(p.characters[1].id);
      speaker = FakeSpeaker();
      mic = FakeListener();
    });

    RehearsalController ctrl() => RehearsalController(
          piece: p,
          speaker: speaker,
          listener: mic,
          settings: const RehearsalSettings(mode: RehearsalMode.handsFree, endSilenceSeconds: 2),
          wait: (_) async {},
        );

    test('söyleyince benim repliğim okunmadan devam eder', () async {
      mic.next = ListenOutcome.spoke;
      await ctrl().play(from: 0);
      expect(speaker.said, ['Merhaba.', 'Nasılsın?']);
      expect(mic.lastEndSilence, const Duration(seconds: 2));
      expect(mic.lastPromptAfter, greaterThan(const Duration(seconds: 3)));
    });

    test('takılınca repliğim gösterilir ve okunur', () async {
      mic.next = ListenOutcome.silent;
      await ctrl().play(from: 0);
      expect(speaker.said, ['Merhaba.', 'Selam.', 'Nasılsın?']);
    });

    test('dinlerken Devam: söyledi sayılır', () async {
      mic.manual = true;
      final c = ctrl();
      final done = c.play(from: 0);
      await pumpEventQueue();
      expect(c.listening, isTrue);
      c.userContinue();
      await done;
      expect(speaker.said, ['Merhaba.', 'Nasılsın?']);
      expect(c.listening, isFalse);
    });

    test('dinlerken duraklat: mikrofon kapanır, prova durur', () async {
      mic.manual = true;
      final c = ctrl();
      final done = c.play(from: 0);
      await pumpEventQueue();
      await c.pause();
      await done;
      expect(c.status, RehearsalStatus.idle);
      expect(c.listening, isFalse);
      expect(speaker.said, ['Merhaba.']);
    });
  });

  test('prova ayarları JSON (kalıcı), bilinmeyen değer varsayılana düşer', () {
    const s = RehearsalSettings(mode: RehearsalMode.handsFree, endSilenceSeconds: 2.4, readDirections: true);
    final back = RehearsalSettings.fromJson(s.toJson());
    expect(back.mode, RehearsalMode.handsFree);
    expect(back.endSilenceSeconds, 2.4);
    expect(back.readDirections, isTrue);
    expect(RehearsalSettings.fromJson({'mode': 'yok'}).mode, RehearsalMode.waitForMe);
  });

  test('karakterlere farklı sesler dağıtılır, seçilmiş ses korunur', () {
    final p = const ScriptParser()
        .parse(text: 'A: 1\nB: 2\nC: 3', title: 't', kind: PieceKind.play, language: 'tr-TR');
    p.characters[1].voice = const VoiceSettings(voiceName: 'v1');
    expect(p.assignDistinctVoices(['v1', 'v2', 'v3']), isTrue);
    expect(p.characters.map((c) => c.voice.voiceName), ['v2', 'v1', 'v3']);
    expect(p.assignDistinctVoices(['v1', 'v2', 'v3']), isFalse, reason: 'ikinci kez değiştirmez');
    final q = const ScriptParser()
        .parse(text: 'A: 1\nB: 2\nC: 3', title: 't', kind: PieceKind.play, language: 'tr-TR');
    q.assignDistinctVoices(['v1', 'v2']);
    expect(q.characters.map((c) => c.voice.voiceName), ['v1', 'v2', 'v1'], reason: 'ses azsa döner');
    // Telefon değişti: kayıtlı ses bu cihazda yok → yeniden atanır, olan korunur.
    expect(q.assignDistinctVoices(['v2', 'yeni']), isTrue);
    expect(q.characters.map((c) => c.voice.voiceName), ['yeni', 'v2', 'yeni']);
  });

  test('metin yönü metnin dilinden gelir', () {
    expect(textDirectionFor('ar-SA'), TextDirection.rtl);
    expect(textDirectionFor('tr-TR'), TextDirection.ltr);
  });
}

class FakeListener implements LineListener {
  ListenOutcome next = ListenOutcome.spoke;

  /// Sırayla döndürülecek sonuçlar (boşsa [next]).
  final queue = <ListenResult>[];
  bool manual = false;
  int calls = 0;
  Duration? lastPromptAfter;
  Duration? lastEndSilence;
  String? lastLanguage;
  Completer<ListenResult>? _pending;

  @override
  Future<bool> ensurePermission() async => true;

  @override
  Future<ListenResult> listen({
    required String language,
    required Duration promptAfter,
    required Duration endSilence,
  }) {
    calls++;
    lastLanguage = language;
    lastPromptAfter = promptAfter;
    lastEndSilence = endSilence;
    if (queue.isNotEmpty) return Future.value(queue.removeAt(0));
    if (!manual) return Future.value(ListenResult(next));
    return (_pending = Completer()).future;
  }

  @override
  void finish(ListenOutcome outcome) {
    final p = _pending;
    if (p != null && !p.isCompleted) p.complete(ListenResult(outcome));
  }
}
