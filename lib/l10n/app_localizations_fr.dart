// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class LFr extends L {
  LFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Assistant Mémorisation';

  @override
  String get library => 'Mes textes';

  @override
  String get emptyLibrary =>
      'Rien pour l\'instant. Ajoutez une pièce, un poème ou un discours et commencez à mémoriser.';

  @override
  String get newPiece => 'Nouveau';

  @override
  String get kindPlay => 'Pièce / scène';

  @override
  String get kindPoem => 'Poème / texte';

  @override
  String get kindSpeech => 'Discours / présentation';

  @override
  String get kindPlayHelp =>
      'Écrivez chaque réplique sous la forme NOM : réplique. Mettez les didascalies entre (parenthèses). Le format scénario fonctionne aussi.';

  @override
  String get kindPoemHelp =>
      'Chaque ligne devient une étape. Pour les poèmes, chansons, listes et tout texte à apprendre mot à mot.';

  @override
  String get kindSpeechHelp =>
      'Chaque phrase ou paragraphe sur sa propre ligne devient une étape. Suivez votre durée et votre débit.';

  @override
  String get title => 'Titre';

  @override
  String get voiceLanguage => 'Langue de la voix';

  @override
  String get pasteHint => 'Collez ou tapez votre texte ici';

  @override
  String get importFile => 'Ouvrir un fichier (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'Ce fichier n\'a pas pu être lu. Utilisez un fichier texte brut (.txt).';

  @override
  String get continueAction => 'Continuer';

  @override
  String get reviewTitle => 'Vérifier les répliques';

  @override
  String get reviewHelp =>
      'Touchez un nom pour attribuer la réplique à un autre personnage. Touchez le texte pour le modifier. Plus d\'options avec ⋮.';

  @override
  String get whoAmI => 'Quel personnage êtes-vous ?';

  @override
  String get whoAmIHelp => 'Vous travaillerez les répliques de ce personnage.';

  @override
  String get characters => 'Personnages';

  @override
  String get direction => 'Didascalie';

  @override
  String get heading => 'Scène';

  @override
  String get editLine => 'Modifier le texte';

  @override
  String get deleteLine => 'Supprimer';

  @override
  String get mergeWithPrevious => 'Joindre à la ligne du dessus';

  @override
  String get makeDirection => 'En faire une didascalie';

  @override
  String get makeHeading => 'En faire un titre de scène';

  @override
  String get makeDialogue => 'En faire une réplique';

  @override
  String get addLineBelow => 'Ajouter une ligne en dessous';

  @override
  String get assignTo => 'Qui dit cela ?';

  @override
  String get newCharacter => 'Nouveau personnage';

  @override
  String get save => 'Enregistrer';

  @override
  String get cancel => 'Annuler';

  @override
  String get delete => 'Supprimer';

  @override
  String get rename => 'Renommer';

  @override
  String get mergeInto => 'Fusionner avec…';

  @override
  String get name => 'Nom';

  @override
  String get voice => 'Voix';

  @override
  String get pitch => 'Hauteur';

  @override
  String get speed => 'Vitesse';

  @override
  String get testVoice => 'Écouter';

  @override
  String get defaultVoice => 'Voix par défaut';

  @override
  String get testSentence => 'Bonjour ! Voici comment je vais sonner.';

  @override
  String get noVoices =>
      'Aucune voix pour cette langue n\'a été trouvée sur votre appareil. Vous pouvez en installer une dans les réglages de synthèse vocale d\'Android.';

  @override
  String get rehearse => 'Répéter';

  @override
  String get mode => 'Mode';

  @override
  String get modeListen => 'Écouter';

  @override
  String get modeListenHelp =>
      'Tout est lu à voix haute. Idéal pour découvrir le texte.';

  @override
  String get modeWait => 'M\'attendre';

  @override
  String get modeWaitHelp =>
      'S\'arrête à votre réplique. Dites-la, puis touchez Continuer.';

  @override
  String get modeCheck => 'Me vérifier';

  @override
  String get modeCheckHelp =>
      'Vous laisse le temps de dire votre réplique, puis la lit pour que vous puissiez vérifier.';

  @override
  String get modeRun => 'Filage';

  @override
  String get modeRunHelp =>
      'Vous laisse le temps de dire votre réplique et continue sans la lire.';

  @override
  String get hint => 'Afficher ma réplique';

  @override
  String get hintFull => 'Texte complet';

  @override
  String get hintFirst => 'Premières lettres';

  @override
  String get hintHidden => 'Masquée';

  @override
  String get readDirections => 'Lire les didascalies à voix haute';

  @override
  String get pauseLength => 'Temps pour ma réplique';

  @override
  String get yourTurn => 'À vous';

  @override
  String get show => 'Afficher';

  @override
  String get play => 'Lecture';

  @override
  String get pause => 'Pause';

  @override
  String get previousLine => 'Ligne précédente';

  @override
  String get nextLine => 'Ligne suivante';

  @override
  String get jumpToScene => 'Aller à la scène';

  @override
  String get fromStart => 'Depuis le début';

  @override
  String get finished => 'Répétition terminée.';

  @override
  String get restart => 'Recommencer';

  @override
  String get settings => 'Réglages';

  @override
  String get appLanguage => 'Langue de l\'application';

  @override
  String get systemDefault => 'Langue du système';

  @override
  String get backup => 'Sauvegarder tous les textes';

  @override
  String get backupHelp =>
      'Enregistrez un fichier de sauvegarde pour ne jamais perdre vos textes en changeant de téléphone.';

  @override
  String get restore => 'Restaurer une sauvegarde';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count textes restaurés',
      one: '1 texte restauré',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'Ce fichier n\'est pas une sauvegarde valide.';

  @override
  String deleteConfirm(String title) {
    return 'Supprimer « $title » ? Cette action est irréversible.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lignes',
      one: '1 ligne',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Confidentialité';

  @override
  String get privacyText =>
      'Vos textes restent sur votre téléphone et ne sont envoyés nulle part. Les voix sont produites sur l\'appareil par le moteur de synthèse vocale de votre téléphone. Le texte des photos est lu sur l\'appareil avec Google ML Kit ; les photos ne sont pas envoyées, mais ML Kit peut envoyer à Google des données de diagnostic anonymes (modèle d\'appareil, codes d\'erreur…). En mode mains libres, le micro sert uniquement, sur l\'appareil et en temps réel, à détecter la fin de votre réplique. Si vous activez « Vérifier ce que je dis », votre voix est transcrite par la reconnaissance vocale de votre téléphone sur l\'appareil ; l\'application n\'utilise jamais de reconnaissance en ligne. Rien n\'est enregistré ni envoyé. En mode « Réciter de mémoire », votre voix est transcrite sur le téléphone par le modèle open source Whisper, téléchargé une seule fois. Seule exception : « Enregistrer les voix » — les répliques ne sont enregistrées que lorsque vous touchez « Enregistrer », et les enregistrements restent sur le téléphone sans jamais être envoyés.';

  @override
  String get privacyPolicyFull => 'Politique de confidentialité complète';

  @override
  String get appVersion => 'Version';

  @override
  String get noMyCharacter =>
      'Choisissez au moins un personnage comme étant le vôtre avant de répéter.';

  @override
  String get me => 'Moi';

  @override
  String get modeHandsFree => 'Mains libres';

  @override
  String get modeHandsFreeHelp =>
      'Écoute quand c\'est votre tour. Dites votre réplique ; quand vous vous taisez, la suite démarre. Si vous bloquez, votre réplique vous est lue.';

  @override
  String get listening => 'J\'écoute… dites votre réplique';

  @override
  String get micDenied =>
      'L\'autorisation du micro est nécessaire pour le mode mains libres. Passage au mode « M\'attendre ».';

  @override
  String get endSilence => 'Silence qui termine ma réplique';

  @override
  String voiceN(int n) {
    return 'Voix $n';
  }

  @override
  String get linesHeader => 'Lignes';

  @override
  String get pdfScanned =>
      'Ce PDF ne contient pas de texte sélectionnable (il ressemble à une page numérisée). Utilisez « Depuis des photos » pour le lire à partir d\'une image, ou collez le texte.';

  @override
  String get hintWord => 'Indice';

  @override
  String get checkAccuracy => 'Vérifier ce que je dis';

  @override
  String get checkAccuracyHelp =>
      'Votre voix est transcrite par la reconnaissance vocale de votre téléphone, directement sur l\'appareil, puis comparée à votre réplique. Rien n\'est enregistré et votre voix ne quitte pas le téléphone.';

  @override
  String get sttUnavailable =>
      'Ce téléphone n\'a pas de reconnaissance vocale sur l\'appareil ; la précision ne peut donc pas être vérifiée. Le mode mains libres fonctionne quand même.';

  @override
  String get sttLanguageMissing =>
      'La reconnaissance vocale sur l\'appareil n\'est pas disponible pour cette langue sur votre téléphone.';

  @override
  String get sttDownload =>
      'Télécharger la reconnaissance vocale pour cette langue';

  @override
  String get sttDownloading =>
      'Téléchargement du pack de langue… Cela peut prendre quelques minutes.';

  @override
  String get readCorrection => 'Lire la bonne réplique si je me trompe';

  @override
  String accuracyScore(int score) {
    return '$score % juste';
  }

  @override
  String missedWords(String words) {
    return 'Oublié : $words';
  }

  @override
  String get notUnderstood => 'Pas compris';

  @override
  String summaryAccuracy(int score) {
    return 'Précision moyenne $score %';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Soufflé $count fois',
      one: 'Soufflé une fois',
      zero: 'Aucun souffle nécessaire',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Bravo ! Vous avez tout fait sans aide.';

  @override
  String get finishedGood => 'Ça avance bien ! Répétition terminée.';

  @override
  String get finishedPractice =>
      'Répétition terminée. Retravaillez les passages où vous avez bloqué.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count répliques',
      one: '1 réplique',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'soufflé sur $count répliques',
      one: 'soufflé sur 1 réplique',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count répliques corrigées',
      one: '1 réplique corrigée',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count répliques non comprises',
      one: '1 réplique non comprise',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'Depuis des photos';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get reading => 'Lecture…';

  @override
  String get docOld =>
      'Les anciens fichiers Word (.doc) ne peuvent pas être lus. Enregistrez le document en .docx ou PDF et réessayez.';

  @override
  String get noTextInPhoto =>
      'Aucun texte lisible n\'a été trouvé sur la photo. Essayez une photo plus nette, bien éclairée et prise de face.';

  @override
  String get photoAlphabet =>
      'La lecture depuis des photos ne prend pas en charge les alphabets cyrillique et arabe. Saisissez ou collez le texte.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'On ne sait pas qui dit $count lignes. Touchez les lignes signalées pour les corriger.',
      one: 'On ne sait pas qui dit 1 ligne. Touchez la ligne signalée pour la corriger.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Appuyez sur Entrée pour couper la ligne en deux.';

  @override
  String get charactersAndVoices => 'Personnages et voix';

  @override
  String get hintProgressive => 'Progressif';

  @override
  String get hintKeywords => 'Mots-clés';

  @override
  String hideRatio(int percent) {
    return 'Mots masqués : $percent %';
  }

  @override
  String levelUp(int percent) {
    return 'Bravo ! Au prochain tour, $percent % des mots seront masqués.';
  }

  @override
  String get modeBuildUp => 'Construire';

  @override
  String get modeBuildUpHelp =>
      'D\'abord la ligne 1, puis 1–2, puis 1–3… Chaque nouvelle ligne vous est d\'abord lue, puis vous dites tout depuis le début. Idéal pour les poèmes et textes courts.';

  @override
  String stepOf(int step, int total) {
    return 'Étape $step sur $total';
  }

  @override
  String get onlyWeak => 'Seulement mes lignes difficiles';

  @override
  String get onlyWeakHelp =>
      'Travaillez uniquement les lignes où vous avez eu besoin d\'aide, d\'une correction ou obtenu un score faible.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count lignes difficiles',
      one: '1 ligne difficile',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Aucune ligne difficile pour l\'instant';

  @override
  String elapsed(String time) {
    return 'Durée $time';
  }

  @override
  String get targetTime => 'Durée visée';

  @override
  String get targetNone => 'Pas d\'objectif';

  @override
  String overTarget(String time) {
    return '$time au-dessus de l\'objectif';
  }

  @override
  String underTarget(String time) {
    return '$time en dessous de l\'objectif';
  }

  @override
  String wpm(int wpm) {
    return '$wpm mots/min';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Apprenez par cœur plus vite avec Pro.';

  @override
  String get proFeatureHandsFree =>
      'Répétition mains libres : écoute quand c\'est votre tour, sans toucher le téléphone';

  @override
  String proFeatureUnlimited(int count) {
    return 'Textes illimités (version gratuite : $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days jours gratuits, puis $price/mois';
  }

  @override
  String proPrice(String price) {
    return '$price/mois';
  }

  @override
  String get proStartTrial => 'Commencer l\'essai gratuit';

  @override
  String get proSubscribe => 'S\'abonner';

  @override
  String get proRestore => 'Restaurer les achats';

  @override
  String get proTerms =>
      'L\'abonnement se renouvelle automatiquement chaque mois. Résiliez à tout moment dans Google Play > Abonnements ; en cas de résiliation, Pro reste actif jusqu\'à la fin de la période.';

  @override
  String get proUnavailable =>
      'L\'abonnement n\'est pas disponible pour le moment. Réessayez plus tard.';

  @override
  String get proActive => 'Pro est actif';

  @override
  String get proManage => 'Gérer l\'abonnement';

  @override
  String get proUpgrade => 'Passer à Pro';

  @override
  String proLimitReached(int count) {
    return 'La version gratuite permet d\'enregistrer jusqu\'à $count textes.';
  }

  @override
  String get proThanks => 'Merci ! Pro est actif.';

  @override
  String get proHandsFreeLocked =>
      'La répétition mains libres est une fonction Pro. Passage au mode « Attends-moi ».';

  @override
  String get proNotFound => 'Aucun abonnement actif trouvé.';

  @override
  String get modePages => 'Page par page';

  @override
  String get modePagesHelp =>
      'Annonce « Page 1 », puis « Temps écoulé. Page 2 ». Parlez sans lire ; touchez « Page suivante » si vous finissez plus tôt.';

  @override
  String pageCue(int n) {
    return 'Page $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Page $n. $title';
  }

  @override
  String get timeUp => 'Temps écoulé.';

  @override
  String get presentationDone => 'Fin de la présentation.';

  @override
  String get nextPage => 'Page suivante';

  @override
  String get pageTimes => 'Durée par page';

  @override
  String get pageTimesHelp =>
      'Les pages viennent des titres du texte, ou des paragraphes s’il n’y en a pas.';

  @override
  String get pageTimesAuto => 'Répartir automatiquement';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'P$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Page $n/$total';
  }

  @override
  String get emotion => 'Ton';

  @override
  String get emotionHelp =>
      'La vitesse, la hauteur et le volume sont adaptés à cette émotion. Les didascalies comme (en colère) ou (en pleurant) sont détectées automatiquement.';

  @override
  String get emoNeutral => 'Normal';

  @override
  String get emoHappy => 'Joyeux';

  @override
  String get emoSad => 'Triste';

  @override
  String get emoAngry => 'En colère';

  @override
  String get emoExcited => 'Excité';

  @override
  String get emoCalm => 'Calme';

  @override
  String get emoWhisper => 'Chuchoté';

  @override
  String get emoAfraid => 'Effrayé';

  @override
  String get modeRecite => 'Réciter de mémoire (contrôle des erreurs)';

  @override
  String get modeReciteHelp =>
      'Récitez le texte de mémoire ; l\'app s\'arrête là où vous sautez ou vous trompez et montre l\'erreur. Un bilan s\'affiche à la fin.';

  @override
  String get reciteTitle => 'Réciter de mémoire';

  @override
  String get reciteModelTitle => 'Modèle de reconnaissance vocale';

  @override
  String get reciteModelHelp =>
      'Pour le contrôle, un modèle de reconnaissance vocale fonctionnant sur le téléphone est téléchargé une fois. Gratuit ; votre voix ne quitte pas le téléphone. Wi-Fi conseillé.';

  @override
  String reciteModelStandard(int mb) {
    return 'Standard ($mb Mo) — rapide';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Haute précision ($mb Mo) — plus lent';
  }

  @override
  String get reciteDownload => 'Télécharger';

  @override
  String reciteDownloading(int pct) {
    return 'Téléchargement… $pct %';
  }

  @override
  String get reciteDownloadFailed =>
      'Échec du téléchargement. Vérifiez la connexion et réessayez.';

  @override
  String get reciteLoading => 'Chargement du modèle…';

  @override
  String get reciteStart => 'Commencer';

  @override
  String get reciteListening => 'J\'écoute… Récitez depuis le début.';

  @override
  String get reciteChecking => 'Vérification…';

  @override
  String reciteHeard(String text) {
    return 'J\'ai entendu : $text';
  }

  @override
  String get reciteSkipped => 'Vous avez sauté un passage';

  @override
  String get reciteWrong => 'Ce n’était pas juste';

  @override
  String reciteExpected(String text) {
    return 'Correct : $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Vous avez dit : $text';
  }

  @override
  String get reciteContinueHere => 'Reprendre ici';

  @override
  String get reciteFinish => 'Terminer';

  @override
  String reciteAccuracy(int n) {
    return 'Précision : $n %';
  }

  @override
  String get reciteNoErrors => 'Aucune erreur, bravo !';

  @override
  String reciteMinor(int n) {
    return '$n petits oublis (mots courts)';
  }

  @override
  String get reciteAgain => 'Recommencer';

  @override
  String get reciteNote =>
      'La reconnaissance n\'est pas parfaite ; elle peut vous arrêter en cas de doute.';

  @override
  String get reciteLoadFailed =>
      'Impossible d\'ouvrir le modèle. Supprimez-le et téléchargez-le à nouveau.';

  @override
  String get recordLines => 'Enregistrer les voix';

  @override
  String get recordLinesHelp =>
      'Enregistrez les répliques des autres personnages avec votre voix ou celle d\'un ami ; elles remplacent la voix de synthèse pendant la répétition, avec une vraie émotion. Les enregistrements restent sur le téléphone et ne sont pas sauvegardés.';

  @override
  String get recordStart => 'Enregistrer';

  @override
  String get recordStop => 'Arrêter';

  @override
  String get recordPlay => 'Écouter';

  @override
  String get recordDelete => 'Supprimer l\'enregistrement';

  @override
  String get recordNext => 'Suivante';

  @override
  String get recordPrev => 'Précédente';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total répliques enregistrées';
  }

  @override
  String get recordIncludeMine => 'Afficher aussi mes répliques';

  @override
  String get recordNone => 'Aucune réplique à enregistrer.';

  @override
  String get recordingNow => 'Enregistrement…';

  @override
  String get recordedBadge => 'Enregistrée';
}
