import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L
/// returned by `L.of(context)`.
///
/// Applications need to include `L.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L.localizationsDelegates,
///   supportedLocales: L.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L.supportedLocales
/// property.
abstract class L {
  L(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L of(BuildContext context) {
    return Localizations.of<L>(context, L)!;
  }

  static const LocalizationsDelegate<L> delegate = _LDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Memorize Assistant'**
  String get appTitle;

  /// No description provided for @library.
  ///
  /// In en, this message translates to:
  /// **'My pieces'**
  String get library;

  /// No description provided for @emptyLibrary.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet. Add a play, a poem or a speech and start memorizing.'**
  String get emptyLibrary;

  /// No description provided for @newPiece.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newPiece;

  /// No description provided for @kindPlay.
  ///
  /// In en, this message translates to:
  /// **'Play / scene'**
  String get kindPlay;

  /// No description provided for @kindPoem.
  ///
  /// In en, this message translates to:
  /// **'Poem / text'**
  String get kindPoem;

  /// No description provided for @kindSpeech.
  ///
  /// In en, this message translates to:
  /// **'Speech / presentation'**
  String get kindSpeech;

  /// No description provided for @kindPlayHelp.
  ///
  /// In en, this message translates to:
  /// **'Write each line as NAME: line. Put stage directions in (parentheses). Screenplay format also works.'**
  String get kindPlayHelp;

  /// No description provided for @kindPoemHelp.
  ///
  /// In en, this message translates to:
  /// **'Each line becomes a step. Good for poems, songs, lists and any text to learn word for word.'**
  String get kindPoemHelp;

  /// No description provided for @kindSpeechHelp.
  ///
  /// In en, this message translates to:
  /// **'Each sentence or paragraph on its own line becomes a step. Track your time and speaking pace.'**
  String get kindSpeechHelp;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @voiceLanguage.
  ///
  /// In en, this message translates to:
  /// **'Voice language'**
  String get voiceLanguage;

  /// No description provided for @pasteHint.
  ///
  /// In en, this message translates to:
  /// **'Paste or type your text here'**
  String get pasteHint;

  /// No description provided for @importFile.
  ///
  /// In en, this message translates to:
  /// **'Open file (.txt, .pdf, .docx)'**
  String get importFile;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'This file could not be read. Please use a plain text (.txt) file.'**
  String get importFailed;

  /// No description provided for @continueAction.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// No description provided for @reviewTitle.
  ///
  /// In en, this message translates to:
  /// **'Check the lines'**
  String get reviewTitle;

  /// No description provided for @reviewHelp.
  ///
  /// In en, this message translates to:
  /// **'Tap a name to give the line to another character. Tap the text to edit it. Use ⋮ for more.'**
  String get reviewHelp;

  /// No description provided for @whoAmI.
  ///
  /// In en, this message translates to:
  /// **'Which character are you?'**
  String get whoAmI;

  /// No description provided for @whoAmIHelp.
  ///
  /// In en, this message translates to:
  /// **'Your lines will be the ones you practise.'**
  String get whoAmIHelp;

  /// No description provided for @characters.
  ///
  /// In en, this message translates to:
  /// **'Characters'**
  String get characters;

  /// No description provided for @direction.
  ///
  /// In en, this message translates to:
  /// **'Direction'**
  String get direction;

  /// No description provided for @heading.
  ///
  /// In en, this message translates to:
  /// **'Scene'**
  String get heading;

  /// No description provided for @editLine.
  ///
  /// In en, this message translates to:
  /// **'Edit text'**
  String get editLine;

  /// No description provided for @deleteLine.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteLine;

  /// No description provided for @mergeWithPrevious.
  ///
  /// In en, this message translates to:
  /// **'Join with the line above'**
  String get mergeWithPrevious;

  /// No description provided for @makeDirection.
  ///
  /// In en, this message translates to:
  /// **'Make it a stage direction'**
  String get makeDirection;

  /// No description provided for @makeHeading.
  ///
  /// In en, this message translates to:
  /// **'Make it a scene heading'**
  String get makeHeading;

  /// No description provided for @makeDialogue.
  ///
  /// In en, this message translates to:
  /// **'Make it a spoken line'**
  String get makeDialogue;

  /// No description provided for @addLineBelow.
  ///
  /// In en, this message translates to:
  /// **'Add a line below'**
  String get addLineBelow;

  /// No description provided for @assignTo.
  ///
  /// In en, this message translates to:
  /// **'Who says this?'**
  String get assignTo;

  /// No description provided for @newCharacter.
  ///
  /// In en, this message translates to:
  /// **'New character'**
  String get newCharacter;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @mergeInto.
  ///
  /// In en, this message translates to:
  /// **'Merge into…'**
  String get mergeInto;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @voice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get voice;

  /// No description provided for @pitch.
  ///
  /// In en, this message translates to:
  /// **'Pitch'**
  String get pitch;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// No description provided for @testVoice.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get testVoice;

  /// No description provided for @defaultVoice.
  ///
  /// In en, this message translates to:
  /// **'Default voice'**
  String get defaultVoice;

  /// No description provided for @testSentence.
  ///
  /// In en, this message translates to:
  /// **'Hello! This is how I will sound.'**
  String get testSentence;

  /// No description provided for @noVoices.
  ///
  /// In en, this message translates to:
  /// **'No voice for this language was found on your device. You can install one in Android\'s text-to-speech settings.'**
  String get noVoices;

  /// No description provided for @rehearse.
  ///
  /// In en, this message translates to:
  /// **'Rehearse'**
  String get rehearse;

  /// No description provided for @mode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get mode;

  /// No description provided for @modeListen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get modeListen;

  /// No description provided for @modeListenHelp.
  ///
  /// In en, this message translates to:
  /// **'Everything is read aloud. Good for getting to know the piece.'**
  String get modeListenHelp;

  /// No description provided for @modeWait.
  ///
  /// In en, this message translates to:
  /// **'Wait for me'**
  String get modeWait;

  /// No description provided for @modeWaitHelp.
  ///
  /// In en, this message translates to:
  /// **'Stops at your line. Say it, then tap Continue.'**
  String get modeWaitHelp;

  /// No description provided for @modeCheck.
  ///
  /// In en, this message translates to:
  /// **'Check me'**
  String get modeCheck;

  /// No description provided for @modeCheckHelp.
  ///
  /// In en, this message translates to:
  /// **'Gives you time to say your line, then reads it so you can check yourself.'**
  String get modeCheckHelp;

  /// No description provided for @modeRun.
  ///
  /// In en, this message translates to:
  /// **'Run-through'**
  String get modeRun;

  /// No description provided for @modeRunHelp.
  ///
  /// In en, this message translates to:
  /// **'Gives you time for your line and carries on without reading it.'**
  String get modeRunHelp;

  /// No description provided for @hint.
  ///
  /// In en, this message translates to:
  /// **'Show my line as'**
  String get hint;

  /// No description provided for @hintFull.
  ///
  /// In en, this message translates to:
  /// **'Full text'**
  String get hintFull;

  /// No description provided for @hintFirst.
  ///
  /// In en, this message translates to:
  /// **'First letters'**
  String get hintFirst;

  /// No description provided for @hintHidden.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get hintHidden;

  /// No description provided for @readDirections.
  ///
  /// In en, this message translates to:
  /// **'Read stage directions aloud'**
  String get readDirections;

  /// No description provided for @pauseLength.
  ///
  /// In en, this message translates to:
  /// **'Time for my line'**
  String get pauseLength;

  /// No description provided for @yourTurn.
  ///
  /// In en, this message translates to:
  /// **'Your turn'**
  String get yourTurn;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @previousLine.
  ///
  /// In en, this message translates to:
  /// **'Previous line'**
  String get previousLine;

  /// No description provided for @nextLine.
  ///
  /// In en, this message translates to:
  /// **'Next line'**
  String get nextLine;

  /// No description provided for @jumpToScene.
  ///
  /// In en, this message translates to:
  /// **'Jump to scene'**
  String get jumpToScene;

  /// No description provided for @fromStart.
  ///
  /// In en, this message translates to:
  /// **'From the beginning'**
  String get fromStart;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Rehearsal complete.'**
  String get finished;

  /// No description provided for @restart.
  ///
  /// In en, this message translates to:
  /// **'Start again'**
  String get restart;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appLanguage.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get appLanguage;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Back up all pieces'**
  String get backup;

  /// No description provided for @backupHelp.
  ///
  /// In en, this message translates to:
  /// **'Save a backup file so you never lose your pieces when you change phones.'**
  String get backupHelp;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore from backup'**
  String get restore;

  /// No description provided for @restoreDone.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 piece restored} other{{count} pieces restored}}'**
  String restoreDone(int count);

  /// No description provided for @restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'This file is not a valid backup.'**
  String get restoreFailed;

  /// No description provided for @deleteConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{title}\"? This cannot be undone.'**
  String deleteConfirm(String title);

  /// No description provided for @lineCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 line} other{{count} lines}}'**
  String lineCount(int count);

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyText.
  ///
  /// In en, this message translates to:
  /// **'Your texts stay on your phone and are never uploaded. Voices are produced on the device by your phone\'s text-to-speech engine. Text in photos is read on the device with Google ML Kit; photos are not sent anywhere, but ML Kit may send Google anonymous diagnostic data (such as device model and error codes). In hands-free mode the microphone is used only on the device, in real time, to notice when you have finished speaking. If you turn on “Check what I say”, your speech is turned into text by your phone\'s on-device speech recognition; the app never uses online recognition. Nothing is recorded or sent. In \"Recite from memory\" mode your speech is transcribed on the phone by the open-source Whisper model, downloaded once. The only exception is \"Record voices\": lines are recorded only when you tap \"Record\", and the recordings stay on the phone and are never sent.'**
  String get privacyText;

  /// No description provided for @privacyPolicyFull.
  ///
  /// In en, this message translates to:
  /// **'Full privacy policy'**
  String get privacyPolicyFull;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get appVersion;

  /// No description provided for @noMyCharacter.
  ///
  /// In en, this message translates to:
  /// **'Choose at least one character as yours before rehearsing.'**
  String get noMyCharacter;

  /// No description provided for @me.
  ///
  /// In en, this message translates to:
  /// **'Me'**
  String get me;

  /// No description provided for @modeHandsFree.
  ///
  /// In en, this message translates to:
  /// **'Hands-free'**
  String get modeHandsFree;

  /// No description provided for @modeHandsFreeHelp.
  ///
  /// In en, this message translates to:
  /// **'Listens when it\'s your turn. Say your line; when you stop talking it carries on. If you get stuck, it reads your line to you.'**
  String get modeHandsFreeHelp;

  /// No description provided for @listening.
  ///
  /// In en, this message translates to:
  /// **'Listening… say your line'**
  String get listening;

  /// No description provided for @micDenied.
  ///
  /// In en, this message translates to:
  /// **'Microphone permission is needed for hands-free mode. Switched to “Wait for me”.'**
  String get micDenied;

  /// No description provided for @endSilence.
  ///
  /// In en, this message translates to:
  /// **'Pause that ends my line'**
  String get endSilence;

  /// No description provided for @voiceN.
  ///
  /// In en, this message translates to:
  /// **'Voice {n}'**
  String voiceN(int n);

  /// No description provided for @linesHeader.
  ///
  /// In en, this message translates to:
  /// **'Lines'**
  String get linesHeader;

  /// No description provided for @pdfScanned.
  ///
  /// In en, this message translates to:
  /// **'This PDF has no selectable text (it looks like a scanned page). Use “From photos” to read it from a picture, or paste the text.'**
  String get pdfScanned;

  /// No description provided for @hintWord.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hintWord;

  /// No description provided for @checkAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Check what I say'**
  String get checkAccuracy;

  /// No description provided for @checkAccuracyHelp.
  ///
  /// In en, this message translates to:
  /// **'Your speech is turned into text by your phone\'s own on-device speech recognition and compared with your line. Nothing is recorded and your voice never leaves the phone.'**
  String get checkAccuracyHelp;

  /// No description provided for @sttUnavailable.
  ///
  /// In en, this message translates to:
  /// **'This phone has no on-device speech recognition, so accuracy can\'t be checked. Hands-free mode still works.'**
  String get sttUnavailable;

  /// No description provided for @sttLanguageMissing.
  ///
  /// In en, this message translates to:
  /// **'On-device speech recognition isn\'t available for this language on your phone.'**
  String get sttLanguageMissing;

  /// No description provided for @sttDownload.
  ///
  /// In en, this message translates to:
  /// **'Download speech recognition for this language'**
  String get sttDownload;

  /// No description provided for @sttDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading the language pack… This may take a few minutes.'**
  String get sttDownloading;

  /// No description provided for @readCorrection.
  ///
  /// In en, this message translates to:
  /// **'Read the correct line if I got it wrong'**
  String get readCorrection;

  /// No description provided for @accuracyScore.
  ///
  /// In en, this message translates to:
  /// **'{score}% correct'**
  String accuracyScore(int score);

  /// No description provided for @missedWords.
  ///
  /// In en, this message translates to:
  /// **'Missed: {words}'**
  String missedWords(String words);

  /// No description provided for @notUnderstood.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t make that out'**
  String get notUnderstood;

  /// No description provided for @summaryAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Average accuracy {score}%'**
  String summaryAccuracy(int score);

  /// No description provided for @summaryPrompts.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No prompts needed} =1{Prompted once} other{Prompted {count} times}}'**
  String summaryPrompts(int count);

  /// No description provided for @finishedPerfect.
  ///
  /// In en, this message translates to:
  /// **'Well done! You got through without any help.'**
  String get finishedPerfect;

  /// No description provided for @finishedGood.
  ///
  /// In en, this message translates to:
  /// **'Going well! Rehearsal complete.'**
  String get finishedGood;

  /// No description provided for @finishedPractice.
  ///
  /// In en, this message translates to:
  /// **'Rehearsal complete. Practise the lines where you got stuck.'**
  String get finishedPractice;

  /// No description provided for @summaryLines.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 line} other{{count} lines}}'**
  String summaryLines(int count);

  /// No description provided for @summaryPrompted.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{prompted on 1 line} other{prompted on {count} lines}}'**
  String summaryPrompted(int count);

  /// No description provided for @summaryCorrected.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 line corrected} other{{count} lines corrected}}'**
  String summaryCorrected(int count);

  /// No description provided for @summaryUnclear.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 line not understood} other{{count} lines not understood}}'**
  String summaryUnclear(int count);

  /// No description provided for @importPhoto.
  ///
  /// In en, this message translates to:
  /// **'From photos'**
  String get importPhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takePhoto;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading…'**
  String get reading;

  /// No description provided for @docOld.
  ///
  /// In en, this message translates to:
  /// **'Old Word files (.doc) can\'t be read. Save the document as .docx or PDF and try again.'**
  String get docOld;

  /// No description provided for @noTextInPhoto.
  ///
  /// In en, this message translates to:
  /// **'No readable text was found in the photo. Try a sharper, well-lit photo taken straight on.'**
  String get noTextInPhoto;

  /// No description provided for @photoAlphabet.
  ///
  /// In en, this message translates to:
  /// **'Reading text from photos only works with the Latin alphabet. Type or paste the text instead.'**
  String get photoAlphabet;

  /// No description provided for @unsureBanner.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{It wasn\'t clear who says 1 line. Tap the highlighted line to fix it.} other{It wasn\'t clear who says {count} lines. Tap the highlighted lines to fix them.}}'**
  String unsureBanner(int count);

  /// No description provided for @splitHint.
  ///
  /// In en, this message translates to:
  /// **'Press Enter to split the line into two.'**
  String get splitHint;

  /// No description provided for @charactersAndVoices.
  ///
  /// In en, this message translates to:
  /// **'Characters and voices'**
  String get charactersAndVoices;

  /// No description provided for @hintProgressive.
  ///
  /// In en, this message translates to:
  /// **'Progressive'**
  String get hintProgressive;

  /// No description provided for @hintKeywords.
  ///
  /// In en, this message translates to:
  /// **'Key words'**
  String get hintKeywords;

  /// No description provided for @hideRatio.
  ///
  /// In en, this message translates to:
  /// **'Hidden words: {percent}%'**
  String hideRatio(int percent);

  /// No description provided for @levelUp.
  ///
  /// In en, this message translates to:
  /// **'Great! Next round {percent}% of the words will be hidden.'**
  String levelUp(int percent);

  /// No description provided for @modeBuildUp.
  ///
  /// In en, this message translates to:
  /// **'Build up'**
  String get modeBuildUp;

  /// No description provided for @modeBuildUpHelp.
  ///
  /// In en, this message translates to:
  /// **'First line 1, then lines 1–2, then 1–3… Each new line is read to you first, then you say everything from the start. Ideal for poems and short texts.'**
  String get modeBuildUpHelp;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Step {step} of {total}'**
  String stepOf(int step, int total);

  /// No description provided for @onlyWeak.
  ///
  /// In en, this message translates to:
  /// **'Only lines I struggled with'**
  String get onlyWeak;

  /// No description provided for @onlyWeakHelp.
  ///
  /// In en, this message translates to:
  /// **'Practise only the lines where you needed a prompt, a correction or had a low score.'**
  String get onlyWeakHelp;

  /// No description provided for @weakCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 line you struggled with} other{{count} lines you struggled with}}'**
  String weakCount(int count);

  /// No description provided for @noWeak.
  ///
  /// In en, this message translates to:
  /// **'No difficult lines yet'**
  String get noWeak;

  /// No description provided for @elapsed.
  ///
  /// In en, this message translates to:
  /// **'Time {time}'**
  String elapsed(String time);

  /// No description provided for @targetTime.
  ///
  /// In en, this message translates to:
  /// **'Target time'**
  String get targetTime;

  /// No description provided for @targetNone.
  ///
  /// In en, this message translates to:
  /// **'No target'**
  String get targetNone;

  /// No description provided for @overTarget.
  ///
  /// In en, this message translates to:
  /// **'{time} over target'**
  String overTarget(String time);

  /// No description provided for @underTarget.
  ///
  /// In en, this message translates to:
  /// **'{time} under target'**
  String underTarget(String time);

  /// No description provided for @wpm.
  ///
  /// In en, this message translates to:
  /// **'{wpm} words/min'**
  String wpm(int wpm);

  /// No description provided for @proTitle.
  ///
  /// In en, this message translates to:
  /// **'Memorize Pro'**
  String get proTitle;

  /// No description provided for @proPitch.
  ///
  /// In en, this message translates to:
  /// **'Learn by heart faster with Pro.'**
  String get proPitch;

  /// No description provided for @proFeatureHandsFree.
  ///
  /// In en, this message translates to:
  /// **'Hands-free rehearsal: listens when it\'s your turn, no need to touch your phone'**
  String get proFeatureHandsFree;

  /// No description provided for @proFeatureUnlimited.
  ///
  /// In en, this message translates to:
  /// **'Unlimited texts (free version: {count})'**
  String proFeatureUnlimited(int count);

  /// No description provided for @proTrial.
  ///
  /// In en, this message translates to:
  /// **'{days} days free, then {price}/month'**
  String proTrial(int days, String price);

  /// No description provided for @proPrice.
  ///
  /// In en, this message translates to:
  /// **'{price}/month'**
  String proPrice(String price);

  /// No description provided for @proStartTrial.
  ///
  /// In en, this message translates to:
  /// **'Start free trial'**
  String get proStartTrial;

  /// No description provided for @proSubscribe.
  ///
  /// In en, this message translates to:
  /// **'Subscribe'**
  String get proSubscribe;

  /// No description provided for @proRestore.
  ///
  /// In en, this message translates to:
  /// **'Restore purchases'**
  String get proRestore;

  /// No description provided for @proTerms.
  ///
  /// In en, this message translates to:
  /// **'The subscription renews automatically every month. Cancel anytime in Google Play > Subscriptions; if you cancel, Pro stays active until the end of the period.'**
  String get proTerms;

  /// No description provided for @proUnavailable.
  ///
  /// In en, this message translates to:
  /// **'The subscription is not available right now. Please try again later.'**
  String get proUnavailable;

  /// No description provided for @proActive.
  ///
  /// In en, this message translates to:
  /// **'Pro is active'**
  String get proActive;

  /// No description provided for @proManage.
  ///
  /// In en, this message translates to:
  /// **'Manage subscription'**
  String get proManage;

  /// No description provided for @proUpgrade.
  ///
  /// In en, this message translates to:
  /// **'Go Pro'**
  String get proUpgrade;

  /// No description provided for @proLimitReached.
  ///
  /// In en, this message translates to:
  /// **'The free version can save up to {count} texts.'**
  String proLimitReached(int count);

  /// No description provided for @proThanks.
  ///
  /// In en, this message translates to:
  /// **'Thank you! Pro is active.'**
  String get proThanks;

  /// No description provided for @proHandsFreeLocked.
  ///
  /// In en, this message translates to:
  /// **'Hands-free rehearsal is a Pro feature. Switched to \"Wait for me\".'**
  String get proHandsFreeLocked;

  /// No description provided for @proNotFound.
  ///
  /// In en, this message translates to:
  /// **'No active subscription found.'**
  String get proNotFound;

  /// No description provided for @modePages.
  ///
  /// In en, this message translates to:
  /// **'Page by page'**
  String get modePages;

  /// No description provided for @modePagesHelp.
  ///
  /// In en, this message translates to:
  /// **'Says \"Page 1\", and when time is up \"Time is up. Page 2\". Talk without reading; tap \"Next page\" if you finish early.'**
  String get modePagesHelp;

  /// No description provided for @pageCue.
  ///
  /// In en, this message translates to:
  /// **'Page {n}'**
  String pageCue(int n);

  /// No description provided for @pageCueTitled.
  ///
  /// In en, this message translates to:
  /// **'Page {n}. {title}'**
  String pageCueTitled(int n, String title);

  /// No description provided for @timeUp.
  ///
  /// In en, this message translates to:
  /// **'Time is up.'**
  String get timeUp;

  /// No description provided for @presentationDone.
  ///
  /// In en, this message translates to:
  /// **'End of presentation.'**
  String get presentationDone;

  /// No description provided for @nextPage.
  ///
  /// In en, this message translates to:
  /// **'Next page'**
  String get nextPage;

  /// No description provided for @pageTimes.
  ///
  /// In en, this message translates to:
  /// **'Page times'**
  String get pageTimes;

  /// No description provided for @pageTimesHelp.
  ///
  /// In en, this message translates to:
  /// **'Pages come from headings in the text, or from paragraphs if there are none.'**
  String get pageTimesHelp;

  /// No description provided for @pageTimesAuto.
  ///
  /// In en, this message translates to:
  /// **'Distribute automatically'**
  String get pageTimesAuto;

  /// No description provided for @pageSummary.
  ///
  /// In en, this message translates to:
  /// **'P{n} {used}/{planned}'**
  String pageSummary(int n, String used, String planned);

  /// No description provided for @pageOf.
  ///
  /// In en, this message translates to:
  /// **'Page {n}/{total}'**
  String pageOf(int n, int total);

  /// No description provided for @emotion.
  ///
  /// In en, this message translates to:
  /// **'Tone'**
  String get emotion;

  /// No description provided for @emotionHelp.
  ///
  /// In en, this message translates to:
  /// **'Speed, pitch and volume are adjusted for this feeling. Directions like (angrily) or (crying) in the text are detected automatically.'**
  String get emotionHelp;

  /// No description provided for @emoNeutral.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get emoNeutral;

  /// No description provided for @emoHappy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get emoHappy;

  /// No description provided for @emoSad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get emoSad;

  /// No description provided for @emoAngry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get emoAngry;

  /// No description provided for @emoExcited.
  ///
  /// In en, this message translates to:
  /// **'Excited'**
  String get emoExcited;

  /// No description provided for @emoCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get emoCalm;

  /// No description provided for @emoWhisper.
  ///
  /// In en, this message translates to:
  /// **'Whisper'**
  String get emoWhisper;

  /// No description provided for @emoAfraid.
  ///
  /// In en, this message translates to:
  /// **'Afraid'**
  String get emoAfraid;

  /// No description provided for @modeRecite.
  ///
  /// In en, this message translates to:
  /// **'Recite from memory (error check)'**
  String get modeRecite;

  /// No description provided for @modeReciteHelp.
  ///
  /// In en, this message translates to:
  /// **'Say the text from memory; it stops where you skip or say something wrong and shows the mistake. You get a report at the end.'**
  String get modeReciteHelp;

  /// No description provided for @reciteTitle.
  ///
  /// In en, this message translates to:
  /// **'Recite from memory'**
  String get reciteTitle;

  /// No description provided for @reciteModelTitle.
  ///
  /// In en, this message translates to:
  /// **'Speech recognition model'**
  String get reciteModelTitle;

  /// No description provided for @reciteModelHelp.
  ///
  /// In en, this message translates to:
  /// **'For the error check, a speech recognition model that runs on your phone is downloaded once. It is free; your voice never leaves the phone. Wi-Fi recommended.'**
  String get reciteModelHelp;

  /// No description provided for @reciteModelStandard.
  ///
  /// In en, this message translates to:
  /// **'Standard ({mb} MB) — fast'**
  String reciteModelStandard(int mb);

  /// No description provided for @reciteModelAccurate.
  ///
  /// In en, this message translates to:
  /// **'High accuracy ({mb} MB) — slower'**
  String reciteModelAccurate(int mb);

  /// No description provided for @reciteDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get reciteDownload;

  /// No description provided for @reciteDownloading.
  ///
  /// In en, this message translates to:
  /// **'Downloading… {pct}%'**
  String reciteDownloading(int pct);

  /// No description provided for @reciteDownloadFailed.
  ///
  /// In en, this message translates to:
  /// **'Download failed. Check your connection and try again.'**
  String get reciteDownloadFailed;

  /// No description provided for @reciteLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading model…'**
  String get reciteLoading;

  /// No description provided for @reciteStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get reciteStart;

  /// No description provided for @reciteListening.
  ///
  /// In en, this message translates to:
  /// **'Listening… Say the text from the beginning.'**
  String get reciteListening;

  /// No description provided for @reciteChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking…'**
  String get reciteChecking;

  /// No description provided for @reciteHeard.
  ///
  /// In en, this message translates to:
  /// **'I heard: {text}'**
  String reciteHeard(String text);

  /// No description provided for @reciteSkipped.
  ///
  /// In en, this message translates to:
  /// **'You skipped a part'**
  String get reciteSkipped;

  /// No description provided for @reciteWrong.
  ///
  /// In en, this message translates to:
  /// **'You said it wrong'**
  String get reciteWrong;

  /// No description provided for @reciteExpected.
  ///
  /// In en, this message translates to:
  /// **'Correct: {text}'**
  String reciteExpected(String text);

  /// No description provided for @reciteYouSaid.
  ///
  /// In en, this message translates to:
  /// **'You said: {text}'**
  String reciteYouSaid(String text);

  /// No description provided for @reciteContinueHere.
  ///
  /// In en, this message translates to:
  /// **'Continue from here'**
  String get reciteContinueHere;

  /// No description provided for @reciteFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get reciteFinish;

  /// No description provided for @reciteAccuracy.
  ///
  /// In en, this message translates to:
  /// **'Accuracy: {n}%'**
  String reciteAccuracy(int n);

  /// No description provided for @reciteNoErrors.
  ///
  /// In en, this message translates to:
  /// **'No mistakes, great!'**
  String get reciteNoErrors;

  /// No description provided for @reciteMinor.
  ///
  /// In en, this message translates to:
  /// **'{n} small skips (short words)'**
  String reciteMinor(int n);

  /// No description provided for @reciteAgain.
  ///
  /// In en, this message translates to:
  /// **'Again'**
  String get reciteAgain;

  /// No description provided for @reciteNote.
  ///
  /// In en, this message translates to:
  /// **'Recognition is not perfect; it may stop you where it is unsure.'**
  String get reciteNote;

  /// No description provided for @reciteLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'The model could not be opened. Try deleting and downloading it again.'**
  String get reciteLoadFailed;

  /// No description provided for @recordLines.
  ///
  /// In en, this message translates to:
  /// **'Record voices'**
  String get recordLines;

  /// No description provided for @recordLinesHelp.
  ///
  /// In en, this message translates to:
  /// **'Record the other characters\' lines in your own voice or a friend\'s; they play instead of the synthetic voice during rehearsal, with real emotion. Recordings stay on the phone and are not included in backups.'**
  String get recordLinesHelp;

  /// No description provided for @recordStart.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get recordStart;

  /// No description provided for @recordStop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get recordStop;

  /// No description provided for @recordPlay.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get recordPlay;

  /// No description provided for @recordDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete recording'**
  String get recordDelete;

  /// No description provided for @recordNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get recordNext;

  /// No description provided for @recordPrev.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get recordPrev;

  /// No description provided for @recordedCount.
  ///
  /// In en, this message translates to:
  /// **'{n}/{total} lines recorded'**
  String recordedCount(int n, int total);

  /// No description provided for @recordIncludeMine.
  ///
  /// In en, this message translates to:
  /// **'Show my own lines too'**
  String get recordIncludeMine;

  /// No description provided for @recordNone.
  ///
  /// In en, this message translates to:
  /// **'No lines to record.'**
  String get recordNone;

  /// No description provided for @recordingNow.
  ///
  /// In en, this message translates to:
  /// **'Recording…'**
  String get recordingNow;

  /// No description provided for @recordedBadge.
  ///
  /// In en, this message translates to:
  /// **'Recorded'**
  String get recordedBadge;
}

class _LDelegate extends LocalizationsDelegate<L> {
  const _LDelegate();

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(lookupL(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'id',
    'it',
    'ja',
    'ko',
    'pt',
    'ru',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_LDelegate old) => false;
}

L lookupL(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return LAr();
    case 'de':
      return LDe();
    case 'en':
      return LEn();
    case 'es':
      return LEs();
    case 'fr':
      return LFr();
    case 'hi':
      return LHi();
    case 'id':
      return LId();
    case 'it':
      return LIt();
    case 'ja':
      return LJa();
    case 'ko':
      return LKo();
    case 'pt':
      return LPt();
    case 'ru':
      return LRu();
    case 'tr':
      return LTr();
    case 'zh':
      return LZh();
  }

  throw FlutterError(
    'L.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
