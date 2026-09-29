// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class LDe extends L {
  LDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Auswendiglern-Assistent';

  @override
  String get library => 'Meine Texte';

  @override
  String get emptyLibrary =>
      'Noch nichts da. Füge ein Stück, ein Gedicht oder eine Rede hinzu und fang an zu lernen.';

  @override
  String get newPiece => 'Neu';

  @override
  String get kindPlay => 'Theaterstück / Szene';

  @override
  String get kindPoem => 'Gedicht / Text';

  @override
  String get kindSpeech => 'Rede / Präsentation';

  @override
  String get kindPlayHelp =>
      'Schreibe jede Replik als NAME: Text. Regieanweisungen in (Klammern). Drehbuchformat funktioniert auch.';

  @override
  String get kindPoemHelp =>
      'Jede Zeile wird ein Schritt. Für Gedichte, Lieder, Listen und jeden Text, der Wort für Wort sitzen muss.';

  @override
  String get kindSpeechHelp =>
      'Jeder Satz oder Absatz in einer eigenen Zeile wird ein Schritt. Behalte Zeit und Sprechtempo im Blick.';

  @override
  String get title => 'Titel';

  @override
  String get voiceLanguage => 'Sprache der Stimme';

  @override
  String get pasteHint => 'Text hier einfügen oder eintippen';

  @override
  String get importFile => 'Datei öffnen (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'Diese Datei konnte nicht gelesen werden. Bitte verwende eine reine Textdatei (.txt).';

  @override
  String get continueAction => 'Weiter';

  @override
  String get reviewTitle => 'Zeilen prüfen';

  @override
  String get reviewHelp =>
      'Tippe auf einen Namen, um die Zeile einer anderen Rolle zu geben. Tippe auf den Text, um ihn zu bearbeiten. Mehr unter ⋮.';

  @override
  String get whoAmI => 'Welche Rolle spielst du?';

  @override
  String get whoAmIHelp => 'Die Repliken dieser Rolle sind die, die du übst.';

  @override
  String get characters => 'Rollen';

  @override
  String get direction => 'Regieanweisung';

  @override
  String get heading => 'Szene';

  @override
  String get editLine => 'Text bearbeiten';

  @override
  String get deleteLine => 'Löschen';

  @override
  String get mergeWithPrevious => 'Mit der Zeile darüber verbinden';

  @override
  String get makeDirection => 'Zur Regieanweisung machen';

  @override
  String get makeHeading => 'Zur Szenenüberschrift machen';

  @override
  String get makeDialogue => 'Zur gesprochenen Zeile machen';

  @override
  String get addLineBelow => 'Zeile darunter einfügen';

  @override
  String get assignTo => 'Wer sagt das?';

  @override
  String get newCharacter => 'Neue Rolle';

  @override
  String get save => 'Speichern';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get rename => 'Umbenennen';

  @override
  String get mergeInto => 'Zusammenführen mit…';

  @override
  String get name => 'Name';

  @override
  String get voice => 'Stimme';

  @override
  String get pitch => 'Tonhöhe';

  @override
  String get speed => 'Tempo';

  @override
  String get testVoice => 'Anhören';

  @override
  String get defaultVoice => 'Standardstimme';

  @override
  String get testSentence => 'Hallo! So werde ich klingen.';

  @override
  String get noVoices =>
      'Auf deinem Gerät wurde keine Stimme für diese Sprache gefunden. Du kannst eine in den Android-Einstellungen für Sprachausgabe installieren.';

  @override
  String get rehearse => 'Proben';

  @override
  String get mode => 'Modus';

  @override
  String get modeListen => 'Zuhören';

  @override
  String get modeListenHelp =>
      'Alles wird vorgelesen. Gut, um den Text kennenzulernen.';

  @override
  String get modeWait => 'Auf mich warten';

  @override
  String get modeWaitHelp =>
      'Hält bei deiner Replik an. Sprich sie, dann tippe auf Weiter.';

  @override
  String get modeCheck => 'Mich prüfen';

  @override
  String get modeCheckHelp =>
      'Gibt dir Zeit für deine Replik und liest sie dann vor, damit du dich prüfen kannst.';

  @override
  String get modeRun => 'Durchlauf';

  @override
  String get modeRunHelp =>
      'Gibt dir Zeit für deine Replik und macht weiter, ohne sie vorzulesen.';

  @override
  String get hint => 'Meine Replik anzeigen als';

  @override
  String get hintFull => 'Ganzer Text';

  @override
  String get hintFirst => 'Anfangsbuchstaben';

  @override
  String get hintHidden => 'Verborgen';

  @override
  String get readDirections => 'Regieanweisungen vorlesen';

  @override
  String get pauseLength => 'Zeit für meine Replik';

  @override
  String get yourTurn => 'Du bist dran';

  @override
  String get show => 'Zeigen';

  @override
  String get play => 'Start';

  @override
  String get pause => 'Pause';

  @override
  String get previousLine => 'Vorherige Zeile';

  @override
  String get nextLine => 'Nächste Zeile';

  @override
  String get jumpToScene => 'Zur Szene springen';

  @override
  String get fromStart => 'Von Anfang an';

  @override
  String get finished => 'Probe beendet.';

  @override
  String get restart => 'Neu beginnen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get appLanguage => 'App-Sprache';

  @override
  String get systemDefault => 'Systemstandard';

  @override
  String get backup => 'Alle Texte sichern';

  @override
  String get backupHelp =>
      'Speichere eine Sicherungsdatei, damit du deine Texte beim Handywechsel nicht verlierst.';

  @override
  String get restore => 'Aus Sicherung wiederherstellen';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Texte wiederhergestellt',
      one: '1 Text wiederhergestellt',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'Diese Datei ist keine gültige Sicherung.';

  @override
  String deleteConfirm(String title) {
    return '„$title“ löschen? Das kann nicht rückgängig gemacht werden.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Zeilen',
      one: '1 Zeile',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Datenschutz';

  @override
  String get privacyText =>
      'Deine Texte bleiben auf deinem Handy und werden nirgendwo hochgeladen. Die Stimmen erzeugt die Sprachausgabe deines Handys direkt auf dem Gerät. Text in Fotos wird mit Google ML Kit auf dem Gerät gelesen; Fotos werden nicht gesendet, ML Kit kann Google jedoch anonyme Diagnosedaten (z. B. Gerätemodell, Fehlercodes) senden. Im freihändigen Modus wird das Mikrofon nur auf dem Gerät und in Echtzeit genutzt, um zu erkennen, wann du fertig gesprochen hast. Wenn du „Prüfen, was ich sage“ einschaltest, wandelt die Spracherkennung deines Handys deine Sprache auf dem Gerät in Text um; die App nutzt nie Online-Erkennung. Nichts wird aufgenommen oder gesendet. Im Modus „Auswendig aufsagen“ wird deine Sprache vom einmalig heruntergeladenen Open-Source-Modell Whisper auf dem Handy in Text umgewandelt. Einzige Ausnahme ist „Stimmen aufnehmen“: Sätze werden nur aufgenommen, wenn du auf „Aufnehmen“ tippst; die Aufnahmen bleiben auf dem Handy und werden nie gesendet.';

  @override
  String get privacyPolicyFull => 'Vollständige Datenschutzerklärung';

  @override
  String get appVersion => 'Version';

  @override
  String get noMyCharacter =>
      'Wähle vor dem Proben mindestens eine Rolle als deine aus.';

  @override
  String get me => 'Ich';

  @override
  String get modeHandsFree => 'Freihändig';

  @override
  String get modeHandsFreeHelp =>
      'Hört zu, wenn du dran bist. Sprich deine Replik; sobald du aufhörst, geht es weiter. Wenn du hängst, wird dir deine Replik vorgelesen.';

  @override
  String get listening => 'Ich höre zu… sprich deine Replik';

  @override
  String get micDenied =>
      'Für den freihändigen Modus wird die Mikrofonberechtigung benötigt. Es wurde zu „Auf mich warten“ gewechselt.';

  @override
  String get endSilence => 'Pause, die meine Replik beendet';

  @override
  String voiceN(int n) {
    return 'Stimme $n';
  }

  @override
  String get linesHeader => 'Zeilen';

  @override
  String get pdfScanned =>
      'Dieses PDF enthält keinen markierbaren Text (es sieht wie ein Scan aus). Nutze „Aus Fotos“, um es aus einem Bild zu lesen, oder füge den Text ein.';

  @override
  String get hintWord => 'Tipp';

  @override
  String get checkAccuracy => 'Prüfen, was ich sage';

  @override
  String get checkAccuracyHelp =>
      'Deine Sprache wird von der Spracherkennung deines Handys direkt auf dem Gerät in Text umgewandelt und mit deiner Replik verglichen. Nichts wird aufgenommen, deine Stimme verlässt das Handy nicht.';

  @override
  String get sttUnavailable =>
      'Dieses Handy hat keine Spracherkennung auf dem Gerät, daher kann die Genauigkeit nicht geprüft werden. Der freihändige Modus funktioniert trotzdem.';

  @override
  String get sttLanguageMissing =>
      'Für diese Sprache gibt es auf deinem Handy keine Spracherkennung auf dem Gerät.';

  @override
  String get sttDownload => 'Spracherkennung für diese Sprache herunterladen';

  @override
  String get sttDownloading =>
      'Sprachpaket wird heruntergeladen… Das kann einige Minuten dauern.';

  @override
  String get readCorrection => 'Richtige Replik vorlesen, wenn ich mich irre';

  @override
  String accuracyScore(int score) {
    return '$score % richtig';
  }

  @override
  String missedWords(String words) {
    return 'Ausgelassen: $words';
  }

  @override
  String get notUnderstood => 'Nicht verstanden';

  @override
  String summaryAccuracy(int score) {
    return 'Durchschnittliche Genauigkeit $score %';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count-mal souffliert',
      one: 'Einmal souffliert',
      zero: 'Kein Soufflieren nötig',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Super! Du hast es ohne jede Hilfe geschafft.';

  @override
  String get finishedGood => 'Läuft gut! Probe beendet.';

  @override
  String get finishedPractice =>
      'Probe beendet. Übe die Stellen, an denen du hängen geblieben bist.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Repliken',
      one: '1 Replik',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'bei $count Repliken souffliert',
      one: 'bei 1 Replik souffliert',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Repliken korrigiert',
      one: '1 Replik korrigiert',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Repliken nicht verstanden',
      one: '1 Replik nicht verstanden',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'Aus Fotos';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get reading => 'Wird gelesen…';

  @override
  String get docOld =>
      'Alte Word-Dateien (.doc) können nicht gelesen werden. Speichere das Dokument als .docx oder PDF und versuche es erneut.';

  @override
  String get noTextInPhoto =>
      'Im Foto wurde kein lesbarer Text gefunden. Versuche ein schärferes, gut beleuchtetes Foto von vorne.';

  @override
  String get photoAlphabet =>
      'Das Lesen aus Fotos unterstützt weder das kyrillische noch das arabische Alphabet. Tippe oder füge den Text ein.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Bei $count Zeilen war unklar, wer sie spricht. Tippe auf die markierten Zeilen, um sie zu korrigieren.',
      one: 'Bei 1 Zeile war unklar, wer sie spricht. Tippe auf die markierte Zeile, um sie zu korrigieren.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Drücke die Eingabetaste, um die Zeile zu teilen.';

  @override
  String get charactersAndVoices => 'Rollen und Stimmen';

  @override
  String get hintProgressive => 'Schrittweise';

  @override
  String get hintKeywords => 'Schlüsselwörter';

  @override
  String hideRatio(int percent) {
    return 'Ausgeblendete Wörter: $percent %';
  }

  @override
  String levelUp(int percent) {
    return 'Super! In der nächsten Runde werden $percent % der Wörter ausgeblendet.';
  }

  @override
  String get modeBuildUp => 'Aufbauen';

  @override
  String get modeBuildUpHelp =>
      'Erst Zeile 1, dann 1–2, dann 1–3… Jede neue Zeile wird dir zuerst vorgelesen, dann sprichst du alles von vorn. Ideal für Gedichte und kurze Texte.';

  @override
  String stepOf(int step, int total) {
    return 'Schritt $step von $total';
  }

  @override
  String get onlyWeak => 'Nur schwierige Zeilen';

  @override
  String get onlyWeakHelp =>
      'Übe nur die Zeilen, bei denen du Hilfe, eine Korrektur oder eine niedrige Bewertung hattest.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count schwierige Zeilen',
      one: '1 schwierige Zeile',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Noch keine schwierigen Zeilen';

  @override
  String elapsed(String time) {
    return 'Zeit $time';
  }

  @override
  String get targetTime => 'Zielzeit';

  @override
  String get targetNone => 'Kein Ziel';

  @override
  String overTarget(String time) {
    return '$time über dem Ziel';
  }

  @override
  String underTarget(String time) {
    return '$time unter dem Ziel';
  }

  @override
  String wpm(int wpm) {
    return '$wpm Wörter/Min.';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Mit Pro schneller auswendig lernen.';

  @override
  String get proFeatureHandsFree =>
      'Freihändiges Proben: hört zu, wenn du dran bist – ohne das Handy zu berühren';

  @override
  String proFeatureUnlimited(int count) {
    return 'Unbegrenzte Texte (kostenlose Version: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days Tage kostenlos, danach $price/Monat';
  }

  @override
  String proPrice(String price) {
    return '$price/Monat';
  }

  @override
  String get proStartTrial => 'Kostenlos testen';

  @override
  String get proSubscribe => 'Abonnieren';

  @override
  String get proRestore => 'Käufe wiederherstellen';

  @override
  String get proTerms =>
      'Das Abo verlängert sich automatisch jeden Monat. Du kannst jederzeit unter Google Play > Abos kündigen; nach der Kündigung bleibt Pro bis zum Ende des Zeitraums aktiv.';

  @override
  String get proUnavailable =>
      'Das Abo ist gerade nicht verfügbar. Bitte versuche es später erneut.';

  @override
  String get proActive => 'Pro ist aktiv';

  @override
  String get proManage => 'Abo verwalten';

  @override
  String get proUpgrade => 'Pro holen';

  @override
  String proLimitReached(int count) {
    return 'In der kostenlosen Version kannst du bis zu $count Texte speichern.';
  }

  @override
  String get proThanks => 'Danke! Pro ist aktiv.';

  @override
  String get proHandsFreeLocked =>
      'Freihändiges Proben ist eine Pro-Funktion. Es wurde zu „Auf mich warten“ gewechselt.';

  @override
  String get proNotFound => 'Kein aktives Abo gefunden.';

  @override
  String get modePages => 'Seite für Seite';

  @override
  String get modePagesHelp =>
      'Sagt „Seite 1“, und wenn die Zeit um ist „Zeit ist um. Seite 2“. Frei sprechen; bei frühem Ende „Nächste Seite“ tippen.';

  @override
  String pageCue(int n) {
    return 'Seite $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Seite $n. $title';
  }

  @override
  String get timeUp => 'Die Zeit ist um.';

  @override
  String get presentationDone => 'Ende der Präsentation.';

  @override
  String get nextPage => 'Nächste Seite';

  @override
  String get pageTimes => 'Zeit pro Seite';

  @override
  String get pageTimesHelp =>
      'Seiten ergeben sich aus den Überschriften im Text, sonst aus den Absätzen.';

  @override
  String get pageTimesAuto => 'Automatisch verteilen';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'S$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Seite $n/$total';
  }

  @override
  String get emotion => 'Tonfall';

  @override
  String get emotionHelp =>
      'Tempo, Tonhöhe und Lautstärke werden an dieses Gefühl angepasst. Regieanweisungen wie (wütend) oder (weinend) werden automatisch erkannt.';

  @override
  String get emoNeutral => 'Normal';

  @override
  String get emoHappy => 'Fröhlich';

  @override
  String get emoSad => 'Traurig';

  @override
  String get emoAngry => 'Wütend';

  @override
  String get emoExcited => 'Aufgeregt';

  @override
  String get emoCalm => 'Ruhig';

  @override
  String get emoWhisper => 'Flüstern';

  @override
  String get emoAfraid => 'Ängstlich';

  @override
  String get modeRecite => 'Auswendig aufsagen (Fehlerprüfung)';

  @override
  String get modeReciteHelp =>
      'Sag den Text auswendig auf; es stoppt, wo du etwas auslässt oder falsch sagst, und zeigt den Fehler. Am Ende gibt es einen Bericht.';

  @override
  String get reciteTitle => 'Auswendig aufsagen';

  @override
  String get reciteModelTitle => 'Spracherkennungsmodell';

  @override
  String get reciteModelHelp =>
      'Für die Fehlerprüfung wird einmalig ein Spracherkennungsmodell heruntergeladen, das auf dem Handy läuft. Kostenlos; deine Stimme verlässt das Handy nicht. WLAN empfohlen.';

  @override
  String reciteModelStandard(int mb) {
    return 'Standard ($mb MB) – schnell';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Hohe Genauigkeit ($mb MB) – langsamer';
  }

  @override
  String get reciteDownload => 'Herunterladen';

  @override
  String reciteDownloading(int pct) {
    return 'Wird geladen … $pct %';
  }

  @override
  String get reciteDownloadFailed =>
      'Download fehlgeschlagen. Prüfe die Verbindung und versuche es erneut.';

  @override
  String get reciteLoading => 'Modell wird geladen …';

  @override
  String get reciteStart => 'Start';

  @override
  String get reciteListening => 'Ich höre zu … Sag den Text von Anfang an.';

  @override
  String get reciteChecking => 'Wird geprüft …';

  @override
  String reciteHeard(String text) {
    return 'Gehört: $text';
  }

  @override
  String get reciteSkipped => 'Du hast etwas ausgelassen';

  @override
  String get reciteWrong => 'Das war falsch';

  @override
  String reciteExpected(String text) {
    return 'Richtig: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Du hast gesagt: $text';
  }

  @override
  String get reciteContinueHere => 'Hier weitermachen';

  @override
  String get reciteFinish => 'Beenden';

  @override
  String reciteAccuracy(int n) {
    return 'Genauigkeit: $n %';
  }

  @override
  String get reciteNoErrors => 'Keine Fehler, super!';

  @override
  String reciteMinor(int n) {
    return '$n kleine Auslassungen (kurze Wörter)';
  }

  @override
  String get reciteAgain => 'Nochmal';

  @override
  String get reciteNote =>
      'Die Erkennung ist nicht perfekt; bei Unsicherheit kann sie dich stoppen.';

  @override
  String get reciteLoadFailed =>
      'Das Modell konnte nicht geöffnet werden. Lösche es und lade es erneut herunter.';

  @override
  String get recordLines => 'Stimmen aufnehmen';

  @override
  String get recordLinesHelp =>
      'Nimm die Sätze der anderen Figuren mit deiner Stimme oder der eines Freundes auf; beim Proben laufen sie statt der künstlichen Stimme – mit echtem Gefühl. Aufnahmen bleiben auf dem Handy und sind nicht im Backup enthalten.';

  @override
  String get recordStart => 'Aufnehmen';

  @override
  String get recordStop => 'Stopp';

  @override
  String get recordPlay => 'Anhören';

  @override
  String get recordDelete => 'Aufnahme löschen';

  @override
  String get recordNext => 'Weiter';

  @override
  String get recordPrev => 'Zurück';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total Sätze aufgenommen';
  }

  @override
  String get recordIncludeMine => 'Auch meine eigenen Sätze zeigen';

  @override
  String get recordNone => 'Keine Sätze zum Aufnehmen.';

  @override
  String get recordingNow => 'Aufnahme läuft …';

  @override
  String get recordedBadge => 'Aufgenommen';
}
