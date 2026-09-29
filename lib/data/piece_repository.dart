import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../core/models.dart';

/// Metinleri uygulama klasöründe, her biri ayrı bir JSON dosyası olarak tutar.
///
/// Rakiplerde "telefon değişince her şey gitti" şikâyeti vardı: yazma işlemi
/// önce geçici dosyaya yapılıp sonra yeniden adlandırılır (yarım kalan kayıt
/// dosyayı bozmaz) ve tek dosyalık yedek/geri yükleme vardır.
class PieceRepository {
  PieceRepository([this._dirOverride]);

  final Directory? _dirOverride;
  Directory? _dir;

  static const backupFormat = 'ezber_asistani_backup';

  Future<Directory> _base() async => _dirOverride ?? await getApplicationSupportDirectory();

  /// Metnin replik kayıtları (kullanıcının sesi): yalnızca telefonda.
  Future<Directory> recordingsDir(String pieceId) async =>
      Directory('${(await _base()).path}${Platform.pathSeparator}recordings${Platform.pathSeparator}$pieceId');

  Future<Directory> _root() async {
    if (_dir != null) return _dir!;
    final base = await _base();
    final dir = Directory('${base.path}${Platform.pathSeparator}pieces');
    await dir.create(recursive: true);
    return _dir = dir;
  }

  Future<File> _file(String id) async =>
      File('${(await _root()).path}${Platform.pathSeparator}$id.json');

  Future<List<Piece>> loadAll() async {
    final dir = await _root();
    final pieces = <Piece>[];
    await for (final f in dir.list()) {
      if (f is! File || !f.path.endsWith('.json')) continue;
      try {
        pieces.add(Piece.fromJson(jsonDecode(await f.readAsString()) as Map<String, dynamic>));
      } catch (_) {
        // Bozuk tek bir dosya kütüphanenin tamamını göstermeyi engellemesin.
      }
    }
    pieces.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return pieces;
  }

  Future<void> save(Piece piece) async {
    piece.updatedAt = DateTime.now();
    final target = await _file(piece.id);
    final tmp = File('${target.path}.tmp');
    await tmp.writeAsString(jsonEncode(piece.toJson()), flush: true);
    try {
      await tmp.rename(target.path);
    } on FileSystemException {
      // Windows'ta (testler) var olan dosyanın üzerine yeniden adlandırma olmaz.
      await target.delete();
      await tmp.rename(target.path);
    }
  }

  Future<void> delete(String id) async {
    final f = await _file(id);
    if (await f.exists()) await f.delete();
    // Metinle birlikte ses kayıtları da silinir.
    final rec = await recordingsDir(id);
    if (await rec.exists()) await rec.delete(recursive: true);
  }

  Future<String> exportAll() async {
    final pieces = await loadAll();
    return jsonEncode({
      'format': backupFormat,
      'version': Piece.schemaVersion,
      'exportedAt': DateTime.now().toIso8601String(),
      'pieces': pieces.map((p) => p.toJson()).toList(),
    });
  }

  /// Yedekteki metinleri ekler; aynı kimlikli metin varsa yedektekiyle
  /// değiştirilir. Geri yüklenen metin sayısını döner.
  Future<int> importAll(String json) async {
    final data = jsonDecode(json);
    if (data is! Map || data['format'] != backupFormat || data['pieces'] is! List) {
      throw const FormatException('not a backup');
    }
    final pieces = (data['pieces'] as List)
        .map((e) => Piece.fromJson((e as Map).cast<String, dynamic>()))
        .toList();
    for (final p in pieces) {
      await save(p);
    }
    return pieces.length;
  }
}
