// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class LId extends L {
  LId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'Asisten Hafalan';

  @override
  String get library => 'Teks saya';

  @override
  String get emptyLibrary =>
      'Belum ada apa-apa. Tambahkan naskah drama, puisi, atau pidato lalu mulai menghafal.';

  @override
  String get newPiece => 'Baru';

  @override
  String get kindPlay => 'Drama / adegan';

  @override
  String get kindPoem => 'Puisi / teks';

  @override
  String get kindSpeech => 'Pidato / presentasi';

  @override
  String get kindPlayHelp =>
      'Tulis setiap dialog sebagai NAMA: dialog. Taruh petunjuk panggung di dalam (kurung). Format skenario juga bisa.';

  @override
  String get kindPoemHelp =>
      'Setiap baris menjadi satu langkah. Untuk puisi, lagu, daftar, dan teks apa pun yang harus dihafal kata demi kata.';

  @override
  String get kindSpeechHelp =>
      'Setiap kalimat atau paragraf di baris tersendiri menjadi satu langkah. Pantau waktu dan kecepatan bicara Anda.';

  @override
  String get title => 'Judul';

  @override
  String get voiceLanguage => 'Bahasa suara';

  @override
  String get pasteHint => 'Tempel atau ketik teks Anda di sini';

  @override
  String get importFile => 'Buka file (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'File ini tidak dapat dibaca. Gunakan file teks biasa (.txt).';

  @override
  String get continueAction => 'Lanjut';

  @override
  String get reviewTitle => 'Periksa baris';

  @override
  String get reviewHelp =>
      'Ketuk nama untuk memberikan baris ke tokoh lain. Ketuk teks untuk mengeditnya. Opsi lain di ⋮.';

  @override
  String get whoAmI => 'Tokoh mana yang Anda perankan?';

  @override
  String get whoAmIHelp => 'Anda akan berlatih dialog tokoh ini.';

  @override
  String get characters => 'Tokoh';

  @override
  String get direction => 'Petunjuk panggung';

  @override
  String get heading => 'Adegan';

  @override
  String get editLine => 'Edit teks';

  @override
  String get deleteLine => 'Hapus';

  @override
  String get mergeWithPrevious => 'Gabungkan dengan baris di atas';

  @override
  String get makeDirection => 'Jadikan petunjuk panggung';

  @override
  String get makeHeading => 'Jadikan judul adegan';

  @override
  String get makeDialogue => 'Jadikan dialog';

  @override
  String get addLineBelow => 'Tambah baris di bawah';

  @override
  String get assignTo => 'Siapa yang mengatakan ini?';

  @override
  String get newCharacter => 'Tokoh baru';

  @override
  String get save => 'Simpan';

  @override
  String get cancel => 'Batal';

  @override
  String get delete => 'Hapus';

  @override
  String get rename => 'Ganti nama';

  @override
  String get mergeInto => 'Gabungkan dengan…';

  @override
  String get name => 'Nama';

  @override
  String get voice => 'Suara';

  @override
  String get pitch => 'Nada';

  @override
  String get speed => 'Kecepatan';

  @override
  String get testVoice => 'Dengarkan';

  @override
  String get defaultVoice => 'Suara bawaan';

  @override
  String get testSentence => 'Halo! Beginilah suara saya.';

  @override
  String get noVoices =>
      'Tidak ada suara untuk bahasa ini di perangkat Anda. Anda bisa memasangnya di pengaturan teks-ke-ucapan Android.';

  @override
  String get rehearse => 'Latihan';

  @override
  String get mode => 'Mode';

  @override
  String get modeListen => 'Dengarkan';

  @override
  String get modeListenHelp => 'Semuanya dibacakan. Cocok untuk mengenal teks.';

  @override
  String get modeWait => 'Tunggu saya';

  @override
  String get modeWaitHelp =>
      'Berhenti di dialog Anda. Ucapkan, lalu ketuk Lanjut.';

  @override
  String get modeCheck => 'Periksa saya';

  @override
  String get modeCheckHelp =>
      'Memberi waktu untuk mengucapkan dialog Anda, lalu membacakannya agar Anda bisa memeriksa diri.';

  @override
  String get modeRun => 'Gladi';

  @override
  String get modeRunHelp =>
      'Memberi waktu untuk dialog Anda dan lanjut tanpa membacakannya.';

  @override
  String get hint => 'Tampilkan dialog saya sebagai';

  @override
  String get hintFull => 'Teks lengkap';

  @override
  String get hintFirst => 'Huruf pertama';

  @override
  String get hintHidden => 'Tersembunyi';

  @override
  String get readDirections => 'Bacakan petunjuk panggung';

  @override
  String get pauseLength => 'Waktu untuk dialog saya';

  @override
  String get yourTurn => 'Giliran Anda';

  @override
  String get show => 'Tampilkan';

  @override
  String get play => 'Mulai';

  @override
  String get pause => 'Jeda';

  @override
  String get previousLine => 'Baris sebelumnya';

  @override
  String get nextLine => 'Baris berikutnya';

  @override
  String get jumpToScene => 'Lompat ke adegan';

  @override
  String get fromStart => 'Dari awal';

  @override
  String get finished => 'Latihan selesai.';

  @override
  String get restart => 'Mulai lagi';

  @override
  String get settings => 'Pengaturan';

  @override
  String get appLanguage => 'Bahasa aplikasi';

  @override
  String get systemDefault => 'Bawaan sistem';

  @override
  String get backup => 'Cadangkan semua teks';

  @override
  String get backupHelp =>
      'Simpan file cadangan agar teks Anda tidak hilang saat berganti ponsel.';

  @override
  String get restore => 'Pulihkan dari cadangan';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count teks dipulihkan',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'File ini bukan cadangan yang valid.';

  @override
  String deleteConfirm(String title) {
    return 'Hapus \"$title\"? Tindakan ini tidak bisa dibatalkan.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baris',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Privasi';

  @override
  String get privacyText =>
      'Teks Anda tetap di ponsel dan tidak diunggah ke mana pun. Suara dihasilkan di perangkat oleh mesin teks-ke-ucapan ponsel Anda. Teks dalam foto dibaca di perangkat dengan Google ML Kit; foto tidak dikirim, tetapi ML Kit dapat mengirim data diagnostik anonim ke Google (seperti model perangkat dan kode kesalahan). Dalam mode tanpa tangan, mikrofon hanya digunakan di perangkat dan secara langsung untuk mengetahui kapan Anda selesai berbicara. Jika Anda menyalakan \"Periksa ucapan saya\", ucapan Anda diubah menjadi teks oleh pengenalan suara ponsel di perangkat; aplikasi tidak pernah memakai pengenalan daring. Tidak ada yang direkam atau dikirim. Dalam mode \"Hafalan tanpa teks\", ucapan Anda ditranskripsi di ponsel oleh model sumber terbuka Whisper yang diunduh sekali. Satu-satunya pengecualian adalah \"Rekam suara\": dialog hanya direkam saat Anda mengetuk \"Rekam\", dan rekaman tetap di ponsel serta tidak pernah dikirim.';

  @override
  String get privacyPolicyFull => 'Kebijakan privasi lengkap';

  @override
  String get appVersion => 'Versi';

  @override
  String get noMyCharacter =>
      'Pilih setidaknya satu tokoh sebagai peran Anda sebelum berlatih.';

  @override
  String get me => 'Saya';

  @override
  String get modeHandsFree => 'Tanpa tangan';

  @override
  String get modeHandsFreeHelp =>
      'Mendengarkan saat giliran Anda. Ucapkan dialog Anda; saat Anda berhenti bicara, latihan berlanjut. Jika Anda lupa, dialog Anda akan dibacakan.';

  @override
  String get listening => 'Mendengarkan… ucapkan dialog Anda';

  @override
  String get micDenied =>
      'Mode tanpa tangan memerlukan izin mikrofon. Beralih ke \"Tunggu saya\".';

  @override
  String get endSilence => 'Jeda yang mengakhiri dialog saya';

  @override
  String voiceN(int n) {
    return 'Suara $n';
  }

  @override
  String get linesHeader => 'Baris';

  @override
  String get pdfScanned =>
      'PDF ini tidak berisi teks yang bisa dipilih (tampak seperti halaman hasil pindai). Gunakan \"Dari foto\" untuk membacanya dari gambar, atau tempel teksnya.';

  @override
  String get hintWord => 'Petunjuk';

  @override
  String get checkAccuracy => 'Periksa ucapan saya';

  @override
  String get checkAccuracyHelp =>
      'Ucapan Anda diubah menjadi teks oleh pengenalan suara ponsel langsung di perangkat, lalu dibandingkan dengan dialog Anda. Tidak ada yang direkam dan suara Anda tidak keluar dari ponsel.';

  @override
  String get sttUnavailable =>
      'Ponsel ini tidak memiliki pengenalan suara di perangkat, jadi ketepatan tidak dapat diperiksa. Mode tanpa tangan tetap berfungsi.';

  @override
  String get sttLanguageMissing =>
      'Pengenalan suara di perangkat tidak tersedia untuk bahasa ini di ponsel Anda.';

  @override
  String get sttDownload => 'Unduh pengenalan suara untuk bahasa ini';

  @override
  String get sttDownloading =>
      'Mengunduh paket bahasa… Ini bisa memakan waktu beberapa menit.';

  @override
  String get readCorrection => 'Bacakan dialog yang benar jika saya salah';

  @override
  String accuracyScore(int score) {
    return '$score% benar';
  }

  @override
  String missedWords(String words) {
    return 'Terlewat: $words';
  }

  @override
  String get notUnderstood => 'Tidak terdengar jelas';

  @override
  String summaryAccuracy(int score) {
    return 'Rata-rata ketepatan $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count kali dibantu',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Hebat! Anda menyelesaikannya tanpa bantuan.';

  @override
  String get finishedGood => 'Bagus! Latihan selesai.';

  @override
  String get finishedPractice =>
      'Latihan selesai. Latih lagi bagian yang membuat Anda tersendat.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dialog',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'dibantu di $count dialog',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dialog dikoreksi',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count dialog tidak dipahami',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'Dari foto';

  @override
  String get takePhoto => 'Ambil foto';

  @override
  String get reading => 'Membaca…';

  @override
  String get docOld =>
      'File Word lama (.doc) tidak dapat dibaca. Simpan dokumen sebagai .docx atau PDF lalu coba lagi.';

  @override
  String get noTextInPhoto =>
      'Tidak ditemukan teks yang terbaca di foto. Coba foto yang lebih tajam, terang, dan diambil dari depan.';

  @override
  String get photoAlphabet =>
      'Membaca dari foto tidak mendukung aksara Sirilik dan Arab. Ketik atau tempel teksnya.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Tidak jelas siapa yang mengucapkan $count baris. Ketuk baris yang ditandai untuk memperbaikinya.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Tekan Enter untuk membagi baris menjadi dua.';

  @override
  String get charactersAndVoices => 'Tokoh dan suara';

  @override
  String get hintProgressive => 'Bertahap';

  @override
  String get hintKeywords => 'Kata kunci';

  @override
  String hideRatio(int percent) {
    return 'Kata tersembunyi: $percent%';
  }

  @override
  String levelUp(int percent) {
    return 'Hebat! Di putaran berikutnya $percent% kata akan disembunyikan.';
  }

  @override
  String get modeBuildUp => 'Bangun bertahap';

  @override
  String get modeBuildUpHelp =>
      'Mula-mula baris 1, lalu 1–2, lalu 1–3… Setiap baris baru dibacakan dulu, lalu Anda mengucapkan semuanya dari awal. Ideal untuk puisi dan teks pendek.';

  @override
  String stepOf(int step, int total) {
    return 'Langkah $step dari $total';
  }

  @override
  String get onlyWeak => 'Hanya baris yang sulit';

  @override
  String get onlyWeakHelp =>
      'Latih hanya baris yang membutuhkan bantuan, koreksi, atau mendapat nilai rendah.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count baris yang sulit',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Belum ada baris yang sulit';

  @override
  String elapsed(String time) {
    return 'Waktu $time';
  }

  @override
  String get targetTime => 'Target waktu';

  @override
  String get targetNone => 'Tanpa target';

  @override
  String overTarget(String time) {
    return '$time melewati target';
  }

  @override
  String underTarget(String time) {
    return '$time di bawah target';
  }

  @override
  String wpm(int wpm) {
    return '$wpm kata/menit';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Hafalkan lebih cepat dengan Pro.';

  @override
  String get proFeatureHandsFree =>
      'Latihan bebas genggam: mendengarkan saat giliran Anda, tanpa menyentuh ponsel';

  @override
  String proFeatureUnlimited(int count) {
    return 'Teks tanpa batas (versi gratis: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return 'Gratis $days hari, lalu $price/bulan';
  }

  @override
  String proPrice(String price) {
    return '$price/bulan';
  }

  @override
  String get proStartTrial => 'Mulai uji coba gratis';

  @override
  String get proSubscribe => 'Berlangganan';

  @override
  String get proRestore => 'Pulihkan pembelian';

  @override
  String get proTerms =>
      'Langganan diperpanjang otomatis setiap bulan. Batalkan kapan saja di Google Play > Langganan; jika dibatalkan, Pro tetap aktif hingga akhir periode.';

  @override
  String get proUnavailable =>
      'Langganan sedang tidak tersedia. Coba lagi nanti.';

  @override
  String get proActive => 'Pro aktif';

  @override
  String get proManage => 'Kelola langganan';

  @override
  String get proUpgrade => 'Beralih ke Pro';

  @override
  String proLimitReached(int count) {
    return 'Versi gratis dapat menyimpan hingga $count teks.';
  }

  @override
  String get proThanks => 'Terima kasih! Pro aktif.';

  @override
  String get proHandsFreeLocked =>
      'Latihan bebas genggam adalah fitur Pro. Beralih ke \"Tunggu saya\".';

  @override
  String get proNotFound => 'Tidak ada langganan aktif.';

  @override
  String get modePages => 'Per halaman';

  @override
  String get modePagesHelp =>
      'Mengucapkan \"Halaman 1\", lalu saat waktu habis \"Waktu habis. Halaman 2\". Bicaralah tanpa membaca; ketuk \"Halaman berikutnya\" jika selesai lebih cepat.';

  @override
  String pageCue(int n) {
    return 'Halaman $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Halaman $n. $title';
  }

  @override
  String get timeUp => 'Waktu habis.';

  @override
  String get presentationDone => 'Presentasi selesai.';

  @override
  String get nextPage => 'Halaman berikutnya';

  @override
  String get pageTimes => 'Waktu per halaman';

  @override
  String get pageTimesHelp =>
      'Halaman diambil dari judul di teks, atau dari paragraf jika tidak ada judul.';

  @override
  String get pageTimesAuto => 'Bagi otomatis';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'H$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Halaman $n/$total';
  }

  @override
  String get emotion => 'Nada';

  @override
  String get emotionHelp =>
      'Kecepatan, tinggi nada, dan volume disesuaikan dengan perasaan ini. Arahan seperti (marah) atau (menangis) dikenali otomatis.';

  @override
  String get emoNeutral => 'Normal';

  @override
  String get emoHappy => 'Gembira';

  @override
  String get emoSad => 'Sedih';

  @override
  String get emoAngry => 'Marah';

  @override
  String get emoExcited => 'Bersemangat';

  @override
  String get emoCalm => 'Tenang';

  @override
  String get emoWhisper => 'Berbisik';

  @override
  String get emoAfraid => 'Takut';

  @override
  String get modeRecite => 'Hafalan tanpa teks (cek kesalahan)';

  @override
  String get modeReciteHelp =>
      'Ucapkan teks dari hafalan; aplikasi berhenti di bagian yang terlewat atau salah dan menunjukkan kesalahannya. Di akhir ada laporan.';

  @override
  String get reciteTitle => 'Hafalan tanpa teks';

  @override
  String get reciteModelTitle => 'Model pengenalan suara';

  @override
  String get reciteModelHelp =>
      'Untuk cek kesalahan, model pengenalan suara yang berjalan di ponsel diunduh sekali. Gratis; suara Anda tidak keluar dari ponsel. Disarankan Wi-Fi.';

  @override
  String reciteModelStandard(int mb) {
    return 'Standar ($mb MB) — cepat';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Akurasi tinggi ($mb MB) — lebih lambat';
  }

  @override
  String get reciteDownload => 'Unduh';

  @override
  String reciteDownloading(int pct) {
    return 'Mengunduh… $pct%';
  }

  @override
  String get reciteDownloadFailed =>
      'Unduhan gagal. Periksa koneksi lalu coba lagi.';

  @override
  String get reciteLoading => 'Memuat model…';

  @override
  String get reciteStart => 'Mulai';

  @override
  String get reciteListening => 'Mendengarkan… Ucapkan teks dari awal.';

  @override
  String get reciteChecking => 'Memeriksa…';

  @override
  String reciteHeard(String text) {
    return 'Yang saya dengar: $text';
  }

  @override
  String get reciteSkipped => 'Ada bagian yang terlewat';

  @override
  String get reciteWrong => 'Ucapan Anda salah';

  @override
  String reciteExpected(String text) {
    return 'Yang benar: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Anda mengucapkan: $text';
  }

  @override
  String get reciteContinueHere => 'Lanjut dari sini';

  @override
  String get reciteFinish => 'Selesai';

  @override
  String reciteAccuracy(int n) {
    return 'Akurasi: $n%';
  }

  @override
  String get reciteNoErrors => 'Tanpa kesalahan, hebat!';

  @override
  String reciteMinor(int n) {
    return '$n lewatan kecil (kata pendek)';
  }

  @override
  String get reciteAgain => 'Ulangi';

  @override
  String get reciteNote =>
      'Pengenalan tidak sempurna; bisa menghentikan Anda saat ragu.';

  @override
  String get reciteLoadFailed =>
      'Model tidak dapat dibuka. Hapus lalu unduh ulang.';

  @override
  String get recordLines => 'Rekam suara';

  @override
  String get recordLinesHelp =>
      'Rekam dialog tokoh lain dengan suara Anda atau suara teman; saat latihan rekaman ini diputar menggantikan suara sintetis, dengan emosi yang nyata. Rekaman hanya disimpan di ponsel dan tidak termasuk dalam cadangan.';

  @override
  String get recordStart => 'Rekam';

  @override
  String get recordStop => 'Berhenti';

  @override
  String get recordPlay => 'Dengarkan';

  @override
  String get recordDelete => 'Hapus rekaman';

  @override
  String get recordNext => 'Berikutnya';

  @override
  String get recordPrev => 'Sebelumnya';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total dialog direkam';
  }

  @override
  String get recordIncludeMine => 'Tampilkan juga dialog saya';

  @override
  String get recordNone => 'Tidak ada dialog untuk direkam.';

  @override
  String get recordingNow => 'Merekam…';

  @override
  String get recordedBadge => 'Direkam';
}
