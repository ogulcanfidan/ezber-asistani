// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class LAr extends L {
  LAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'مساعد الحفظ';

  @override
  String get library => 'نصوصي';

  @override
  String get emptyLibrary =>
      'لا يوجد شيء بعد. أضف مسرحية أو قصيدة أو خطابًا وابدأ الحفظ.';

  @override
  String get newPiece => 'جديد';

  @override
  String get kindPlay => 'مسرحية / مشهد';

  @override
  String get kindPoem => 'قصيدة / نص';

  @override
  String get kindSpeech => 'خطاب / عرض تقديمي';

  @override
  String get kindPlayHelp =>
      'اكتب كل حوار بالشكل: الاسم: الحوار. ضع الإرشادات المسرحية بين (قوسين). تنسيق السيناريو يعمل أيضًا.';

  @override
  String get kindPoemHelp =>
      'يصبح كل سطر خطوة. للقصائد والأغاني والقوائم وأي نص يُحفظ كلمة بكلمة.';

  @override
  String get kindSpeechHelp =>
      'تصبح كل جملة أو فقرة في سطر مستقل خطوة. تابع الوقت وسرعة كلامك.';

  @override
  String get title => 'العنوان';

  @override
  String get voiceLanguage => 'لغة الصوت';

  @override
  String get pasteHint => 'الصق نصك أو اكتبه هنا';

  @override
  String get importFile => 'فتح ملف (.txt، .pdf، .docx)';

  @override
  String get importFailed =>
      'تعذّرت قراءة هذا الملف. يرجى استخدام ملف نصي عادي (.txt).';

  @override
  String get continueAction => 'متابعة';

  @override
  String get reviewTitle => 'راجع الأسطر';

  @override
  String get reviewHelp =>
      'المس اسمًا لإسناد السطر إلى شخصية أخرى. المس النص لتعديله. المزيد من الخيارات في ⋮.';

  @override
  String get whoAmI => 'أي شخصية أنت؟';

  @override
  String get whoAmIHelp => 'ستتدرّب على حوارات هذه الشخصية.';

  @override
  String get characters => 'الشخصيات';

  @override
  String get direction => 'إرشاد مسرحي';

  @override
  String get heading => 'مشهد';

  @override
  String get editLine => 'تعديل النص';

  @override
  String get deleteLine => 'حذف';

  @override
  String get mergeWithPrevious => 'دمج مع السطر السابق';

  @override
  String get makeDirection => 'تحويل إلى إرشاد مسرحي';

  @override
  String get makeHeading => 'تحويل إلى عنوان مشهد';

  @override
  String get makeDialogue => 'تحويل إلى حوار';

  @override
  String get addLineBelow => 'إضافة سطر أدناه';

  @override
  String get assignTo => 'من يقول هذا؟';

  @override
  String get newCharacter => 'شخصية جديدة';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get delete => 'حذف';

  @override
  String get rename => 'إعادة تسمية';

  @override
  String get mergeInto => 'دمج مع…';

  @override
  String get name => 'الاسم';

  @override
  String get voice => 'الصوت';

  @override
  String get pitch => 'طبقة الصوت';

  @override
  String get speed => 'السرعة';

  @override
  String get testVoice => 'استماع';

  @override
  String get defaultVoice => 'الصوت الافتراضي';

  @override
  String get testSentence => 'مرحبًا! هكذا سيكون صوتي.';

  @override
  String get noVoices =>
      'لم يُعثر على صوت لهذه اللغة في جهازك. يمكنك تثبيت صوت من إعدادات تحويل النص إلى كلام في أندرويد.';

  @override
  String get rehearse => 'تدريب';

  @override
  String get mode => 'الوضع';

  @override
  String get modeListen => 'استماع';

  @override
  String get modeListenHelp =>
      'يُقرأ كل شيء بصوت عالٍ. مناسب للتعرّف على النص.';

  @override
  String get modeWait => 'انتظرني';

  @override
  String get modeWaitHelp => 'يتوقف عند حوارك. قله ثم المس متابعة.';

  @override
  String get modeCheck => 'راجعني';

  @override
  String get modeCheckHelp => 'يمنحك وقتًا لقول حوارك ثم يقرؤه لتتحقق من نفسك.';

  @override
  String get modeRun => 'عرض متواصل';

  @override
  String get modeRunHelp => 'يمنحك وقتًا لحوارك ويستمر دون قراءته.';

  @override
  String get hint => 'إظهار حواري';

  @override
  String get hintFull => 'النص كاملًا';

  @override
  String get hintFirst => 'الحروف الأولى';

  @override
  String get hintHidden => 'مخفي';

  @override
  String get readDirections => 'قراءة الإرشادات المسرحية بصوت عالٍ';

  @override
  String get pauseLength => 'الوقت المخصص لحواري';

  @override
  String get yourTurn => 'دورك';

  @override
  String get show => 'إظهار';

  @override
  String get play => 'تشغيل';

  @override
  String get pause => 'إيقاف مؤقت';

  @override
  String get previousLine => 'السطر السابق';

  @override
  String get nextLine => 'السطر التالي';

  @override
  String get jumpToScene => 'الانتقال إلى مشهد';

  @override
  String get fromStart => 'من البداية';

  @override
  String get finished => 'اكتمل التدريب.';

  @override
  String get restart => 'البدء من جديد';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appLanguage => 'لغة التطبيق';

  @override
  String get systemDefault => 'لغة النظام';

  @override
  String get backup => 'نسخ احتياطي لكل النصوص';

  @override
  String get backupHelp =>
      'احفظ ملف نسخة احتياطية حتى لا تفقد نصوصك عند تغيير هاتفك.';

  @override
  String get restore => 'استعادة من نسخة احتياطية';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تمت استعادة $count نص',
      many: 'تمت استعادة $count نصًا',
      few: 'تمت استعادة $count نصوص',
      two: 'تمت استعادة نصين',
      one: 'تمت استعادة نص واحد',
      zero: 'لم تتم استعادة أي نص',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'هذا الملف ليس نسخة احتياطية صالحة.';

  @override
  String deleteConfirm(String title) {
    return 'حذف «$title»؟ لا يمكن التراجع عن ذلك.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سطر',
      many: '$count سطرًا',
      few: '$count أسطر',
      two: 'سطران',
      one: 'سطر واحد',
      zero: 'لا أسطر',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'الخصوصية';

  @override
  String get privacyText =>
      'تبقى نصوصك على هاتفك ولا تُرفع إلى أي مكان. تُنتَج الأصوات على الجهاز بواسطة محرك تحويل النص إلى كلام في هاتفك. يُقرأ النص في الصور على الجهاز باستخدام Google ML Kit؛ لا تُرسَل الصور، لكن قد يرسل ML Kit إلى Google بيانات تشخيص مجهولة (مثل طراز الجهاز ورموز الأخطاء). في وضع بدون استخدام اليدين يُستخدم الميكروفون على الجهاز فقط وفي الوقت الفعلي لمعرفة متى انتهيت من الكلام. إذا فعّلت «تحقّق مما أقوله» يحوّل التعرّف على الكلام في هاتفك صوتك إلى نص على الجهاز؛ ولا يستخدم التطبيق التعرّف عبر الإنترنت أبدًا. لا يُسجَّل أي شيء ولا يُرسَل. في وضع «التسميع من الذاكرة» يُحوَّل كلامك إلى نص على الهاتف بواسطة نموذج Whisper مفتوح المصدر الذي يُنزَّل مرة واحدة. الاستثناء الوحيد هو «تسجيل الأصوات»: لا تُسجَّل الحوارات إلا عندما تضغط «تسجيل»، وتبقى التسجيلات على الهاتف ولا تُرسَل أبدًا.';

  @override
  String get privacyPolicyFull => 'سياسة الخصوصية الكاملة';

  @override
  String get appVersion => 'الإصدار';

  @override
  String get noMyCharacter =>
      'اختر شخصية واحدة على الأقل لتكون شخصيتك قبل التدريب.';

  @override
  String get me => 'أنا';

  @override
  String get modeHandsFree => 'بدون استخدام اليدين';

  @override
  String get modeHandsFreeHelp =>
      'يستمع عندما يحين دورك. قل حوارك، وعندما تتوقف عن الكلام يتابع. إذا تعثّرت، يقرأ حوارك لك.';

  @override
  String get listening => 'أستمع… قل حوارك';

  @override
  String get micDenied =>
      'يحتاج وضع بدون استخدام اليدين إلى إذن الميكروفون. تم التبديل إلى «انتظرني».';

  @override
  String get endSilence => 'مدة الصمت التي تنهي حواري';

  @override
  String voiceN(int n) {
    return 'الصوت $n';
  }

  @override
  String get linesHeader => 'الأسطر';

  @override
  String get pdfScanned =>
      'لا يحتوي ملف PDF هذا على نص قابل للتحديد (يبدو كصفحة ممسوحة ضوئيًا). استخدم «من الصور» لقراءته من صورة، أو الصق النص.';

  @override
  String get hintWord => 'تلميح';

  @override
  String get checkAccuracy => 'تحقّق مما أقوله';

  @override
  String get checkAccuracyHelp =>
      'يحوّل التعرّف على الكلام في هاتفك صوتك إلى نص على الجهاز نفسه ويقارنه بحوارك. لا يُسجَّل أي شيء ولا يغادر صوتك الهاتف.';

  @override
  String get sttUnavailable =>
      'لا يتوفر في هذا الهاتف تعرّف على الكلام على الجهاز، لذا لا يمكن التحقق من الدقة. يظل وضع بدون استخدام اليدين يعمل.';

  @override
  String get sttLanguageMissing =>
      'التعرّف على الكلام على الجهاز غير متاح لهذه اللغة في هاتفك.';

  @override
  String get sttDownload => 'تنزيل التعرّف على الكلام لهذه اللغة';

  @override
  String get sttDownloading =>
      'جارٍ تنزيل حزمة اللغة… قد يستغرق ذلك بضع دقائق.';

  @override
  String get readCorrection => 'اقرأ الحوار الصحيح إذا أخطأت';

  @override
  String accuracyScore(int score) {
    return 'صحيح بنسبة $score٪';
  }

  @override
  String missedWords(String words) {
    return 'فاتك: $words';
  }

  @override
  String get notUnderstood => 'لم يُفهم';

  @override
  String summaryAccuracy(int score) {
    return 'متوسط الدقة $score٪';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تلقين $count مرة',
      many: 'تلقين $count مرة',
      few: 'تلقين $count مرات',
      two: 'تلقين مرتين',
      one: 'تلقين مرة واحدة',
      zero: 'لم تحتج إلى تلقين',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'أحسنت! أنهيت دون أي مساعدة.';

  @override
  String get finishedGood => 'أداء جيد! اكتمل التدريب.';

  @override
  String get finishedPractice =>
      'اكتمل التدريب. تدرّب على المواضع التي تعثّرت فيها.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حوار',
      many: '$count حوارًا',
      few: '$count حوارات',
      two: 'حواران',
      one: 'حوار واحد',
      zero: 'لا حوارات',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تلقين في $count حوار',
      many: 'تلقين في $count حوارًا',
      few: 'تلقين في $count حوارات',
      two: 'تلقين في حوارين',
      one: 'تلقين في حوار واحد',
      zero: 'دون تلقين',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تصحيح $count حوار',
      many: 'تصحيح $count حوارًا',
      few: 'تصحيح $count حوارات',
      two: 'تصحيح حوارين',
      one: 'تصحيح حوار واحد',
      zero: 'لا تصحيحات',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حوار لم يُفهم',
      many: '$count حوارًا لم يُفهم',
      few: '$count حوارات لم تُفهم',
      two: 'حواران لم يُفهما',
      one: 'حوار واحد لم يُفهم',
      zero: 'فُهمت كل الحوارات',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'من الصور';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get reading => 'جارٍ القراءة…';

  @override
  String get docOld =>
      'لا يمكن قراءة ملفات Word القديمة (.doc). احفظ المستند بصيغة .docx أو PDF وحاول مجددًا.';

  @override
  String get noTextInPhoto =>
      'لم يُعثر على نص مقروء في الصورة. جرّب صورة أوضح وجيدة الإضاءة ومأخوذة من الأمام.';

  @override
  String get photoAlphabet =>
      'القراءة من الصور تعمل مع الأبجدية اللاتينية فقط. اكتب النص أو الصقه.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'لم يتضح من يقول $count سطر. المس الأسطر المميزة لتصحيحها.',
      many: 'لم يتضح من يقول $count سطرًا. المس الأسطر المميزة لتصحيحها.',
      few: 'لم يتضح من يقول $count أسطر. المس الأسطر المميزة لتصحيحها.',
      two: 'لم يتضح من يقول سطرين. المس السطرين المميزين لتصحيحهما.',
      one: 'لم يتضح من يقول سطرًا واحدًا. المس السطر المميز لتصحيحه.',
      zero: 'كل الأسطر واضحة',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'اضغط Enter لتقسيم السطر إلى سطرين.';

  @override
  String get charactersAndVoices => 'الشخصيات والأصوات';

  @override
  String get hintProgressive => 'تدريجي';

  @override
  String get hintKeywords => 'الكلمات المفتاحية';

  @override
  String hideRatio(int percent) {
    return 'الكلمات المخفية: $percent٪';
  }

  @override
  String levelUp(int percent) {
    return 'أحسنت! في الجولة التالية سيُخفى $percent٪ من الكلمات.';
  }

  @override
  String get modeBuildUp => 'البناء التدريجي';

  @override
  String get modeBuildUpHelp =>
      'أولًا السطر 1، ثم 1–2، ثم 1–3… يُقرأ عليك كل سطر جديد أولًا، ثم تقول كل شيء من البداية. مثالي للقصائد والنصوص القصيرة.';

  @override
  String stepOf(int step, int total) {
    return 'الخطوة $step من $total';
  }

  @override
  String get onlyWeak => 'الأسطر الصعبة فقط';

  @override
  String get onlyWeakHelp =>
      'تدرّب فقط على الأسطر التي احتجت فيها إلى تلقين أو تصحيح أو حصلت فيها على نتيجة منخفضة.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سطر صعب',
      many: '$count سطرًا صعبًا',
      few: '$count أسطر صعبة',
      two: 'سطران صعبان',
      one: 'سطر صعب واحد',
      zero: 'لا أسطر صعبة',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'لا توجد أسطر صعبة بعد';

  @override
  String elapsed(String time) {
    return 'الوقت $time';
  }

  @override
  String get targetTime => 'الوقت المستهدف';

  @override
  String get targetNone => 'بلا هدف';

  @override
  String overTarget(String time) {
    return 'تجاوزت الهدف بـ $time';
  }

  @override
  String underTarget(String time) {
    return 'أقل من الهدف بـ $time';
  }

  @override
  String wpm(int wpm) {
    return '$wpm كلمة/دقيقة';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'احفظ أسرع مع Pro.';

  @override
  String get proFeatureHandsFree =>
      'تمرين بدون استخدام اليدين: يستمع عندما يحين دورك دون لمس الهاتف';

  @override
  String proFeatureUnlimited(int count) {
    return 'نصوص غير محدودة (النسخة المجانية: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days أيام مجانًا، ثم $price/شهريًا';
  }

  @override
  String proPrice(String price) {
    return '$price/شهريًا';
  }

  @override
  String get proStartTrial => 'ابدأ الفترة التجريبية المجانية';

  @override
  String get proSubscribe => 'اشترك';

  @override
  String get proRestore => 'استعادة المشتريات';

  @override
  String get proTerms =>
      'يتجدد الاشتراك تلقائيًا كل شهر. يمكنك الإلغاء في أي وقت من Google Play > الاشتراكات؛ وعند الإلغاء يبقى Pro فعالًا حتى نهاية الفترة.';

  @override
  String get proUnavailable => 'الاشتراك غير متاح حاليًا. حاول لاحقًا.';

  @override
  String get proActive => 'Pro مفعّل';

  @override
  String get proManage => 'إدارة الاشتراك';

  @override
  String get proUpgrade => 'الترقية إلى Pro';

  @override
  String proLimitReached(int count) {
    return 'يمكن حفظ $count نصوص كحد أقصى في النسخة المجانية.';
  }

  @override
  String get proThanks => 'شكرًا! Pro مفعّل.';

  @override
  String get proHandsFreeLocked =>
      'التمرين بدون استخدام اليدين ميزة Pro. تم التبديل إلى «انتظرني».';

  @override
  String get proNotFound => 'لم يتم العثور على اشتراك فعّال.';

  @override
  String get modePages => 'صفحة بصفحة';

  @override
  String get modePagesHelp =>
      'يقول «الصفحة 1»، وعند انتهاء الوقت «انتهى الوقت. الصفحة 2». تحدّث دون قراءة؛ اضغط «الصفحة التالية» إذا أنهيت مبكرًا.';

  @override
  String pageCue(int n) {
    return 'الصفحة $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'الصفحة $n. $title';
  }

  @override
  String get timeUp => 'انتهى الوقت.';

  @override
  String get presentationDone => 'انتهى العرض.';

  @override
  String get nextPage => 'الصفحة التالية';

  @override
  String get pageTimes => 'الوقت لكل صفحة';

  @override
  String get pageTimesHelp =>
      'تُؤخذ الصفحات من عناوين النص، أو من الفقرات إذا لم توجد عناوين.';

  @override
  String get pageTimesAuto => 'توزيع تلقائي';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'ص$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'الصفحة $n/$total';
  }

  @override
  String get emotion => 'النبرة';

  @override
  String get emotionHelp =>
      'تُضبط السرعة وطبقة الصوت وارتفاعه وفق هذا الشعور. تُكتشف الإرشادات مثل (بغضب) أو (يبكي) تلقائيًا.';

  @override
  String get emoNeutral => 'عادي';

  @override
  String get emoHappy => 'سعيد';

  @override
  String get emoSad => 'حزين';

  @override
  String get emoAngry => 'غاضب';

  @override
  String get emoExcited => 'متحمس';

  @override
  String get emoCalm => 'هادئ';

  @override
  String get emoWhisper => 'همس';

  @override
  String get emoAfraid => 'خائف';

  @override
  String get modeRecite => 'التسميع من الذاكرة (فحص الأخطاء)';

  @override
  String get modeReciteHelp =>
      'قل النص من الذاكرة؛ يتوقف التطبيق حيث تتخطى أو تخطئ ويعرض الخطأ، وفي النهاية تحصل على تقرير.';

  @override
  String get reciteTitle => 'التسميع من الذاكرة';

  @override
  String get reciteModelTitle => 'نموذج التعرّف على الكلام';

  @override
  String get reciteModelHelp =>
      'لفحص الأخطاء يُنزَّل مرة واحدة نموذج للتعرّف على الكلام يعمل على الهاتف. مجاني؛ ولا يغادر صوتك الهاتف. يُفضَّل Wi-Fi.';

  @override
  String reciteModelStandard(int mb) {
    return 'قياسي ($mb ميغابايت) — سريع';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'دقة عالية ($mb ميغابايت) — أبطأ';
  }

  @override
  String get reciteDownload => 'تنزيل';

  @override
  String reciteDownloading(int pct) {
    return 'جارٍ التنزيل… $pct%';
  }

  @override
  String get reciteDownloadFailed =>
      'فشل التنزيل. تحقق من الاتصال وحاول مجددًا.';

  @override
  String get reciteLoading => 'جارٍ تحميل النموذج…';

  @override
  String get reciteStart => 'ابدأ';

  @override
  String get reciteListening => 'أستمع… قل النص من البداية.';

  @override
  String get reciteChecking => 'جارٍ الفحص…';

  @override
  String reciteHeard(String text) {
    return 'سمعت: $text';
  }

  @override
  String get reciteSkipped => 'تخطيت جزءًا';

  @override
  String get reciteWrong => 'قلتها بشكل خاطئ';

  @override
  String reciteExpected(String text) {
    return 'الصحيح: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'قلت: $text';
  }

  @override
  String get reciteContinueHere => 'تابع من هنا';

  @override
  String get reciteFinish => 'إنهاء';

  @override
  String reciteAccuracy(int n) {
    return 'الدقة: $n%';
  }

  @override
  String get reciteNoErrors => 'لا أخطاء، رائع!';

  @override
  String reciteMinor(int n) {
    return 'تخطّيات صغيرة (كلمات قصيرة): $n';
  }

  @override
  String get reciteAgain => 'مرة أخرى';

  @override
  String get reciteNote =>
      'التعرّف ليس مثاليًا؛ قد يوقفك عندما لا يكون متأكدًا.';

  @override
  String get reciteLoadFailed => 'تعذّر فتح النموذج. احذفه ونزّله مجددًا.';

  @override
  String get recordLines => 'تسجيل الأصوات';

  @override
  String get recordLinesHelp =>
      'سجّل حوارات الشخصيات الأخرى بصوتك أو بصوت صديق؛ تُشغَّل أثناء التمرين بدل الصوت الاصطناعي، بمشاعر حقيقية. تبقى التسجيلات على الهاتف ولا تدخل في النسخة الاحتياطية.';

  @override
  String get recordStart => 'تسجيل';

  @override
  String get recordStop => 'إيقاف';

  @override
  String get recordPlay => 'استماع';

  @override
  String get recordDelete => 'حذف التسجيل';

  @override
  String get recordNext => 'التالي';

  @override
  String get recordPrev => 'السابق';

  @override
  String recordedCount(int n, int total) {
    return 'تم تسجيل $n/$total حوار';
  }

  @override
  String get recordIncludeMine => 'إظهار حواراتي أيضًا';

  @override
  String get recordNone => 'لا توجد حوارات للتسجيل.';

  @override
  String get recordingNow => 'جارٍ التسجيل…';

  @override
  String get recordedBadge => 'مسجّل';
}
