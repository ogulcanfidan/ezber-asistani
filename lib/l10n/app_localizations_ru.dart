// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class LRu extends L {
  LRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Помощник заучивания';

  @override
  String get library => 'Мои тексты';

  @override
  String get emptyLibrary =>
      'Пока ничего нет. Добавьте пьесу, стихотворение или речь и начните учить.';

  @override
  String get newPiece => 'Новый';

  @override
  String get kindPlay => 'Пьеса / сцена';

  @override
  String get kindPoem => 'Стихи / текст';

  @override
  String get kindSpeech => 'Речь / презентация';

  @override
  String get kindPlayHelp =>
      'Пишите каждую реплику как ИМЯ: реплика. Ремарки берите в (скобки). Формат сценария тоже подходит.';

  @override
  String get kindPoemHelp =>
      'Каждая строка — отдельный шаг. Для стихов, песен, списков и любого текста, который нужно выучить дословно.';

  @override
  String get kindSpeechHelp =>
      'Каждое предложение или абзац на отдельной строке — шаг. Следите за временем и темпом речи.';

  @override
  String get title => 'Название';

  @override
  String get voiceLanguage => 'Язык озвучивания';

  @override
  String get pasteHint => 'Вставьте или введите текст здесь';

  @override
  String get importFile => 'Открыть файл (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'Не удалось прочитать файл. Используйте обычный текстовый файл (.txt).';

  @override
  String get continueAction => 'Далее';

  @override
  String get reviewTitle => 'Проверьте реплики';

  @override
  String get reviewHelp =>
      'Нажмите на имя, чтобы передать реплику другому персонажу. Нажмите на текст, чтобы изменить его. Другие действия — в ⋮.';

  @override
  String get whoAmI => 'Какую роль вы играете?';

  @override
  String get whoAmIHelp => 'Вы будете учить реплики этого персонажа.';

  @override
  String get characters => 'Персонажи';

  @override
  String get direction => 'Ремарка';

  @override
  String get heading => 'Сцена';

  @override
  String get editLine => 'Изменить текст';

  @override
  String get deleteLine => 'Удалить';

  @override
  String get mergeWithPrevious => 'Объединить со строкой выше';

  @override
  String get makeDirection => 'Сделать ремаркой';

  @override
  String get makeHeading => 'Сделать заголовком сцены';

  @override
  String get makeDialogue => 'Сделать репликой';

  @override
  String get addLineBelow => 'Добавить строку ниже';

  @override
  String get assignTo => 'Кто это говорит?';

  @override
  String get newCharacter => 'Новый персонаж';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get rename => 'Переименовать';

  @override
  String get mergeInto => 'Объединить с…';

  @override
  String get name => 'Имя';

  @override
  String get voice => 'Голос';

  @override
  String get pitch => 'Высота';

  @override
  String get speed => 'Скорость';

  @override
  String get testVoice => 'Прослушать';

  @override
  String get defaultVoice => 'Голос по умолчанию';

  @override
  String get testSentence => 'Привет! Так я буду звучать.';

  @override
  String get noVoices =>
      'На устройстве не найден голос для этого языка. Его можно установить в настройках синтеза речи Android.';

  @override
  String get rehearse => 'Репетиция';

  @override
  String get mode => 'Режим';

  @override
  String get modeListen => 'Слушать';

  @override
  String get modeListenHelp =>
      'Всё читается вслух. Хорошо, чтобы познакомиться с текстом.';

  @override
  String get modeWait => 'Ждать меня';

  @override
  String get modeWaitHelp =>
      'Останавливается на вашей реплике. Произнесите её и нажмите «Далее».';

  @override
  String get modeCheck => 'Проверять меня';

  @override
  String get modeCheckHelp =>
      'Даёт время произнести реплику, затем читает её, чтобы вы могли себя проверить.';

  @override
  String get modeRun => 'Прогон';

  @override
  String get modeRunHelp =>
      'Даёт время на вашу реплику и продолжает, не читая её.';

  @override
  String get hint => 'Показывать мою реплику';

  @override
  String get hintFull => 'Полностью';

  @override
  String get hintFirst => 'Первые буквы';

  @override
  String get hintHidden => 'Скрыто';

  @override
  String get readDirections => 'Читать ремарки вслух';

  @override
  String get pauseLength => 'Время на мою реплику';

  @override
  String get yourTurn => 'Ваша очередь';

  @override
  String get show => 'Показать';

  @override
  String get play => 'Старт';

  @override
  String get pause => 'Пауза';

  @override
  String get previousLine => 'Предыдущая строка';

  @override
  String get nextLine => 'Следующая строка';

  @override
  String get jumpToScene => 'Перейти к сцене';

  @override
  String get fromStart => 'С начала';

  @override
  String get finished => 'Репетиция окончена.';

  @override
  String get restart => 'Начать заново';

  @override
  String get settings => 'Настройки';

  @override
  String get appLanguage => 'Язык приложения';

  @override
  String get systemDefault => 'Как в системе';

  @override
  String get backup => 'Сохранить копию всех текстов';

  @override
  String get backupHelp =>
      'Сохраните файл резервной копии, чтобы не потерять тексты при смене телефона.';

  @override
  String get restore => 'Восстановить из копии';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Восстановлено $count текста',
      many: 'Восстановлено $count текстов',
      few: 'Восстановлено $count текста',
      one: 'Восстановлен $count текст',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed =>
      'Этот файл не является корректной резервной копией.';

  @override
  String deleteConfirm(String title) {
    return 'Удалить «$title»? Это действие нельзя отменить.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count строки',
      many: '$count строк',
      few: '$count строки',
      one: '$count строка',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Конфиденциальность';

  @override
  String get privacyText =>
      'Ваши тексты остаются на телефоне и никуда не загружаются. Голоса создаются на устройстве встроенным синтезатором речи. Текст на фото распознаётся на устройстве с помощью Google ML Kit; фото никуда не отправляются, но ML Kit может отправлять Google анонимные диагностические данные (модель устройства, коды ошибок). В режиме «Без рук» микрофон используется только на устройстве и в реальном времени, чтобы понять, что вы договорили. Если включить «Проверять, что я говорю», речь распознаётся встроенным распознаванием телефона на устройстве; приложение никогда не использует онлайн-распознавание. Ничего не записывается и не отправляется. В режиме «Рассказать наизусть» речь распознаётся на телефоне открытой моделью Whisper, которая скачивается один раз. Единственное исключение — «Записать голоса»: реплики записываются, только когда вы нажимаете «Записать»; записи остаются на телефоне и никуда не отправляются.';

  @override
  String get privacyPolicyFull => 'Полная политика конфиденциальности';

  @override
  String get appVersion => 'Версия';

  @override
  String get noMyCharacter =>
      'Перед репетицией выберите хотя бы одного персонажа как своего.';

  @override
  String get me => 'Я';

  @override
  String get modeHandsFree => 'Без рук';

  @override
  String get modeHandsFreeHelp =>
      'Слушает, когда ваша очередь. Произнесите реплику — когда вы замолчите, всё продолжится. Если вы забыли, реплику прочитают вам.';

  @override
  String get listening => 'Слушаю… произнесите реплику';

  @override
  String get micDenied =>
      'Для режима «Без рук» нужен доступ к микрофону. Включён режим «Ждать меня».';

  @override
  String get endSilence => 'Пауза, завершающая мою реплику';

  @override
  String voiceN(int n) {
    return 'Голос $n';
  }

  @override
  String get linesHeader => 'Реплики';

  @override
  String get pdfScanned =>
      'В этом PDF нет выделяемого текста (похоже на скан). Используйте «Из фото», чтобы прочитать его с изображения, или вставьте текст.';

  @override
  String get hintWord => 'Подсказка';

  @override
  String get checkAccuracy => 'Проверять, что я говорю';

  @override
  String get checkAccuracyHelp =>
      'Ваша речь распознаётся встроенным распознаванием речи телефона прямо на устройстве и сравнивается с репликой. Ничего не записывается, голос не покидает телефон.';

  @override
  String get sttUnavailable =>
      'На этом телефоне нет распознавания речи на устройстве, поэтому точность проверить нельзя. Режим «Без рук» всё равно работает.';

  @override
  String get sttLanguageMissing =>
      'Для этого языка на вашем телефоне нет распознавания речи на устройстве.';

  @override
  String get sttDownload => 'Скачать распознавание речи для этого языка';

  @override
  String get sttDownloading =>
      'Загружается языковой пакет… Это может занять несколько минут.';

  @override
  String get readCorrection => 'Читать правильную реплику, если я ошибся';

  @override
  String accuracyScore(int score) {
    return 'Верно на $score%';
  }

  @override
  String missedWords(String words) {
    return 'Пропущено: $words';
  }

  @override
  String get notUnderstood => 'Не удалось разобрать';

  @override
  String summaryAccuracy(int score) {
    return 'Средняя точность $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Подсказка $count раза',
      many: 'Подсказка $count раз',
      few: 'Подсказка $count раза',
      one: 'Подсказка $count раз',
      zero: 'Подсказки не понадобились',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Отлично! Вы справились без подсказок.';

  @override
  String get finishedGood => 'Хорошо идёт! Репетиция окончена.';

  @override
  String get finishedPractice =>
      'Репетиция окончена. Повторите места, где вы запнулись.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count реплики',
      many: '$count реплик',
      few: '$count реплики',
      one: '$count реплика',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'подсказки в $count репликах',
      many: 'подсказки в $count репликах',
      few: 'подсказки в $count репликах',
      one: 'подсказка в $count реплике',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'исправлено $count реплики',
      many: 'исправлено $count реплик',
      few: 'исправлены $count реплики',
      one: 'исправлена $count реплика',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'не распознано $count реплики',
      many: 'не распознано $count реплик',
      few: 'не распознаны $count реплики',
      one: 'не распознана $count реплика',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'Из фото';

  @override
  String get takePhoto => 'Сфотографировать';

  @override
  String get reading => 'Чтение…';

  @override
  String get docOld =>
      'Старые файлы Word (.doc) не читаются. Сохраните документ в .docx или PDF и попробуйте снова.';

  @override
  String get noTextInPhoto =>
      'На фото не найден читаемый текст. Попробуйте более чёткое, хорошо освещённое фото, снятое прямо.';

  @override
  String get photoAlphabet =>
      'Чтение с фото работает только с латиницей. Введите или вставьте текст.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Непонятно, кто произносит $count строки. Нажмите на отмеченные строки, чтобы исправить.',
      many:
          'Непонятно, кто произносит $count строк. Нажмите на отмеченные строки, чтобы исправить.',
      few:
          'Непонятно, кто произносит $count строки. Нажмите на отмеченные строки, чтобы исправить.',
      one:
          'Непонятно, кто произносит $count строку. Нажмите на отмеченную строку, чтобы исправить.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Нажмите Enter, чтобы разделить строку на две.';

  @override
  String get charactersAndVoices => 'Персонажи и голоса';

  @override
  String get hintProgressive => 'Постепенно';

  @override
  String get hintKeywords => 'Ключевые слова';

  @override
  String hideRatio(int percent) {
    return 'Скрыто слов: $percent%';
  }

  @override
  String levelUp(int percent) {
    return 'Отлично! В следующем круге будет скрыто $percent% слов.';
  }

  @override
  String get modeBuildUp => 'Наращивание';

  @override
  String get modeBuildUpHelp =>
      'Сначала строка 1, потом 1–2, потом 1–3… Каждую новую строку вам сначала читают, затем вы произносите всё с начала. Идеально для стихов и коротких текстов.';

  @override
  String stepOf(int step, int total) {
    return 'Шаг $step из $total';
  }

  @override
  String get onlyWeak => 'Только трудные строки';

  @override
  String get onlyWeakHelp =>
      'Повторяйте только строки, где понадобилась подсказка, исправление или был низкий результат.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count трудной строки',
      many: '$count трудных строк',
      few: '$count трудные строки',
      one: '$count трудная строка',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Трудных строк пока нет';

  @override
  String elapsed(String time) {
    return 'Время $time';
  }

  @override
  String get targetTime => 'Целевое время';

  @override
  String get targetNone => 'Без цели';

  @override
  String overTarget(String time) {
    return 'На $time больше цели';
  }

  @override
  String underTarget(String time) {
    return 'На $time меньше цели';
  }

  @override
  String wpm(int wpm) {
    return '$wpm слов/мин';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Учите наизусть быстрее с Pro.';

  @override
  String get proFeatureHandsFree =>
      'Репетиция без рук: слушает, когда ваша очередь, телефон трогать не нужно';

  @override
  String proFeatureUnlimited(int count) {
    return 'Безлимитные тексты (в бесплатной версии: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days дн. бесплатно, затем $price/мес.';
  }

  @override
  String proPrice(String price) {
    return '$price/мес.';
  }

  @override
  String get proStartTrial => 'Начать бесплатный период';

  @override
  String get proSubscribe => 'Оформить подписку';

  @override
  String get proRestore => 'Восстановить покупки';

  @override
  String get proTerms =>
      'Подписка продлевается автоматически каждый месяц. Отменить можно в любой момент в Google Play > Подписки; после отмены Pro действует до конца периода.';

  @override
  String get proUnavailable => 'Подписка сейчас недоступна. Попробуйте позже.';

  @override
  String get proActive => 'Pro активен';

  @override
  String get proManage => 'Управлять подпиской';

  @override
  String get proUpgrade => 'Перейти на Pro';

  @override
  String proLimitReached(int count) {
    return 'В бесплатной версии можно сохранить не более $count текстов.';
  }

  @override
  String get proThanks => 'Спасибо! Pro активен.';

  @override
  String get proHandsFreeLocked =>
      'Репетиция без рук — функция Pro. Включён режим «Жди меня».';

  @override
  String get proNotFound => 'Активная подписка не найдена.';

  @override
  String get modePages => 'По страницам';

  @override
  String get modePagesHelp =>
      'Говорит «Страница 1», а когда время выйдет — «Время вышло. Страница 2». Рассказывайте, не читая; если закончили раньше, нажмите «Следующая страница».';

  @override
  String pageCue(int n) {
    return 'Страница $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Страница $n. $title';
  }

  @override
  String get timeUp => 'Время вышло.';

  @override
  String get presentationDone => 'Конец презентации.';

  @override
  String get nextPage => 'Следующая страница';

  @override
  String get pageTimes => 'Время на страницу';

  @override
  String get pageTimesHelp =>
      'Страницы берутся из заголовков текста, а если их нет — из абзацев.';

  @override
  String get pageTimesAuto => 'Распределить автоматически';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'С$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Страница $n/$total';
  }

  @override
  String get emotion => 'Тон';

  @override
  String get emotionHelp =>
      'Скорость, высота и громкость голоса подстраиваются под это чувство. Ремарки вроде (сердито) или (плача) распознаются автоматически.';

  @override
  String get emoNeutral => 'Обычный';

  @override
  String get emoHappy => 'Радостный';

  @override
  String get emoSad => 'Грустный';

  @override
  String get emoAngry => 'Сердитый';

  @override
  String get emoExcited => 'Взволнованный';

  @override
  String get emoCalm => 'Спокойный';

  @override
  String get emoWhisper => 'Шёпот';

  @override
  String get emoAfraid => 'Испуганный';

  @override
  String get modeRecite => 'Рассказать наизусть (проверка ошибок)';

  @override
  String get modeReciteHelp =>
      'Расскажите текст наизусть; приложение остановится там, где вы пропустили или ошиблись, и покажет ошибку. В конце — отчёт.';

  @override
  String get reciteTitle => 'Рассказать наизусть';

  @override
  String get reciteModelTitle => 'Модель распознавания речи';

  @override
  String get reciteModelHelp =>
      'Для проверки один раз загружается модель распознавания речи, работающая на телефоне. Бесплатно; ваш голос не покидает телефон. Рекомендуется Wi-Fi.';

  @override
  String reciteModelStandard(int mb) {
    return 'Стандартная ($mb МБ) — быстрая';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Высокая точность ($mb МБ) — медленнее';
  }

  @override
  String get reciteDownload => 'Скачать';

  @override
  String reciteDownloading(int pct) {
    return 'Загрузка… $pct%';
  }

  @override
  String get reciteDownloadFailed =>
      'Не удалось скачать. Проверьте подключение и попробуйте снова.';

  @override
  String get reciteLoading => 'Загрузка модели…';

  @override
  String get reciteStart => 'Начать';

  @override
  String get reciteListening => 'Слушаю… Расскажите текст с начала.';

  @override
  String get reciteChecking => 'Проверка…';

  @override
  String reciteHeard(String text) {
    return 'Я услышал: $text';
  }

  @override
  String get reciteSkipped => 'Вы пропустили часть';

  @override
  String get reciteWrong => 'Вы ошиблись';

  @override
  String reciteExpected(String text) {
    return 'Правильно: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Вы сказали: $text';
  }

  @override
  String get reciteContinueHere => 'Продолжить отсюда';

  @override
  String get reciteFinish => 'Завершить';

  @override
  String reciteAccuracy(int n) {
    return 'Точность: $n%';
  }

  @override
  String get reciteNoErrors => 'Ни одной ошибки, отлично!';

  @override
  String reciteMinor(int n) {
    return 'Небольших пропусков (короткие слова): $n';
  }

  @override
  String get reciteAgain => 'Ещё раз';

  @override
  String get reciteNote =>
      'Распознавание не идеально: при сомнении оно может остановить вас.';

  @override
  String get reciteLoadFailed =>
      'Не удалось открыть модель. Удалите её и скачайте снова.';

  @override
  String get recordLines => 'Записать голоса';

  @override
  String get recordLinesHelp =>
      'Запишите реплики других персонажей своим голосом или голосом друга; на репетиции вместо синтезированного голоса будут звучать эти записи — с настоящими эмоциями. Записи хранятся только на телефоне и не входят в резервную копию.';

  @override
  String get recordStart => 'Записать';

  @override
  String get recordStop => 'Стоп';

  @override
  String get recordPlay => 'Прослушать';

  @override
  String get recordDelete => 'Удалить запись';

  @override
  String get recordNext => 'Далее';

  @override
  String get recordPrev => 'Назад';

  @override
  String recordedCount(int n, int total) {
    return 'Записано реплик: $n/$total';
  }

  @override
  String get recordIncludeMine => 'Показывать и мои реплики';

  @override
  String get recordNone => 'Нет реплик для записи.';

  @override
  String get recordingNow => 'Идёт запись…';

  @override
  String get recordedBadge => 'Записано';
}
