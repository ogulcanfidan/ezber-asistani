import 'models.dart';

/// Replik duygusu. Android ses motorları gerçek duygu stili sunmuyor; burada
/// duygu hız, ton ve ses yüksekliğiyle yaklaşık verilir (dürüst olmak için
/// arayüzde "ton" olarak anlatılır, "gerçek oyuncu sesi" vaat edilmez).
enum Emotion { neutral, happy, sad, angry, excited, calm, whisper, afraid }

/// (hız çarpanı, ton çarpanı, ses yüksekliği 0–1)
const _shape = <Emotion, (double, double, double)>{
  Emotion.neutral: (1.0, 1.0, 1.0),
  Emotion.happy: (1.08, 1.12, 1.0),
  Emotion.sad: (0.82, 0.88, 0.8),
  Emotion.angry: (1.12, 0.94, 1.0),
  Emotion.excited: (1.18, 1.2, 1.0),
  Emotion.calm: (0.9, 0.97, 0.85),
  Emotion.whisper: (0.85, 0.92, 0.4),
  Emotion.afraid: (1.12, 1.1, 0.75),
};

extension EmotionVoice on VoiceSettings {
  /// Karakterin kendi sesine duygu biçimi uygulanır.
  VoiceSettings withEmotion(Emotion e) {
    if (e == Emotion.neutral) return this;
    final (r, p, v) = _shape[e]!;
    return VoiceSettings(
      voiceName: voiceName,
      rate: (rate * r).clamp(0.1, 1.0),
      pitch: (pitch * p).clamp(0.5, 2.0),
      volume: v,
    );
  }
}

/// Yönergeden duygu: "(öfkeyle)", "(ağlayarak)", "(whispering)"… Birden
/// fazla dil; bilinmeyen yönerge nötr kalır.
Emotion emotionFromDirection(String direction) {
  final t = direction.replaceAll('İ', 'i').toLowerCase();
  // Kelime başında eşleşme: "sadece" üzgün (sad) sayılmasın.
  final words = t.split(RegExp(r'[^\p{L}]+', unicode: true));
  for (final e in _keywords.entries) {
    for (final k in e.value) {
      final hit = k.contains(' ')
          ? t.contains(k)
          : _exact.contains(k)
              ? words.contains(k)
              : words.any((w) => w.startsWith(k));
      if (hit) return e.key;
    }
  }
  return Emotion.neutral;
}

/// Kısa kökler başka dillerde kelime başı olur ("sad" → "sadece"): tam eşleşme.
const _exact = {'sad', 'sob', 'joy'};

const _keywords = <Emotion, List<String>>{
  // Fısıltı önce: "öfkeyle fısıldar" fısıltıdır.
  Emotion.whisper: ['fısılda', 'fisilda', 'alçak sesle', 'whisper', 'flüster', 'murmur', 'chuchot', 'susurr', 'sussurr',
    'шёпот', 'шепот', 'шепч', 'berbisik', 'همس'],
  Emotion.angry: ['öfke', 'kızgın', 'sinir', 'bağır', 'hiddet', 'angr', 'furious', 'shout', 'yell', 'wütend',
    'zornig', 'schrei', 'colère', 'furieux', 'furieuse', 'crie', 'enfadad', 'furios', 'grita', 'raiva', 'bravo',
    'arrabbiat', 'urla', 'сердит', 'злобн', 'крич', 'marah', 'berteriak', 'غاضب', 'يصرخ'],
  Emotion.sad: ['üzgün', 'üzül', 'ağla', 'hüzün', 'kederl', 'sad', 'sadly', 'crying', 'tearful', 'weep', 'sob', 'traurig',
    'weinend', 'triste', 'pleur', 'llorando', 'chorando', 'piangend', 'грустн', 'плач', 'sedih', 'menangis', 'حزين', 'يبكي'],
  Emotion.excited: ['heyecan', 'coşku', 'excited', 'eager', 'aufgeregt', 'begeistert', 'excité', 'emocionad',
    'entusiasm', 'eccitat', 'взволнован', 'восторж', 'bersemangat', 'متحمس'],
  Emotion.happy: ['sevinç', 'neşe', 'mutlu', 'gülerek', 'gülümse', 'happ', 'joy', 'laugh', 'smil', 'fröhlich',
    'lachend', 'glücklich', 'joyeu', 'riant', 'alegre', 'feliz', 'riendo', 'rindo', 'felice', 'ridendo', 'радостн',
    'смеясь', 'весел', 'gembira', 'tertawa', 'senang', 'سعيد', 'يضحك'],
  Emotion.afraid: ['kork', 'ürker', 'titre', 'afraid', 'scared', 'fear', 'terrified', 'ängstlich', 'angst', 'effray',
    'peur', 'asustad', 'miedo', 'assustad', 'spaventat', 'испуган', 'страх', 'takut', 'خائف'],
  Emotion.calm: ['sakin', 'yavaşça', 'yumuşak', 'calm', 'gently', 'softly', 'quietly', 'ruhig', 'sanft', 'calme',
    'doucement', 'tranquil', 'suavemente', 'спокойн', 'тихо', 'tenang', 'pelan', 'بهدوء'],
};
