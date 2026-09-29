import 'package:flutter/material.dart';

import '../app_state.dart';
import '../core/emotion.dart';
import '../core/models.dart';
import '../l10n/app_localizations.dart';
import '../widgets/character_panel.dart';
import 'record_lines_screen.dart';
import 'rehearsal_screen.dart';

String emotionLabel(L l, Emotion e) => switch (e) {
      Emotion.neutral => l.emoNeutral,
      Emotion.happy => l.emoHappy,
      Emotion.sad => l.emoSad,
      Emotion.angry => l.emoAngry,
      Emotion.excited => l.emoExcited,
      Emotion.calm => l.emoCalm,
      Emotion.whisper => l.emoWhisper,
      Emotion.afraid => l.emoAfraid,
    };

String characterLabel(BuildContext context, Piece piece, Character? c) {
  if (c == null) return L.of(context).direction;
  return piece.kind == PieceKind.play ? c.name : L.of(context).me;
}

/// İçe aktarılan metnin kontrol edildiği ekran. Rakiplerde en çok şikâyet
/// edilen şey yanlış atanan replikleri düzeltmenin zahmetiydi; burada her
/// düzeltme tek dokunuştur ve her değişiklik anında kaydedilir.
class EditorScreen extends StatefulWidget {
  const EditorScreen({super.key, required this.piece, this.isNew = false});

  final Piece piece;
  final bool isNew;

  @override
  State<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends State<EditorScreen> {
  Piece get piece => widget.piece;

  Future<void> _changed() async {
    setState(() {});
    await AppScope.of(context).repository.save(piece);
  }

  Future<String?> _askText({required String title, String initial = '', String? helper}) {
    final l = L.of(context);
    final controller = TextEditingController(text: initial);
    return showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(helperText: helper, helperMaxLines: 2),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(l.cancel)),
          FilledButton(
            onPressed: () => Navigator.pop(context, controller.text.trim()),
            child: Text(l.save),
          ),
        ],
      ),
    );
  }

  Future<void> _assign(Line line) async {
    final l = L.of(context);
    const directionKey = '__direction__';
    const newKey = '__new__';
    final choice = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(title: Text(l.assignTo, style: Theme.of(context).textTheme.titleMedium)),
            for (final c in piece.characters)
              ListTile(
                leading: Icon(line.kind == LineKind.dialogue && line.characterId == c.id
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked),
                title: Text(characterLabel(context, piece, c)),
                onTap: () => Navigator.pop(context, c.id),
              ),
            ListTile(
              leading: const Icon(Icons.person_add_alt),
              title: Text(l.newCharacter),
              onTap: () => Navigator.pop(context, newKey),
            ),
            ListTile(
              leading: Icon(line.kind == LineKind.direction
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
              title: Text(l.direction),
              onTap: () => Navigator.pop(context, directionKey),
            ),
          ],
        ),
      ),
    );
    if (choice == null || !mounted) return;
    line.unsure = false;
    if (choice == directionKey) {
      line
        ..kind = LineKind.direction
        ..characterId = null;
    } else if (choice == newKey) {
      final name = await _askText(title: l.newCharacter);
      if (name == null || name.isEmpty) return;
      final c = Character(name: name);
      piece.characters.add(c);
      line
        ..kind = LineKind.dialogue
        ..characterId = c.id;
    } else {
      line
        ..kind = LineKind.dialogue
        ..characterId = choice;
    }
    piece.removeUnusedCharacters();
    await _changed();
  }

  /// Metni düzenle. Enter ile yazılan her satır ayrı bir satır olur:
  /// iki konuşmacının replikleri birleşik gelmişse bölünebilir.
  Future<void> _edit(Line line) async {
    final l = L.of(context);
    final text = await _askText(title: l.editLine, initial: line.text, helper: l.splitHint);
    if (text == null || text.isEmpty) return;
    final parts = text.split('\n').map((s) => s.trim()).where((s) => s.isNotEmpty).toList();
    line
      ..text = parts.first
      ..unsure = false;
    final at = piece.lines.indexOf(line);
    for (var k = 1; k < parts.length; k++) {
      piece.lines.insert(at + k, Line(kind: line.kind, characterId: line.characterId, text: parts[k]));
    }
    await _changed();
  }

  Future<void> _action(String action, int i) async {
    final line = piece.lines[i];
    line.unsure = false;
    switch (action) {
      case 'edit':
        return _edit(line);
      case 'direction':
        line
          ..kind = LineKind.direction
          ..characterId = null;
      case 'heading':
        line
          ..kind = LineKind.heading
          ..characterId = null;
      case 'dialogue':
        return _assign(line);
      case 'emotion':
        return _pickEmotion(line);
      case 'record':
        return _record(line);
      case 'merge':
        if (i == 0) return;
        final prev = piece.lines[i - 1];
        prev.text = '${prev.text} ${line.text}';
        piece.lines.removeAt(i);
      case 'add':
        final text = await _askText(title: L.of(context).addLineBelow);
        if (text == null || text.isEmpty) return;
        piece.lines.insert(
          i + 1,
          Line(kind: line.kind, characterId: line.characterId, text: text),
        );
      case 'delete':
        piece.lines.removeAt(i);
    }
    piece.removeUnusedCharacters();
    await _changed();
  }

  /// Replik tonu: seçince o tonla dinletilir.
  Future<void> _pickEmotion(Line line) async {
    final l = L.of(context);
    final state = AppScope.of(context);
    final voice = piece.characterById(line.characterId)?.voice ?? const VoiceSettings();
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheet) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l.emotion, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text(l.emotionHelp, style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    for (final e in Emotion.values)
                      ChoiceChip(
                        label: Text(emotionLabel(l, e)),
                        selected: line.emotion == e,
                        onSelected: (_) {
                          setSheet(() => line.emotion = e);
                          state.speaker.stop();
                          state.speaker.speak(line.text, language: piece.language, voice: voice.withEmotion(e));
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    await state.speaker.stop();
    if (mounted) await _changed();
  }

  Future<void> _record([Line? line]) async {
    await Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => RecordLinesScreen(piece: piece, startLineId: line?.id)),
    );
    if (mounted) setState(() {});
  }

  void _rehearse() {
    final route = MaterialPageRoute<void>(builder: (_) => RehearsalScreen(piece: piece));
    if (widget.isNew) {
      Navigator.of(context).pushReplacement(route);
    } else {
      Navigator.of(context).push(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final theme = Theme.of(context);
    final isPlay = piece.kind == PieceKind.play;

    return Scaffold(
      appBar: AppBar(
        title: Text(l.reviewTitle),
        actions: [
          IconButton(
            tooltip: l.recordLines,
            icon: const Icon(Icons.mic_none),
            onPressed: _record,
          ),
          IconButton(
            tooltip: l.charactersAndVoices,
            icon: const Icon(Icons.people_outline),
            onPressed: () async {
              await showCharacterSheet(context, piece, _changed);
              setState(() {});
            },
          ),
        ],
      ),
      // FAB'ın pasif görünümü yok; karakter seçilene kadar gizlenir
      // (yerine kırmızı "karakter seçin" uyarısı görünür).
      floatingActionButton: piece.myCharacterIds.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: _rehearse,
              icon: const Icon(Icons.play_arrow),
              label: Text(l.rehearse),
            ),
      body: ListView.builder(
        padding: const EdgeInsets.only(bottom: 96),
        itemCount: piece.lines.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            // Karakter seçimi ayrı bir kartta, satırlar kendi başlığı altında:
            // telefonda iki bölüm birbirine karışıyordu.
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Karakter seçimi ve sesleri aynı kartta: ⭐ ile "ben"
                  // seçilir, ⚙ ile ses/ton/hız ayarlanır, 🔊 ile dinlenir.
                  Card.filled(
                    color: theme.colorScheme.surfaceContainerHigh,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(children: [
                            Icon(isPlay ? Icons.star : Icons.record_voice_over_outlined,
                                color: theme.colorScheme.primary),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(isPlay ? l.whoAmI : l.charactersAndVoices,
                                  style: theme.textTheme.titleMedium),
                            ),
                          ]),
                          if (isPlay) ...[
                            const SizedBox(height: 4),
                            Text(l.whoAmIHelp, style: theme.textTheme.bodySmall),
                          ],
                          const SizedBox(height: 8),
                          CharacterPanel(piece: piece, onChanged: _changed),
                          if (piece.myCharacterIds.isEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(l.noMyCharacter, style: TextStyle(color: theme.colorScheme.error)),
                            ),
                        ],
                      ),
                    ),
                  ),
                  if (piece.lines.any((x) => x.unsure))
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Card.filled(
                        color: theme.colorScheme.tertiaryContainer,
                        child: ListTile(
                          leading: Icon(Icons.help_outline, color: theme.colorScheme.onTertiaryContainer),
                          title: Text(
                            l.unsureBanner(piece.lines.where((x) => x.unsure).length),
                            style: TextStyle(color: theme.colorScheme.onTertiaryContainer),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Text(l.linesHeader, style: theme.textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(l.reviewHelp, style: theme.textTheme.bodySmall),
                  const Divider(height: 24),
                ],
              ),
            );
          }
          final i = index - 1;
          return _LineTile(
            key: ValueKey(piece.lines[i].id),
            piece: piece,
            line: piece.lines[i],
            canMerge: i > 0,
            onAssign: () => _assign(piece.lines[i]),
            onEdit: () => _edit(piece.lines[i]),
            onAction: (a) => _action(a, i),
          );
        },
      ),
    );
  }
}

class _LineTile extends StatelessWidget {
  const _LineTile({
    super.key,
    required this.piece,
    required this.line,
    required this.canMerge,
    required this.onAssign,
    required this.onEdit,
    required this.onAction,
  });

  final Piece piece;
  final Line line;
  final bool canMerge;
  final VoidCallback onAssign;
  final VoidCallback onEdit;
  final ValueChanged<String> onAction;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final theme = Theme.of(context);
    final mine = piece.isMine(line);

    final menu = PopupMenuButton<String>(
      onSelected: onAction,
      itemBuilder: (context) => [
        PopupMenuItem(value: 'edit', child: Text(l.editLine)),
        if (line.kind != LineKind.dialogue) PopupMenuItem(value: 'dialogue', child: Text(l.makeDialogue)),
        if (line.kind == LineKind.dialogue && piece.kind == PieceKind.play)
          PopupMenuItem(value: 'emotion', child: Text(l.emotion)),
        if (line.kind == LineKind.dialogue) PopupMenuItem(value: 'record', child: Text(l.recordLines)),
        if (line.kind != LineKind.direction) PopupMenuItem(value: 'direction', child: Text(l.makeDirection)),
        if (line.kind != LineKind.heading) PopupMenuItem(value: 'heading', child: Text(l.makeHeading)),
        if (canMerge) PopupMenuItem(value: 'merge', child: Text(l.mergeWithPrevious)),
        PopupMenuItem(value: 'add', child: Text(l.addLineBelow)),
        PopupMenuItem(value: 'delete', child: Text(l.deleteLine)),
      ],
    );

    if (line.kind == LineKind.heading) {
      return Container(
        color: theme.colorScheme.surfaceContainerHighest,
        child: ListTile(
          title: Text(line.text, style: theme.textTheme.titleSmall),
          onTap: onEdit,
          trailing: menu,
        ),
      );
    }

    final speaker = piece.characterById(line.characterId);
    // Kime ait olduğu anlaşılamayan satır: vurgulu, soru işaretli çip.
    return Container(
      color: line.unsure ? theme.colorScheme.tertiaryContainer.withValues(alpha: 0.5) : null,
      padding: const EdgeInsetsDirectional.only(start: 12, top: 4, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (piece.kind == PieceKind.play || line.kind == LineKind.direction)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: ActionChip(
                label: Text(line.unsure ? '?' : characterLabel(context, piece, speaker)),
                avatar: mine
                    ? const Icon(Icons.star, size: 16)
                    : line.unsure
                        ? const Icon(Icons.person_search, size: 16)
                        : null,
                backgroundColor: mine
                    ? theme.colorScheme.primaryContainer
                    : line.unsure
                        ? theme.colorScheme.tertiaryContainer
                        : null,
                onPressed: onAssign,
              ),
            ),
          Expanded(
            child: InkWell(
              onTap: onEdit,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      line.kind == LineKind.direction ? '(${line.text})' : line.text,
                      textDirection: textDirectionFor(piece.language),
                      style: line.kind == LineKind.direction
                          ? theme.textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: theme.colorScheme.onSurfaceVariant,
                            )
                          : theme.textTheme.bodyLarge,
                    ),
                    if (line.kind == LineKind.dialogue && line.recorded)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          Icon(Icons.mic, size: 14, color: theme.colorScheme.primary),
                          const SizedBox(width: 4),
                          Text(l.recordedBadge,
                              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary)),
                        ]),
                      ),
                    // Seçili/algılanan ton: dokununca değiştirilir.
                    if (line.kind == LineKind.dialogue && line.emotion != Emotion.neutral)
                      InkWell(
                        onTap: () => onAction('emotion'),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Icon(Icons.theater_comedy_outlined, size: 14, color: theme.colorScheme.primary),
                            const SizedBox(width: 4),
                            Text(
                              '${l.emotion}: ${emotionLabel(l, line.emotion)}',
                              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
                            ),
                          ]),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          menu,
        ],
      ),
    );
  }
}
