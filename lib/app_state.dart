import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/rehearsal.dart';
import 'data/line_recordings.dart';
import 'data/mic_listener.dart';
import 'data/piece_repository.dart';
import 'data/pro.dart';
import 'data/tts_speaker.dart';

/// Metnin yazım yönü arayüz dilinden değil metnin kendi dilinden gelir:
/// Arapça arayüzde Türkçe metin soldan sağa, Türkçe arayüzde Arapça metin
/// sağdan sola yazılmalı.
TextDirection textDirectionFor(String language) =>
    const {'ar', 'he', 'fa', 'ur'}.contains(language.split(RegExp('[-_]')).first.toLowerCase())
        ? TextDirection.rtl
        : TextDirection.ltr;

/// Uygulamanın desteklediği diller ve seslendirme için varsayılan bölgeleri.
const supportedLanguages = <String, String>{
  'tr': 'Türkçe',
  'en': 'English',
  'de': 'Deutsch',
  'fr': 'Français',
  'es': 'Español',
  'pt': 'Português (Brasil)',
  'ru': 'Русский',
  'it': 'Italiano',
  'ar': 'العربية',
  'id': 'Bahasa Indonesia',
  'hi': 'हिन्दी',
  'zh': '简体中文',
  'ja': '日本語',
  'ko': '한국어',
};

/// Metinlerin seslendirme dilleri (BCP-47).
const voiceLanguages = <String, String>{
  'tr-TR': 'Türkçe',
  'en-US': 'English (US)',
  'en-GB': 'English (UK)',
  'de-DE': 'Deutsch',
  'fr-FR': 'Français',
  'es-ES': 'Español (España)',
  'es-MX': 'Español (México)',
  'pt-BR': 'Português (Brasil)',
  'pt-PT': 'Português (Portugal)',
  'ru-RU': 'Русский',
  'it-IT': 'Italiano',
  'ar-SA': 'العربية',
  'id-ID': 'Bahasa Indonesia',
  'hi-IN': 'हिन्दी',
  'zh-CN': '中文（普通话）',
  'ja-JP': '日本語',
  'ko-KR': '한국어',
};

String defaultVoiceLanguageFor(Locale locale) {
  final code = locale.languageCode;
  final match = voiceLanguages.keys.where((k) => k.startsWith('$code-'));
  if (locale.languageCode == 'pt') return 'pt-BR';
  return match.isNotEmpty ? match.first : 'en-US';
}

class AppState {
  AppState._(this._prefs, PieceRepository? repository, this.pro)
      : repository = repository ?? PieceRepository(),
        locale = ValueNotifier(_readLocale(_prefs));

  /// [pro] verilmezse Google Play aboneliği kullanılır (testler sahte verir).
  static Future<AppState> load({PieceRepository? repository, ProStore? pro}) async {
    final prefs = await SharedPreferences.getInstance();
    if (pro == null && proUnlocked) pro = UnlockedProStore();
    if (pro == null) {
      final play = PlayProStore(prefs);
      // Açılışı bekletmesin: son bilinen durumla başlar, Play yanıtlayınca güncellenir.
      unawaited(play.init());
      pro = play;
    }
    return AppState._(prefs, repository, pro);
  }

  final SharedPreferences _prefs;
  final PieceRepository repository;

  /// Aylık abonelik: eller serbest prova ve sınırsız metin.
  final ProStore pro;
  final speaker = TtsSpeaker();
  late final listener = MicLineListener();

  /// Kullanıcının kendi sesiyle kaydettiği replikler.
  late final recordings = LineRecordings(repository);
  late final speech = OnDeviceSpeech();

  /// Cihaz üzerinde tanımanın çalışmadığı anlaşılan diller (kalıcı): doğruluk
  /// anahtarı bu dillerde bir daha yanıltıcı şekilde etkin görünmez.
  late final ValueNotifier<Set<String>> sttFailedLanguages =
      ValueNotifier((_prefs.getStringList('sttFailed') ?? const <String>[]).toSet());

  /// Doğruluk kontrolü: cihaz üzerinde tanıma, yoksa ses seviyesi.
  late final checkingListener = CheckingLineListener(
    fallback: listener,
    speech: speech,
    failedLanguages: sttFailedLanguages.value,
    onLanguageFailed: (language) {
      sttFailedLanguages.value = {...sttFailedLanguages.value, language};
      _prefs.setStringList('sttFailed', sttFailedLanguages.value.toList());
    },
  );

  /// Son kullanılan prova ayarları (mod, ipucu, süreler) hatırlanır.
  RehearsalSettings get rehearsalSettings {
    final raw = _prefs.getString('rehearsal');
    if (raw == null) return const RehearsalSettings();
    try {
      return RehearsalSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      return const RehearsalSettings();
    }
  }

  Future<void> saveRehearsalSettings(RehearsalSettings s) =>
      _prefs.setString('rehearsal', jsonEncode(s.toJson()));

  /// null: sistem dili.
  final ValueNotifier<Locale?> locale;

  static Locale? _readLocale(SharedPreferences p) {
    final code = p.getString('locale');
    return code == null ? null : Locale(code);
  }

  Future<void> setLocale(Locale? value) async {
    locale.value = value;
    if (value == null) {
      await _prefs.remove('locale');
    } else {
      await _prefs.setString('locale', value.languageCode);
    }
  }
}

/// Alt ağaçlara [AppState] erişimi.
class AppScope extends InheritedWidget {
  const AppScope({super.key, required this.state, required super.child});

  final AppState state;

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.state;

  @override
  bool updateShouldNotify(AppScope oldWidget) => state != oldWidget.state;
}
