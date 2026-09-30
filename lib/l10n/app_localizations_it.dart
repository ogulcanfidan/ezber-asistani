// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class LIt extends L {
  LIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Assistente Memoria';

  @override
  String get library => 'I miei testi';

  @override
  String get emptyLibrary =>
      'Ancora niente. Aggiungi un copione, una poesia o un discorso e inizia a memorizzare.';

  @override
  String get newPiece => 'Nuovo';

  @override
  String get kindPlay => 'Copione / scena';

  @override
  String get kindPoem => 'Poesia / testo';

  @override
  String get kindSpeech => 'Discorso / presentazione';

  @override
  String get kindPlayHelp =>
      'Scrivi ogni battuta come NOME: battuta. Metti le didascalie tra (parentesi). Funziona anche il formato sceneggiatura.';

  @override
  String get kindPoemHelp =>
      'Ogni riga diventa un passo. Per poesie, canzoni, elenchi e qualsiasi testo da imparare parola per parola.';

  @override
  String get kindSpeechHelp =>
      'Ogni frase o paragrafo su una riga diventa un passo. Tieni d\'occhio il tempo e il ritmo.';

  @override
  String get title => 'Titolo';

  @override
  String get voiceLanguage => 'Lingua della voce';

  @override
  String get pasteHint => 'Incolla o scrivi qui il tuo testo';

  @override
  String get importFile => 'Apri file (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'Impossibile leggere questo file. Usa un file di testo semplice (.txt).';

  @override
  String get continueAction => 'Continua';

  @override
  String get reviewTitle => 'Controlla le battute';

  @override
  String get reviewHelp =>
      'Tocca un nome per assegnare la battuta a un altro personaggio. Tocca il testo per modificarlo. Altre opzioni in ⋮.';

  @override
  String get whoAmI => 'Quale personaggio sei?';

  @override
  String get whoAmIHelp => 'Studierai le battute di questo personaggio.';

  @override
  String get characters => 'Personaggi';

  @override
  String get direction => 'Didascalia';

  @override
  String get heading => 'Scena';

  @override
  String get editLine => 'Modifica testo';

  @override
  String get deleteLine => 'Elimina';

  @override
  String get mergeWithPrevious => 'Unisci alla riga sopra';

  @override
  String get makeDirection => 'Trasforma in didascalia';

  @override
  String get makeHeading => 'Trasforma in titolo di scena';

  @override
  String get makeDialogue => 'Trasforma in battuta';

  @override
  String get addLineBelow => 'Aggiungi riga sotto';

  @override
  String get assignTo => 'Chi lo dice?';

  @override
  String get newCharacter => 'Nuovo personaggio';

  @override
  String get save => 'Salva';

  @override
  String get cancel => 'Annulla';

  @override
  String get delete => 'Elimina';

  @override
  String get rename => 'Rinomina';

  @override
  String get mergeInto => 'Unisci a…';

  @override
  String get name => 'Nome';

  @override
  String get voice => 'Voce';

  @override
  String get pitch => 'Tono';

  @override
  String get speed => 'Velocità';

  @override
  String get testVoice => 'Ascolta';

  @override
  String get defaultVoice => 'Voce predefinita';

  @override
  String get testSentence => 'Ciao! Ecco come suonerò.';

  @override
  String get noVoices =>
      'Sul dispositivo non è stata trovata una voce per questa lingua. Puoi installarne una nelle impostazioni di sintesi vocale di Android.';

  @override
  String get rehearse => 'Prova';

  @override
  String get mode => 'Modalità';

  @override
  String get modeListen => 'Ascolta';

  @override
  String get modeListenHelp =>
      'Tutto viene letto ad alta voce. Ideale per conoscere il testo.';

  @override
  String get modeWait => 'Aspettami';

  @override
  String get modeWaitHelp =>
      'Si ferma alla tua battuta. Dilla, poi tocca Continua.';

  @override
  String get modeCheck => 'Controllami';

  @override
  String get modeCheckHelp =>
      'Ti dà il tempo di dire la battuta, poi la legge per farti controllare.';

  @override
  String get modeRun => 'Filata';

  @override
  String get modeRunHelp =>
      'Ti dà il tempo per la battuta e prosegue senza leggerla.';

  @override
  String get hint => 'Mostra la mia battuta come';

  @override
  String get hintFull => 'Testo completo';

  @override
  String get hintFirst => 'Iniziali';

  @override
  String get hintHidden => 'Nascosta';

  @override
  String get readDirections => 'Leggi le didascalie ad alta voce';

  @override
  String get pauseLength => 'Tempo per la mia battuta';

  @override
  String get yourTurn => 'Tocca a te';

  @override
  String get show => 'Mostra';

  @override
  String get play => 'Avvia';

  @override
  String get pause => 'Pausa';

  @override
  String get previousLine => 'Riga precedente';

  @override
  String get nextLine => 'Riga successiva';

  @override
  String get jumpToScene => 'Vai alla scena';

  @override
  String get fromStart => 'Dall\'inizio';

  @override
  String get finished => 'Prova terminata.';

  @override
  String get restart => 'Ricomincia';

  @override
  String get settings => 'Impostazioni';

  @override
  String get appLanguage => 'Lingua dell\'app';

  @override
  String get systemDefault => 'Predefinita di sistema';

  @override
  String get backup => 'Backup di tutti i testi';

  @override
  String get backupHelp =>
      'Salva un file di backup per non perdere mai i tuoi testi quando cambi telefono.';

  @override
  String get restore => 'Ripristina da backup';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count testi ripristinati',
      one: '1 testo ripristinato',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'Questo file non è un backup valido.';

  @override
  String deleteConfirm(String title) {
    return 'Eliminare \"$title\"? L\'operazione non può essere annullata.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count righe',
      one: '1 riga',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyText =>
      'I tuoi testi restano sul telefono e non vengono caricati da nessuna parte. Le voci sono generate sul dispositivo dal motore di sintesi vocale del telefono. Il testo nelle foto viene letto sul dispositivo con Google ML Kit; le foto non vengono inviate, ma ML Kit può inviare a Google dati diagnostici anonimi (come modello del dispositivo e codici di errore). In modalità mani libere il microfono è usato solo sul dispositivo e in tempo reale per capire quando hai finito di parlare. Se attivi \"Controlla quello che dico\", il riconoscimento vocale del telefono trasforma la tua voce in testo sul dispositivo; l\'app non usa mai il riconoscimento online. Niente viene registrato o inviato. Nella modalità «Recita a memoria» la tua voce viene trascritta sul telefono dal modello open source Whisper, scaricato una sola volta. Unica eccezione: «Registra le voci» — le battute vengono registrate solo quando tocchi «Registra» e le registrazioni restano sul telefono, senza mai essere inviate.';

  @override
  String get privacyPolicyFull => 'Informativa sulla privacy completa';

  @override
  String get appVersion => 'Versione';

  @override
  String get noMyCharacter =>
      'Scegli almeno un personaggio come tuo prima di provare.';

  @override
  String get me => 'Io';

  @override
  String get modeHandsFree => 'Mani libere';

  @override
  String get modeHandsFreeHelp =>
      'Ascolta quando tocca a te. Di\' la tua battuta; quando smetti di parlare, prosegue. Se ti blocchi, ti legge la battuta.';

  @override
  String get listening => 'Ti ascolto… di\' la tua battuta';

  @override
  String get micDenied =>
      'La modalità mani libere richiede il permesso del microfono. Passato a \"Aspettami\".';

  @override
  String get endSilence => 'Pausa che chiude la mia battuta';

  @override
  String voiceN(int n) {
    return 'Voce $n';
  }

  @override
  String get linesHeader => 'Righe';

  @override
  String get pdfScanned =>
      'Questo PDF non ha testo selezionabile (sembra una pagina scansionata). Usa \"Da foto\" per leggerlo da un\'immagine, oppure incolla il testo.';

  @override
  String get hintWord => 'Suggerimento';

  @override
  String get checkAccuracy => 'Controlla quello che dico';

  @override
  String get checkAccuracyHelp =>
      'Il riconoscimento vocale del telefono trasforma la tua voce in testo direttamente sul dispositivo e la confronta con la battuta. Niente viene registrato e la voce non lascia il telefono.';

  @override
  String get sttUnavailable =>
      'Questo telefono non ha il riconoscimento vocale sul dispositivo, quindi la precisione non può essere controllata. La modalità mani libere funziona comunque.';

  @override
  String get sttLanguageMissing =>
      'Il riconoscimento vocale sul dispositivo non è disponibile per questa lingua sul tuo telefono.';

  @override
  String get sttDownload =>
      'Scarica il riconoscimento vocale per questa lingua';

  @override
  String get sttDownloading =>
      'Download del pacchetto lingua… Può richiedere qualche minuto.';

  @override
  String get readCorrection => 'Leggi la battuta giusta se sbaglio';

  @override
  String accuracyScore(int score) {
    return '$score% corretto';
  }

  @override
  String missedWords(String words) {
    return 'Saltato: $words';
  }

  @override
  String get notUnderstood => 'Non capito';

  @override
  String summaryAccuracy(int score) {
    return 'Precisione media $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Suggerito $count volte',
      one: 'Suggerito una volta',
      zero: 'Nessun suggerimento necessario',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Bravo! Hai finito senza nessun aiuto.';

  @override
  String get finishedGood => 'Va bene! Prova terminata.';

  @override
  String get finishedPractice =>
      'Prova terminata. Ripassa i punti in cui ti sei bloccato.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count battute',
      one: '1 battuta',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'suggerito in $count battute',
      one: 'suggerito in 1 battuta',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count battute corrette',
      one: '1 battuta corretta',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count battute non capite',
      one: '1 battuta non capita',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'Da foto';

  @override
  String get takePhoto => 'Scatta una foto';

  @override
  String get reading => 'Lettura…';

  @override
  String get docOld =>
      'I vecchi file Word (.doc) non possono essere letti. Salva il documento come .docx o PDF e riprova.';

  @override
  String get noTextInPhoto =>
      'Nella foto non è stato trovato testo leggibile. Prova una foto più nitida, ben illuminata e scattata di fronte.';

  @override
  String get photoAlphabet =>
      'La lettura da foto funziona solo con l\'alfabeto latino. Scrivi o incolla il testo.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Non è chiaro chi dice $count righe. Tocca le righe evidenziate per correggerle.',
      one: 'Non è chiaro chi dice 1 riga. Tocca la riga evidenziata per correggerla.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Premi Invio per dividere la riga in due.';

  @override
  String get charactersAndVoices => 'Personaggi e voci';

  @override
  String get hintProgressive => 'Progressivo';

  @override
  String get hintKeywords => 'Parole chiave';

  @override
  String hideRatio(int percent) {
    return 'Parole nascoste: $percent%';
  }

  @override
  String levelUp(int percent) {
    return 'Bravo! Al prossimo giro sarà nascosto il $percent% delle parole.';
  }

  @override
  String get modeBuildUp => 'Costruisci';

  @override
  String get modeBuildUpHelp =>
      'Prima la riga 1, poi 1–2, poi 1–3… Ogni nuova riga ti viene letta prima, poi dici tutto dall\'inizio. Ideale per poesie e testi brevi.';

  @override
  String stepOf(int step, int total) {
    return 'Passo $step di $total';
  }

  @override
  String get onlyWeak => 'Solo le righe difficili';

  @override
  String get onlyWeakHelp =>
      'Esercitati solo sulle righe in cui hai avuto bisogno di aiuto, di una correzione o hai avuto un punteggio basso.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count righe difficili',
      one: '1 riga difficile',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Ancora nessuna riga difficile';

  @override
  String elapsed(String time) {
    return 'Tempo $time';
  }

  @override
  String get targetTime => 'Tempo obiettivo';

  @override
  String get targetNone => 'Nessun obiettivo';

  @override
  String overTarget(String time) {
    return '$time oltre l\'obiettivo';
  }

  @override
  String underTarget(String time) {
    return '$time sotto l\'obiettivo';
  }

  @override
  String wpm(int wpm) {
    return '$wpm parole/min';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Impara a memoria più in fretta con Pro.';

  @override
  String get proFeatureHandsFree =>
      'Prova a mani libere: ascolta quando tocca a te, senza toccare il telefono';

  @override
  String proFeatureUnlimited(int count) {
    return 'Testi illimitati (versione gratuita: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days giorni gratis, poi $price/mese';
  }

  @override
  String proPrice(String price) {
    return '$price/mese';
  }

  @override
  String get proStartTrial => 'Inizia la prova gratuita';

  @override
  String get proSubscribe => 'Abbonati';

  @override
  String get proRestore => 'Ripristina acquisti';

  @override
  String get proTerms =>
      'L\'abbonamento si rinnova automaticamente ogni mese. Puoi annullarlo in qualsiasi momento da Google Play > Abbonamenti; se annulli, Pro resta attivo fino alla fine del periodo.';

  @override
  String get proUnavailable =>
      'L\'abbonamento non è disponibile al momento. Riprova più tardi.';

  @override
  String get proActive => 'Pro attivo';

  @override
  String get proManage => 'Gestisci abbonamento';

  @override
  String get proUpgrade => 'Passa a Pro';

  @override
  String proLimitReached(int count) {
    return 'La versione gratuita può salvare fino a $count testi.';
  }

  @override
  String get proThanks => 'Grazie! Pro è attivo.';

  @override
  String get proHandsFreeLocked =>
      'La prova a mani libere è una funzione Pro. Passato a «Aspettami».';

  @override
  String get proNotFound => 'Nessun abbonamento attivo trovato.';

  @override
  String get modePages => 'Pagina per pagina';

  @override
  String get modePagesHelp =>
      'Dice «Pagina 1» e, allo scadere del tempo, «Tempo scaduto. Pagina 2». Parla senza leggere; tocca «Pagina successiva» se finisci prima.';

  @override
  String pageCue(int n) {
    return 'Pagina $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Pagina $n. $title';
  }

  @override
  String get timeUp => 'Tempo scaduto.';

  @override
  String get presentationDone => 'Fine della presentazione.';

  @override
  String get nextPage => 'Pagina successiva';

  @override
  String get pageTimes => 'Tempo per pagina';

  @override
  String get pageTimesHelp =>
      'Le pagine derivano dai titoli del testo o, se mancano, dai paragrafi.';

  @override
  String get pageTimesAuto => 'Distribuisci automaticamente';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'P$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Pagina $n/$total';
  }

  @override
  String get emotion => 'Tono';

  @override
  String get emotionHelp =>
      'Velocità, altezza e volume si adattano a questa emozione. Le didascalie come (arrabbiato) o (piangendo) vengono riconosciute automaticamente.';

  @override
  String get emoNeutral => 'Normale';

  @override
  String get emoHappy => 'Allegro';

  @override
  String get emoSad => 'Triste';

  @override
  String get emoAngry => 'Arrabbiato';

  @override
  String get emoExcited => 'Eccitato';

  @override
  String get emoCalm => 'Calmo';

  @override
  String get emoWhisper => 'Sussurro';

  @override
  String get emoAfraid => 'Spaventato';

  @override
  String get modeRecite => 'Recita a memoria (controllo errori)';

  @override
  String get modeReciteHelp =>
      'Recita il testo a memoria; l\'app si ferma dove salti o sbagli e mostra l\'errore. Alla fine ricevi un resoconto.';

  @override
  String get reciteTitle => 'Recita a memoria';

  @override
  String get reciteModelTitle => 'Modello di riconoscimento vocale';

  @override
  String get reciteModelHelp =>
      'Per il controllo viene scaricato una volta un modello di riconoscimento vocale che funziona sul telefono. È gratuito; la tua voce non lascia il telefono. Consigliato il Wi-Fi.';

  @override
  String reciteModelStandard(int mb) {
    return 'Standard ($mb MB) — veloce';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Alta precisione ($mb MB) — più lento';
  }

  @override
  String get reciteDownload => 'Scarica';

  @override
  String reciteDownloading(int pct) {
    return 'Download… $pct%';
  }

  @override
  String get reciteDownloadFailed =>
      'Download non riuscito. Controlla la connessione e riprova.';

  @override
  String get reciteLoading => 'Caricamento del modello…';

  @override
  String get reciteStart => 'Inizia';

  @override
  String get reciteListening => 'Ascolto… Recita il testo dall\'inizio.';

  @override
  String get reciteChecking => 'Controllo…';

  @override
  String reciteHeard(String text) {
    return 'Ho sentito: $text';
  }

  @override
  String get reciteSkipped => 'Hai saltato una parte';

  @override
  String get reciteWrong => 'Hai sbagliato';

  @override
  String reciteExpected(String text) {
    return 'Corretto: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Hai detto: $text';
  }

  @override
  String get reciteContinueHere => 'Continua da qui';

  @override
  String get reciteFinish => 'Fine';

  @override
  String reciteAccuracy(int n) {
    return 'Precisione: $n%';
  }

  @override
  String get reciteNoErrors => 'Nessun errore, ottimo!';

  @override
  String reciteMinor(int n) {
    return '$n piccoli salti (parole brevi)';
  }

  @override
  String get reciteAgain => 'Ancora';

  @override
  String get reciteNote =>
      'Il riconoscimento non è perfetto; può fermarti quando è incerto.';

  @override
  String get reciteLoadFailed =>
      'Impossibile aprire il modello. Eliminalo e scaricalo di nuovo.';

  @override
  String get recordLines => 'Registra le voci';

  @override
  String get recordLinesHelp =>
      'Registra le battute degli altri personaggi con la tua voce o quella di un amico; durante la prova vengono riprodotte al posto della voce sintetica, con emozioni vere. Le registrazioni restano sul telefono e non sono incluse nel backup.';

  @override
  String get recordStart => 'Registra';

  @override
  String get recordStop => 'Ferma';

  @override
  String get recordPlay => 'Ascolta';

  @override
  String get recordDelete => 'Elimina registrazione';

  @override
  String get recordNext => 'Successiva';

  @override
  String get recordPrev => 'Precedente';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total battute registrate';
  }

  @override
  String get recordIncludeMine => 'Mostra anche le mie battute';

  @override
  String get recordNone => 'Nessuna battuta da registrare.';

  @override
  String get recordingNow => 'Registrazione…';

  @override
  String get recordedBadge => 'Registrata';
}
