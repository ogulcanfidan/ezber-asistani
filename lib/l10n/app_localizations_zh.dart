// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class LZh extends L {
  LZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '背诵助手';

  @override
  String get library => '我的文本';

  @override
  String get emptyLibrary => '这里还没有内容。添加一部剧本、一首诗或一篇演讲，开始背诵吧。';

  @override
  String get newPiece => '新建';

  @override
  String get kindPlay => '戏剧 / 场景';

  @override
  String get kindPoem => '诗歌 / 文本';

  @override
  String get kindSpeech => '演讲 / 演示';

  @override
  String get kindPlayHelp => '每句台词写成“角色名：台词”。舞台提示放在（括号）里。也支持电影剧本格式。';

  @override
  String get kindPoemHelp => '每一行是一个步骤。适合诗歌、歌词、清单以及任何需要逐字背诵的文本。';

  @override
  String get kindSpeechHelp => '单独成行的每个句子或段落是一个步骤。可以查看用时和语速。';

  @override
  String get title => '标题';

  @override
  String get voiceLanguage => '朗读语言';

  @override
  String get pasteHint => '在这里粘贴或输入文本';

  @override
  String get importFile => '打开文件（.txt、.pdf、.docx）';

  @override
  String get importFailed => '无法读取此文件。请使用纯文本（.txt）文件。';

  @override
  String get continueAction => '继续';

  @override
  String get reviewTitle => '检查台词';

  @override
  String get reviewHelp => '点按名字可把这句台词交给其他角色。点按文字可编辑。更多选项请点 ⋮。';

  @override
  String get whoAmI => '你演哪个角色？';

  @override
  String get whoAmIHelp => '你要练习的就是这个角色的台词。';

  @override
  String get characters => '角色';

  @override
  String get direction => '舞台提示';

  @override
  String get heading => '场景';

  @override
  String get editLine => '编辑文字';

  @override
  String get deleteLine => '删除';

  @override
  String get mergeWithPrevious => '与上一行合并';

  @override
  String get makeDirection => '设为舞台提示';

  @override
  String get makeHeading => '设为场景标题';

  @override
  String get makeDialogue => '设为台词';

  @override
  String get addLineBelow => '在下方添加一行';

  @override
  String get assignTo => '这句是谁说的？';

  @override
  String get newCharacter => '新角色';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get rename => '重命名';

  @override
  String get mergeInto => '合并到…';

  @override
  String get name => '名字';

  @override
  String get voice => '声音';

  @override
  String get pitch => '音调';

  @override
  String get speed => '语速';

  @override
  String get testVoice => '试听';

  @override
  String get defaultVoice => '默认声音';

  @override
  String get testSentence => '你好！我的声音听起来是这样的。';

  @override
  String get noVoices => '你的设备上没有这种语言的声音。可以在 Android 的文字转语音设置中安装。';

  @override
  String get rehearse => '排练';

  @override
  String get mode => '模式';

  @override
  String get modeListen => '听';

  @override
  String get modeListenHelp => '全部内容都会朗读出来。适合熟悉文本。';

  @override
  String get modeWait => '等我';

  @override
  String get modeWaitHelp => '轮到你时停下。说完台词后点“继续”。';

  @override
  String get modeCheck => '检查我';

  @override
  String get modeCheckHelp => '先留出时间让你说台词，再朗读出来供你核对。';

  @override
  String get modeRun => '连排';

  @override
  String get modeRunHelp => '留出时间让你说台词，不朗读，直接继续。';

  @override
  String get hint => '我的台词显示为';

  @override
  String get hintFull => '全文';

  @override
  String get hintFirst => '首字';

  @override
  String get hintHidden => '隐藏';

  @override
  String get readDirections => '朗读舞台提示';

  @override
  String get pauseLength => '留给我的时间';

  @override
  String get yourTurn => '轮到你了';

  @override
  String get show => '显示';

  @override
  String get play => '开始';

  @override
  String get pause => '暂停';

  @override
  String get previousLine => '上一行';

  @override
  String get nextLine => '下一行';

  @override
  String get jumpToScene => '跳到场景';

  @override
  String get fromStart => '从头开始';

  @override
  String get finished => '排练结束。';

  @override
  String get restart => '重新开始';

  @override
  String get settings => '设置';

  @override
  String get appLanguage => '应用语言';

  @override
  String get systemDefault => '跟随系统';

  @override
  String get backup => '备份全部文本';

  @override
  String get backupHelp => '保存一个备份文件，换手机时文本不会丢失。';

  @override
  String get restore => '从备份恢复';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '已恢复 $count 个文本',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => '此文件不是有效的备份。';

  @override
  String deleteConfirm(String title) {
    return '要删除“$title”吗？此操作无法撤销。';
  }

  @override
  String lineCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 行',
    );
    return '$_temp0';
  }

  @override
  String get privacy => '隐私';

  @override
  String get privacyText =>
      '你的文本保存在手机上，不会上传到任何地方。声音由手机自带的文字转语音引擎在设备上生成。照片中的文字由 Google ML Kit 在手机上识别；照片不会发送到任何地方，但 ML Kit 可能向 Google 发送匿名诊断数据（如设备型号、错误代码）。在免提模式下，麦克风只在设备上实时使用，用来判断你是否已经说完。如果开启“检查我说的内容”，你的语音会由手机自带的设备端语音识别转成文字；应用从不使用在线识别。不会录音，也不会发送任何内容。在“背诵检查”模式下，你的语音由只需下载一次的开源 Whisper 模型在手机上转成文字。唯一的例外是“录制声音”：只有在你点按“录音”时才会录下台词，这些录音保存在手机上，不会发送。';

  @override
  String get privacyPolicyFull => '完整隐私政策';

  @override
  String get appVersion => '版本';

  @override
  String get noMyCharacter => '开始排练前，请至少选择一个角色作为你自己。';

  @override
  String get me => '我';

  @override
  String get modeHandsFree => '免提';

  @override
  String get modeHandsFreeHelp => '轮到你时开始聆听。说出你的台词，你停下后会自动继续。卡住时会把台词读给你听。';

  @override
  String get listening => '正在听… 请说出你的台词';

  @override
  String get micDenied => '免提模式需要麦克风权限。已切换到“等我”模式。';

  @override
  String get endSilence => '停顿多久算说完';

  @override
  String voiceN(int n) {
    return '声音 $n';
  }

  @override
  String get linesHeader => '台词';

  @override
  String get pdfScanned => '这个 PDF 没有可选择的文字（看起来是扫描页）。可以用“从照片”识别图片，或直接粘贴文本。';

  @override
  String get hintWord => '提示';

  @override
  String get checkAccuracy => '检查我说的内容';

  @override
  String get checkAccuracyHelp =>
      '你的语音由手机自带的语音识别在设备上转成文字，并与台词比对。不会录音，你的声音不会离开手机。';

  @override
  String get sttUnavailable => '这部手机没有设备端语音识别，无法检查准确度。免提模式仍可使用。';

  @override
  String get sttLanguageMissing => '你的手机上没有这种语言的设备端语音识别。';

  @override
  String get sttDownload => '下载这种语言的语音识别';

  @override
  String get sttDownloading => '正在下载语言包… 可能需要几分钟。';

  @override
  String get readCorrection => '说错时朗读正确的台词';

  @override
  String accuracyScore(int score) {
    return '正确率 $score%';
  }

  @override
  String missedWords(String words) {
    return '漏掉：$words';
  }

  @override
  String get notUnderstood => '没听清';

  @override
  String summaryAccuracy(int score) {
    return '平均正确率 $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '提词 $count 次',
      zero: '没有用到提词',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => '太棒了！你没有借助任何帮助就完成了。';

  @override
  String get finishedGood => '进展不错！排练结束。';

  @override
  String get finishedPractice => '排练结束。再练一练卡住的地方。';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 句台词',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 句用了提词',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 句被纠正',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 句没听清',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => '从照片';

  @override
  String get takePhoto => '拍照';

  @override
  String get reading => '正在读取…';

  @override
  String get docOld => '无法读取旧版 Word 文件（.doc）。请把文档另存为 .docx 或 PDF 后重试。';

  @override
  String get noTextInPhoto => '照片中没有找到可识别的文字。请换一张更清晰、光线充足、正面拍摄的照片。';

  @override
  String get photoAlphabet => '从照片读取文字只支持拉丁字母。请输入或粘贴文本。';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 行无法确定是谁说的。点按标出的行进行修正。',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => '按回车键可把这一行分成两行。';

  @override
  String get charactersAndVoices => '角色和声音';

  @override
  String get hintProgressive => '逐步隐藏';

  @override
  String get hintKeywords => '关键词';

  @override
  String hideRatio(int percent) {
    return '隐藏的字词：$percent%';
  }

  @override
  String levelUp(int percent) {
    return '很好！下一轮会隐藏 $percent% 的字词。';
  }

  @override
  String get modeBuildUp => '逐句累加';

  @override
  String get modeBuildUpHelp =>
      '先第 1 行，再 1–2 行，再 1–3 行… 每个新行先读给你听，然后你从头把全部说一遍。适合诗歌和短文。';

  @override
  String stepOf(int step, int total) {
    return '第 $step/$total 步';
  }

  @override
  String get onlyWeak => '只练我卡住的行';

  @override
  String get onlyWeakHelp => '只练习需要提词、被纠正或得分较低的行。';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '有 $count 行你觉得困难',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => '还没有困难的行';

  @override
  String elapsed(String time) {
    return '用时 $time';
  }

  @override
  String get targetTime => '目标时间';

  @override
  String get targetNone => '无目标';

  @override
  String overTarget(String time) {
    return '超出目标 $time';
  }

  @override
  String underTarget(String time) {
    return '比目标少 $time';
  }

  @override
  String wpm(int wpm) {
    return '每分钟 $wpm 词';
  }

  @override
  String get proTitle => '背诵 Pro';

  @override
  String get proPitch => '用 Pro 更快背下来。';

  @override
  String get proFeatureHandsFree => '免提排练：轮到你时自动聆听，不用碰手机';

  @override
  String proFeatureUnlimited(int count) {
    return '文本数量不限（免费版：$count 个）';
  }

  @override
  String proTrial(int days, String price) {
    return '免费 $days 天，之后每月 $price';
  }

  @override
  String proPrice(String price) {
    return '每月 $price';
  }

  @override
  String get proStartTrial => '开始免费试用';

  @override
  String get proSubscribe => '订阅';

  @override
  String get proRestore => '恢复购买';

  @override
  String get proTerms =>
      '订阅每月自动续订。可随时在 Google Play > 订阅中取消；取消后，Pro 在当前周期结束前仍然有效。';

  @override
  String get proUnavailable => '暂时无法订阅。请稍后再试。';

  @override
  String get proActive => 'Pro 已启用';

  @override
  String get proManage => '管理订阅';

  @override
  String get proUpgrade => '升级到 Pro';

  @override
  String proLimitReached(int count) {
    return '免费版最多可保存 $count 个文本。';
  }

  @override
  String get proThanks => '谢谢！Pro 已启用。';

  @override
  String get proHandsFreeLocked => '免提排练是 Pro 功能。已切换到“等我”模式。';

  @override
  String get proNotFound => '没有找到有效的订阅。';

  @override
  String get modePages => '逐页演示';

  @override
  String get modePagesHelp => '会说“第 1 页”，时间到了会说“时间到。第 2 页”。不看稿讲；提前讲完就点“下一页”。';

  @override
  String pageCue(int n) {
    return '第 $n 页';
  }

  @override
  String pageCueTitled(int n, String title) {
    return '第 $n 页。$title';
  }

  @override
  String get timeUp => '时间到。';

  @override
  String get presentationDone => '演示结束。';

  @override
  String get nextPage => '下一页';

  @override
  String get pageTimes => '每页时间';

  @override
  String get pageTimesHelp => '页面按文本中的标题划分；没有标题时按段落划分。';

  @override
  String get pageTimesAuto => '自动分配';

  @override
  String pageSummary(int n, String used, String planned) {
    return '第$n页 $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return '第 $n/$total 页';
  }

  @override
  String get emotion => '语气';

  @override
  String get emotionHelp => '语速、音调和音量会按这种情绪调整。文本中（生气地）、（哭着）这类提示会自动识别。';

  @override
  String get emoNeutral => '正常';

  @override
  String get emoHappy => '开心';

  @override
  String get emoSad => '悲伤';

  @override
  String get emoAngry => '生气';

  @override
  String get emoExcited => '兴奋';

  @override
  String get emoCalm => '平静';

  @override
  String get emoWhisper => '低语';

  @override
  String get emoAfraid => '害怕';

  @override
  String get modeRecite => '背诵检查（找出错误）';

  @override
  String get modeReciteHelp => '凭记忆说出文本；在你漏掉或说错的地方停下并显示错误。结束时给出报告。';

  @override
  String get reciteTitle => '背诵检查';

  @override
  String get reciteModelTitle => '语音识别模型';

  @override
  String get reciteModelHelp =>
      '为了检查错误，需要下载一次在手机上运行的语音识别模型。免费；你的声音不会离开手机。建议使用 Wi-Fi。';

  @override
  String reciteModelStandard(int mb) {
    return '标准（$mb MB）— 快';
  }

  @override
  String reciteModelAccurate(int mb) {
    return '高准确度（$mb MB）— 较慢';
  }

  @override
  String get reciteDownload => '下载';

  @override
  String reciteDownloading(int pct) {
    return '正在下载… $pct%';
  }

  @override
  String get reciteDownloadFailed => '下载失败。请检查网络后重试。';

  @override
  String get reciteLoading => '正在加载模型…';

  @override
  String get reciteStart => '开始';

  @override
  String get reciteListening => '正在听… 请从头说出文本。';

  @override
  String get reciteChecking => '正在检查…';

  @override
  String reciteHeard(String text) {
    return '我听到的：$text';
  }

  @override
  String get reciteSkipped => '你漏掉了一部分';

  @override
  String get reciteWrong => '你说错了';

  @override
  String reciteExpected(String text) {
    return '正确：$text';
  }

  @override
  String reciteYouSaid(String text) {
    return '你说的：$text';
  }

  @override
  String get reciteContinueHere => '从这里继续';

  @override
  String get reciteFinish => '结束';

  @override
  String reciteAccuracy(int n) {
    return '正确率：$n%';
  }

  @override
  String get reciteNoErrors => '没有错误，太棒了！';

  @override
  String reciteMinor(int n) {
    return '$n 处小遗漏（短词）';
  }

  @override
  String get reciteAgain => '再来一次';

  @override
  String get reciteNote => '识别并不完美；在没把握的地方可能会让你停下。';

  @override
  String get reciteLoadFailed => '无法打开模型。请删除后重新下载。';

  @override
  String get recordLines => '录制声音';

  @override
  String get recordLinesHelp =>
      '用你自己或朋友的声音录下对手的台词；排练时会播放这些录音而不是合成声音，情感更真实。录音只保存在手机上，不包含在备份中。';

  @override
  String get recordStart => '录音';

  @override
  String get recordStop => '停止';

  @override
  String get recordPlay => '试听';

  @override
  String get recordDelete => '删除录音';

  @override
  String get recordNext => '下一句';

  @override
  String get recordPrev => '上一句';

  @override
  String recordedCount(int n, int total) {
    return '已录制 $n/$total 句';
  }

  @override
  String get recordIncludeMine => '也显示我自己的台词';

  @override
  String get recordNone => '没有可录制的台词。';

  @override
  String get recordingNow => '正在录音…';

  @override
  String get recordedBadge => '已录制';
}
