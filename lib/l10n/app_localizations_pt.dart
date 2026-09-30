// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class LPt extends L {
  LPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Assistente de Memorização';

  @override
  String get library => 'Meus textos';

  @override
  String get emptyLibrary =>
      'Nada por aqui ainda. Adicione uma peça, um poema ou um discurso e comece a decorar.';

  @override
  String get newPiece => 'Novo';

  @override
  String get kindPlay => 'Peça / cena';

  @override
  String get kindPoem => 'Poema / texto';

  @override
  String get kindSpeech => 'Discurso / apresentação';

  @override
  String get kindPlayHelp =>
      'Escreva cada fala como NOME: fala. Coloque as rubricas entre (parênteses). O formato de roteiro também funciona.';

  @override
  String get kindPoemHelp =>
      'Cada linha vira uma etapa. Para poemas, músicas, listas e qualquer texto para decorar palavra por palavra.';

  @override
  String get kindSpeechHelp =>
      'Cada frase ou parágrafo em sua própria linha vira uma etapa. Acompanhe seu tempo e ritmo de fala.';

  @override
  String get title => 'Título';

  @override
  String get voiceLanguage => 'Idioma da voz';

  @override
  String get pasteHint => 'Cole ou digite seu texto aqui';

  @override
  String get importFile => 'Abrir arquivo (.txt, .pdf, .docx)';

  @override
  String get importFailed =>
      'Não foi possível ler este arquivo. Use um arquivo de texto simples (.txt).';

  @override
  String get continueAction => 'Continuar';

  @override
  String get reviewTitle => 'Confira as falas';

  @override
  String get reviewHelp =>
      'Toque em um nome para dar a fala a outro personagem. Toque no texto para editar. Mais opções em ⋮.';

  @override
  String get whoAmI => 'Qual personagem é você?';

  @override
  String get whoAmIHelp => 'Você vai praticar as falas deste personagem.';

  @override
  String get characters => 'Personagens';

  @override
  String get direction => 'Rubrica';

  @override
  String get heading => 'Cena';

  @override
  String get editLine => 'Editar texto';

  @override
  String get deleteLine => 'Excluir';

  @override
  String get mergeWithPrevious => 'Juntar com a linha de cima';

  @override
  String get makeDirection => 'Transformar em rubrica';

  @override
  String get makeHeading => 'Transformar em título de cena';

  @override
  String get makeDialogue => 'Transformar em fala';

  @override
  String get addLineBelow => 'Adicionar linha abaixo';

  @override
  String get assignTo => 'Quem diz isto?';

  @override
  String get newCharacter => 'Novo personagem';

  @override
  String get save => 'Salvar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Excluir';

  @override
  String get rename => 'Renomear';

  @override
  String get mergeInto => 'Juntar com…';

  @override
  String get name => 'Nome';

  @override
  String get voice => 'Voz';

  @override
  String get pitch => 'Tom';

  @override
  String get speed => 'Velocidade';

  @override
  String get testVoice => 'Ouvir';

  @override
  String get defaultVoice => 'Voz padrão';

  @override
  String get testSentence => 'Olá! É assim que vou soar.';

  @override
  String get noVoices =>
      'Nenhuma voz para este idioma foi encontrada no seu aparelho. Você pode instalar uma nas configurações de texto para fala do Android.';

  @override
  String get rehearse => 'Ensaiar';

  @override
  String get mode => 'Modo';

  @override
  String get modeListen => 'Ouvir';

  @override
  String get modeListenHelp =>
      'Tudo é lido em voz alta. Ótimo para conhecer o texto.';

  @override
  String get modeWait => 'Espere por mim';

  @override
  String get modeWaitHelp => 'Para na sua fala. Diga-a e toque em Continuar.';

  @override
  String get modeCheck => 'Me confira';

  @override
  String get modeCheckHelp =>
      'Dá tempo para você dizer sua fala e depois a lê para você conferir.';

  @override
  String get modeRun => 'Passada';

  @override
  String get modeRunHelp => 'Dá tempo para sua fala e continua sem lê-la.';

  @override
  String get hint => 'Mostrar minha fala como';

  @override
  String get hintFull => 'Texto completo';

  @override
  String get hintFirst => 'Primeiras letras';

  @override
  String get hintHidden => 'Oculta';

  @override
  String get readDirections => 'Ler rubricas em voz alta';

  @override
  String get pauseLength => 'Tempo para minha fala';

  @override
  String get yourTurn => 'Sua vez';

  @override
  String get show => 'Mostrar';

  @override
  String get play => 'Iniciar';

  @override
  String get pause => 'Pausar';

  @override
  String get previousLine => 'Linha anterior';

  @override
  String get nextLine => 'Próxima linha';

  @override
  String get jumpToScene => 'Ir para a cena';

  @override
  String get fromStart => 'Do começo';

  @override
  String get finished => 'Ensaio concluído.';

  @override
  String get restart => 'Recomeçar';

  @override
  String get settings => 'Configurações';

  @override
  String get appLanguage => 'Idioma do app';

  @override
  String get systemDefault => 'Padrão do sistema';

  @override
  String get backup => 'Fazer backup de todos os textos';

  @override
  String get backupHelp =>
      'Salve um arquivo de backup para nunca perder seus textos ao trocar de celular.';

  @override
  String get restore => 'Restaurar backup';

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
  String get restoreFailed => 'Este arquivo não é um backup válido.';

  @override
  String deleteConfirm(String title) {
    return 'Excluir \"$title\"? Isso não pode ser desfeito.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linhas',
      one: '1 linha',
    );
    return '$_temp0';
  }

  @override
  String get privacy => 'Privacidade';

  @override
  String get privacyText =>
      'Seus textos ficam no seu celular e não são enviados para lugar nenhum. As vozes são geradas no aparelho pelo mecanismo de texto para fala do seu celular. O texto das fotos é lido no aparelho com o Google ML Kit; as fotos não são enviadas, mas o ML Kit pode enviar ao Google dados de diagnóstico anônimos (como modelo do aparelho e códigos de erro). No modo mãos livres, o microfone é usado apenas no aparelho e em tempo real para perceber quando você terminou de falar. Se você ativar \"Conferir o que eu falo\", o reconhecimento de voz do celular transforma sua fala em texto no aparelho; o app nunca usa reconhecimento on-line. Nada é gravado ou enviado. No modo \"Recitar de cor\", sua fala é transcrita no celular pelo modelo de código aberto Whisper, baixado uma única vez. A única exceção é \"Gravar vozes\": as falas só são gravadas quando você toca em \"Gravar\", e as gravações ficam no celular e nunca são enviadas.';

  @override
  String get privacyPolicyFull => 'Política de privacidade completa';

  @override
  String get appVersion => 'Versão';

  @override
  String get noMyCharacter =>
      'Escolha pelo menos um personagem como seu antes de ensaiar.';

  @override
  String get me => 'Eu';

  @override
  String get modeHandsFree => 'Mãos livres';

  @override
  String get modeHandsFreeHelp =>
      'Escuta quando é a sua vez. Diga sua fala; quando você parar de falar, continua. Se você travar, ele lê sua fala para você.';

  @override
  String get listening => 'Ouvindo… diga sua fala';

  @override
  String get micDenied =>
      'O modo mãos livres precisa de permissão do microfone. Mudamos para \"Espere por mim\".';

  @override
  String get endSilence => 'Pausa que encerra minha fala';

  @override
  String voiceN(int n) {
    return 'Voz $n';
  }

  @override
  String get linesHeader => 'Falas';

  @override
  String get pdfScanned =>
      'Este PDF não tem texto selecionável (parece uma página digitalizada). Use \"De fotos\" para ler a partir de uma imagem, ou cole o texto.';

  @override
  String get hintWord => 'Dica';

  @override
  String get checkAccuracy => 'Conferir o que eu falo';

  @override
  String get checkAccuracyHelp =>
      'O reconhecimento de voz do seu celular transforma sua fala em texto no próprio aparelho e compara com sua fala. Nada é gravado e sua voz não sai do celular.';

  @override
  String get sttUnavailable =>
      'Este celular não tem reconhecimento de voz no aparelho, então não é possível conferir a precisão. O modo mãos livres continua funcionando.';

  @override
  String get sttLanguageMissing =>
      'O reconhecimento de voz no aparelho não está disponível para este idioma no seu celular.';

  @override
  String get sttDownload => 'Baixar o reconhecimento de voz deste idioma';

  @override
  String get sttDownloading =>
      'Baixando o pacote de idioma… Pode levar alguns minutos.';

  @override
  String get readCorrection => 'Ler a fala certa se eu errar';

  @override
  String accuracyScore(int score) {
    return '$score% certo';
  }

  @override
  String missedWords(String words) {
    return 'Faltou: $words';
  }

  @override
  String get notUnderstood => 'Não deu para entender';

  @override
  String summaryAccuracy(int score) {
    return 'Precisão média $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ajudado $count vezes',
      one: 'Ajudado uma vez',
      zero: 'Nenhuma ajuda necessária',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'Parabéns! Você terminou sem nenhuma ajuda.';

  @override
  String get finishedGood => 'Indo bem! Ensaio concluído.';

  @override
  String get finishedPractice =>
      'Ensaio concluído. Pratique as partes em que você travou.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count falas',
      one: '1 fala',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ajuda em $count falas',
      one: 'ajuda em 1 fala',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count falas corrigidas',
      one: '1 fala corrigida',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count falas não entendidas',
      one: '1 fala não entendida',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => 'De fotos';

  @override
  String get takePhoto => 'Tirar foto';

  @override
  String get reading => 'Lendo…';

  @override
  String get docOld =>
      'Arquivos antigos do Word (.doc) não podem ser lidos. Salve o documento como .docx ou PDF e tente de novo.';

  @override
  String get noTextInPhoto =>
      'Nenhum texto legível foi encontrado na foto. Tente uma foto mais nítida, bem iluminada e tirada de frente.';

  @override
  String get photoAlphabet =>
      'A leitura de fotos só funciona com o alfabeto latino. Digite ou cole o texto.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'Não ficou claro quem diz $count linhas. Toque nas linhas marcadas para corrigir.',
      one: 'Não ficou claro quem diz 1 linha. Toque na linha marcada para corrigir.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Pressione Enter para dividir a linha em duas.';

  @override
  String get charactersAndVoices => 'Personagens e vozes';

  @override
  String get hintProgressive => 'Progressivo';

  @override
  String get hintKeywords => 'Palavras-chave';

  @override
  String hideRatio(int percent) {
    return 'Palavras ocultas: $percent%';
  }

  @override
  String levelUp(int percent) {
    return 'Muito bem! Na próxima rodada $percent% das palavras ficarão ocultas.';
  }

  @override
  String get modeBuildUp => 'Acumular';

  @override
  String get modeBuildUpHelp =>
      'Primeiro a linha 1, depois 1–2, depois 1–3… Cada linha nova é lida para você primeiro, depois você diz tudo desde o começo. Ideal para poemas e textos curtos.';

  @override
  String stepOf(int step, int total) {
    return 'Etapa $step de $total';
  }

  @override
  String get onlyWeak => 'Só as linhas difíceis';

  @override
  String get onlyWeakHelp =>
      'Pratique só as linhas em que você precisou de ajuda, de correção ou teve nota baixa.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count linhas difíceis',
      one: '1 linha difícil',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => 'Ainda não há linhas difíceis';

  @override
  String elapsed(String time) {
    return 'Tempo $time';
  }

  @override
  String get targetTime => 'Tempo alvo';

  @override
  String get targetNone => 'Sem meta';

  @override
  String overTarget(String time) {
    return '$time acima da meta';
  }

  @override
  String underTarget(String time) {
    return '$time abaixo da meta';
  }

  @override
  String wpm(int wpm) {
    return '$wpm palavras/min';
  }

  @override
  String get proTitle => 'Memorize Pro';

  @override
  String get proPitch => 'Decore mais rápido com o Pro.';

  @override
  String get proFeatureHandsFree =>
      'Ensaio mãos-livres: ouve quando é a sua vez, sem tocar no celular';

  @override
  String proFeatureUnlimited(int count) {
    return 'Textos ilimitados (versão gratuita: $count)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days dias grátis, depois $price/mês';
  }

  @override
  String proPrice(String price) {
    return '$price/mês';
  }

  @override
  String get proStartTrial => 'Iniciar teste grátis';

  @override
  String get proSubscribe => 'Assinar';

  @override
  String get proRestore => 'Restaurar compras';

  @override
  String get proTerms =>
      'A assinatura é renovada automaticamente todo mês. Cancele quando quiser em Google Play > Assinaturas; se cancelar, o Pro continua ativo até o fim do período.';

  @override
  String get proUnavailable =>
      'A assinatura não está disponível agora. Tente novamente mais tarde.';

  @override
  String get proActive => 'Pro ativo';

  @override
  String get proManage => 'Gerenciar assinatura';

  @override
  String get proUpgrade => 'Assinar o Pro';

  @override
  String proLimitReached(int count) {
    return 'A versão gratuita salva até $count textos.';
  }

  @override
  String get proThanks => 'Obrigado! O Pro está ativo.';

  @override
  String get proHandsFreeLocked =>
      'O ensaio mãos-livres é um recurso Pro. Mudamos para \"Espere por mim\".';

  @override
  String get proNotFound => 'Nenhuma assinatura ativa encontrada.';

  @override
  String get modePages => 'Página por página';

  @override
  String get modePagesHelp =>
      'Diz \"Página 1\" e, quando o tempo acaba, \"Tempo esgotado. Página 2\". Fale sem ler; toque em \"Próxima página\" se terminar antes.';

  @override
  String pageCue(int n) {
    return 'Página $n';
  }

  @override
  String pageCueTitled(int n, String title) {
    return 'Página $n. $title';
  }

  @override
  String get timeUp => 'Tempo esgotado.';

  @override
  String get presentationDone => 'Fim da apresentação.';

  @override
  String get nextPage => 'Próxima página';

  @override
  String get pageTimes => 'Tempo por página';

  @override
  String get pageTimesHelp =>
      'As páginas vêm dos títulos do texto ou, se não houver, dos parágrafos.';

  @override
  String get pageTimesAuto => 'Distribuir automaticamente';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'P$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'Página $n/$total';
  }

  @override
  String get emotion => 'Tom';

  @override
  String get emotionHelp =>
      'Velocidade, tom e volume são ajustados para essa emoção. Rubricas como (com raiva) ou (chorando) são detectadas automaticamente.';

  @override
  String get emoNeutral => 'Normal';

  @override
  String get emoHappy => 'Alegre';

  @override
  String get emoSad => 'Triste';

  @override
  String get emoAngry => 'Com raiva';

  @override
  String get emoExcited => 'Empolgado';

  @override
  String get emoCalm => 'Calmo';

  @override
  String get emoWhisper => 'Sussurro';

  @override
  String get emoAfraid => 'Assustado';

  @override
  String get modeRecite => 'Recitar de cor (verificação de erros)';

  @override
  String get modeReciteHelp =>
      'Diga o texto de cor; o app para onde você pular ou errar e mostra o erro. No fim, você recebe um relatório.';

  @override
  String get reciteTitle => 'Recitar de cor';

  @override
  String get reciteModelTitle => 'Modelo de reconhecimento de voz';

  @override
  String get reciteModelHelp =>
      'Para a verificação, um modelo de reconhecimento de voz que roda no celular é baixado uma vez. É grátis; sua voz não sai do celular. Wi-Fi recomendado.';

  @override
  String reciteModelStandard(int mb) {
    return 'Padrão ($mb MB) — rápido';
  }

  @override
  String reciteModelAccurate(int mb) {
    return 'Alta precisão ($mb MB) — mais lento';
  }

  @override
  String get reciteDownload => 'Baixar';

  @override
  String reciteDownloading(int pct) {
    return 'Baixando… $pct%';
  }

  @override
  String get reciteDownloadFailed =>
      'Falha no download. Verifique a conexão e tente de novo.';

  @override
  String get reciteLoading => 'Carregando modelo…';

  @override
  String get reciteStart => 'Começar';

  @override
  String get reciteListening => 'Ouvindo… Diga o texto desde o início.';

  @override
  String get reciteChecking => 'Verificando…';

  @override
  String reciteHeard(String text) {
    return 'Ouvi: $text';
  }

  @override
  String get reciteSkipped => 'Você pulou uma parte';

  @override
  String get reciteWrong => 'Você errou';

  @override
  String reciteExpected(String text) {
    return 'Correto: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'Você disse: $text';
  }

  @override
  String get reciteContinueHere => 'Continuar daqui';

  @override
  String get reciteFinish => 'Terminar';

  @override
  String reciteAccuracy(int n) {
    return 'Precisão: $n%';
  }

  @override
  String get reciteNoErrors => 'Nenhum erro, ótimo!';

  @override
  String reciteMinor(int n) {
    return '$n pequenos pulos (palavras curtas)';
  }

  @override
  String get reciteAgain => 'De novo';

  @override
  String get reciteNote =>
      'O reconhecimento não é perfeito; ele pode parar você quando estiver em dúvida.';

  @override
  String get reciteLoadFailed =>
      'Não foi possível abrir o modelo. Exclua e baixe novamente.';

  @override
  String get recordLines => 'Gravar vozes';

  @override
  String get recordLinesHelp =>
      'Grave as falas dos outros personagens com a sua voz ou a de um amigo; no ensaio elas tocam no lugar da voz sintética, com emoção de verdade. As gravações ficam no celular e não entram no backup.';

  @override
  String get recordStart => 'Gravar';

  @override
  String get recordStop => 'Parar';

  @override
  String get recordPlay => 'Ouvir';

  @override
  String get recordDelete => 'Apagar gravação';

  @override
  String get recordNext => 'Próxima';

  @override
  String get recordPrev => 'Anterior';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total falas gravadas';
  }

  @override
  String get recordIncludeMine => 'Mostrar também minhas falas';

  @override
  String get recordNone => 'Nenhuma fala para gravar.';

  @override
  String get recordingNow => 'Gravando…';

  @override
  String get recordedBadge => 'Gravada';
}
