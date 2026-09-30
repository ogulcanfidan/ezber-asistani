# Ezber Asistanı: Replik, Sunum, Şiir

Tiyatro repliği, şiir ve sunum ezberlemek için bir prova uygulaması. Metni
sesli okur, sıra sana gelince dinler, takıldığında suflör gibi yardım eder.
Her şey telefonda çalışır; hesap yok, reklam yok.

İngilizce adı: *Memorize: Lines, Speech, Poems*.

## Özellikler

- TXT, PDF, Word ve fotoğraftan metin aktarma; karakterler ve replikler
  otomatik ayrılır
- Eller serbest prova: sıra sende dinler, susunca devam eder
- Kademeli suflör: önce ilk kelimeler, gerekirse repliğin tamamı
- Ezberden okuma: atlanan ya da yanlış söylenen yerde durur, sonda rapor
  (telefonda çalışan Whisper)
- Şiir için üst üste ekleme ve kademeli silme, zorlanılan satırları çalışma
- Sunumda sayfa sayfa süre, hedef süre ve konuşma hızı
- Her karaktere ayrı ses, replik tonu, istenirse kendi sesinle kayıt
- Aylık abonelik (Pro); reklam yok
- 14 dilde arayüz

Flutter ile yazılmış bir Android uygulaması.

## Geliştirme

```bash
flutter pub get
flutter test
flutter run
flutter build appbundle --release                              # abonelikli sürüm
flutter build appbundle --release --dart-define=PRO_UNLOCKED=true  # test sürümü
```

İmzalı derleme için `android/key.properties` ve yükleme anahtarı gerekir;
ikisi de depoya girmez (`android/key.properties.example`'a bakın).
