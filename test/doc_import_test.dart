import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:ezber_asistani/core/models.dart';
import 'package:ezber_asistani/core/script_parser.dart';
import 'package:ezber_asistani/data/doc_import.dart';
import 'package:flutter_test/flutter_test.dart';

Uint8List zip(Map<String, String> files) {
  final a = Archive();
  files.forEach((name, content) {
    final bytes = utf8.encode(content);
    a.addFile(ArchiveFile(name, bytes.length, bytes));
  });
  return Uint8List.fromList(ZipEncoder().encode(a));
}

void main() {
  test('Word (.docx): paragraflar satır, bölünmüş "run"lar birleşir, XML kaçışları çözülür', () async {
    const xml = '''<?xml version="1.0" encoding="UTF-8"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:body>
<w:p><w:r><w:t>BİRİNCİ PERDE</w:t></w:r></w:p>
<w:p><w:r><w:rPr><w:b/></w:rPr><w:t>AHMET</w:t></w:r><w:r><w:t xml:space="preserve">: Nereye </w:t></w:r><w:r><w:t>gidiyorsun?</w:t></w:r></w:p>
<w:p/>
<w:p><w:r><w:t>ZEYNEP: Tom &amp; Jerry&apos;yi izlemeye &lt;dışarı&gt;.</w:t></w:r></w:p>
</w:body></w:document>''';
    final text = await extractText('oyun.docx', zip({'word/document.xml': xml}));
    expect(text.split('\n').where((l) => l.isNotEmpty), [
      'BİRİNCİ PERDE',
      'AHMET: Nereye gidiyorsun?',
      "ZEYNEP: Tom & Jerry'yi izlemeye <dışarı>.",
    ]);
    final p = const ScriptParser().parse(text: text, title: 't', kind: PieceKind.play, language: 'tr-TR');
    expect(p.characters.map((c) => c.name), ['AHMET', 'ZEYNEP']);
  });

  test('OpenDocument (.odt): paragraf, başlık, satır sonu ve boşluklar', () async {
    const xml = '''<?xml version="1.0" encoding="UTF-8"?>
<office:document-content><office:body><office:text>
<text:h text:outline-level="1">Birinci Sahne</text:h>
<text:p text:style-name="P1">AHMET: Merhaba<text:s text:c="2"/>dostum.</text:p>
<text:p>Şiirin ilk dizesi<text:line-break/>ikinci dizesi</text:p>
</office:text></office:body></office:document-content>''';
    final text = await extractText('metin.odt', zip({'content.xml': xml}));
    expect(text.split('\n').where((l) => l.isNotEmpty),
        ['Birinci Sahne', 'AHMET: Merhaba  dostum.', 'Şiirin ilk dizesi', 'ikinci dizesi']);
  });

  test('eski Word (.doc) açıkça reddedilir', () {
    final doc = Uint8List.fromList([0xD0, 0xCF, 0x11, 0xE0, 0xA1, 0xB1, 0x1A, 0xE1]);
    expect(() => extractText('eski.doc', doc), throwsA(isA<UnsupportedFormatException>()));
    expect(() => extractText('adsiz', doc), throwsA(isA<UnsupportedFormatException>()));
  });

  test('bozuk .docx', () {
    expect(() => extractText('bozuk.docx', Uint8List.fromList([1, 2, 3])), throwsFormatException);
  });

  test('düz metin kodlamaları', () async {
    expect(await extractText('a.txt', Uint8List.fromList([0xEF, 0xBB, 0xBF, ...utf8.encode('Şiir — uzun tire')])),
        'Şiir — uzun tire');
    expect(decodeText([0xFF, 0xFE, 0x5E, 0x01, 0x69, 0x00]), 'Şi');
    expect(decodeText([0x63, 0x61, 0x66, 0xE9]), 'café');
  });

  test('fotoğraftan okuma: Kiril ve Arap alfabesi desteklenmez', () {
    expect(imageOcrSupports('tr-TR'), isTrue);
    expect(imageOcrSupports('id-ID'), isTrue);
    expect(imageOcrSupports('ru-RU'), isFalse);
    expect(imageOcrSupports('ar-SA'), isFalse);
  });
}
