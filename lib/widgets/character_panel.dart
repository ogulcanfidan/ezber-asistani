import 'package:flutter/material.dart';

import '../app_state.dart';
import '../core/models.dart';
import '../data/tts_speaker.dart';
import '../l10n/app_localizations.dart';

/// Karakterler, "ben" seçimi ve sesler tek yerde. Eskiden kendi karakterini
/// seçmek bir ekranda, sesini ayarlamak üç dokunuş ötede başka bir ekrandaydı.
class CharacterPanel extends StatefulWidget {
  const CharacterPanel({super.key, required this.piece, required this.onChanged});

  final Piece piece;
  final VoidCallback onChanged;

  @override
  State<CharacterPanel> createState() => _CharacterPanelState();
}

class _CharacterPanelState extends State<CharacterPanel> {
  List<DeviceVoice>? _voices;
  String? _expanded;

  Piece get piece => widget.piece;
  bool get _isPlay => piece.kind == PieceKind.play;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_voices != null) return;
    AppScope.of(context).speaker.voicesFor(piece.language).then((v) {
      if (piece.assignDistinctVoices([for (final x in v) x.name])) widget.onChanged();
      if (mounted) setState(() => _voices = v);
    });
  }

  void _changed() {
    setState(() {});
    widget.onChanged();
  }

  void _preview(Character c) {
    AppScope.of(context).speaker.speak(L.of(context).testSentence, language: piece.language, voice: c.voice);
  }

  Future<void> _rename(Character c) async {
    final l = L.of(context);
    final controller = TextEditingController(text: c.name);
    final name = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.rename),
        content: TextField(controller: controller, autofocus: true),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
          FilledButton(onPressed: () => Navigator.pop(context, controller.text.trim()), child: Text(l.save)),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    c.name = name;
    _changed();
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final voices = _voices;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (voices != null && voices.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(l.noVoices, style: TextStyle(color: Theme.of(context).colorScheme.error)),
          ),
        for (final c in piece.characters) _tile(l, c, voices),
      ],
    );
  }

  Widget _tile(L l, Character c, List<DeviceVoice>? voices) {
    final theme = Theme.of(context);
    final mine = piece.myCharacterIds.contains(c.id);
    final expanded = _expanded == c.id || !_isPlay;
    final voiceIndex = voices?.indexWhere((v) => v.name == c.voice.voiceName) ?? -1;
    final lines = piece.lines.where((x) => x.characterId == c.id).length;

    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: mine ? theme.colorScheme.primaryContainer.withValues(alpha: 0.35) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            contentPadding: const EdgeInsetsDirectional.only(start: 4, end: 8),
            leading: _isPlay
                ? IconButton(
                    tooltip: l.me,
                    isSelected: mine,
                    icon: const Icon(Icons.star_border),
                    selectedIcon: Icon(Icons.star, color: theme.colorScheme.primary),
                    onPressed: () {
                      mine ? piece.myCharacterIds.remove(c.id) : piece.myCharacterIds.add(c.id);
                      _changed();
                    },
                  )
                : const Padding(padding: EdgeInsets.all(12), child: Icon(Icons.record_voice_over_outlined)),
            title: Text(_isPlay ? c.name : l.me, style: theme.textTheme.titleMedium),
            subtitle: Text([
              if (_isPlay) l.lineCount(lines),
              if (voiceIndex >= 0) l.voiceN(voiceIndex + 1),
            ].join(' · ')),
            trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              IconButton(
                tooltip: l.testVoice,
                icon: const Icon(Icons.volume_up_outlined),
                onPressed: () => _preview(c),
              ),
              if (_isPlay)
                IconButton(
                  tooltip: l.voice,
                  icon: Icon(expanded ? Icons.expand_less : Icons.tune),
                  onPressed: () => setState(() => _expanded = expanded ? null : c.id),
                ),
            ]),
          ),
          if (expanded) _settings(l, c, voices),
        ],
      ),
    );
  }

  Widget _settings(L l, Character c, List<DeviceVoice>? voices) {
    final others = piece.characters.where((x) => x.id != c.id).toList();
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (voices != null && voices.isNotEmpty) ...[
            Text(l.voice, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 4),
            // Sesler çip olarak: seçince hemen o sesle önizleme çalar.
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: [
                for (final (i, v) in voices.indexed)
                  ChoiceChip(
                    label: Text(l.voiceN(i + 1)),
                    selected: c.voice.voiceName == v.name,
                    onSelected: (_) {
                      c.voice = c.voice.copyWith(voiceName: v.name);
                      _changed();
                      _preview(c);
                    },
                  ),
              ],
            ),
          ],
          const SizedBox(height: 8),
          Row(children: [
            SizedBox(width: 72, child: Text(l.pitch)),
            Expanded(
              child: Slider(
                value: c.voice.pitch,
                min: 0.5,
                max: 2.0,
                divisions: 15,
                label: c.voice.pitch.toStringAsFixed(1),
                onChanged: (v) => setState(() => c.voice = c.voice.copyWith(pitch: v)),
                onChangeEnd: (_) {
                  widget.onChanged();
                  _preview(c);
                },
              ),
            ),
          ]),
          Row(children: [
            SizedBox(width: 72, child: Text(l.speed)),
            Expanded(
              child: Slider(
                value: c.voice.rate,
                min: 0.1,
                max: 1.0,
                divisions: 18,
                label: c.voice.rate.toStringAsFixed(2),
                onChanged: (v) => setState(() => c.voice = c.voice.copyWith(rate: v)),
                onChangeEnd: (_) {
                  widget.onChanged();
                  _preview(c);
                },
              ),
            ),
          ]),
          if (_isPlay)
            Wrap(spacing: 8, children: [
              TextButton.icon(
                onPressed: () => _rename(c),
                icon: const Icon(Icons.edit_outlined),
                label: Text(l.rename),
              ),
              if (others.isNotEmpty)
                PopupMenuButton<String>(
                  onSelected: (intoId) {
                    piece.mergeCharacters(c.id, intoId);
                    _expanded = null;
                    _changed();
                  },
                  itemBuilder: (context) => [
                    for (final o in others) PopupMenuItem(value: o.id, child: Text(o.name)),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const Icon(Icons.merge, size: 18),
                      const SizedBox(width: 8),
                      Text(l.mergeInto),
                    ]),
                  ),
                ),
            ]),
        ],
      ),
    );
  }
}

/// Prova ekranından tek dokunuşla açılan karakter/ses paneli.
Future<void> showCharacterSheet(BuildContext context, Piece piece, VoidCallback onChanged) {
  final l = L.of(context);
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) => DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      builder: (context, scroll) => ListView(
        controller: scroll,
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        children: [
          Text(l.charactersAndVoices, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          CharacterPanel(piece: piece, onChanged: onChanged),
        ],
      ),
    ),
  );
}
