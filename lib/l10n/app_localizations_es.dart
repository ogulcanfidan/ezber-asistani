// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LEs extends L {
  LEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Asistente de Memorización';

  @override
  String get library => 'Mis textos';

  @override
  String get emptyLibrary =>
      'Aún no hay nada. Añade una obra, un poema o un discurso y empieza a memorizar.';

  @override
  String get newPiece => 'Nuevo';

  @override
  String get kindPlay => 'Obra / escena';

  @override
  String get kindPoem => 'Poema / texto';

  @override
  String get kindSpeech => 'Discurso / presentación';

  @override
  String get kindPlayHelp =>
      'Escribe cada línea como NOMBRE: texto. Pon las acotaciones entre (paréntesis). El formato de guion también funciona.';

  @override
  String get kindPoemHelp =>
      'Cada línea se convierte en un paso. Para poemas, canciones, listas y cualquier texto que aprender palabra por palabra.';

  @override
  String get kindSpeechHelp =>
      'Cada frase o párrafo en su propia línea es un paso. Controla tu tiempo y ritmo.';

  @override
  String get title => 'Título';

  @override
  String get voiceLanguage => 'Idioma de la voz';

  @override
  String get pasteHint => 'Pega o escribe tu texto aquí';

  @override
  String get importFile => 'Abrir archivo (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'No se pudo leer este archivo. Usa un archivo de texto plano (.txt).';

  @override
  String get continueAction => 'Continuar';

  @override
  String get reviewTitle => 'Revisa las líneas';

  @override
  String get reviewHelp =>
      'Toca un nombre para dar la línea a otro personaje. Toca el texto para editarlo. Más opciones en ⋮.';

  @override
  String get whoAmI => '¿Qué personaje eres?';

  @override
  String get whoAmIHelp => 'Practicarás las líneas de este personaje.';

  @override
  String get characters => 'Personajes';

  @override
  String get direction => 'Acotación';

  @override
  String get heading => 'Escena';

  @override
  String get editLine => 'Editar texto';

  @override
  String get deleteLine => 'Eliminar';

  @override
  String get mergeWithPrevious => 'Unir con la línea de arriba';

  @override
  String get makeDirection => 'Convertir en acotación';

  @override
  String get makeHeading => 'Convertir en título de escena';

  @override
  String get makeDialogue => 'Convertir en línea hablada';

  @override
  String get addLineBelow => 'Añadir línea debajo';

  @override
  String get assignTo => '¿Quién dice esto?';

  @override
  String get newCharacter => 'Nuevo personaje';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get rename => 'Cambiar nombre';

  @override
  String get mergeInto => 'Combinar con…';

  @override
  String get name => 'Nombre';

  @override
  String get voice => 'Voz';

  @override
  String get pitch => 'Tono';

  @override
  String get speed => 'Velocidad';

  @override
  String get testVoice => 'Escuchar';

  @override
  String get defaultVoice => 'Voz predeterminada';

  @override
  String get testSentence => '¡Hola! Así es como sonaré.';

  @override
  String get noVoices =>
      'No se encontró ninguna voz para este idioma en tu dispositivo. Puedes instalar una en los ajustes de texto a voz de Android.';

  @override
  String get rehearse => 'Ensayar';

  @override
  String get mode => 'Modo';

  @override
  String get modeListen => 'Escuchar';

  @override
  String get modeListenHelp =>
      'Se lee todo en voz alta. Ideal para conocer el texto.';

  @override
  String get modeWait => 'Espérame';

  @override
  String get modeWaitHelp =>
      'Se detiene en tu línea. Dila y luego toca Continuar.';

  @override
  String get modeCheck => 'Compruébame';

  @override
  String get modeCheckHelp =>
      'Te da tiempo para decir tu línea y luego la lee para que te compruebes.';

  @override
  String get modeRun => 'Pasada completa';

  @override
  String get modeRunHelp => 'Te da tiempo para tu línea y sigue sin leerla.';

  @override
  String get hint => 'Mostrar mi línea como';

  @override
  String get hintFull => 'Texto completo';

  @override
  String get hintFirst => 'Primeras letras';

  @override
  String get hintHidden => 'Oculta';

  @override
  String get readDirections => 'Leer las acotaciones en voz alta';

  @override
  String get pauseLength => 'Tiempo para mi línea';

  @override
  String get yourTurn => 'Tu turno';

  @override
  String get show => 'Mostrar';

  @override
  String get play => 'Reproducir';

  @override
  String get pause => 'Pausa';

  @override
  String get previousLine => 'Línea anterior';

  @override
  String get nextLine => 'Línea siguiente';

  @override
  String get jumpToScene => 'Ir a la escena';

  @override
  String get fromStart => 'Desde el principio';

  @override
  String get finished => 'Ensayo terminado.';

  @override
  String get restart => 'Empezar de nuevo';

  @override
  String get settings => 'Ajustes';

  @override
  String get appLanguage => 'Idioma de la app';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get backup => 'Hacer copia de todos los textos';

  @override
  String get backupHelp =>
      'Guarda un archivo de copia para no perder nunca tus textos al cambiar de teléfono.';

  @override
  String get restore => 'Restaurar copia';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count textos restaurados',
      one: '1 texto restaurado',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'Este archivo no es una copia válida.';

  @override
  String deleteConfirm(String title) {
    return '¿Eliminar «$title»? No se puede deshacer.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count líneas',
      one: '1 línea',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Privacidad';

  @override
  String get privacyText =>
      'Tus textos se quedan en tu teléfono y no se suben a ningún sitio. Las voces las genera en el dispositivo el motor de texto a voz de tu teléfono. El texto de las fotos se lee en el dispositivo con Google ML Kit; las fotos no se envían, pero ML Kit puede enviar a Google datos de diagnóstico anónimos (como el modelo del dispositivo o códigos de error). En modo manos libres, el micrófono solo se usa en el dispositivo y en tiempo real para notar cuándo terminas de hablar. Si activas «Comprobar lo que digo», el reconocimiento de voz de tu teléfono convierte tu voz en texto en el dispositivo; la app nunca usa reconocimiento en línea. No se graba ni se envía nada. En el modo «Recitar de memoria», tu voz se transcribe en el teléfono con el modelo de código abierto Whisper, descargado una sola vez. La única excepción es «Grabar voces»: las frases se graban solo cuando tocas «Grabar», y las grabaciones se quedan en el teléfono y nunca se envían.';

  @override
  String get privacyPolicyFull => 'Política de privacidad completa';

  @override
  String get appVersion => 'Versión';

  @override
  String get noMyCharacter =>
      'Elige al menos un personaje como tuyo antes de ensayar.';

  @override
  String get me => 'Yo';

  @override
  String get modeHandsFree => 'Manos libres';

  @override
  String get modeHandsFreeHelp =>
      'Escucha cuando es tu turno. Di tu línea; cuando dejas de hablar, continúa. Si te atascas, te lee tu línea.';

  @override
  String get listening => 'Escuchando… di tu línea';

  @override
  String get micDenied =>
      'El modo manos libres necesita permiso de micrófono. Se cambió a «Espérame».';

  @override
  String get endSilence => 'Pausa que termina mi línea';

  @override
  String voiceN(int n) {
    return 'Voz $n';
  }

  @override
  String get linesHeader => 'Líneas';

  @override
  String get pdfScanned =>
      'Este PDF no tiene texto seleccionable (parece una página escaneada). Usa «Desde fotos» para leerlo desde una imagen, o pega el texto.';

  @override
  String get hintWord => 'Pista';

  @override
  String get checkAccuracy => 'Comprobar lo que digo';

  @override
  String get checkAccuracyHelp =>
      'El reconocimiento de voz de tu teléfono convierte tu voz en texto en el propio dispositivo y la compara con tu línea. No se graba nada y tu voz no sale del teléfono.';

  @override
  String get sttUnavailable =>
      'Este teléfono no tiene reconocimiento de voz en el dispositivo, así que no se puede comprobar la precisión. El modo manos libres sigue funcionando.';

  @override
  String get sttLanguageMissing =>
      'El reconocimiento de voz en el dispositivo no está disponible para este idioma en tu teléfono.';

  @override
  String get sttDownload => 'Descargar el reconocimiento de voz de este idioma';

  @override
  String get sttDownloading =>
      'Descargando el paquete de idioma… Puede tardar unos minutos.';

  @override
  String get readCorrection => 'Leer la línea correcta si me equivoco';

  @override
  String accuracyScore(int score) {
    return '$score % correcto';
  }

  @override
  String missedWords(String words) {
    return 'Omitido: $words';
  }

  @override
  String get notUnderstood => 'No se entendió';

  @override
  String summaryAccuracy(int score) {
    return 'Precisión media $score %';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Apuntado $count veces',
      one: 'Apuntado una vez',
      zero: 'Sin apuntes',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => '¡Muy bien! Lo lograste sin ninguna ayuda.';

  @override
  String get finishedGood => '¡Vas bien! Ensayo terminado.';

  @override
  String get finishedPractice =>
      'Ensayo terminado. Practica las partes donde te atascaste.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count líneas',
      one: '1 línea',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'apuntado en $count líneas',
      one: 'apuntado en 1 línea',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count líneas corregidas',
      one: '1 línea corregida',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count líneas no entendidas',
      one: '1 línea no entendida',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'Desde fotos';

  @override
  String get takePhoto => 'Hacer una foto';

  @override
  String get reading => 'Leyendo…';

  @override
  String get docOld =>
      'Los archivos antiguos de Word (.doc) no se pueden leer. Guarda el documento como .docx o PDF e inténtalo de nuevo.';

  @override
  String get noTextInPhoto =>
      'No se encontró texto legible en la foto. Prueba con una foto más nítida, bien iluminada y tomada de frente.';

  @override
  String get photoAlphabet =>
      'La lectura desde fotos solo funciona con el alfabeto latino. Escribe o pega el texto.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'No quedó claro quién dice $count líneas. Toca las líneas marcadas para corregirlas.',
      one: 'No quedó claro quién dice 1 línea. Toca la línea marcada para corregirla.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Pulsa Intro para dividir la línea en dos.';

  @override
  String get charactersAndVoices => 'Personajes y voces';

  @override
  String get hintProgressive => 'Progresivo';

  @override
  String get hintKeywords => 'Palabras clave';

  @override
  String hideRatio(int percent) {
    return 'Palabras ocultas: $percent %';
  }

  @override
  String levelUp(int percent) {
    return '¡Muy bien! En la próxima ronda se ocultará el $percent % de las palabras.';
  }

  @override
  String get modeBuildUp => 'Acumular';

  @override
  String get modeBuildUpHelp =>
      'Primero la línea 1, luego 1–2, luego 1–3… Cada línea nueva se te lee primero y luego dices todo desde el principio. Ideal para poemas y textos cortos.';

  @override
  String stepOf(int step, int total) {
    return 'Paso $step de $total';
  }

  @override
  String get onlyWeak => 'Solo mis líneas difíciles';

  @override
  String get onlyWeakHelp =>
      'Practica solo las líneas en las que necesitaste ayuda, una corrección o tuviste una puntuación baja.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count líneas difíciles',
      one: '1 línea difícil',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Aún no hay líneas difíciles';

  @override
  String elapsed(String time) {
    return 'Tiempo $time';
  }

  @override
  String get targetTime => 'Tiempo objetivo';

  @override
  String get targetNone => 'Sin objetivo';

  @override
  String overTarget(String time) {
    return '$time por encima del objetivo';
  }

  @override
  String underTarget(String time) {
    return '$time por debajo del objetivo';
  }

  @override
  String wpm(int wpm) {
    return '$wpm palabras/min';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Memoriza más rápido con Pro.';

  @override
  String get proFeatureHandsFree =>
      'Ensayo manos libres: escucha cuando te toca, sin tocar el teléfono';

  @override
  String proFeatureUnlimited(int count) {
    return 'Textos ilimitados (versión gratuita: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days días gratis, luego $price/mes';
  }

  @override
  String proPrice(String price) {
    return '$price/mes';
  }

  @override
  String get proStartTrial => 'Empezar prueba gratis';

  @override
  String get proSubscribe => 'Suscribirse';

  @override
  String get proRestore => 'Restaurar compras';

  @override
  String get proTerms =>
      'La suscripción se renueva automáticamente cada mes. Cancela cuando quieras en Google Play > Suscripciones; si cancelas, Pro sigue activo hasta el final del periodo.';

  @override
  String get proUnavailable =>
      'La suscripción no está disponible ahora. Inténtalo más tarde.';

  @override
  String get proActive => 'Pro está activo';

  @override
  String get proManage => 'Gestionar suscripción';

  @override
  String get proUpgrade => 'Hazte Pro';

  @override
  String proLimitReached(int count) {
    return 'La versión gratuita puede guardar hasta $count textos.';
  }

  @override
  String get proThanks => '¡Gracias! Pro está activo.';

  @override
  String get proHandsFreeLocked =>
      'El ensayo manos libres es una función Pro. Se cambió a «Espérame».';

  @override
  String get proNotFound => 'No se encontró ninguna suscripción activa.';

  @override
  String get modePages => 'Página a página';

  @override
  String get modePagesHelp =>
      'Dice «Página 1» y, al acabarse el tiempo, «Se acabó el tiempo. Página 2». Habla sin leer; toca «Página siguiente» si terminas antes.';

  @override
  String pageCue(int n) {
    return 'Página $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Página $n. $title';
  }

  @override
  String get timeUp => 'Se acabó el tiempo.';

  @override
  String get presentationDone => 'Fin de la presentación.';

  @override
  String get nextPage => 'Página siguiente';

  @override
  String get pageTimes => 'Tiempo por página';

  @override
  String get pageTimesHelp =>
      'Las páginas salen de los títulos del texto o, si no hay, de los párrafos.';

  @override
  String get pageTimesAuto => 'Repartir automáticamente';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'P$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Página $n/$total';
  }

  @override
  String get emotion => 'Tono';

  @override
  String get emotionHelp =>
      'La velocidad, el tono y el volumen se ajustan a esta emoción. Las acotaciones como (enfadado) o (llorando) se detectan automáticamente.';

  @override
  String get emoNeutral => 'Normal';

  @override
  String get emoHappy => 'Alegre';

  @override
  String get emoSad => 'Triste';

  @override
  String get emoAngry => 'Enfadado';

  @override
  String get emoExcited => 'Emocionado';

  @override
  String get emoCalm => 'Tranquilo';

  @override
  String get emoWhisper => 'Susurro';

  @override
  String get emoAfraid => 'Asustado';

  @override
  String get modeRecite => 'Recitar de memoria (control de errores)';

  @override
  String get modeReciteHelp =>
      'Di el texto de memoria; se detiene donde te saltas algo o lo dices mal y muestra el error. Al final verás un informe.';

  @override
  String get reciteTitle => 'Recitar de memoria';

  @override
  String get reciteModelTitle => 'Modelo de reconocimiento de voz';

  @override
  String get reciteModelHelp =>
      'Para el control se descarga una vez un modelo de reconocimiento de voz que funciona en el teléfono. Es gratis; tu voz no sale del teléfono. Se recomienda Wi-Fi.';

  @override
  String reciteModelStandard(int mb) {
    return 'Estándar ($mb MB): rápido';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Alta precisión ($mb MB): más lento';
  }

  @override
  String get reciteDownload => 'Descargar';

  @override
  String reciteDownloading(int pct) {
    return 'Descargando… $pct %';
  }

  @override
  String get reciteDownloadFailed =>
      'La descarga falló. Revisa la conexión e inténtalo de nuevo.';

  @override
  String get reciteLoading => 'Cargando modelo…';

  @override
  String get reciteStart => 'Empezar';

  @override
  String get reciteListening => 'Escuchando… Di el texto desde el principio.';

  @override
  String get reciteChecking => 'Comprobando…';

  @override
  String reciteHeard(String text) {
    return 'He oído: $text';
  }

  @override
  String get reciteSkipped => 'Te saltaste una parte';

  @override
  String get reciteWrong => 'Lo dijiste mal';

  @override
  String reciteExpected(String text) {
    return 'Correcto: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Dijiste: $text';
  }

  @override
  String get reciteContinueHere => 'Seguir desde aquí';

  @override
  String get reciteFinish => 'Terminar';

  @override
  String reciteAccuracy(int n) {
    return 'Precisión: $n %';
  }

  @override
  String get reciteNoErrors => 'Sin errores, ¡genial!';

  @override
  String reciteMinor(int n) {
    return '$n pequeños saltos (palabras cortas)';
  }

  @override
  String get reciteAgain => 'Otra vez';

  @override
  String get reciteNote =>
      'El reconocimiento no es perfecto; puede detenerte cuando dude.';

  @override
  String get reciteLoadFailed =>
      'No se pudo abrir el modelo. Bórralo y descárgalo de nuevo.';

  @override
  String get recordLines => 'Grabar voces';

  @override
  String get recordLinesHelp =>
      'Graba las frases de los demás personajes con tu voz o la de un amigo; en el ensayo suenan en lugar de la voz sintética, con emoción real. Las grabaciones se quedan en el teléfono y no se incluyen en las copias de seguridad.';

  @override
  String get recordStart => 'Grabar';

  @override
  String get recordStop => 'Detener';

  @override
  String get recordPlay => 'Escuchar';

  @override
  String get recordDelete => 'Borrar grabación';

  @override
  String get recordNext => 'Siguiente';

  @override
  String get recordPrev => 'Anterior';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total frases grabadas';
  }

  @override
  String get recordIncludeMine => 'Mostrar también mis frases';

  @override
  String get recordNone => 'No hay frases para grabar.';

  @override
  String get recordingNow => 'Grabando…';

  @override
  String get recordedBadge => 'Grabada';
}
