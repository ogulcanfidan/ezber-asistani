import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../app_state.dart';
import '../core/models.dart';
import '../core/script_parser.dart';
import '../data/doc_import.dart';
import '../data/pdf_import.dart';
import '../l10n/app_localizations.dart';
import 'editor_screen.dart';
import 'library_screen.dart';

class NewPieceScreen extends StatefulWidget {
  const NewPieceScreen({super.key});

  @override
  State<NewPieceScreen> createState() => _NewPieceScreenState();
}

class _NewPieceScreenState extends State<NewPieceScreen> {
  final _title = TextEditingController();
  final _text = TextEditingController();
  PieceKind _kind = PieceKind.play;
  String? _language;
  bool _reading = false;

  @override
  void dispose() {
    _title.dispose();
    _text.dispose();
    super.dispose();
  }

  /// İçe aktarma: her tür (dosya/fotoğraf) aynı hata ve yükleniyor akışı.
  Future<void> _import(Future<(String, String?)?> Function() read) async {
    final l = L.of(context);
    final messenger = ScaffoldMessenger.of(context);
    void show(String msg) =>
        messenger.showSnackBar(SnackBar(content: Text(msg), duration: const Duration(seconds: 8)));

    setState(() => _reading = true);
    try {
      final result = await read();
      if (result == null) return;
      final (text, name) = result;
      setState(() {
        _text.text = text.trim();
        if (_title.text.isEmpty && name != null) {
          _title.text = name.replaceAll(RegExp(r'\.[A-Za-z0-9]{2,5}$'), '');
        }
      });
    } on ScannedPdfException {
      show(l.pdfScanned);
    } on UnsupportedFormatException {
      show(l.docOld);
    } on NoTextInImageException {
      show(l.noTextInPhoto);
    } catch (_) {
      show(l.importFailed);
    } finally {
      if (mounted) setState(() => _reading = false);
    }
  }

  Future<void> _importFile() => _import(() async {
        final files = await FilePicker.pickFiles(type: FileType.custom, allowedExtensions: textExtensions);
        if (files.isEmpty) return null;
        final file = files.first;
        return (await extractText(file.name, await file.readAsBytes()), file.name);
      });

  Future<void> _importPhotos({required bool camera}) async {
    final l = L.of(context);
    if (!imageOcrSupports(_language!)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l.photoAlphabet)));
      return;
    }
    await _import(() async {
      final picker = ImagePicker();
      final images = camera
          ? [?await picker.pickImage(source: ImageSource.camera)]
          : await picker.pickMultiImage();
      if (images.isEmpty) return null;
      return (await extractImageText([for (final i in images) i.path]), null);
    });
  }

  Future<void> _continue() async {
    final state = AppScope.of(context);
    final l = L.of(context);
    final piece = const ScriptParser().parse(
      text: _text.text,
      title: _title.text.trim().isEmpty ? l.appTitle : _title.text.trim(),
      kind: _kind,
      language: _language!,
    );
    await state.repository.save(piece);
    if (!mounted) return;
    await Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => EditorScreen(piece: piece, isNew: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    _language ??= defaultVoiceLanguageFor(Localizations.localeOf(context));
    final help = switch (_kind) {
      PieceKind.play => l.kindPlayHelp,
      PieceKind.poem => l.kindPoemHelp,
      PieceKind.speech => l.kindSpeechHelp,
    };

    return Scaffold(
      appBar: AppBar(title: Text(l.newPiece)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Segment düğmesi uzun etiketleri (ör. "Konuşma / sunum", Almanca)
          // kelime ortasından bölüyordu; çipler satıra sığmazsa alta geçer.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final (kind, label) in [
                (PieceKind.play, l.kindPlay),
                (PieceKind.poem, l.kindPoem),
                (PieceKind.speech, l.kindSpeech),
              ])
                ChoiceChip(
                  avatar: Icon(kindIcon(kind)),
                  label: Text(label),
                  selected: _kind == kind,
                  showCheckmark: false,
                  onSelected: (_) => setState(() => _kind = kind),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(help, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          TextField(
            controller: _title,
            decoration: InputDecoration(labelText: l.title, border: const OutlineInputBorder()),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _language,
            decoration: InputDecoration(labelText: l.voiceLanguage, border: const OutlineInputBorder()),
            items: [
              for (final e in voiceLanguages.entries)
                DropdownMenuItem(value: e.key, child: Text(e.value)),
            ],
            onChanged: (v) => setState(() => _language = v),
          ),
          const SizedBox(height: 12),
          // İçe aktarma: dosya (txt/pdf/docx/odt), galeri fotoğrafları
          // (birden çok sayfa) veya kamerayla çekim.
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: _reading ? null : _importFile,
                icon: const Icon(Icons.file_open_outlined),
                label: Text(l.importFile),
              ),
              OutlinedButton.icon(
                onPressed: _reading ? null : () => _importPhotos(camera: false),
                icon: const Icon(Icons.photo_library_outlined),
                label: Text(l.importPhoto),
              ),
              OutlinedButton.icon(
                onPressed: _reading ? null : () => _importPhotos(camera: true),
                icon: const Icon(Icons.photo_camera_outlined),
                label: Text(l.takePhoto),
              ),
            ],
          ),
          if (_reading) ...[
            const SizedBox(height: 12),
            Row(children: [
              const SizedBox.square(dimension: 18, child: CircularProgressIndicator(strokeWidth: 2)),
              const SizedBox(width: 12),
              Text(l.reading),
            ]),
          ],
          const SizedBox(height: 12),
          TextField(
            controller: _text,
            minLines: 10,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: l.pasteHint,
              border: const OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _text.text.trim().isEmpty || _reading ? null : _continue,
            child: Text(l.continueAction),
          ),
        ],
      ),
    );
  }
}
