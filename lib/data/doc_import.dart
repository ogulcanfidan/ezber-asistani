import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'pdf_import.dart';

/// Desteklenmeyen eski format (ör. .doc): kullanıcıya dönüştürmesi söylenir.
class UnsupportedFormatException implements Exception {}

/// Fotoğrafta okunabilir metin bulunamadı.
class NoTextInImageException implements Exception {}

const textExtensions = ['txt', 'pdf', 'docx', 'odt', 'doc'];
const imageExtensions = ['jpg', 'jpeg', 'png', 'webp', 'heic', 'bmp'];

/// Dosyanın türüne göre metnini çıkarır; her şey telefonda yapılır.
Future<String> extractText(String fileName, Uint8List bytes) async {
  final name = fileName.toLowerCase();
  if (name.endsWith('.pdf') || _startsWith(bytes, '%PDF')) return extractPdfText(bytes);
  if (name.endsWith('.docx')) return extractDocxText(bytes);
  if (name.endsWith('.odt')) return extractOdtText(bytes);
  if (name.endsWith('.doc') || _isOleCompound(bytes)) throw UnsupportedFormatException();
  return decodeText(bytes);
}

bool _startsWith(Uint8List b, String magic) =>
    b.length >= magic.length && String.fromCharCodes(b.take(magic.length)) == magic;

/// Eski Word (.doc) ikili biçimi: D0 CF 11 E0.
bool _isOleCompound(Uint8List b) =>
    b.length > 4 && b[0] == 0xD0 && b[1] == 0xCF && b[2] == 0x11 && b[3] == 0xE0;

/// Word (.docx): zip içindeki word/document.xml. Her paragraf bir satır.
String extractDocxText(List<int> bytes) {
  final xml = _zipEntry(bytes, 'word/document.xml');
  final out = StringBuffer();
  for (final p in RegExp(r'<w:p[ >].*?</w:p>|<w:p/>', dotAll: true).allMatches(xml)) {
    final para = p[0]!;
    final sb = StringBuffer();
    for (final m in RegExp(r'<w:t(?: [^>]*)?>(.*?)</w:t>|<w:tab/>|<w:br(?: [^>]*)?/>|<w:cr/>', dotAll: true)
        .allMatches(para)) {
      final token = m[0]!;
      if (token.startsWith('<w:tab')) {
        sb.write(' ');
      } else if (token.startsWith('<w:br') || token.startsWith('<w:cr')) {
        sb.write('\n');
      } else {
        sb.write(_unescape(m[1]!));
      }
    }
    out.writeln(sb);
  }
  return out.toString();
}

/// OpenDocument (.odt): content.xml içindeki paragraf ve başlıklar.
String extractOdtText(List<int> bytes) {
  final xml = _zipEntry(bytes, 'content.xml');
  final body = RegExp(r'<office:text[^>]*>(.*)</office:text>', dotAll: true).firstMatch(xml)?[1] ?? xml;
  final out = StringBuffer();
  for (final p in RegExp(r'<text:(p|h)(?: [^>]*)?(?:/>|>(.*?)</text:\1>)', dotAll: true).allMatches(body)) {
    final inner = (p[2] ?? '')
        .replaceAll(RegExp(r'<text:line-break\s*/>'), '\n')
        .replaceAll(RegExp(r'<text:tab\s*/>'), ' ')
        .replaceAllMapped(RegExp(r'<text:s(?: text:c="(\d+)")?\s*/>'), (m) => ' ' * int.parse(m[1] ?? '1'))
        .replaceAll(RegExp(r'<[^>]+>'), '');
    out.writeln(_unescape(inner));
  }
  return out.toString();
}

String _zipEntry(List<int> bytes, String name) {
  final Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(bytes);
  } catch (_) {
    throw const FormatException('not a zip');
  }
  final file = archive.findFile(name);
  if (file == null) throw const FormatException('entry missing');
  return utf8.decode(file.content, allowMalformed: true);
}

String _unescape(String s) => s
    .replaceAllMapped(RegExp(r'&#x([0-9a-fA-F]+);'), (m) => String.fromCharCode(int.parse(m[1]!, radix: 16)))
    .replaceAllMapped(RegExp(r'&#(\d+);'), (m) => String.fromCharCode(int.parse(m[1]!)))
    .replaceAll('&lt;', '<')
    .replaceAll('&gt;', '>')
    .replaceAll('&quot;', '"')
    .replaceAll('&apos;', "'")
    .replaceAll('&amp;', '&');

/// UTF-8 (BOM'lu/BOM'suz), UTF-16 ve eski tek baytlık kodlamalarla kaydedilmiş
/// dosyaları okur. Rakipte uzun tire gibi karakterler "garip karakterlere"
/// dönüşüyordu; bunun sebebi yanlış kodlama tahminiydi.
String decodeText(List<int> bytes) {
  if (bytes.length >= 2 && bytes[0] == 0xFF && bytes[1] == 0xFE) {
    return _utf16(bytes.sublist(2), littleEndian: true);
  }
  if (bytes.length >= 2 && bytes[0] == 0xFE && bytes[1] == 0xFF) {
    return _utf16(bytes.sublist(2), littleEndian: false);
  }
  var start = 0;
  if (bytes.length >= 3 && bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF) start = 3;
  try {
    return utf8.decode(bytes.sublist(start));
  } on FormatException {
    return latin1.decode(bytes);
  }
}

String _utf16(List<int> b, {required bool littleEndian}) {
  final units = <int>[];
  for (var i = 0; i + 1 < b.length; i += 2) {
    units.add(littleEndian ? b[i] | (b[i + 1] << 8) : (b[i] << 8) | b[i + 1]);
  }
  return String.fromCharCodes(units);
}

/// Fotoğraf(lar)daki metni Google ML Kit ile TELEFONDA okur. Yalnızca Latin
/// alfabesi (Türkçe, İngilizce, Almanca, Fransızca, İspanyolca, Portekizce,
/// İtalyanca, Endonezce); Kiril ve Arap alfabesi ML Kit'te yok.
Future<String> extractImageText(List<String> paths) async {
  final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
  try {
    final pages = <String>[];
    for (final path in paths) {
      final result = await recognizer.processImage(InputImage.fromFilePath(path));
      // Satırları yukarıdan aşağıya, soldan sağa sırala (iki sütunlu
      // sayfalarda blok sırası karışabiliyor).
      final lines = [for (final b in result.blocks) ...b.lines]
        ..sort((a, b) {
          final dy = a.boundingBox.top - b.boundingBox.top;
          if (dy.abs() > a.boundingBox.height / 2) return dy.sign.toInt();
          return (a.boundingBox.left - b.boundingBox.left).sign.toInt();
        });
      pages.add(lines.map((l) => l.text).join('\n'));
    }
    final text = pages.join('\n');
    if (text.replaceAll(RegExp(r'\s'), '').length < 5) throw NoTextInImageException();
    return text;
  } finally {
    await recognizer.close();
  }
}

/// Fotoğraftan okuma bu dilin alfabesini destekliyor mu.
bool imageOcrSupports(String language) =>
    !const {'ru', 'ar'}.contains(language.split(RegExp('[-_]')).first.toLowerCase());
