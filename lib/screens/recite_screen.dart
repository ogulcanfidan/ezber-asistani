import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../app_state.dart';
import '../core/models.dart';
import '../core/recite.dart';
import '../core/recite_session.dart';
import '../data/whisper_stt.dart';
import '../l10n/app_localizations.dart';

enum _Phase { checking, needModel, downloading, loading, ready, failed }

/// Ezberden okuma: metin gizli, kullanıcı baştan söyler; hata olunca durur,
/// hatalı yer gösterilir, "Buradan devam et" ile sürer; sonda rapor.
class ReciteScreen extends StatefulWidget {
  const ReciteScreen({super.key, required this.piece, this.models, this.loader, this.mic});

  final Piece piece;

  /// Testler için; verilmezse gerçek Whisper ve mikrofon.
  final ReciteModels? models;
  final Future<Transcriber> Function(String modelPath)? loader;
  final ReciteMic? mic;

  @override
  State<ReciteScreen> createState() => _ReciteScreenState();
}

class _ReciteScreenState extends State<ReciteScreen> {
  late final ReciteModels _models = widget.models ?? ReciteModels();
  _Phase _phase = _Phase.checking;
  double _progress = 0;
  ReciteModel _choice = ReciteModel.standard;
  StreamSubscription<double>? _download;
  Transcriber? _transcriber;
  ReciteSession? _session;

  Piece get piece => widget.piece;

  @override
  void initState() {
    super.initState();
    _findModel();
  }

  @override
  void dispose() {
    _download?.cancel();
    _session?.removeListener(_onSession);
    _session?.dispose();
    _transcriber?.dispose();
    WakelockPlus.disable().catchError((_) {});
    super.dispose();
  }

  Future<void> _findModel() async {
    final best = await _models.best();
    if (!mounted) return;
    if (best == null) {
      setState(() => _phase = _Phase.needModel);
    } else {
      await _load(best.$2);
    }
  }

  void _startDownload() {
    setState(() {
      _phase = _Phase.downloading;
      _progress = 0;
    });
    _download = _models.download(_choice).listen(
      (p) => setState(() => _progress = p),
      onError: (Object e) {
        if (!mounted) return;
        setState(() => _phase = _Phase.needModel);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(L.of(context).reciteDownloadFailed)));
      },
      onDone: () async {
        final path = await _models.installedPath(_choice);
        if (!mounted) return;
        if (path == null) {
          setState(() => _phase = _Phase.needModel);
        } else {
          await _load(path);
        }
      },
    );
  }

  Future<void> _load(String path) async {
    setState(() => _phase = _Phase.loading);
    try {
      final t = _transcriber = await (widget.loader ?? WhisperTranscriber.load)(path);
      if (!mounted) return;
      final language = piece.language.split(RegExp('[-_]')).first;
      _newSession(t, language);
      setState(() => _phase = _Phase.ready);
    } catch (e) {
      debugPrint('Whisper yüklenemedi: $e');
      if (mounted) setState(() => _phase = _Phase.failed);
    }
  }

  void _newSession(Transcriber t, String language) {
    _session?.removeListener(_onSession);
    _session?.dispose();
    _session = ReciteSession(
      piece: piece,
      mic: widget.mic ?? RecordReciteMic(),
      transcribe: (pcm, prompt) => t.transcribe(pcm, language: language, prompt: prompt),
    )..addListener(_onSession);
  }

  void _onSession() {
    if (!mounted) return;
    final s = _session!;
    final active = s.state == ReciteState.listening;
    (active ? WakelockPlus.enable() : WakelockPlus.disable()).catchError((_) {});
    if (s.state == ReciteState.finished || s.state == ReciteState.stopped) {
      AppScope.of(context).repository.save(piece);
    }
    setState(() {});
  }

  Future<void> _start() async {
    final ok = await _session!.start();
    if (!ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(L.of(context).micDenied)));
    }
  }

  void _again() {
    final t = _transcriber;
    if (t == null) return;
    _newSession(t, piece.language.split(RegExp('[-_]')).first);
    setState(() {});
  }

  Future<void> _deleteAndRetry() async {
    for (final m in ReciteModel.values) {
      await _models.delete(m);
    }
    if (mounted) setState(() => _phase = _Phase.needModel);
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l.reciteTitle)),
      body: SafeArea(
        child: switch (_phase) {
          _Phase.checking || _Phase.loading => _Centered(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(l.reciteLoading),
              ]),
            ),
          _Phase.needModel => _modelChooser(l),
          _Phase.downloading => _Centered(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                LinearProgressIndicator(value: _progress),
                const SizedBox(height: 16),
                Text(l.reciteDownloading((_progress * 100).round())),
              ]),
            ),
          _Phase.failed => _Centered(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(l.reciteLoadFailed, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                FilledButton(onPressed: _deleteAndRetry, child: Text(l.reciteDownload)),
              ]),
            ),
          _Phase.ready => _body(l),
        },
      ),
    );
  }

  Widget _modelChooser(L l) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Icon(Icons.record_voice_over_outlined, size: 56, color: theme.colorScheme.primary),
        const SizedBox(height: 12),
        Text(l.reciteModelTitle, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
        const SizedBox(height: 8),
        Text(l.reciteModelHelp, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        RadioGroup<ReciteModel>(
          groupValue: _choice,
          onChanged: (m) => setState(() => _choice = m ?? _choice),
          child: Column(children: [
            RadioListTile(value: ReciteModel.standard, title: Text(l.reciteModelStandard(ReciteModel.standard.megabytes))),
            RadioListTile(value: ReciteModel.accurate, title: Text(l.reciteModelAccurate(ReciteModel.accurate.megabytes))),
          ]),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(onPressed: _startDownload, icon: const Icon(Icons.download), label: Text(l.reciteDownload)),
      ],
    );
  }

  Widget _body(L l) {
    final s = _session!;
    final theme = Theme.of(context);
    final c = s.checker;
    final error = s.error;
    final errorWords = error == null ? const <int>{} : {for (var i = error.from; i < error.to; i++) i};

    // Satır satır: söylenen kelimeler açık, gerisi gizli; hatalı kelimeler
    // kırmızı ve açık (kullanıcı doğrusunu görsün).
    final byLine = <int, List<int>>{};
    for (var i = 0; i < c.words.length; i++) {
      byLine.putIfAbsent(c.words[i].line, () => []).add(i);
    }
    final finished = s.state == ReciteState.finished;

    return Column(children: [
      Expanded(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            for (final e in byLine.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Directionality(
                  textDirection: textDirectionFor(piece.language),
                  child: Text.rich(
                    TextSpan(children: [
                      for (final i in e.value)
                        TextSpan(
                          text: '${i < c.pos || finished || errorWords.contains(i) ? c.words[i].text : '_' * c.words[i].text.length.clamp(2, 8)} ',
                          style: errorWords.contains(i)
                              ? TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold)
                              : i < c.pos
                                  ? null
                                  : TextStyle(color: theme.colorScheme.onSurfaceVariant),
                        ),
                    ]),
                    style: theme.textTheme.bodyLarge?.copyWith(fontSize: 18),
                  ),
                ),
              ),
          ],
        ),
      ),
      _panel(l, s, theme),
    ]);
  }

  Widget _panel(L l, ReciteSession s, ThemeData theme) {
    final c = s.checker;
    switch (s.state) {
      case ReciteState.idle:
        return _Bottom(children: [
          Text(l.reciteNote, style: theme.textTheme.bodySmall, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 64,
            child: FilledButton.icon(onPressed: _start, icon: const Icon(Icons.mic), label: Text(l.reciteStart)),
          ),
        ]);
      case ReciteState.listening:
        return _Bottom(children: [
          Row(children: [
            Icon(Icons.mic, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Expanded(child: Text(s.pending > 0 ? l.reciteChecking : l.reciteListening)),
            TextButton(onPressed: s.finish, child: Text(l.reciteFinish)),
          ]),
          if (s.lastHeard.isNotEmpty)
            Text(l.reciteHeard(s.lastHeard),
                style: theme.textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          LinearProgressIndicator(value: c.words.isEmpty ? 0 : c.pos / c.words.length),
        ]);
      case ReciteState.stopped:
        final e = s.error!;
        return _Bottom(
          color: theme.colorScheme.errorContainer,
          children: [
            Text(
              e.kind == ReciteErrorKind.skipped ? l.reciteSkipped : l.reciteWrong,
              style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onErrorContainer),
            ),
            const SizedBox(height: 4),
            Text(l.reciteExpected(c.textOf(e)), style: TextStyle(color: theme.colorScheme.onErrorContainer)),
            if (e.kind == ReciteErrorKind.wrong && e.heard.isNotEmpty)
              Text(l.reciteYouSaid(e.heard), style: TextStyle(color: theme.colorScheme.onErrorContainer)),
            const SizedBox(height: 8),
            Row(children: [
              TextButton(onPressed: s.finish, child: Text(l.reciteFinish)),
              const Spacer(),
              FilledButton.icon(
                onPressed: s.resume,
                icon: const Icon(Icons.play_arrow),
                label: Text(l.reciteContinueHere),
              ),
            ]),
          ],
        );
      case ReciteState.finished:
        final major = c.errors.where((e) => !e.minor).toList();
        final minor = c.errors.length - major.length;
        final secs = s.elapsed.inSeconds;
        return _Bottom(
          color: theme.colorScheme.primaryContainer,
          children: [
            Text(
              '${l.reciteAccuracy(c.accuracy)} · ${l.elapsed('${secs ~/ 60}:${(secs % 60).toString().padLeft(2, '0')}')}',
              style: theme.textTheme.titleMedium,
            ),
            if (major.isEmpty) Text(l.reciteNoErrors),
            for (final e in major.take(6))
              Text(
                '• ${e.kind == ReciteErrorKind.skipped ? l.reciteSkipped : l.reciteWrong}: '
                '"${c.textOf(e)}"${e.heard.isNotEmpty ? ' → "${e.heard}"' : ''}',
                style: theme.textTheme.bodySmall,
              ),
            if (minor > 0) Text(l.reciteMinor(minor), style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: FilledButton.icon(onPressed: _again, icon: const Icon(Icons.replay), label: Text(l.reciteAgain)),
            ),
          ],
        );
    }
  }
}

class _Centered extends StatelessWidget {
  const _Centered({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Center(child: Padding(padding: const EdgeInsets.all(32), child: child));
}

class _Bottom extends StatelessWidget {
  const _Bottom({required this.children, this.color});
  final List<Widget> children;
  final Color? color;

  @override
  Widget build(BuildContext context) => Material(
        color: color ?? Theme.of(context).colorScheme.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      );
}
