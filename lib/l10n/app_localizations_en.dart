// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LEn extends L {
  LEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Memorize Assistant';

  @override
  String get library => 'My pieces';

  @override
  String get emptyLibrary =>
      'Nothing here yet. Add a play, a poem or a speech and start memorizing.';

  @override
  String get newPiece => 'New';

  @override
  String get kindPlay => 'Play / scene';

  @override
  String get kindPoem => 'Poem / text';

  @override
  String get kindSpeech => 'Speech / presentation';

  @override
  String get kindPlayHelp =>
      'Write each line as NAME: line. Put stage directions in (parentheses). Screenplay format also works.';

  @override
  String get kindPoemHelp =>
      'Each line becomes a step. Good for poems, songs, lists and any text to learn word for word.';

  @override
  String get kindSpeechHelp =>
      'Each sentence or paragraph on its own line becomes a step. Track your time and speaking pace.';

  @override
  String get title => 'Title';

  @override
  String get voiceLanguage => 'Voice language';

  @override
  String get pasteHint => 'Paste or type your text here';

  @override
  String get importFile => 'Open file (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'This file could not be read. Please use a plain text (.txt) file.';

  @override
  String get continueAction => 'Continue';

  @override
  String get reviewTitle => 'Check the lines';

  @override
  String get reviewHelp =>
      'Tap a name to give the line to another character. Tap the text to edit it. Use ⋮ for more.';

  @override
  String get whoAmI => 'Which character are you?';

  @override
  String get whoAmIHelp => 'Your lines will be the ones you practise.';

  @override
  String get characters => 'Characters';

  @override
  String get direction => 'Direction';

  @override
  String get heading => 'Scene';

  @override
  String get editLine => 'Edit text';

  @override
  String get deleteLine => 'Delete';

  @override
  String get mergeWithPrevious => 'Join with the line above';

  @override
  String get makeDirection => 'Make it a stage direction';

  @override
  String get makeHeading => 'Make it a scene heading';

  @override
  String get makeDialogue => 'Make it a spoken line';

  @override
  String get addLineBelow => 'Add a line below';

  @override
  String get assignTo => 'Who says this?';

  @override
  String get newCharacter => 'New character';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get rename => 'Rename';

  @override
  String get mergeInto => 'Merge into…';

  @override
  String get name => 'Name';

  @override
  String get voice => 'Voice';

  @override
  String get pitch => 'Pitch';

  @override
  String get speed => 'Speed';

  @override
  String get testVoice => 'Test';

  @override
  String get defaultVoice => 'Default voice';

  @override
  String get testSentence => 'Hello! This is how I will sound.';

  @override
  String get noVoices =>
      'No voice for this language was found on your device. You can install one in Android\'s text-to-speech settings.';

  @override
  String get rehearse => 'Rehearse';

  @override
  String get mode => 'Mode';

  @override
  String get modeListen => 'Listen';

  @override
  String get modeListenHelp =>
      'Everything is read aloud. Good for getting to know the piece.';

  @override
  String get modeWait => 'Wait for me';

  @override
  String get modeWaitHelp => 'Stops at your line. Say it, then tap Continue.';

  @override
  String get modeCheck => 'Check me';

  @override
  String get modeCheckHelp =>
      'Gives you time to say your line, then reads it so you can check yourself.';

  @override
  String get modeRun => 'Run-through';

  @override
  String get modeRunHelp =>
      'Gives you time for your line and carries on without reading it.';

  @override
  String get hint => 'Show my line as';

  @override
  String get hintFull => 'Full text';

  @override
  String get hintFirst => 'First letters';

  @override
  String get hintHidden => 'Hidden';

  @override
  String get readDirections => 'Read stage directions aloud';

  @override
  String get pauseLength => 'Time for my line';

  @override
  String get yourTurn => 'Your turn';

  @override
  String get show => 'Show';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get previousLine => 'Previous line';

  @override
  String get nextLine => 'Next line';

  @override
  String get jumpToScene => 'Jump to scene';

  @override
  String get fromStart => 'From the beginning';

  @override
  String get finished => 'Rehearsal complete.';

  @override
  String get restart => 'Start again';

  @override
  String get settings => 'Settings';

  @override
  String get appLanguage => 'App language';

  @override
  String get systemDefault => 'System default';

  @override
  String get backup => 'Back up all pieces';

  @override
  String get backupHelp =>
      'Save a backup file so you never lose your pieces when you change phones.';

  @override
  String get restore => 'Restore from backup';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pieces restored',
      one: '1 piece restored',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'This file is not a valid backup.';

  @override
  String deleteConfirm(String title) {
    return 'Delete \"$title\"? This cannot be undone.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lines',
      one: '1 line',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyText =>
      'Your texts stay on your phone and are never uploaded. Voices are produced on the device by your phone\'s text-to-speech engine. Text in photos is read on the device with Google ML Kit; photos are not sent anywhere, but ML Kit may send Google anonymous diagnostic data (such as device model and error codes). In hands-free mode the microphone is used only on the device, in real time, to notice when you have finished speaking. If you turn on “Check what I say”, your speech is turned into text by your phone\'s on-device speech recognition; the app never uses online recognition. Nothing is recorded or sent. In \"Recite from memory\" mode your speech is transcribed on the phone by the open-source Whisper model, downloaded once. The only exception is \"Record voices\": lines are recorded only when you tap \"Record\", and the recordings stay on the phone and are never sent.';

  @override
  String get privacyPolicyFull => 'Full privacy policy';

  @override
  String get appVersion => 'Version';

  @override
  String get noMyCharacter =>
      'Choose at least one character as yours before rehearsing.';

  @override
  String get me => 'Me';

  @override
  String get modeHandsFree => 'Hands-free';

  @override
  String get modeHandsFreeHelp =>
      'Listens when it\'s your turn. Say your line; when you stop talking it carries on. If you get stuck, it reads your line to you.';

  @override
  String get listening => 'Listening… say your line';

  @override
  String get micDenied =>
      'Microphone permission is needed for hands-free mode. Switched to “Wait for me”.';

  @override
  String get endSilence => 'Pause that ends my line';

  @override
  String voiceN(int n) {
    return 'Voice $n';
  }

  @override
  String get linesHeader => 'Lines';

  @override
  String get pdfScanned =>
      'This PDF has no selectable text (it looks like a scanned page). Use “From photos” to read it from a picture, or paste the text.';

  @override
  String get hintWord => 'Hint';

  @override
  String get checkAccuracy => 'Check what I say';

  @override
  String get checkAccuracyHelp =>
      'Your speech is turned into text by your phone\'s own on-device speech recognition and compared with your line. Nothing is recorded and your voice never leaves the phone.';

  @override
  String get sttUnavailable =>
      'This phone has no on-device speech recognition, so accuracy can\'t be checked. Hands-free mode still works.';

  @override
  String get sttLanguageMissing =>
      'On-device speech recognition isn\'t available for this language on your phone.';

  @override
  String get sttDownload => 'Download speech recognition for this language';

  @override
  String get sttDownloading =>
      'Downloading the language pack… This may take a few minutes.';

  @override
  String get readCorrection => 'Read the correct line if I got it wrong';

  @override
  String accuracyScore(int score) {
    return '$score% correct';
  }

  @override
  String missedWords(String words) {
    return 'Missed: $words';
  }

  @override
  String get notUnderstood => 'Couldn\'t make that out';

  @override
  String summaryAccuracy(int score) {
    return 'Average accuracy $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Prompted $count times',
      one: 'Prompted once',
      zero: 'No prompts needed',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Well done! You got through without any help.';

  @override
  String get finishedGood => 'Going well! Rehearsal complete.';

  @override
  String get finishedPractice =>
      'Rehearsal complete. Practise the lines where you got stuck.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lines',
      one: '1 line',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'prompted on $count lines',
      one: 'prompted on 1 line',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lines corrected',
      one: '1 line corrected',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lines not understood',
      one: '1 line not understood',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'From photos';

  @override
  String get takePhoto => 'Take a photo';

  @override
  String get reading => 'Reading…';

  @override
  String get docOld =>
      'Old Word files (.doc) can\'t be read. Save the document as .docx or PDF and try again.';

  @override
  String get noTextInPhoto =>
      'No readable text was found in the photo. Try a sharper, well-lit photo taken straight on.';

  @override
  String get photoAlphabet =>
      'Reading text from photos only works with the Latin alphabet. Type or paste the text instead.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'It wasn\'t clear who says $count lines. Tap the highlighted lines to fix them.',
      one: 'It wasn\'t clear who says 1 line. Tap the highlighted line to fix it.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Press Enter to split the line into two.';

  @override
  String get charactersAndVoices => 'Characters and voices';

  @override
  String get hintProgressive => 'Progressive';

  @override
  String get hintKeywords => 'Key words';

  @override
  String hideRatio(int percent) {
    return 'Hidden words: $percent%';
  }

  @override
  String levelUp(int percent) {
    return 'Great! Next round $percent% of the words will be hidden.';
  }

  @override
  String get modeBuildUp => 'Build up';

  @override
  String get modeBuildUpHelp =>
      'First line 1, then lines 1–2, then 1–3… Each new line is read to you first, then you say everything from the start. Ideal for poems and short texts.';

  @override
  String stepOf(int step, int total) {
    return 'Step $step of $total';
  }

  @override
  String get onlyWeak => 'Only lines I struggled with';

  @override
  String get onlyWeakHelp =>
      'Practise only the lines where you needed a prompt, a correction or had a low score.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lines you struggled with',
      one: '1 line you struggled with',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'No difficult lines yet';

  @override
  String elapsed(String time) {
    return 'Time $time';
  }

  @override
  String get targetTime => 'Target time';

  @override
  String get targetNone => 'No target';

  @override
  String overTarget(String time) {
    return '$time over target';
  }

  @override
  String underTarget(String time) {
    return '$time under target';
  }

  @override
  String wpm(int wpm) {
    return '$wpm words/min';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Learn by heart faster with Pro.';

  @override
  String get proFeatureHandsFree =>
      'Hands-free rehearsal: listens when it\'s your turn, no need to touch your phone';

  @override
  String proFeatureUnlimited(int count) {
    return 'Unlimited texts (free version: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days days free, then $price/month';
  }

  @override
  String proPrice(String price) {
    return '$price/month';
  }

  @override
  String get proStartTrial => 'Start free trial';

  @override
  String get proSubscribe => 'Subscribe';

  @override
  String get proRestore => 'Restore purchases';

  @override
  String get proTerms =>
      'The subscription renews automatically every month. Cancel anytime in Google Play > Subscriptions; if you cancel, Pro stays active until the end of the period.';

  @override
  String get proUnavailable =>
      'The subscription is not available right now. Please try again later.';

  @override
  String get proActive => 'Pro is active';

  @override
  String get proManage => 'Manage subscription';

  @override
  String get proUpgrade => 'Go Pro';

  @override
  String proLimitReached(int count) {
    return 'The free version can save up to $count texts.';
  }

  @override
  String get proThanks => 'Thank you! Pro is active.';

  @override
  String get proHandsFreeLocked =>
      'Hands-free rehearsal is a Pro feature. Switched to \"Wait for me\".';

  @override
  String get proNotFound => 'No active subscription found.';

  @override
  String get modePages => 'Page by page';

  @override
  String get modePagesHelp =>
      'Says \"Page 1\", and when time is up \"Time is up. Page 2\". Talk without reading; tap \"Next page\" if you finish early.';

  @override
  String pageCue(int n) {
    return 'Page $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Page $n. $title';
  }

  @override
  String get timeUp => 'Time is up.';

  @override
  String get presentationDone => 'End of presentation.';

  @override
  String get nextPage => 'Next page';

  @override
  String get pageTimes => 'Page times';

  @override
  String get pageTimesHelp =>
      'Pages come from headings in the text, or from paragraphs if there are none.';

  @override
  String get pageTimesAuto => 'Distribute automatically';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'P$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Page $n/$total';
  }

  @override
  String get emotion => 'Tone';

  @override
  String get emotionHelp =>
      'Speed, pitch and volume are adjusted for this feeling. Directions like (angrily) or (crying) in the text are detected automatically.';

  @override
  String get emoNeutral => 'Normal';

  @override
  String get emoHappy => 'Happy';

  @override
  String get emoSad => 'Sad';

  @override
  String get emoAngry => 'Angry';

  @override
  String get emoExcited => 'Excited';

  @override
  String get emoCalm => 'Calm';

  @override
  String get emoWhisper => 'Whisper';

  @override
  String get emoAfraid => 'Afraid';

  @override
  String get modeRecite => 'Recite from memory (error check)';

  @override
  String get modeReciteHelp =>
      'Say the text from memory; it stops where you skip or say something wrong and shows the mistake. You get a report at the end.';

  @override
  String get reciteTitle => 'Recite from memory';

  @override
  String get reciteModelTitle => 'Speech recognition model';

  @override
  String get reciteModelHelp =>
      'For the error check, a speech recognition model that runs on your phone is downloaded once. It is free; your voice never leaves the phone. Wi-Fi recommended.';

  @override
  String reciteModelStandard(int mb) {
    return 'Standard ($mb MB) — fast';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'High accuracy ($mb MB) — slower';
  }

  @override
  String get reciteDownload => 'Download';

  @override
  String reciteDownloading(int pct) {
    return 'Downloading… $pct%';
  }

  @override
  String get reciteDownloadFailed =>
      'Download failed. Check your connection and try again.';

  @override
  String get reciteLoading => 'Loading model…';

  @override
  String get reciteStart => 'Start';

  @override
  String get reciteListening => 'Listening… Say the text from the beginning.';

  @override
  String get reciteChecking => 'Checking…';

  @override
  String reciteHeard(String text) {
    return 'I heard: $text';
  }

  @override
  String get reciteSkipped => 'You skipped a part';

  @override
  String get reciteWrong => 'You said it wrong';

  @override
  String reciteExpected(String text) {
    return 'Correct: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'You said: $text';
  }

  @override
  String get reciteContinueHere => 'Continue from here';

  @override
  String get reciteFinish => 'Finish';

  @override
  String reciteAccuracy(int n) {
    return 'Accuracy: $n%';
  }

  @override
  String get reciteNoErrors => 'No mistakes, great!';

  @override
  String reciteMinor(int n) {
    return '$n small skips (short words)';
  }

  @override
  String get reciteAgain => 'Again';

  @override
  String get reciteNote =>
      'Recognition is not perfect; it may stop you where it is unsure.';

  @override
  String get reciteLoadFailed =>
      'The model could not be opened. Try deleting and downloading it again.';

  @override
  String get recordLines => 'Record voices';

  @override
  String get recordLinesHelp =>
      'Record the other characters\' lines in your own voice or a friend\'s; they play instead of the synthetic voice during rehearsal, with real emotion. Recordings stay on the phone and are not included in backups.';

  @override
  String get recordStart => 'Record';

  @override
  String get recordStop => 'Stop';

  @override
  String get recordPlay => 'Listen';

  @override
  String get recordDelete => 'Delete recording';

  @override
  String get recordNext => 'Next';

  @override
  String get recordPrev => 'Previous';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total lines recorded';
  }

  @override
  String get recordIncludeMine => 'Show my own lines too';

  @override
  String get recordNone => 'No lines to record.';

  @override
  String get recordingNow => 'Recording…';

  @override
  String get recordedBadge => 'Recorded';
}
