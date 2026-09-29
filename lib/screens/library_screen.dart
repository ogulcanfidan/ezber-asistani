import 'package:flutter/material.dart';

import '../app_state.dart';
import '../core/models.dart';
import '../data/pro.dart';
import '../l10n/app_localizations.dart';
import 'editor_screen.dart';
import 'new_piece_screen.dart';
import 'pro_screen.dart';
import 'rehearsal_screen.dart';
import 'settings_screen.dart';

IconData kindIcon(PieceKind kind) => switch (kind) {
      PieceKind.play => Icons.theater_comedy_outlined,
      PieceKind.poem => Icons.auto_stories_outlined,
      PieceKind.speech => Icons.record_voice_over_outlined,
    };

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  List<Piece>? _pieces;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_pieces == null) _reload();
  }

  Future<void> _reload() async {
    final pieces = await AppScope.of(context).repository.loadAll();
    if (mounted) setState(() => _pieces = pieces);
  }

  Future<void> _open(Widget screen) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
    await _reload();
  }

  /// Ücretsiz sürümde [freePieceLimit] metin; fazlası Pro. Yedekten geri
  /// yükleme sınırlanmaz: kullanıcının metni hiçbir zaman kaybolmaz.
  Future<void> _newPiece() async {
    final pro = AppScope.of(context).pro;
    if (!pro.isPro.value && (_pieces?.length ?? 0) >= freePieceLimit) {
      final messenger = ScaffoldMessenger.of(context);
      messenger.showSnackBar(SnackBar(content: Text(L.of(context).proLimitReached(freePieceLimit))));
      if (!await showProScreen(context) || !mounted) return;
    }
    await _open(const NewPieceScreen());
  }

  Future<void> _delete(Piece piece) async {
    final l = L.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        content: Text(l.deleteConfirm(piece.title)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(l.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, true), child: Text(l.delete)),
        ],
      ),
    );
    if (ok == true && mounted) {
      await AppScope.of(context).repository.delete(piece.id);
      await _reload();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final pieces = _pieces;
    return Scaffold(
      appBar: AppBar(
        title: Text(l.library),
        actions: [
          IconButton(
            tooltip: l.settings,
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => _open(const SettingsScreen()),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _newPiece,
        icon: const Icon(Icons.add),
        label: Text(l.newPiece),
      ),
      body: pieces == null
          ? const Center(child: CircularProgressIndicator())
          : pieces.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(l.emptyLibrary, textAlign: TextAlign.center),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.only(bottom: 96),
                  itemCount: pieces.length,
                  itemBuilder: (context, i) {
                    final p = pieces[i];
                    return ListTile(
                      leading: Icon(kindIcon(p.kind)),
                      title: Text(p.title),
                      subtitle: Text([
                        l.lineCount(p.lines.length),
                        if (p.weakCount > 0) l.weakCount(p.weakCount),
                      ].join(' · ')),
                      onTap: () => _open(RehearsalScreen(piece: p)),
                      trailing: PopupMenuButton<String>(
                        onSelected: (v) => v == 'edit' ? _open(EditorScreen(piece: p)) : _delete(p),
                        itemBuilder: (context) => [
                          PopupMenuItem(value: 'edit', child: Text(l.editLine)),
                          PopupMenuItem(value: 'delete', child: Text(l.delete)),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
