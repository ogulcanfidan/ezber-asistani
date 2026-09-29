import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../core/models.dart';
import '../core/rehearsal.dart';

class DeviceVoice {
  const DeviceVoice(this.name, this.locale);
  final String name;
  final String locale;
}

/// Cihazın metin okuma motoru (Android TextToSpeech).
///
/// Rakip uygulamada bir Google güncellemesi seslerin yarısını bozmuş ve prova
/// sessizce takılmıştı. Burada seçili ses ayarlanamazsa dilin varsayılan sesine
/// düşülür ve her okuma bir zaman aşımıyla korunur.
class TtsSpeaker implements Speaker {
  final FlutterTts _tts = FlutterTts();
  Future<void>? _init;

  Future<void> _ensureInit() => _init ??= () async {
        await _tts.awaitSpeakCompletion(true);
      }();

  final _localVoices = <String, Future<List<DeviceVoice>>>{};

  @override
  Future<void> speak(String text, {required String language, required VoiceSettings voice}) async {
    await _ensureInit();
    await _tts.setLanguage(language);
    // Google'ın dil varsayılanı ("tr-TR-language") bir sunucu sesine
    // bağlı: internet varken metin sunucuya gidebilir. Ses seçilmemişse
    // ilk yerel ses kullanılır, böylece metin telefondan çıkmaz.
    final local = await (_localVoices[language] ??= voicesFor(language));
    final name = voice.voiceName ?? (local.isNotEmpty ? local.first.name : null);
    if (name != null) {
      try {
        await _tts.setVoice({'name': name, 'locale': language});
      } catch (e) {
        debugPrint('Ses ayarlanamadı ($name), varsayılan kullanılacak: $e');
        await _tts.setLanguage(language);
      }
    }
    await _tts.setPitch(voice.pitch);
    await _tts.setSpeechRate(voice.rate);
    await _tts.setVolume(voice.volume);

    // Ses motoru hata verip tamamlanma bildirmezse prova takılmasın.
    final limit = Duration(seconds: 10 + text.length ~/ 5);
    await _tts.speak(text).timeout(limit, onTimeout: () => _tts.stop());
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }

  /// Bu dil için cihazda yüklü, internet gerektirmeyen sesler.
  Future<List<DeviceVoice>> voicesFor(String language) async {
    await _ensureInit();
    final lang = language.split(RegExp('[-_]')).first.toLowerCase();
    final raw = await _tts.getVoices;
    if (raw is! List) return const [];
    final result = <DeviceVoice>[];
    for (final v in raw) {
      if (v is! Map) continue;
      final name = v['name']?.toString();
      final locale = v['locale']?.toString() ?? '';
      if (name == null) continue;
      if (locale.split(RegExp('[-_]')).first.toLowerCase() != lang) continue;
      final network = v['network_required']?.toString();
      if (network == '1' || network == 'true') continue;
      // Gizlilik metnimiz "sesler cihazda üretilir" diyor: ağ gerektiren
      // sesler ve sunucu sesine bağlanan "-language" takma adı dışarıda.
      if (name.contains('network') || name.contains('server') || name.endsWith('-language')) continue;
      result.add(DeviceVoice(name, locale));
    }
    // Google motorunda gerçekten yerel olanlar "-local" ile biter; varsa
    // yalnızca onlar. Başka motorlarda (Samsung vb.) adlandırma farklı.
    final explicit = result.where((v) => v.name.endsWith('-local')).toList();
    var voices = explicit.isNotEmpty ? explicit : result;
    // "English (US)" seçildiyse yalnızca ABD sesleri: aksi halde İngilizce
    // için İngiltere/Avustralya/Hindistan… 16+ ses listelenip seçim zorlaşıyordu.
    // Bu bölgede ses yoksa dilin tüm sesleri kalır.
    String norm(String s) => s.replaceAll('_', '-').toLowerCase();
    final region = voices.where((v) => norm(v.locale) == norm(language)).toList();
    if (region.isNotEmpty) voices = region;
    voices.sort((a, b) => a.name.compareTo(b.name));
    return voices;
  }
}
