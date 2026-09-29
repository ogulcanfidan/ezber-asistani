import 'dart:math';

import 'emotion.dart';

export 'emotion.dart' show Emotion;

/// Ezberlenecek metnin türü.
enum PieceKind { play, poem, speech }

enum LineKind {
  /// Bir karakterin repliği (şiir/konuşmada "ben").
  dialogue,

  /// Sahne yönergesi: (girer), [ışıklar söner] gibi.
  direction,

  /// Sahne/perde başlığı: prova içinde atlama noktası.
  heading,
}

String newId() {
  final r = Random.secure();
  return List.generate(12, (_) => r.nextInt(36).toRadixString(36)).join();
}

class VoiceSettings {
  const VoiceSettings({this.voiceName, this.pitch = 1.0, this.rate = 0.5, this.volume = 1.0});

  /// Cihazdaki ses motorunun ses adı; null ise dilin varsayılan sesi.
  final String? voiceName;
  final double pitch;
  final double rate;

  /// 0–1; yalnızca replik duygusu için (fısıltı, üzgün). Kaydedilmez.
  final double volume;

  VoiceSettings copyWith({String? voiceName, bool clearVoice = false, double? pitch, double? rate}) =>
      VoiceSettings(
        voiceName: clearVoice ? null : (voiceName ?? this.voiceName),
        pitch: pitch ?? this.pitch,
        rate: rate ?? this.rate,
        volume: volume,
      );

  Map<String, dynamic> toJson() => {
        if (voiceName != null) 'voiceName': voiceName,
        'pitch': pitch,
        'rate': rate,
      };

  factory VoiceSettings.fromJson(Map<String, dynamic> j) => VoiceSettings(
        voiceName: j['voiceName'] as String?,
        pitch: (j['pitch'] as num?)?.toDouble() ?? 1.0,
        rate: (j['rate'] as num?)?.toDouble() ?? 0.5,
      );
}

class Character {
  Character({String? id, required this.name, this.voice = const VoiceSettings()})
      : id = id ?? newId();

  final String id;
  String name;
  VoiceSettings voice;

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'voice': voice.toJson()};

  factory Character.fromJson(Map<String, dynamic> j) => Character(
        id: j['id'] as String,
        name: j['name'] as String,
        voice: VoiceSettings.fromJson((j['voice'] as Map).cast<String, dynamic>()),
      );
}

class Line {
  Line({
    String? id,
    required this.kind,
    this.characterId,
    required this.text,
    this.unsure = false,
    this.emotion = Emotion.neutral,
    this.recorded = false,
  }) : id = id ?? newId();

  final String id;
  LineKind kind;
  String? characterId;
  String text;

  /// Ayrıştırıcı bu satırın kime ait olduğundan emin değil: düzeltme
  /// ekranında işaretlenir, kullanıcı dokununca kalkar.
  bool unsure;

  /// Seslendirme tonu: yönergeden ("öfkeyle") otomatik ya da elle seçilir.
  Emotion emotion;

  /// Kullanıcı bu repliği kendi sesiyle kaydetti (dosya telefonda); provada
  /// yapay ses yerine kayıt çalınır. Dosya yoksa yapay sese düşülür.
  bool recorded;

  Map<String, dynamic> toJson() => {
        'id': id,
        'kind': kind.name,
        if (characterId != null) 'characterId': characterId,
        'text': text,
        if (unsure) 'unsure': true,
        if (emotion != Emotion.neutral) 'emo': emotion.name,
        if (recorded) 'rec': true,
      };

  factory Line.fromJson(Map<String, dynamic> j) => Line(
        id: j['id'] as String,
        kind: LineKind.values.byName(j['kind'] as String),
        characterId: j['characterId'] as String?,
        text: j['text'] as String,
        unsure: j['unsure'] == true,
        emotion: Emotion.values.where((e) => e.name == j['emo']).firstOrNull ?? Emotion.neutral,
        recorded: j['rec'] == true,
      );
}

/// Bir satırın çalışma geçmişi: "zorlandığım satırlar" için.
class LineStat {
  LineStat({this.attempts = 0, this.lastHelped = false, this.lastScore});

  int attempts;

  /// Son denemede suflör/düzeltme/ipucu gerekti mi.
  bool lastHelped;

  /// Son doğruluk puanı (kontrol açıksa).
  int? lastScore;

  bool get weak => lastHelped || (lastScore != null && lastScore! < 90);

  Map<String, dynamic> toJson() => {
        'a': attempts,
        if (lastHelped) 'h': true,
        if (lastScore != null) 's': lastScore,
      };

  factory LineStat.fromJson(Map<String, dynamic> j) => LineStat(
        attempts: (j['a'] as num?)?.toInt() ?? 0,
        lastHelped: j['h'] == true,
        lastScore: (j['s'] as num?)?.toInt(),
      );
}

class Piece {
  Piece({
    String? id,
    required this.title,
    required this.kind,
    required this.language,
    List<Character>? characters,
    List<Line>? lines,
    Set<String>? myCharacterIds,
    DateTime? updatedAt,
    this.targetSeconds,
    this.pageSeconds,
    Map<String, LineStat>? stats,
  })  : id = id ?? newId(),
        characters = characters ?? [],
        lines = lines ?? [],
        myCharacterIds = myCharacterIds ?? {},
        updatedAt = updatedAt ?? DateTime.now(),
        stats = stats ?? {};

  /// Sunum için hedef süre (saniye).
  int? targetSeconds;

  /// Sunumda sayfa başına süre (saniye); null ise otomatik paylaştırılır.
  List<int>? pageSeconds;

  /// Satır kimliği → çalışma geçmişi.
  final Map<String, LineStat> stats;

  void recordAttempt(String lineId, {required bool helped, int? score}) {
    final s = stats.putIfAbsent(lineId, LineStat.new);
    s.attempts++;
    s.lastHelped = helped;
    s.lastScore = score;
  }

  bool isWeak(Line line) => stats[line.id]?.weak ?? false;

  int get weakCount => lines.where((l) => isMine(l) && isWeak(l)).length;

  static const schemaVersion = 1;

  final String id;
  String title;
  PieceKind kind;

  /// Seslendirme dili, BCP-47 (ör. tr-TR, en-US).
  String language;
  final List<Character> characters;
  final List<Line> lines;

  /// Kullanıcının ezberlediği karakter(ler).
  final Set<String> myCharacterIds;
  DateTime updatedAt;

  Character? characterById(String? id) {
    if (id == null) return null;
    for (final c in characters) {
      if (c.id == id) return c;
    }
    return null;
  }

  bool isMine(Line line) =>
      line.kind == LineKind.dialogue && myCharacterIds.contains(line.characterId);

  /// Sesi seçilmemiş karakterlere, mümkünse başka karakterin kullanmadığı
  /// farklı sesler dağıtır: AHMET ile ZEYNEP baştan ayırt edilebilir olsun.
  /// Android seslerin cinsiyetini bildirmediği için bu bir tahmin değil,
  /// yalnızca çeşitlilik; kullanıcı dinleyip değiştirebilir.
  /// Değişiklik yaptıysa true döner.
  bool assignDistinctVoices(List<String> voiceNames) {
    if (voiceNames.isEmpty) return false;
    final available = voiceNames.toSet();
    // Bu cihazda olmayan ses (telefon değişti, bölge filtresi değişti) atanmamış sayılır.
    bool unassigned(Character c) => c.voice.voiceName == null || !available.contains(c.voice.voiceName);
    final used = {
      for (final c in characters)
        if (!unassigned(c)) c.voice.voiceName!,
    };
    final free = voiceNames.where((v) => !used.contains(v)).toList();
    var changed = false;
    var i = 0;
    for (final c in characters) {
      if (!unassigned(c)) continue;
      final name = i < free.length ? free[i] : voiceNames[i % voiceNames.length];
      c.voice = c.voice.copyWith(voiceName: name);
      i++;
      changed = true;
    }
    return changed;
  }

  /// Hiçbir satırın kullanmadığı karakterleri siler.
  void removeUnusedCharacters() {
    final used = lines.map((l) => l.characterId).whereType<String>().toSet();
    characters.removeWhere((c) => !used.contains(c.id));
    myCharacterIds.removeWhere((id) => !used.contains(id));
  }

  /// [fromId] karakterinin tüm repliklerini [intoId] karakterine taşır.
  void mergeCharacters(String fromId, String intoId) {
    for (final l in lines) {
      if (l.characterId == fromId) l.characterId = intoId;
    }
    if (myCharacterIds.remove(fromId)) myCharacterIds.add(intoId);
    characters.removeWhere((c) => c.id == fromId);
  }

  Map<String, dynamic> toJson() => {
        'schema': schemaVersion,
        'id': id,
        'title': title,
        'kind': kind.name,
        'language': language,
        'characters': characters.map((c) => c.toJson()).toList(),
        'lines': lines.map((l) => l.toJson()).toList(),
        'me': myCharacterIds.toList(),
        'updatedAt': updatedAt.toIso8601String(),
        if (targetSeconds != null) 'target': targetSeconds,
        if (pageSeconds != null) 'pages': pageSeconds,
        if (stats.isNotEmpty) 'stats': {for (final e in stats.entries) e.key: e.value.toJson()},
      };

  factory Piece.fromJson(Map<String, dynamic> j) => Piece(
        id: j['id'] as String,
        title: j['title'] as String,
        kind: PieceKind.values.byName(j['kind'] as String),
        language: j['language'] as String,
        characters: (j['characters'] as List)
            .map((e) => Character.fromJson((e as Map).cast<String, dynamic>()))
            .toList(),
        lines: (j['lines'] as List)
            .map((e) => Line.fromJson((e as Map).cast<String, dynamic>()))
            .toList(),
        myCharacterIds: (j['me'] as List).cast<String>().toSet(),
        updatedAt: DateTime.parse(j['updatedAt'] as String),
        targetSeconds: (j['target'] as num?)?.toInt(),
        pageSeconds: (j['pages'] as List?)?.map((e) => (e as num).toInt()).toList(),
        stats: {
          for (final e in ((j['stats'] as Map?) ?? const {}).entries)
            e.key as String: LineStat.fromJson((e.value as Map).cast<String, dynamic>()),
        },
      );
}
