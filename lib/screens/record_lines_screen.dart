import 'package:flutter/material.dart';

import '../app_state.dart';
import '../core/models.dart';
import '../data/line_recordings.dart';
import '../l10n/app_localizations.dart';
import 'editor_screen.dart' show emotionLabel;

/// Replikleri tek tek kendi sesiyle (ya da bir arkadaşının sesiyle) kaydetme.
/// Varsayılan olarak karşı replikler; istenirse kendi replikleri de.
class RecordLinesScreen extends StatefulWidget {
  const RecordLinesScreen({super.key, required this.piece, this.startLineId});

  final Piece piece;
  final String? startLineId;

  @override
  State<RecordLinesScreen> createState() => _RecordLinesScreenState();
}

class _RecordLinesScreenState extends State<RecordLinesScreen> {
  bool _includeMine = false;
  int _i = 0;
  bool _recording = false;
  bool _playing = false;
  final _watch = Stopwatch();

  Piece get piece => widget.piece;

  List<Line> get _lines => [
        for (final l in piece.lines)
          if (l.kind == LineKind.dialogue && (_includeMine || !piece.isMine(l))) l,
      ];

  @override
  void initState() {
    super.initState();
    final start = widget.startLineId;
    if (start != null) {
      final line = piece.lines.firstWhere((l) => l.id == start, orElse: () => piece.lines.first);
      _includeMine = piece.isMine(line);
      _i = _lines.indexWhere((l) => l.id == start).clamp(0, 1 << 30);
    }
  }

  late LineRecordings _rec;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _rec = AppScope.of(context).recordings;
  }

  @override
  void dispose() {
    final rec = _rec;
    if (_recording) rec.stop(piece, _lines[_i], length: Duration.zero);
    rec.stopPlaying();
    super.dispose();
  }

  Future<void> _toggleRecord() async {
    final state = AppScope.of(context);
    final line = _lines[_i];
    if (_recording) {
      _watch.stop();
      await state.recordings.stop(piece, line, length: _watch.elapsed);
      setState(() => _recording = false);
      await state.repository.save(piece);
      return;
    }
    await state.recordings.stopPlaying();
    final ok = await state.recordings.start(piece, line);
    if (!mounted) return;
    if (!ok) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(L.of(context).micDenied)));
      return;
    }
    _watch
      ..reset()
      ..start();
    setState(() {
      _recording = true;
      _playing = false;
    });
  }

  Future<void> _play() async {
    final rec = AppScope.of(context).recordings;
    if (_playing) {
      await rec.stopPlaying();
      return;
    }
    setState(() => _playing = true);
    await rec.play(piece, _lines[_i]);
    if (mounted) setState(() => _playing = false);
  }

  Future<void> _delete() async {
    final state = AppScope.of(context);
    await state.recordings.stopPlaying();
    await state.recordings.delete(piece, _lines[_i]);
    await state.repository.save(piece);
    if (mounted) setState(() {});
  }

  Future<void> _go(int delta) async {
    if (_recording) await _toggleRecord();
    if (!mounted) return;
    await AppScope.of(context).recordings.stopPlaying();
    setState(() {
      _i = (_i + delta).clamp(0, _lines.length - 1);
      _playing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final theme = Theme.of(context);
    final lines = _lines;
    final recordedCount = lines.where((x) => x.recorded).length;
    if (_i >= lines.length) _i = lines.isEmpty ? 0 : lines.length - 1;

    return Scaffold(
      appBar: AppBar(title: Text(l.recordLines)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(l.recordLinesHelp, style: theme.textTheme.bodySmall),
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(l.recordIncludeMine),
              value: _includeMine,
              onChanged: _recording
                  ? null
                  : (v) => setState(() {
                        _includeMine = v;
                        _i = 0;
                      }),
            ),
            if (lines.isEmpty)
              Padding(padding: const EdgeInsets.all(24), child: Text(l.recordNone, textAlign: TextAlign.center))
            else ...[
              Text(l.recordedCount(recordedCount, lines.length), style: theme.textTheme.labelLarge),
              const SizedBox(height: 4),
              LinearProgressIndicator(value: recordedCount / lines.length),
              const SizedBox(height: 16),
              _card(l, theme, lines[_i]),
              const SizedBox(height: 16),
              SizedBox(
                height: 72,
                child: FilledButton.icon(
                  style: _recording ? FilledButton.styleFrom(backgroundColor: theme.colorScheme.error) : null,
                  onPressed: _toggleRecord,
                  icon: Icon(_recording ? Icons.stop : Icons.mic, size: 32),
                  label: Text(_recording ? l.recordStop : l.recordStart, style: theme.textTheme.titleLarge?.copyWith(color: _recording ? theme.colorScheme.onError : theme.colorScheme.onPrimary)),
                ),
              ),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: lines[_i].recorded && !_recording ? _play : null,
                    icon: Icon(_playing ? Icons.stop : Icons.play_arrow),
                    label: Text(l.recordPlay),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: lines[_i].recorded && !_recording ? _delete : null,
                    icon: const Icon(Icons.delete_outline),
                    label: Text(l.recordDelete),
                  ),
                ),
              ]),
              const SizedBox(height: 16),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Row(children: [
                  TextButton.icon(
                    onPressed: _i > 0 ? () => _go(-1) : null,
                    icon: const Icon(Icons.chevron_left),
                    label: Text(l.recordPrev),
                  ),
                  const Spacer(),
                  Text('${_i + 1}/${lines.length}'),
                  const Spacer(),
                  TextButton.icon(
                    onPressed: _i < lines.length - 1 ? () => _go(1) : null,
                    icon: const Icon(Icons.chevron_right),
                    label: Text(l.recordNext),
                  ),
                ]),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _card(L l, ThemeData theme, Line line) {
    final name = piece.characterById(line.characterId)?.name ?? '';
    return Card.filled(
      color: theme.colorScheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            if (piece.kind == PieceKind.play)
              Text(name, style: theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.primary, fontWeight: FontWeight.bold)),
            if (line.emotion != Emotion.neutral) ...[
              const SizedBox(width: 8),
              Text('(${emotionLabel(l, line.emotion)})', style: theme.textTheme.labelMedium),
            ],
            const Spacer(),
            if (line.recorded)
              Chip(
                avatar: const Icon(Icons.check, size: 16),
                label: Text(l.recordedBadge),
                visualDensity: VisualDensity.compact,
              ),
          ]),
          const SizedBox(height: 8),
          Directionality(
            textDirection: textDirectionFor(piece.language),
            child: Text(line.text, style: theme.textTheme.headlineSmall),
          ),
          if (_recording) ...[
            const SizedBox(height: 8),
            Row(children: [
              Icon(Icons.fiber_manual_record, color: theme.colorScheme.error, size: 16),
              const SizedBox(width: 4),
              Text(l.recordingNow, style: TextStyle(color: theme.colorScheme.error)),
            ]),
          ],
        ]),
      ),
    );
  }
}
