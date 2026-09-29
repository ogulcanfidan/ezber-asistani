import 'dart:typed_data';

import 'package:pdfrx/pdfrx.dart';

/// PDF'te seçilebilir metin yok (taranmış sayfa resmi).
class ScannedPdfException implements Exception {}

/// PDF'teki metni telefonda (PDFium ile) çıkarır; dosya hiçbir yere
/// gönderilmez. Sayfa başlık/altlık ve numaraları sonra ScriptParser
/// tarafından temizlenir.
Future<String> extractPdfText(Uint8List bytes) async {
  await pdfrxFlutterInitialize();
  final doc = await PdfDocument.openData(
    bytes,
    sourceName: 'import-${DateTime.now().microsecondsSinceEpoch}',
  );
  try {
    final sb = StringBuffer();
    for (final page in doc.pages) {
      final text = await page.loadText();
      if (text != null) sb.writeln(text.fullText);
    }
    final result = sb.toString();
    if (result.replaceAll(RegExp(r'\s'), '').length < 20) throw ScannedPdfException();
    return result;
  } finally {
    await doc.dispose();
  }
}
