// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class LTr extends L {
  LTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Ezber Asistanı';

  @override
  String get library => 'Metinlerim';

  @override
  String get emptyLibrary =>
      'Henüz bir şey yok. Bir oyun, şiir veya konuşma ekleyip ezberlemeye başlayın.';

  @override
  String get newPiece => 'Yeni';

  @override
  String get kindPlay => 'Oyun / sahne';

  @override
  String get kindPoem => 'Şiir / Metin';

  @override
  String get kindSpeech => 'Konuşma / sunum';

  @override
  String get kindPlayHelp =>
      'Her repliği AD: replik şeklinde yazın. Sahne yönergelerini (parantez) içine alın. Senaryo biçimi de çalışır.';

  @override
  String get kindPoemHelp =>
      'Her satır ayrı bir adım olur. Şiir, şarkı, liste ve kelimesi kelimesine öğrenilecek her metin için.';

  @override
  String get kindSpeechHelp =>
      'Ayrı satırdaki her cümle veya paragraf bir adım olur. Sürenizi ve konuşma hızınızı takip edin.';

  @override
  String get title => 'Başlık';

  @override
  String get voiceLanguage => 'Seslendirme dili';

  @override
  String get pasteHint => 'Metninizi buraya yapıştırın veya yazın';

  @override
  String get importFile => 'Dosya aç (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'Bu dosya okunamadı. Lütfen düz metin (.txt) dosyası kullanın.';

  @override
  String get continueAction => 'Devam';

  @override
  String get reviewTitle => 'Satırları kontrol edin';

  @override
  String get reviewHelp =>
      'Satırı başka bir karaktere vermek için ada dokunun. Düzenlemek için metne dokunun. Diğer seçenekler için ⋮.';

  @override
  String get whoAmI => 'Hangi karaktersiniz?';

  @override
  String get whoAmIHelp =>
      'Çalışacağınız satırlar bu karakterin replikleri olur.';

  @override
  String get characters => 'Karakterler';

  @override
  String get direction => 'Yönerge';

  @override
  String get heading => 'Sahne';

  @override
  String get editLine => 'Metni düzenle';

  @override
  String get deleteLine => 'Sil';

  @override
  String get mergeWithPrevious => 'Üstteki satırla birleştir';

  @override
  String get makeDirection => 'Sahne yönergesi yap';

  @override
  String get makeHeading => 'Sahne başlığı yap';

  @override
  String get makeDialogue => 'Replik yap';

  @override
  String get addLineBelow => 'Altına satır ekle';

  @override
  String get assignTo => 'Bunu kim söylüyor?';

  @override
  String get newCharacter => 'Yeni karakter';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'Vazgeç';

  @override
  String get delete => 'Sil';

  @override
  String get rename => 'Yeniden adlandır';

  @override
  String get mergeInto => 'Şununla birleştir…';

  @override
  String get name => 'Ad';

  @override
  String get voice => 'Ses';

  @override
  String get pitch => 'Ses tonu';

  @override
  String get speed => 'Hız';

  @override
  String get testVoice => 'Dinle';

  @override
  String get defaultVoice => 'Varsayılan ses';

  @override
  String get testSentence => 'Merhaba! Sesim böyle olacak.';

  @override
  String get noVoices =>
      'Cihazınızda bu dil için ses bulunamadı. Android\'in metin okuma ayarlarından yükleyebilirsiniz.';

  @override
  String get rehearse => 'Prova';

  @override
  String get mode => 'Mod';

  @override
  String get modeListen => 'Dinle';

  @override
  String get modeListenHelp =>
      'Her şey sesli okunur. Metni tanımak için idealdir.';

  @override
  String get modeWait => 'Beni bekle';

  @override
  String get modeWaitHelp =>
      'Sıra size gelince durur. Repliğinizi söyleyin, sonra Devam\'a dokunun.';

  @override
  String get modeCheck => 'Beni kontrol et';

  @override
  String get modeCheckHelp =>
      'Repliğinizi söylemeniz için süre tanır, sonra kendinizi kontrol edebilmeniz için okur.';

  @override
  String get modeRun => 'Akış';

  @override
  String get modeRunHelp =>
      'Repliğiniz için süre tanır ve okumadan devam eder.';

  @override
  String get hint => 'Repliğimi göster';

  @override
  String get hintFull => 'Tam metin';

  @override
  String get hintFirst => 'Baş harfler';

  @override
  String get hintHidden => 'Gizli';

  @override
  String get readDirections => 'Sahne yönergelerini sesli oku';

  @override
  String get pauseLength => 'Replik süresi';

  @override
  String get yourTurn => 'Sıra sizde';

  @override
  String get show => 'Göster';

  @override
  String get play => 'Başlat';

  @override
  String get pause => 'Duraklat';

  @override
  String get previousLine => 'Önceki satır';

  @override
  String get nextLine => 'Sonraki satır';

  @override
  String get jumpToScene => 'Sahneye git';

  @override
  String get fromStart => 'En baştan';

  @override
  String get finished => 'Prova tamamlandı.';

  @override
  String get restart => 'Baştan başla';

  @override
  String get settings => 'Ayarlar';

  @override
  String get appLanguage => 'Uygulama dili';

  @override
  String get systemDefault => 'Sistem varsayılanı';

  @override
  String get backup => 'Tüm metinleri yedekle';

  @override
  String get backupHelp =>
      'Telefon değiştirdiğinizde metinlerinizi kaybetmemek için bir yedek dosyası kaydedin.';

  @override
  String get restore => 'Yedekten geri yükle';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count metin geri yüklendi',
      one: '1 metin geri yüklendi',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'Bu dosya geçerli bir yedek değil.';

  @override
  String deleteConfirm(String title) {
    return '\"$title\" silinsin mi? Bu işlem geri alınamaz.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count satır',
      one: '1 satır',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Gizlilik';

  @override
  String get privacyText =>
      'Metinleriniz telefonunuzda kalır, hiçbir yere yüklenmez. Sesler telefonunuzun kendi metin okuma motoruyla, cihaz üzerinde üretilir. Fotoğraflardaki metin Google ML Kit ile telefonda okunur; fotoğraflar hiçbir yere gönderilmez, ancak ML Kit Google\'a anonim teşhis verisi (cihaz modeli, hata kodları gibi) gönderebilir. Eller serbest modda mikrofon yalnızca konuşmanızın bittiğini anlamak için anlık olarak telefonda kullanılır. \"Söylediğimi kontrol et\" açıksa konuşmanız telefonunuzun cihaz üzerindeki ses tanımasıyla yazıya çevrilir; uygulama hiçbir zaman çevrimiçi tanıma kullanmaz. Hiçbir şey kaydedilmez veya gönderilmez. \"Ezberden oku\" modunda konuşmanız, bir kez indirilen açık kaynak Whisper modeliyle yine telefonda yazıya çevrilir. Tek istisna \"Sesle kaydet\": yalnızca siz \"Kaydet\"e bastığınızda replikler kaydedilir; bu kayıtlar telefonda kalır, gönderilmez.';

  @override
  String get privacyPolicyFull => 'Gizlilik politikasının tamamı';

  @override
  String get appVersion => 'Sürüm';

  @override
  String get noMyCharacter =>
      'Provaya başlamadan önce en az bir karakteri kendiniz olarak seçin.';

  @override
  String get me => 'Ben';

  @override
  String get modeHandsFree => 'Eller serbest';

  @override
  String get modeHandsFreeHelp =>
      'Sıra size gelince dinler. Repliğinizi söyleyin, susunca devam eder. Takılırsanız repliğinizi size okur.';

  @override
  String get listening => 'Dinliyorum… repliğinizi söyleyin';

  @override
  String get micDenied =>
      'Eller serbest mod için mikrofon izni gerekiyor. \"Beni bekle\" moduna geçildi.';

  @override
  String get endSilence => 'Repliğimin bittiğini anlama süresi';

  @override
  String voiceN(int n) {
    return 'Ses $n';
  }

  @override
  String get linesHeader => 'Satırlar';

  @override
  String get pdfScanned =>
      'Bu PDF\'te seçilebilir metin yok (taranmış sayfa gibi görünüyor). \"Fotoğraftan\" ile resimden okuyabilir veya metni yapıştırabilirsiniz.';

  @override
  String get hintWord => 'İpucu';

  @override
  String get checkAccuracy => 'Söylediğimi kontrol et';

  @override
  String get checkAccuracyHelp =>
      'Konuşmanız telefonunuzun kendi ses tanımasıyla, cihaz üzerinde yazıya çevrilip repliğinizle karşılaştırılır. Hiçbir şey kaydedilmez, sesiniz telefondan çıkmaz.';

  @override
  String get sttUnavailable =>
      'Bu telefonda cihaz üzerinde ses tanıma yok, bu yüzden doğruluk kontrol edilemiyor. Eller serbest mod yine çalışır.';

  @override
  String get sttLanguageMissing =>
      'Telefonunuzda bu dil için cihaz üzerinde ses tanıma bulunmuyor.';

  @override
  String get sttDownload => 'Bu dil için ses tanıma paketini indir';

  @override
  String get sttDownloading =>
      'Dil paketi indiriliyor… Birkaç dakika sürebilir.';

  @override
  String get readCorrection => 'Yanlış söylersem doğrusunu oku';

  @override
  String accuracyScore(int score) {
    return '%$score doğru';
  }

  @override
  String missedWords(String words) {
    return 'Atlanan: $words';
  }

  @override
  String get notUnderstood => 'Anlaşılamadı';

  @override
  String summaryAccuracy(int score) {
    return 'Ortalama doğruluk %$score';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Suflör $count kez yardım etti',
      zero: 'Suflöre gerek kalmadı',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Tebrikler! Hiç yardım almadan bitirdiniz.';

  @override
  String get finishedGood => 'İyi gidiyor! Prova bitti.';

  @override
  String get finishedPractice =>
      'Prova bitti. Takıldığınız yerleri tekrar çalışın.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count replik',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'suflör $count replikte yardım etti',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count replik düzeltildi',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count replik anlaşılamadı',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'Fotoğraftan';

  @override
  String get takePhoto => 'Fotoğraf çek';

  @override
  String get reading => 'Okunuyor…';

  @override
  String get docOld =>
      'Eski Word (.doc) dosyaları okunamıyor. Belgeyi .docx veya PDF olarak kaydedip tekrar deneyin.';

  @override
  String get noTextInPhoto =>
      'Fotoğrafta okunabilir metin bulunamadı. Daha net, iyi ışıklı ve karşıdan çekilmiş bir fotoğraf deneyin.';

  @override
  String get photoAlphabet =>
      'Fotoğraftan okuma Kiril ve Arap alfabelerini desteklemiyor. Metni yazın veya yapıştırın.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count satırın kime ait olduğu anlaşılamadı. İşaretli satırlara dokunup düzeltin.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Satırı ikiye bölmek için Enter\'a basın.';

  @override
  String get charactersAndVoices => 'Karakterler ve sesler';

  @override
  String get hintProgressive => 'Kademeli';

  @override
  String get hintKeywords => 'Anahtar kelimeler';

  @override
  String hideRatio(int percent) {
    return 'Gizlenen kelimeler: %$percent';
  }

  @override
  String levelUp(int percent) {
    return 'Harika! Sonraki turda kelimelerin %$percent\'i gizlenecek.';
  }

  @override
  String get modeBuildUp => 'Üst üste ekle';

  @override
  String get modeBuildUpHelp =>
      'Önce 1. satır, sonra 1–2, sonra 1–3… Her yeni satır önce size okunur, sonra baştan hepsini söylersiniz. Şiir ve kısa metinler için idealdir.';

  @override
  String stepOf(int step, int total) {
    return 'Adım $step/$total';
  }

  @override
  String get onlyWeak => 'Sadece zorlandığım satırlar';

  @override
  String get onlyWeakHelp =>
      'Yalnızca suflör aldığınız, düzeltildiğiniz veya puanınızın düşük olduğu satırları çalışın.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Zorlandığınız $count satır',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Henüz zorlandığınız satır yok';

  @override
  String elapsed(String time) {
    return 'Süre $time';
  }

  @override
  String get targetTime => 'Hedef süre';

  @override
  String get targetNone => 'Hedef yok';

  @override
  String overTarget(String time) {
    return 'Hedefi $time aştınız';
  }

  @override
  String underTarget(String time) {
    return 'Hedefin $time altında';
  }

  @override
  String wpm(int wpm) {
    return 'Dakikada $wpm kelime';
  }

  @override
  String get proTitle => 'Ezber Pro';

  @override
  String get proPitch => 'Pro ile daha hızlı ezberleyin.';

  @override
  String get proFeatureHandsFree =>
      'Eller serbest prova: sıra size gelince dinler, telefona dokunmanız gerekmez';

  @override
  String proFeatureUnlimited(int count) {
    return 'Sınırsız metin (ücretsiz sürümde $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days gün ücretsiz, sonra $price/ay';
  }

  @override
  String proPrice(String price) {
    return '$price/ay';
  }

  @override
  String get proStartTrial => 'Ücretsiz denemeyi başlat';

  @override
  String get proSubscribe => 'Abone ol';

  @override
  String get proRestore => 'Satın alımları geri yükle';

  @override
  String get proTerms =>
      'Abonelik her ay otomatik yenilenir. İstediğiniz zaman Google Play > Abonelikler bölümünden iptal edebilirsiniz; iptal ederseniz dönem sonuna kadar Pro kalırsınız.';

  @override
  String get proUnavailable =>
      'Abonelik şu anda kullanılamıyor. Daha sonra tekrar deneyin.';

  @override
  String get proActive => 'Pro etkin';

  @override
  String get proManage => 'Aboneliği yönet';

  @override
  String get proUpgrade => 'Pro\'ya geç';

  @override
  String proLimitReached(int count) {
    return 'Ücretsiz sürümde en fazla $count metin kaydedebilirsiniz.';
  }

  @override
  String get proThanks => 'Teşekkürler! Pro etkin.';

  @override
  String get proHandsFreeLocked =>
      'Eller serbest prova Pro özelliğidir. \"Beni bekle\" moduna geçildi.';

  @override
  String get proNotFound => 'Etkin abonelik bulunamadı.';

  @override
  String get modePages => 'Sayfa sayfa sunum';

  @override
  String get modePagesHelp =>
      '\"Sayfa 1\" der, süre dolunca \"Süre doldu. Sayfa 2\" diye geçer. Metne bakmadan anlatın; erken bitirince \"Sonraki sayfa\"ya basın.';

  @override
  String pageCue(int n) {
    return 'Sayfa $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Sayfa $n. $title';
  }

  @override
  String get timeUp => 'Süre doldu.';

  @override
  String get presentationDone => 'Sunum bitti.';

  @override
  String get nextPage => 'Sonraki sayfa';

  @override
  String get pageTimes => 'Sayfa süreleri';

  @override
  String get pageTimesHelp =>
      'Sayfalar metindeki başlıklardan, başlık yoksa paragraflardan oluşur.';

  @override
  String get pageTimesAuto => 'Otomatik dağıt';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'S$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Sayfa $n/$total';
  }

  @override
  String get emotion => 'Ton';

  @override
  String get emotionHelp =>
      'Sesin hızı, perdesi ve yüksekliği bu duyguya göre ayarlanır. Metindeki (öfkeyle), (ağlayarak) gibi yönergeler otomatik algılanır.';

  @override
  String get emoNeutral => 'Normal';

  @override
  String get emoHappy => 'Neşeli';

  @override
  String get emoSad => 'Üzgün';

  @override
  String get emoAngry => 'Öfkeli';

  @override
  String get emoExcited => 'Heyecanlı';

  @override
  String get emoCalm => 'Sakin';

  @override
  String get emoWhisper => 'Fısıltı';

  @override
  String get emoAfraid => 'Korkmuş';

  @override
  String get modeRecite => 'Ezberden oku (hata kontrolü)';

  @override
  String get modeReciteHelp =>
      'Metni ezberden söyleyin; atladığınız veya yanlış söylediğiniz yerde durur ve hatayı gösterir. Sonunda rapor verir.';

  @override
  String get reciteTitle => 'Ezberden oku';

  @override
  String get reciteModelTitle => 'Konuşma tanıma modeli';

  @override
  String get reciteModelHelp =>
      'Hata kontrolü için telefonda çalışan bir konuşma tanıma modeli bir kez indirilir. Ücretsizdir; sesiniz telefondan çıkmaz. Wi-Fi önerilir.';

  @override
  String reciteModelStandard(int mb) {
    return 'Standart ($mb MB) — hızlı';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Yüksek doğruluk ($mb MB) — daha yavaş';
  }

  @override
  String get reciteDownload => 'İndir';

  @override
  String reciteDownloading(int pct) {
    return 'İndiriliyor… %$pct';
  }

  @override
  String get reciteDownloadFailed =>
      'İndirme başarısız. Bağlantınızı kontrol edip tekrar deneyin.';

  @override
  String get reciteLoading => 'Model yükleniyor…';

  @override
  String get reciteStart => 'Başla';

  @override
  String get reciteListening => 'Dinliyorum… Metni baştan söyleyin.';

  @override
  String get reciteChecking => 'Kontrol ediliyor…';

  @override
  String reciteHeard(String text) {
    return 'Duyduğum: $text';
  }

  @override
  String get reciteSkipped => 'Bir kısmı atladınız';

  @override
  String get reciteWrong => 'Yanlış söylediniz';

  @override
  String reciteExpected(String text) {
    return 'Doğrusu: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Sizin söylediğiniz: $text';
  }

  @override
  String get reciteContinueHere => 'Buradan devam et';

  @override
  String get reciteFinish => 'Bitir';

  @override
  String reciteAccuracy(int n) {
    return 'Doğruluk: %$n';
  }

  @override
  String get reciteNoErrors => 'Hiç hata yok, harika!';

  @override
  String reciteMinor(int n) {
    return '$n küçük atlama (kısa kelime)';
  }

  @override
  String get reciteAgain => 'Tekrar';

  @override
  String get reciteNote =>
      'Tanıma kusursuz değildir; emin olamadığı yerde sizi durdurabilir.';

  @override
  String get reciteLoadFailed =>
      'Model açılamadı. Silip yeniden indirmeyi deneyin.';

  @override
  String get recordLines => 'Sesle kaydet';

  @override
  String get recordLinesHelp =>
      'Karşı replikleri kendi sesinizle ya da bir arkadaşınızın sesiyle kaydedin; provada yapay ses yerine bu kayıtlar çalınır, duygu gerçek olur. Kayıtlar yalnızca telefonda saklanır ve yedeğe dahil değildir.';

  @override
  String get recordStart => 'Kaydet';

  @override
  String get recordStop => 'Durdur';

  @override
  String get recordPlay => 'Dinle';

  @override
  String get recordDelete => 'Kaydı sil';

  @override
  String get recordNext => 'Sonraki';

  @override
  String get recordPrev => 'Önceki';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total replik kaydedildi';
  }

  @override
  String get recordIncludeMine => 'Kendi repliklerimi de göster';

  @override
  String get recordNone => 'Kaydedilecek replik yok.';

  @override
  String get recordingNow => 'Kaydediliyor…';

  @override
  String get recordedBadge => 'Kayıtlı';
}
