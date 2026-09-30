// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class LHi extends L {
  LHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'याद सहायक';

  @override
  String get library => 'मेरे पाठ';

  @override
  String get emptyLibrary =>
      'अभी यहाँ कुछ नहीं है। कोई नाटक, कविता या भाषण जोड़ें और याद करना शुरू करें।';

  @override
  String get newPiece => 'नया';

  @override
  String get kindPlay => 'नाटक / दृश्य';

  @override
  String get kindPoem => 'कविता / पाठ';

  @override
  String get kindSpeech => 'भाषण / प्रस्तुति';

  @override
  String get kindPlayHelp =>
      'हर संवाद को नाम: संवाद के रूप में लिखें। मंच निर्देश (कोष्ठक) में रखें। पटकथा का प्रारूप भी चलता है।';

  @override
  String get kindPoemHelp =>
      'हर पंक्ति एक चरण बनती है। कविता, गीत, सूची और शब्दशः याद किए जाने वाले हर पाठ के लिए।';

  @override
  String get kindSpeechHelp =>
      'अलग पंक्ति में लिखा हर वाक्य या अनुच्छेद एक चरण बनता है। अपना समय और बोलने की गति देखें।';

  @override
  String get title => 'शीर्षक';

  @override
  String get voiceLanguage => 'आवाज़ की भाषा';

  @override
  String get pasteHint => 'अपना पाठ यहाँ चिपकाएँ या लिखें';

  @override
  String get importFile => 'फ़ाइल खोलें (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'यह फ़ाइल पढ़ी नहीं जा सकी। कृपया सादा टेक्स्ट (.txt) फ़ाइल इस्तेमाल करें।';

  @override
  String get continueAction => 'आगे बढ़ें';

  @override
  String get reviewTitle => 'पंक्तियाँ जाँचें';

  @override
  String get reviewHelp =>
      'संवाद किसी दूसरे पात्र को देने के लिए नाम पर टैप करें। बदलने के लिए पाठ पर टैप करें। और विकल्पों के लिए ⋮।';

  @override
  String get whoAmI => 'आप कौन-सा पात्र हैं?';

  @override
  String get whoAmIHelp => 'आप इसी पात्र के संवादों का अभ्यास करेंगे।';

  @override
  String get characters => 'पात्र';

  @override
  String get direction => 'निर्देश';

  @override
  String get heading => 'दृश्य';

  @override
  String get editLine => 'पाठ बदलें';

  @override
  String get deleteLine => 'हटाएँ';

  @override
  String get mergeWithPrevious => 'ऊपर की पंक्ति से जोड़ें';

  @override
  String get makeDirection => 'मंच निर्देश बनाएँ';

  @override
  String get makeHeading => 'दृश्य शीर्षक बनाएँ';

  @override
  String get makeDialogue => 'संवाद बनाएँ';

  @override
  String get addLineBelow => 'नीचे पंक्ति जोड़ें';

  @override
  String get assignTo => 'यह कौन बोलता है?';

  @override
  String get newCharacter => 'नया पात्र';

  @override
  String get save => 'सहेजें';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get delete => 'हटाएँ';

  @override
  String get rename => 'नाम बदलें';

  @override
  String get mergeInto => 'इसमें मिलाएँ…';

  @override
  String get name => 'नाम';

  @override
  String get voice => 'आवाज़';

  @override
  String get pitch => 'स्वर';

  @override
  String get speed => 'गति';

  @override
  String get testVoice => 'सुनें';

  @override
  String get defaultVoice => 'डिफ़ॉल्ट आवाज़';

  @override
  String get testSentence => 'नमस्ते! मेरी आवाज़ ऐसी सुनाई देगी।';

  @override
  String get noVoices =>
      'आपके डिवाइस पर इस भाषा की कोई आवाज़ नहीं मिली। आप इसे Android की टेक्स्ट-टू-स्पीच सेटिंग से इंस्टॉल कर सकते हैं।';

  @override
  String get rehearse => 'अभ्यास';

  @override
  String get mode => 'मोड';

  @override
  String get modeListen => 'सुनें';

  @override
  String get modeListenHelp =>
      'सब कुछ पढ़कर सुनाया जाता है। पाठ से परिचित होने के लिए अच्छा है।';

  @override
  String get modeWait => 'मेरा इंतज़ार करो';

  @override
  String get modeWaitHelp =>
      'आपकी बारी पर रुकता है। अपना संवाद बोलें, फिर आगे बढ़ें पर टैप करें।';

  @override
  String get modeCheck => 'मुझे जाँचो';

  @override
  String get modeCheckHelp =>
      'आपको संवाद बोलने का समय देता है, फिर उसे पढ़ता है ताकि आप खुद जाँच सकें।';

  @override
  String get modeRun => 'लगातार';

  @override
  String get modeRunHelp =>
      'आपके संवाद के लिए समय देता है और बिना पढ़े आगे बढ़ता है।';

  @override
  String get hint => 'मेरा संवाद ऐसे दिखाएँ';

  @override
  String get hintFull => 'पूरा पाठ';

  @override
  String get hintFirst => 'पहले अक्षर';

  @override
  String get hintHidden => 'छिपा हुआ';

  @override
  String get readDirections => 'मंच निर्देश पढ़कर सुनाएँ';

  @override
  String get pauseLength => 'मेरे संवाद का समय';

  @override
  String get yourTurn => 'आपकी बारी';

  @override
  String get show => 'दिखाएँ';

  @override
  String get play => 'शुरू करें';

  @override
  String get pause => 'रोकें';

  @override
  String get previousLine => 'पिछली पंक्ति';

  @override
  String get nextLine => 'अगली पंक्ति';

  @override
  String get jumpToScene => 'दृश्य पर जाएँ';

  @override
  String get fromStart => 'शुरू से';

  @override
  String get finished => 'अभ्यास पूरा हुआ।';

  @override
  String get restart => 'फिर से शुरू करें';

  @override
  String get settings => 'सेटिंग';

  @override
  String get appLanguage => 'ऐप की भाषा';

  @override
  String get systemDefault => 'सिस्टम डिफ़ॉल्ट';

  @override
  String get backup => 'सभी पाठों का बैकअप लें';

  @override
  String get backupHelp =>
      'बैकअप फ़ाइल सहेजें ताकि फ़ोन बदलने पर आपके पाठ न खोएँ।';

  @override
  String get restore => 'बैकअप से वापस लाएँ';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पाठ वापस लाए गए',
      one: '$count पाठ वापस लाया गया',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'यह फ़ाइल सही बैकअप नहीं है।';

  @override
  String deleteConfirm(String title) {
    return '\"$title\" हटाएँ? इसे वापस नहीं लाया जा सकता।';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पंक्तियाँ',
      one: '$count पंक्ति',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'निजता';

  @override
  String get privacyText =>
      'आपके पाठ आपके फ़ोन में ही रहते हैं और कहीं अपलोड नहीं होते। आवाज़ें आपके फ़ोन के टेक्स्ट-टू-स्पीच इंजन से, डिवाइस पर ही बनती हैं। फ़ोटो का पाठ Google ML Kit से फ़ोन पर ही पढ़ा जाता है; फ़ोटो कहीं नहीं भेजे जाते, लेकिन ML Kit, Google को गुमनाम डायग्नोस्टिक डेटा (जैसे डिवाइस मॉडल और एरर कोड) भेज सकता है। हैंड्स-फ़्री मोड में माइक्रोफ़ोन केवल डिवाइस पर, उसी समय, यह जानने के लिए इस्तेमाल होता है कि आपने बोलना पूरा कर लिया है। अगर आप \"मेरा बोला हुआ जाँचें\" चालू करते हैं, तो आपकी आवाज़ फ़ोन की ऑन-डिवाइस स्पीच रिकग्निशन से पाठ में बदली जाती है; ऐप कभी ऑनलाइन रिकग्निशन इस्तेमाल नहीं करता। कुछ भी रिकॉर्ड या भेजा नहीं जाता। \"ज़बानी सुनाएँ\" मोड में आपकी आवाज़ एक बार डाउनलोड किए गए ओपन-सोर्स Whisper मॉडल से फ़ोन पर ही पाठ में बदली जाती है। एकमात्र अपवाद \"आवाज़ रिकॉर्ड करें\" है: संवाद तभी रिकॉर्ड होते हैं जब आप \"रिकॉर्ड\" पर टैप करते हैं; ये रिकॉर्डिंग फ़ोन में रहती हैं और कहीं नहीं भेजी जातीं।';

  @override
  String get privacyPolicyFull => 'पूरी निजता नीति';

  @override
  String get appVersion => 'संस्करण';

  @override
  String get noMyCharacter =>
      'अभ्यास शुरू करने से पहले कम से कम एक पात्र को अपना चुनें।';

  @override
  String get me => 'मैं';

  @override
  String get modeHandsFree => 'हैंड्स-फ़्री';

  @override
  String get modeHandsFreeHelp =>
      'आपकी बारी आने पर सुनता है। अपना संवाद बोलें; आपके चुप होते ही आगे बढ़ता है। अटकने पर आपका संवाद पढ़कर सुनाता है।';

  @override
  String get listening => 'सुन रहा हूँ… अपना संवाद बोलें';

  @override
  String get micDenied =>
      'हैंड्स-फ़्री मोड के लिए माइक्रोफ़ोन की अनुमति चाहिए। \"मेरा इंतज़ार करो\" मोड चालू किया गया।';

  @override
  String get endSilence => 'कितनी चुप्पी पर संवाद पूरा माना जाए';

  @override
  String voiceN(int n) {
    return 'आवाज़ $n';
  }

  @override
  String get linesHeader => 'पंक्तियाँ';

  @override
  String get pdfScanned =>
      'इस PDF में चुनने लायक पाठ नहीं है (यह स्कैन किया हुआ पन्ना लगता है)। \"फ़ोटो से\" का इस्तेमाल करें या पाठ चिपकाएँ।';

  @override
  String get hintWord => 'संकेत';

  @override
  String get checkAccuracy => 'मेरा बोला हुआ जाँचें';

  @override
  String get checkAccuracyHelp =>
      'आपकी आवाज़ फ़ोन की अपनी स्पीच रिकग्निशन से, डिवाइस पर ही पाठ में बदलकर आपके संवाद से मिलाई जाती है। कुछ भी रिकॉर्ड नहीं होता और आपकी आवाज़ फ़ोन से बाहर नहीं जाती।';

  @override
  String get sttUnavailable =>
      'इस फ़ोन में ऑन-डिवाइस स्पीच रिकग्निशन नहीं है, इसलिए सटीकता जाँची नहीं जा सकती। हैंड्स-फ़्री मोड फिर भी चलता है।';

  @override
  String get sttLanguageMissing =>
      'आपके फ़ोन में इस भाषा के लिए ऑन-डिवाइस स्पीच रिकग्निशन उपलब्ध नहीं है।';

  @override
  String get sttDownload => 'इस भाषा की स्पीच रिकग्निशन डाउनलोड करें';

  @override
  String get sttDownloading =>
      'भाषा पैक डाउनलोड हो रहा है… इसमें कुछ मिनट लग सकते हैं।';

  @override
  String get readCorrection => 'गलत बोलने पर सही संवाद पढ़कर सुनाएँ';

  @override
  String accuracyScore(int score) {
    return '$score% सही';
  }

  @override
  String missedWords(String words) {
    return 'छूटा: $words';
  }

  @override
  String get notUnderstood => 'समझ नहीं आया';

  @override
  String summaryAccuracy(int score) {
    return 'औसत सटीकता $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'प्रॉम्प्टर ने $count बार मदद की',
      zero: 'प्रॉम्प्टर की ज़रूरत नहीं पड़ी',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'शाबाश! आपने बिना किसी मदद के पूरा किया।';

  @override
  String get finishedGood => 'अच्छा चल रहा है! अभ्यास पूरा हुआ।';

  @override
  String get finishedPractice =>
      'अभ्यास पूरा हुआ। जहाँ अटके थे, उन पंक्तियों का फिर अभ्यास करें।';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count संवाद',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count संवादों में मदद मिली',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count संवाद सुधारे गए',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count संवाद समझ नहीं आए',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'फ़ोटो से';

  @override
  String get takePhoto => 'फ़ोटो लें';

  @override
  String get reading => 'पढ़ा जा रहा है…';

  @override
  String get docOld =>
      'पुरानी Word फ़ाइलें (.doc) पढ़ी नहीं जा सकतीं। दस्तावेज़ को .docx या PDF के रूप में सहेजकर फिर कोशिश करें।';

  @override
  String get noTextInPhoto =>
      'फ़ोटो में पढ़ने लायक पाठ नहीं मिला। अच्छी रोशनी में, सामने से ली गई साफ़ फ़ोटो आज़माएँ।';

  @override
  String get photoAlphabet =>
      'फ़ोटो से पढ़ना केवल लैटिन लिपि के लिए काम करता है। पाठ लिखें या चिपकाएँ।';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          '$count पंक्तियाँ किसकी हैं, यह साफ़ नहीं था। चिह्नित पंक्तियों पर टैप करके ठीक करें।',
      one:
          '$count पंक्ति किसकी है, यह साफ़ नहीं था। चिह्नित पंक्ति पर टैप करके ठीक करें।',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'पंक्ति को दो हिस्सों में बाँटने के लिए Enter दबाएँ।';

  @override
  String get charactersAndVoices => 'पात्र और आवाज़ें';

  @override
  String get hintProgressive => 'क्रमशः';

  @override
  String get hintKeywords => 'मुख्य शब्द';

  @override
  String hideRatio(int percent) {
    return 'छिपे शब्द: $percent%';
  }

  @override
  String levelUp(int percent) {
    return 'बहुत बढ़िया! अगले दौर में $percent% शब्द छिपे होंगे।';
  }

  @override
  String get modeBuildUp => 'जोड़ते जाएँ';

  @override
  String get modeBuildUpHelp =>
      'पहले पंक्ति 1, फिर 1–2, फिर 1–3… हर नई पंक्ति पहले आपको सुनाई जाती है, फिर आप शुरू से सब बोलते हैं। कविता और छोटे पाठों के लिए बढ़िया।';

  @override
  String stepOf(int step, int total) {
    return 'चरण $step/$total';
  }

  @override
  String get onlyWeak => 'केवल वे पंक्तियाँ जिनमें मैं अटका';

  @override
  String get onlyWeakHelp =>
      'केवल उन पंक्तियों का अभ्यास करें जिनमें मदद लेनी पड़ी, सुधार हुआ या अंक कम रहे।';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count पंक्तियाँ जिनमें आप अटके',
      one: '$count पंक्ति जिसमें आप अटके',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'अभी कोई कठिन पंक्ति नहीं';

  @override
  String elapsed(String time) {
    return 'समय $time';
  }

  @override
  String get targetTime => 'लक्ष्य समय';

  @override
  String get targetNone => 'कोई लक्ष्य नहीं';

  @override
  String overTarget(String time) {
    return 'लक्ष्य से $time ज़्यादा';
  }

  @override
  String underTarget(String time) {
    return 'लक्ष्य से $time कम';
  }

  @override
  String wpm(int wpm) {
    return '$wpm शब्द/मिनट';
  }

  @override
  String get proTitle => 'याद Pro';

  @override
  String get proPitch => 'Pro के साथ जल्दी याद करें।';

  @override
  String get proFeatureHandsFree =>
      'हैंड्स-फ़्री अभ्यास: आपकी बारी आने पर सुनता है, फ़ोन छूने की ज़रूरत नहीं';

  @override
  String proFeatureUnlimited(int count) {
    return 'असीमित पाठ (मुफ़्त संस्करण में $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days दिन मुफ़्त, फिर $price/माह';
  }

  @override
  String proPrice(String price) {
    return '$price/माह';
  }

  @override
  String get proStartTrial => 'मुफ़्त ट्रायल शुरू करें';

  @override
  String get proSubscribe => 'सदस्यता लें';

  @override
  String get proRestore => 'खरीदारी वापस लाएँ';

  @override
  String get proTerms =>
      'सदस्यता हर महीने अपने-आप नवीनीकृत होती है। आप कभी भी Google Play > सदस्यताएँ में जाकर रद्द कर सकते हैं; रद्द करने पर Pro अवधि के अंत तक चालू रहता है।';

  @override
  String get proUnavailable =>
      'सदस्यता अभी उपलब्ध नहीं है। बाद में फिर कोशिश करें।';

  @override
  String get proActive => 'Pro चालू है';

  @override
  String get proManage => 'सदस्यता प्रबंधित करें';

  @override
  String get proUpgrade => 'Pro लें';

  @override
  String proLimitReached(int count) {
    return 'मुफ़्त संस्करण में अधिकतम $count पाठ सहेजे जा सकते हैं।';
  }

  @override
  String get proThanks => 'धन्यवाद! Pro चालू है।';

  @override
  String get proHandsFreeLocked =>
      'हैंड्स-फ़्री अभ्यास Pro की सुविधा है। \"मेरा इंतज़ार करो\" मोड चालू किया गया।';

  @override
  String get proNotFound => 'कोई चालू सदस्यता नहीं मिली।';

  @override
  String get modePages => 'पृष्ठ-दर-पृष्ठ प्रस्तुति';

  @override
  String get modePagesHelp =>
      '\"पृष्ठ 1\" कहता है, और समय पूरा होने पर \"समय पूरा हुआ। पृष्ठ 2\" कहकर आगे बढ़ता है। बिना पढ़े बोलें; जल्दी पूरा हो जाए तो \"अगला पृष्ठ\" पर टैप करें।';

  @override
  String pageCue(int n) {
    return 'पृष्ठ $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'पृष्ठ $n। $title';
  }

  @override
  String get timeUp => 'समय पूरा हुआ।';

  @override
  String get presentationDone => 'प्रस्तुति समाप्त।';

  @override
  String get nextPage => 'अगला पृष्ठ';

  @override
  String get pageTimes => 'पृष्ठों का समय';

  @override
  String get pageTimesHelp =>
      'पृष्ठ पाठ के शीर्षकों से बनते हैं; शीर्षक न हों तो अनुच्छेदों से।';

  @override
  String get pageTimesAuto => 'अपने-आप बाँटें';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'पृ$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'पृष्ठ $n/$total';
  }

  @override
  String get emotion => 'लहजा';

  @override
  String get emotionHelp =>
      'गति, स्वर और आवाज़ की ऊँचाई इस भाव के अनुसार बदलती है। पाठ में (गुस्से से), (रोते हुए) जैसे निर्देश अपने-आप पहचाने जाते हैं।';

  @override
  String get emoNeutral => 'सामान्य';

  @override
  String get emoHappy => 'खुश';

  @override
  String get emoSad => 'उदास';

  @override
  String get emoAngry => 'गुस्सा';

  @override
  String get emoExcited => 'उत्साहित';

  @override
  String get emoCalm => 'शांत';

  @override
  String get emoWhisper => 'फुसफुसाहट';

  @override
  String get emoAfraid => 'डरा हुआ';

  @override
  String get modeRecite => 'ज़बानी सुनाएँ (गलती की जाँच)';

  @override
  String get modeReciteHelp =>
      'पाठ ज़बानी बोलें; जहाँ आप कुछ छोड़ते या गलत बोलते हैं, वहाँ रुककर गलती दिखाता है। अंत में रिपोर्ट मिलती है।';

  @override
  String get reciteTitle => 'ज़बानी सुनाएँ';

  @override
  String get reciteModelTitle => 'स्पीच रिकग्निशन मॉडल';

  @override
  String get reciteModelHelp =>
      'गलती की जाँच के लिए, फ़ोन पर चलने वाला स्पीच रिकग्निशन मॉडल एक बार डाउनलोड होता है। यह मुफ़्त है; आपकी आवाज़ फ़ोन से बाहर नहीं जाती। Wi-Fi बेहतर रहेगा।';

  @override
  String reciteModelStandard(int mb) {
    return 'सामान्य ($mb MB) — तेज़';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'अधिक सटीक ($mb MB) — धीमा';
  }

  @override
  String get reciteDownload => 'डाउनलोड करें';

  @override
  String reciteDownloading(int pct) {
    return 'डाउनलोड हो रहा है… $pct%';
  }

  @override
  String get reciteDownloadFailed =>
      'डाउनलोड नहीं हो सका। अपना कनेक्शन जाँचकर फिर कोशिश करें।';

  @override
  String get reciteLoading => 'मॉडल लोड हो रहा है…';

  @override
  String get reciteStart => 'शुरू करें';

  @override
  String get reciteListening => 'सुन रहा हूँ… पाठ शुरू से बोलें।';

  @override
  String get reciteChecking => 'जाँच हो रही है…';

  @override
  String reciteHeard(String text) {
    return 'मैंने सुना: $text';
  }

  @override
  String get reciteSkipped => 'आपने एक हिस्सा छोड़ दिया';

  @override
  String get reciteWrong => 'आपने गलत बोला';

  @override
  String reciteExpected(String text) {
    return 'सही: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'आपने कहा: $text';
  }

  @override
  String get reciteContinueHere => 'यहाँ से आगे बढ़ें';

  @override
  String get reciteFinish => 'समाप्त करें';

  @override
  String reciteAccuracy(int n) {
    return 'सटीकता: $n%';
  }

  @override
  String get reciteNoErrors => 'कोई गलती नहीं, बहुत बढ़िया!';

  @override
  String reciteMinor(int n) {
    return '$n छोटी चूक (छोटे शब्द)';
  }

  @override
  String get reciteAgain => 'फिर से';

  @override
  String get reciteNote =>
      'पहचान पूरी तरह सही नहीं होती; जहाँ भरोसा न हो वहाँ यह आपको रोक सकता है।';

  @override
  String get reciteLoadFailed =>
      'मॉडल खुल नहीं सका। इसे हटाकर फिर डाउनलोड करें।';

  @override
  String get recordLines => 'आवाज़ रिकॉर्ड करें';

  @override
  String get recordLinesHelp =>
      'दूसरे पात्रों के संवाद अपनी या किसी दोस्त की आवाज़ में रिकॉर्ड करें; अभ्यास में कृत्रिम आवाज़ की जगह ये रिकॉर्डिंग बजती हैं, असली भाव के साथ। रिकॉर्डिंग केवल फ़ोन में रहती हैं और बैकअप में शामिल नहीं होतीं।';

  @override
  String get recordStart => 'रिकॉर्ड';

  @override
  String get recordStop => 'रोकें';

  @override
  String get recordPlay => 'सुनें';

  @override
  String get recordDelete => 'रिकॉर्डिंग हटाएँ';

  @override
  String get recordNext => 'अगला';

  @override
  String get recordPrev => 'पिछला';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total संवाद रिकॉर्ड हुए';
  }

  @override
  String get recordIncludeMine => 'मेरे अपने संवाद भी दिखाएँ';

  @override
  String get recordNone => 'रिकॉर्ड करने के लिए कोई संवाद नहीं।';

  @override
  String get recordingNow => 'रिकॉर्ड हो रहा है…';

  @override
  String get recordedBadge => 'रिकॉर्ड हुआ';
}
