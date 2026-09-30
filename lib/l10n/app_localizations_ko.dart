// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class LKo extends L {
  LKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '암기 도우미';

  @override
  String get library => '내 텍스트';

  @override
  String get emptyLibrary => '아직 아무것도 없습니다. 희곡, 시, 연설문을 추가하고 암기를 시작하세요.';

  @override
  String get newPiece => '새로 만들기';

  @override
  String get kindPlay => '희곡 / 장면';

  @override
  String get kindPoem => '시 / 텍스트';

  @override
  String get kindSpeech => '연설 / 발표';

  @override
  String get kindPlayHelp =>
      '대사는 \'이름: 대사\' 형식으로 쓰세요. 지문은 (괄호) 안에 넣습니다. 시나리오 형식도 됩니다.';

  @override
  String get kindPoemHelp =>
      '한 줄이 한 단계가 됩니다. 시, 노래, 목록 등 글자 그대로 외워야 하는 텍스트에 좋습니다.';

  @override
  String get kindSpeechHelp =>
      '줄마다 있는 문장이나 문단이 한 단계가 됩니다. 시간과 말하는 속도를 확인할 수 있습니다.';

  @override
  String get title => '제목';

  @override
  String get voiceLanguage => '읽어 주는 언어';

  @override
  String get pasteHint => '여기에 텍스트를 붙여넣거나 입력하세요';

  @override
  String get importFile => '파일 열기 (.txt, .pdf, .docx)';

  @override
  String get importFailed => '이 파일을 읽을 수 없습니다. 일반 텍스트(.txt) 파일을 사용하세요.';

  @override
  String get continueAction => '계속';

  @override
  String get reviewTitle => '대사 확인';

  @override
  String get reviewHelp =>
      '이름을 누르면 대사를 다른 인물에게 넘길 수 있습니다. 글을 누르면 고칠 수 있습니다. 더 보려면 ⋮.';

  @override
  String get whoAmI => '어느 인물을 맡으셨나요?';

  @override
  String get whoAmIHelp => '이 인물의 대사를 연습하게 됩니다.';

  @override
  String get characters => '등장인물';

  @override
  String get direction => '지문';

  @override
  String get heading => '장면';

  @override
  String get editLine => '글 고치기';

  @override
  String get deleteLine => '삭제';

  @override
  String get mergeWithPrevious => '윗줄과 합치기';

  @override
  String get makeDirection => '지문으로 바꾸기';

  @override
  String get makeHeading => '장면 제목으로 바꾸기';

  @override
  String get makeDialogue => '대사로 바꾸기';

  @override
  String get addLineBelow => '아래에 줄 추가';

  @override
  String get assignTo => '누구의 대사인가요?';

  @override
  String get newCharacter => '새 인물';

  @override
  String get save => '저장';

  @override
  String get cancel => '취소';

  @override
  String get delete => '삭제';

  @override
  String get rename => '이름 바꾸기';

  @override
  String get mergeInto => '다음과 합치기…';

  @override
  String get name => '이름';

  @override
  String get voice => '목소리';

  @override
  String get pitch => '음높이';

  @override
  String get speed => '속도';

  @override
  String get testVoice => '들어 보기';

  @override
  String get defaultVoice => '기본 목소리';

  @override
  String get testSentence => '안녕하세요! 제 목소리는 이렇게 들립니다.';

  @override
  String get noVoices =>
      '기기에 이 언어의 음성이 없습니다. Android의 텍스트 음성 변환 설정에서 설치할 수 있습니다.';

  @override
  String get rehearse => '연습';

  @override
  String get mode => '모드';

  @override
  String get modeListen => '듣기';

  @override
  String get modeListenHelp => '전부 소리 내어 읽어 줍니다. 텍스트에 익숙해질 때 좋습니다.';

  @override
  String get modeWait => '기다려 주기';

  @override
  String get modeWaitHelp => '내 차례에서 멈춥니다. 대사를 말한 뒤 \'계속\'을 누르세요.';

  @override
  String get modeCheck => '확인해 주기';

  @override
  String get modeCheckHelp => '대사를 말할 시간을 준 뒤, 스스로 확인할 수 있도록 읽어 줍니다.';

  @override
  String get modeRun => '이어서 하기';

  @override
  String get modeRunHelp => '대사를 말할 시간을 주고, 읽지 않고 넘어갑니다.';

  @override
  String get hint => '내 대사 표시';

  @override
  String get hintFull => '전체';

  @override
  String get hintFirst => '첫 글자';

  @override
  String get hintHidden => '숨김';

  @override
  String get readDirections => '지문도 읽어 주기';

  @override
  String get pauseLength => '내 대사 시간';

  @override
  String get yourTurn => '내 차례';

  @override
  String get show => '보기';

  @override
  String get play => '시작';

  @override
  String get pause => '일시정지';

  @override
  String get previousLine => '이전 줄';

  @override
  String get nextLine => '다음 줄';

  @override
  String get jumpToScene => '장면으로 이동';

  @override
  String get fromStart => '처음부터';

  @override
  String get finished => '연습이 끝났습니다.';

  @override
  String get restart => '처음부터 다시';

  @override
  String get settings => '설정';

  @override
  String get appLanguage => '앱 언어';

  @override
  String get systemDefault => '시스템 기본값';

  @override
  String get backup => '모든 텍스트 백업';

  @override
  String get backupHelp => '휴대폰을 바꿔도 텍스트를 잃지 않도록 백업 파일을 저장합니다.';

  @override
  String get restore => '백업에서 복원';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '텍스트 $count개를 복원했습니다',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => '올바른 백업 파일이 아닙니다.';

  @override
  String deleteConfirm(String title) {
    return '\"$title\"을(를) 삭제할까요? 되돌릴 수 없습니다.';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count줄',
    );
    return '$_temp0';
  }

  @override
  String get privacy => '개인정보';

  @override
  String get privacyText =>
      '텍스트는 휴대폰에만 저장되며 어디에도 업로드되지 않습니다. 음성은 휴대폰의 텍스트 음성 변환 엔진이 기기에서 만듭니다. 사진 속 글자는 Google ML Kit이 기기에서 읽습니다. 사진은 어디에도 전송되지 않지만, ML Kit이 익명 진단 데이터(기기 모델, 오류 코드 등)를 Google에 보낼 수 있습니다. 핸즈프리 모드에서 마이크는 말이 끝났는지 알아내기 위해 기기 안에서 실시간으로만 사용됩니다. \'내가 말한 내용 확인\'을 켜면 말소리는 휴대폰의 기기 내 음성 인식으로 글자로 바뀝니다. 앱은 온라인 인식을 절대 사용하지 않습니다. 아무것도 녹음되거나 전송되지 않습니다. \'암송 확인\' 모드에서는 한 번만 내려받는 오픈 소스 Whisper 모델이 기기에서 말소리를 글자로 바꿉니다. 유일한 예외는 \'목소리 녹음\'입니다. \'녹음\'을 누를 때만 대사가 녹음되며, 녹음은 휴대폰에 남고 전송되지 않습니다.';

  @override
  String get privacyPolicyFull => '개인정보처리방침 전문';

  @override
  String get appVersion => '버전';

  @override
  String get noMyCharacter => '연습을 시작하기 전에 내 역할을 하나 이상 선택하세요.';

  @override
  String get me => '나';

  @override
  String get modeHandsFree => '핸즈프리';

  @override
  String get modeHandsFreeHelp =>
      '내 차례가 되면 듣기 시작합니다. 대사를 말하고 멈추면 다음으로 넘어갑니다. 막히면 대사를 읽어 줍니다.';

  @override
  String get listening => '듣는 중… 대사를 말하세요';

  @override
  String get micDenied => '핸즈프리 모드에는 마이크 권한이 필요합니다. \'기다려 주기\'로 바꿨습니다.';

  @override
  String get endSilence => '대사가 끝났다고 보는 침묵 시간';

  @override
  String voiceN(int n) {
    return '목소리 $n';
  }

  @override
  String get linesHeader => '대사';

  @override
  String get pdfScanned =>
      '이 PDF에는 선택할 수 있는 글자가 없습니다(스캔한 페이지 같습니다). \'사진에서\'로 이미지에서 읽거나 텍스트를 붙여넣으세요.';

  @override
  String get hintWord => '힌트';

  @override
  String get checkAccuracy => '내가 말한 내용 확인';

  @override
  String get checkAccuracyHelp =>
      '말소리는 휴대폰의 음성 인식으로 기기에서 글자로 바뀌어 대사와 비교됩니다. 아무것도 녹음되지 않으며 목소리가 휴대폰 밖으로 나가지 않습니다.';

  @override
  String get sttUnavailable =>
      '이 휴대폰에는 기기 내 음성 인식이 없어 정확도를 확인할 수 없습니다. 핸즈프리 모드는 그대로 쓸 수 있습니다.';

  @override
  String get sttLanguageMissing => '휴대폰에 이 언어의 기기 내 음성 인식이 없습니다.';

  @override
  String get sttDownload => '이 언어의 음성 인식 내려받기';

  @override
  String get sttDownloading => '언어 팩을 내려받는 중… 몇 분 걸릴 수 있습니다.';

  @override
  String get readCorrection => '틀리면 올바른 대사 읽어 주기';

  @override
  String accuracyScore(int score) {
    return '정확도 $score%';
  }

  @override
  String missedWords(String words) {
    return '빠뜨림: $words';
  }

  @override
  String get notUnderstood => '알아듣지 못했습니다';

  @override
  String summaryAccuracy(int score) {
    return '평균 정확도 $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '프롬프터 도움 $count번',
      zero: '프롬프터 도움 없음',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => '훌륭해요! 도움 없이 끝까지 해냈습니다.';

  @override
  String get finishedGood => '잘하고 있어요! 연습이 끝났습니다.';

  @override
  String get finishedPractice => '연습이 끝났습니다. 막혔던 부분을 다시 연습해 보세요.';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '대사 $count개',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '대사 $count개에서 도움 받음',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '대사 $count개 교정',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '대사 $count개를 알아듣지 못함',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => '사진에서';

  @override
  String get takePhoto => '사진 찍기';

  @override
  String get reading => '읽는 중…';

  @override
  String get docOld =>
      '예전 Word 파일(.doc)은 읽을 수 없습니다. 문서를 .docx나 PDF로 저장한 뒤 다시 시도하세요.';

  @override
  String get noTextInPhoto =>
      '사진에서 읽을 수 있는 글자를 찾지 못했습니다. 밝은 곳에서 정면으로 찍은 선명한 사진으로 다시 시도하세요.';

  @override
  String get photoAlphabet => '사진에서 읽기는 라틴 문자(알파벳)만 지원합니다. 텍스트를 입력하거나 붙여넣으세요.';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '누구의 대사인지 알 수 없는 줄이 $count개 있습니다. 표시된 줄을 눌러 고치세요.',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Enter를 누르면 줄을 둘로 나눕니다.';

  @override
  String get charactersAndVoices => '등장인물과 목소리';

  @override
  String get hintProgressive => '점점 가리기';

  @override
  String get hintKeywords => '핵심어';

  @override
  String hideRatio(int percent) {
    return '가린 단어: $percent%';
  }

  @override
  String levelUp(int percent) {
    return '좋아요! 다음 번에는 단어의 $percent%를 가립니다.';
  }

  @override
  String get modeBuildUp => '쌓아 가기';

  @override
  String get modeBuildUpHelp =>
      '먼저 1행, 다음에 1–2행, 다음에 1–3행… 새 줄은 먼저 읽어 주고, 그다음 처음부터 전부 말합니다. 시와 짧은 글에 좋습니다.';

  @override
  String stepOf(int step, int total) {
    return '$step/$total 단계';
  }

  @override
  String get onlyWeak => '어려웠던 줄만';

  @override
  String get onlyWeakHelp => '도움을 받았거나, 교정되었거나, 점수가 낮았던 줄만 연습합니다.';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '어려웠던 줄 $count개',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => '아직 어려운 줄이 없습니다';

  @override
  String elapsed(String time) {
    return '시간 $time';
  }

  @override
  String get targetTime => '목표 시간';

  @override
  String get targetNone => '목표 없음';

  @override
  String overTarget(String time) {
    return '목표보다 $time 초과';
  }

  @override
  String underTarget(String time) {
    return '목표보다 $time 짧음';
  }

  @override
  String wpm(int wpm) {
    return '분당 $wpm단어';
  }

  @override
  String get proTitle => '암기 Pro';

  @override
  String get proPitch => 'Pro로 더 빨리 외우세요.';

  @override
  String get proFeatureHandsFree =>
      '핸즈프리 연습: 내 차례가 되면 듣기 시작하므로 휴대폰을 만질 필요가 없습니다';

  @override
  String proFeatureUnlimited(int count) {
    return '텍스트 무제한 (무료 버전: $count개)';
  }

  @override
  String proTrial(int days, String price) {
    return '$days일 무료, 이후 월 $price';
  }

  @override
  String proPrice(String price) {
    return '월 $price';
  }

  @override
  String get proStartTrial => '무료 체험 시작';

  @override
  String get proSubscribe => '구독';

  @override
  String get proRestore => '구매 복원';

  @override
  String get proTerms =>
      '구독은 매월 자동으로 갱신됩니다. Google Play > 정기 결제에서 언제든지 해지할 수 있으며, 해지해도 기간이 끝날 때까지 Pro를 쓸 수 있습니다.';

  @override
  String get proUnavailable => '지금은 구독할 수 없습니다. 나중에 다시 시도하세요.';

  @override
  String get proActive => 'Pro 사용 중';

  @override
  String get proManage => '구독 관리';

  @override
  String get proUpgrade => 'Pro로 업그레이드';

  @override
  String proLimitReached(int count) {
    return '무료 버전에서는 텍스트를 $count개까지 저장할 수 있습니다.';
  }

  @override
  String get proThanks => '감사합니다! Pro가 켜졌습니다.';

  @override
  String get proHandsFreeLocked => '핸즈프리 연습은 Pro 기능입니다. \'기다려 주기\'로 바꿨습니다.';

  @override
  String get proNotFound => '사용 중인 구독을 찾지 못했습니다.';

  @override
  String get modePages => '페이지별 발표';

  @override
  String get modePagesHelp =>
      '\'1페이지\'라고 말하고, 시간이 다 되면 \'시간이 다 됐습니다. 2페이지\'라고 넘어갑니다. 원고를 보지 않고 말하세요. 일찍 끝나면 \'다음 페이지\'를 누르세요.';

  @override
  String pageCue(int n) {
    return '$n페이지';
  }

  @override
  String pageCueTitled(int n, String title) {
    return '$n페이지. $title';
  }

  @override
  String get timeUp => '시간이 다 됐습니다.';

  @override
  String get presentationDone => '발표가 끝났습니다.';

  @override
  String get nextPage => '다음 페이지';

  @override
  String get pageTimes => '페이지별 시간';

  @override
  String get pageTimesHelp => '페이지는 텍스트의 제목으로 나뉘고, 제목이 없으면 문단으로 나뉩니다.';

  @override
  String get pageTimesAuto => '자동으로 나누기';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'P$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return '$n/$total 페이지';
  }

  @override
  String get emotion => '어조';

  @override
  String get emotionHelp =>
      '이 감정에 맞게 속도, 음높이, 음량을 조절합니다. 텍스트의 (화내며), (울면서) 같은 지문은 자동으로 인식됩니다.';

  @override
  String get emoNeutral => '보통';

  @override
  String get emoHappy => '기쁨';

  @override
  String get emoSad => '슬픔';

  @override
  String get emoAngry => '화남';

  @override
  String get emoExcited => '신남';

  @override
  String get emoCalm => '차분함';

  @override
  String get emoWhisper => '속삭임';

  @override
  String get emoAfraid => '두려움';

  @override
  String get modeRecite => '암송 확인 (오류 찾기)';

  @override
  String get modeReciteHelp =>
      '텍스트를 외워서 말하세요. 빠뜨리거나 틀린 곳에서 멈추고 오류를 보여 줍니다. 끝나면 보고서가 나옵니다.';

  @override
  String get reciteTitle => '암송 확인';

  @override
  String get reciteModelTitle => '음성 인식 모델';

  @override
  String get reciteModelHelp =>
      '오류 확인을 위해 휴대폰에서 실행되는 음성 인식 모델을 한 번만 내려받습니다. 무료이며 목소리가 휴대폰 밖으로 나가지 않습니다. Wi-Fi를 권장합니다.';

  @override
  String reciteModelStandard(int mb) {
    return '표준 ($mb MB) — 빠름';
  }

  @override
  String reciteModelAccurate(int mb) {
    return '높은 정확도 ($mb MB) — 더 느림';
  }

  @override
  String get reciteDownload => '내려받기';

  @override
  String reciteDownloading(int pct) {
    return '내려받는 중… $pct%';
  }

  @override
  String get reciteDownloadFailed => '내려받지 못했습니다. 연결을 확인하고 다시 시도하세요.';

  @override
  String get reciteLoading => '모델을 불러오는 중…';

  @override
  String get reciteStart => '시작';

  @override
  String get reciteListening => '듣는 중… 처음부터 말하세요.';

  @override
  String get reciteChecking => '확인 중…';

  @override
  String reciteHeard(String text) {
    return '들은 내용: $text';
  }

  @override
  String get reciteSkipped => '일부를 빠뜨렸습니다';

  @override
  String get reciteWrong => '틀리게 말했습니다';

  @override
  String reciteExpected(String text) {
    return '정답: $text';
  }

  @override
  String reciteYouSaid(String text) {
    return '내가 한 말: $text';
  }

  @override
  String get reciteContinueHere => '여기서부터 계속';

  @override
  String get reciteFinish => '끝내기';

  @override
  String reciteAccuracy(int n) {
    return '정확도: $n%';
  }

  @override
  String get reciteNoErrors => '틀린 곳이 없습니다. 훌륭해요!';

  @override
  String reciteMinor(int n) {
    return '작은 누락 $n개 (짧은 단어)';
  }

  @override
  String get reciteAgain => '다시';

  @override
  String get reciteNote => '인식이 완벽하지는 않습니다. 확실하지 않은 곳에서 멈출 수 있습니다.';

  @override
  String get reciteLoadFailed => '모델을 열 수 없습니다. 삭제한 뒤 다시 내려받아 보세요.';

  @override
  String get recordLines => '목소리 녹음';

  @override
  String get recordLinesHelp =>
      '상대역 대사를 내 목소리나 친구의 목소리로 녹음하세요. 연습할 때 합성 음성 대신 이 녹음이 재생되어 감정이 살아납니다. 녹음은 휴대폰에만 저장되며 백업에 포함되지 않습니다.';

  @override
  String get recordStart => '녹음';

  @override
  String get recordStop => '정지';

  @override
  String get recordPlay => '듣기';

  @override
  String get recordDelete => '녹음 삭제';

  @override
  String get recordNext => '다음';

  @override
  String get recordPrev => '이전';

  @override
  String recordedCount(int n, int total) {
    return '대사 $n/$total개 녹음됨';
  }

  @override
  String get recordIncludeMine => '내 대사도 표시';

  @override
  String get recordNone => '녹음할 대사가 없습니다.';

  @override
  String get recordingNow => '녹음 중…';

  @override
  String get recordedBadge => '녹음됨';
}
