// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class LJa extends L {
  LJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '暗記アシスタント';

  @override
  String get library => 'マイテキスト';

  @override
  String get emptyLibrary => 'まだ何もありません。戯曲、詩、スピーチを追加して暗記を始めましょう。';

  @override
  String get newPiece => '新規';

  @override
  String get kindPlay => '戯曲 / シーン';

  @override
  String get kindPoem => '詩 / テキスト';

  @override
  String get kindSpeech => 'スピーチ / プレゼン';

  @override
  String get kindPlayHelp =>
      'セリフは「役名：セリフ」の形で書いてください。ト書きは（かっこ）に入れます。映画脚本の形式にも対応しています。';

  @override
  String get kindPoemHelp => '1行が1ステップになります。詩、歌、リストなど、一字一句覚えたいテキストに向いています。';

  @override
  String get kindSpeechHelp => '1行ごとの文や段落が1ステップになります。時間と話す速さを確認できます。';

  @override
  String get title => 'タイトル';

  @override
  String get voiceLanguage => '読み上げ言語';

  @override
  String get pasteHint => 'ここにテキストを貼り付けるか入力してください';

  @override
  String get importFile => 'ファイルを開く（.txt、.pdf、.docx）';

  @override
  String get importFailed => 'このファイルは読み込めませんでした。テキストファイル（.txt）を使ってください。';

  @override
  String get continueAction => '次へ';

  @override
  String get reviewTitle => 'セリフを確認';

  @override
  String get reviewHelp =>
      '名前をタップすると、そのセリフを別の登場人物に変更できます。本文をタップすると編集できます。その他は ⋮ から。';

  @override
  String get whoAmI => 'あなたの役はどれですか？';

  @override
  String get whoAmIHelp => 'この役のセリフを練習します。';

  @override
  String get characters => '登場人物';

  @override
  String get direction => 'ト書き';

  @override
  String get heading => 'シーン';

  @override
  String get editLine => '本文を編集';

  @override
  String get deleteLine => '削除';

  @override
  String get mergeWithPrevious => '上の行とつなげる';

  @override
  String get makeDirection => 'ト書きにする';

  @override
  String get makeHeading => 'シーンの見出しにする';

  @override
  String get makeDialogue => 'セリフにする';

  @override
  String get addLineBelow => '下に行を追加';

  @override
  String get assignTo => '誰のセリフですか？';

  @override
  String get newCharacter => '新しい登場人物';

  @override
  String get save => '保存';

  @override
  String get cancel => 'キャンセル';

  @override
  String get delete => '削除';

  @override
  String get rename => '名前を変更';

  @override
  String get mergeInto => '統合先…';

  @override
  String get name => '名前';

  @override
  String get voice => '声';

  @override
  String get pitch => '声の高さ';

  @override
  String get speed => '速さ';

  @override
  String get testVoice => '試聴';

  @override
  String get defaultVoice => '標準の声';

  @override
  String get testSentence => 'こんにちは！こんな声で読み上げます。';

  @override
  String get noVoices => 'この言語の音声が端末に見つかりません。Android のテキスト読み上げ設定からインストールできます。';

  @override
  String get rehearse => '稽古';

  @override
  String get mode => 'モード';

  @override
  String get modeListen => '聞く';

  @override
  String get modeListenHelp => 'すべて読み上げます。テキストに慣れるのに向いています。';

  @override
  String get modeWait => '待ってもらう';

  @override
  String get modeWaitHelp => 'あなたの番で止まります。セリフを言ってから「次へ」をタップします。';

  @override
  String get modeCheck => '答え合わせ';

  @override
  String get modeCheckHelp => 'セリフを言う時間を取り、そのあと読み上げるので自分で確認できます。';

  @override
  String get modeRun => '通し稽古';

  @override
  String get modeRunHelp => 'セリフを言う時間を取り、読み上げずに先へ進みます。';

  @override
  String get hint => '自分のセリフの表示';

  @override
  String get hintFull => '全文';

  @override
  String get hintFirst => '最初の文字';

  @override
  String get hintHidden => '非表示';

  @override
  String get readDirections => 'ト書きを読み上げる';

  @override
  String get pauseLength => 'セリフの時間';

  @override
  String get yourTurn => 'あなたの番です';

  @override
  String get show => '表示';

  @override
  String get play => '開始';

  @override
  String get pause => '一時停止';

  @override
  String get previousLine => '前の行';

  @override
  String get nextLine => '次の行';

  @override
  String get jumpToScene => 'シーンへ移動';

  @override
  String get fromStart => '最初から';

  @override
  String get finished => '稽古が終わりました。';

  @override
  String get restart => 'もう一度最初から';

  @override
  String get settings => '設定';

  @override
  String get appLanguage => 'アプリの言語';

  @override
  String get systemDefault => 'システムの設定';

  @override
  String get backup => 'すべてのテキストをバックアップ';

  @override
  String get backupHelp => '機種変更してもテキストを失わないよう、バックアップファイルを保存します。';

  @override
  String get restore => 'バックアップから復元';

  @override
  String restoreDone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 件のテキストを復元しました',
    );
    return '$_temp0';
  }

  @override
  String get restoreFailed => 'このファイルは有効なバックアップではありません。';

  @override
  String deleteConfirm(String title) {
    return '「$title」を削除しますか？この操作は取り消せません。';
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
  String get privacy => 'プライバシー';

  @override
  String get privacyText =>
      'テキストはスマートフォンの中に保存され、どこにもアップロードされません。音声はスマートフォンの読み上げエンジンによって端末内で作られます。写真の文字は Google ML Kit によって端末内で読み取られます。写真はどこにも送信されませんが、ML Kit が匿名の診断データ（機種名やエラーコードなど）を Google に送信することがあります。ハンズフリーモードでは、話し終わったことを判断するためだけに、マイクを端末内でリアルタイムに使います。「話した内容をチェック」をオンにすると、音声はスマートフォンの端末内音声認識で文字に変換されます。アプリがオンラインの認識を使うことはありません。何も録音も送信もされません。「暗唱チェック」モードでは、一度だけダウンロードするオープンソースの Whisper モデルが、端末内で音声を文字に変換します。唯一の例外は「声を録音」です。「録音」をタップしたときだけセリフが録音され、録音は端末内に残り、送信されません。';

  @override
  String get privacyPolicyFull => 'プライバシーポリシー全文';

  @override
  String get appVersion => 'バージョン';

  @override
  String get noMyCharacter => '稽古を始める前に、自分の役を1つ以上選んでください。';

  @override
  String get me => '自分';

  @override
  String get modeHandsFree => 'ハンズフリー';

  @override
  String get modeHandsFreeHelp =>
      'あなたの番になると聞き取りを始めます。セリフを言って黙ると先へ進みます。詰まったらセリフを読み上げます。';

  @override
  String get listening => '聞いています… セリフをどうぞ';

  @override
  String get micDenied => 'ハンズフリーモードにはマイクの許可が必要です。「待ってもらう」に切り替えました。';

  @override
  String get endSilence => 'セリフの終わりと判断する間';

  @override
  String voiceN(int n) {
    return '声 $n';
  }

  @override
  String get linesHeader => 'セリフ';

  @override
  String get pdfScanned =>
      'この PDF には選択できる文字がありません（スキャンしたページのようです）。「写真から」で画像から読み取るか、テキストを貼り付けてください。';

  @override
  String get hintWord => 'ヒント';

  @override
  String get checkAccuracy => '話した内容をチェック';

  @override
  String get checkAccuracyHelp =>
      '音声はスマートフォンの音声認識で端末内で文字に変換され、セリフと比べられます。何も録音されず、声が端末の外に出ることはありません。';

  @override
  String get sttUnavailable =>
      'このスマートフォンには端末内音声認識がないため、正確さをチェックできません。ハンズフリーモードは使えます。';

  @override
  String get sttLanguageMissing => 'この言語の端末内音声認識がスマートフォンにありません。';

  @override
  String get sttDownload => 'この言語の音声認識をダウンロード';

  @override
  String get sttDownloading => '言語パックをダウンロード中… 数分かかることがあります。';

  @override
  String get readCorrection => '間違えたら正しいセリフを読み上げる';

  @override
  String accuracyScore(int score) {
    return '正解率 $score%';
  }

  @override
  String missedWords(String words) {
    return '抜け：$words';
  }

  @override
  String get notUnderstood => '聞き取れませんでした';

  @override
  String summaryAccuracy(int score) {
    return '平均正解率 $score%';
  }

  @override
  String summaryPrompts(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'プロンプト $count 回',
      zero: 'プロンプトなし',
    );
    return '$_temp0';
  }

  @override
  String get finishedPerfect => 'お見事！助けなしで最後まで言えました。';

  @override
  String get finishedGood => 'いい調子です！稽古が終わりました。';

  @override
  String get finishedPractice => '稽古が終わりました。詰まったところをもう一度練習しましょう。';

  @override
  String summaryLines(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count セリフ',
    );
    return '$_temp0';
  }

  @override
  String summaryPrompted(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count セリフでプロンプト',
    );
    return '$_temp0';
  }

  @override
  String summaryCorrected(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count セリフを訂正',
    );
    return '$_temp0';
  }

  @override
  String summaryUnclear(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count セリフが聞き取れず',
    );
    return '$_temp0';
  }

  @override
  String get importPhoto => '写真から';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get reading => '読み取り中…';

  @override
  String get docOld => '古い Word ファイル（.doc）は読み込めません。.docx か PDF で保存し直してお試しください。';

  @override
  String get noTextInPhoto =>
      '写真から読み取れる文字が見つかりませんでした。明るい場所で正面から撮った、はっきりした写真でお試しください。';

  @override
  String get photoAlphabet =>
      '写真からの読み取りはラテン文字（アルファベット）のみ対応しています。テキストを入力するか貼り付けてください。';

  @override
  String unsureBanner(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '誰のセリフか分からない行が $count 行あります。色の付いた行をタップして直してください。',
    );
    return '$_temp0';
  }

  @override
  String get splitHint => 'Enter を押すと行を2つに分けられます。';

  @override
  String get charactersAndVoices => '登場人物と声';

  @override
  String get hintProgressive => '段階的に隠す';

  @override
  String get hintKeywords => 'キーワード';

  @override
  String hideRatio(int percent) {
    return '隠す語句：$percent%';
  }

  @override
  String levelUp(int percent) {
    return 'いいですね！次の回は語句の $percent% を隠します。';
  }

  @override
  String get modeBuildUp => '積み上げ';

  @override
  String get modeBuildUpHelp =>
      'まず1行目、次に1〜2行目、次に1〜3行目… 新しい行は先に読み上げられ、そのあと最初から全部言います。詩や短いテキストに向いています。';

  @override
  String stepOf(int step, int total) {
    return 'ステップ $step/$total';
  }

  @override
  String get onlyWeak => '苦手な行だけ';

  @override
  String get onlyWeakHelp => 'プロンプトが必要だった行、訂正された行、点数の低かった行だけを練習します。';

  @override
  String weakCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '苦手な行 $count 行',
    );
    return '$_temp0';
  }

  @override
  String get noWeak => '苦手な行はまだありません';

  @override
  String elapsed(String time) {
    return '時間 $time';
  }

  @override
  String get targetTime => '目標時間';

  @override
  String get targetNone => '目標なし';

  @override
  String overTarget(String time) {
    return '目標を $time 超過';
  }

  @override
  String underTarget(String time) {
    return '目標より $time 短い';
  }

  @override
  String wpm(int wpm) {
    return '毎分 $wpm 語';
  }

  @override
  String get proTitle => '暗記 Pro';

  @override
  String get proPitch => 'Pro でもっと速く覚えましょう。';

  @override
  String get proFeatureHandsFree => 'ハンズフリー稽古：あなたの番になると聞き取り、スマートフォンに触る必要はありません';

  @override
  String proFeatureUnlimited(int count) {
    return 'テキスト数無制限（無料版：$count 件）';
  }

  @override
  String proTrial(int days, String price) {
    return '$days 日間無料、その後 $price/月';
  }

  @override
  String proPrice(String price) {
    return '$price/月';
  }

  @override
  String get proStartTrial => '無料トライアルを始める';

  @override
  String get proSubscribe => '登録する';

  @override
  String get proRestore => '購入を復元';

  @override
  String get proTerms =>
      '定期購入は毎月自動的に更新されます。Google Play > 定期購入からいつでも解約できます。解約しても期間の終わりまで Pro を使えます。';

  @override
  String get proUnavailable => '現在、定期購入を利用できません。あとでもう一度お試しください。';

  @override
  String get proActive => 'Pro は有効です';

  @override
  String get proManage => '定期購入を管理';

  @override
  String get proUpgrade => 'Pro にする';

  @override
  String proLimitReached(int count) {
    return '無料版で保存できるテキストは $count 件までです。';
  }

  @override
  String get proThanks => 'ありがとうございます！Pro が有効になりました。';

  @override
  String get proHandsFreeLocked => 'ハンズフリー稽古は Pro の機能です。「待ってもらう」に切り替えました。';

  @override
  String get proNotFound => '有効な定期購入が見つかりませんでした。';

  @override
  String get modePages => 'ページごとに発表';

  @override
  String get modePagesHelp =>
      '「1ページ」と言い、時間になると「時間です。2ページ」と進みます。原稿を見ずに話し、早く終わったら「次のページ」をタップします。';

  @override
  String pageCue(int n) {
    return '$nページ';
  }

  @override
  String pageCueTitled(int n, String title) {
    return '$nページ。$title';
  }

  @override
  String get timeUp => '時間です。';

  @override
  String get presentationDone => '発表は終わりです。';

  @override
  String get nextPage => '次のページ';

  @override
  String get pageTimes => 'ページごとの時間';

  @override
  String get pageTimesHelp => 'ページはテキスト内の見出しで分かれます。見出しがなければ段落で分かれます。';

  @override
  String get pageTimesAuto => '自動で配分';

  @override
  String pageSummary(int n, String used, String planned) {
    return 'P$n $used/$planned';
  }

  @override
  String pageOf(int n, int total) {
    return 'ページ $n/$total';
  }

  @override
  String get emotion => 'トーン';

  @override
  String get emotionHelp =>
      'この感情に合わせて速さ、高さ、音量を調整します。テキスト内の（怒って）、（泣きながら）のようなト書きは自動で判別されます。';

  @override
  String get emoNeutral => 'ふつう';

  @override
  String get emoHappy => 'うれしい';

  @override
  String get emoSad => '悲しい';

  @override
  String get emoAngry => '怒り';

  @override
  String get emoExcited => '興奮';

  @override
  String get emoCalm => '落ち着いた';

  @override
  String get emoWhisper => 'ささやき';

  @override
  String get emoAfraid => 'おびえ';

  @override
  String get modeRecite => '暗唱チェック（間違いを指摘）';

  @override
  String get modeReciteHelp =>
      'テキストを暗唱してください。飛ばしたところや間違えたところで止まり、間違いを表示します。最後にレポートが出ます。';

  @override
  String get reciteTitle => '暗唱チェック';

  @override
  String get reciteModelTitle => '音声認識モデル';

  @override
  String get reciteModelHelp =>
      '間違いのチェックのために、端末内で動く音声認識モデルを一度だけダウンロードします。無料です。声が端末の外に出ることはありません。Wi-Fi をおすすめします。';

  @override
  String reciteModelStandard(int mb) {
    return '標準（$mb MB）— 速い';
  }

  @override
  String reciteModelAccurate(int mb) {
    return '高精度（$mb MB）— やや遅い';
  }

  @override
  String get reciteDownload => 'ダウンロード';

  @override
  String reciteDownloading(int pct) {
    return 'ダウンロード中… $pct%';
  }

  @override
  String get reciteDownloadFailed => 'ダウンロードに失敗しました。接続を確認してもう一度お試しください。';

  @override
  String get reciteLoading => 'モデルを読み込み中…';

  @override
  String get reciteStart => '開始';

  @override
  String get reciteListening => '聞いています… 最初から暗唱してください。';

  @override
  String get reciteChecking => 'チェック中…';

  @override
  String reciteHeard(String text) {
    return '聞き取った内容：$text';
  }

  @override
  String get reciteSkipped => '一部を飛ばしました';

  @override
  String get reciteWrong => '間違えました';

  @override
  String reciteExpected(String text) {
    return '正しくは：$text';
  }

  @override
  String reciteYouSaid(String text) {
    return 'あなたの言葉：$text';
  }

  @override
  String get reciteContinueHere => 'ここから続ける';

  @override
  String get reciteFinish => '終了';

  @override
  String reciteAccuracy(int n) {
    return '正解率：$n%';
  }

  @override
  String get reciteNoErrors => '間違いなし、すばらしい！';

  @override
  String reciteMinor(int n) {
    return '小さな抜け $n か所（短い語）';
  }

  @override
  String get reciteAgain => 'もう一度';

  @override
  String get reciteNote => '認識は完璧ではありません。自信のないところで止めることがあります。';

  @override
  String get reciteLoadFailed => 'モデルを開けませんでした。削除してもう一度ダウンロードしてください。';

  @override
  String get recordLines => '声を録音';

  @override
  String get recordLinesHelp =>
      '相手役のセリフを自分や友だちの声で録音します。稽古では合成音声の代わりにこの録音が再生され、感情がこもります。録音は端末内にだけ保存され、バックアップには含まれません。';

  @override
  String get recordStart => '録音';

  @override
  String get recordStop => '停止';

  @override
  String get recordPlay => '聞く';

  @override
  String get recordDelete => '録音を削除';

  @override
  String get recordNext => '次へ';

  @override
  String get recordPrev => '前へ';

  @override
  String recordedCount(int n, int total) {
    return '$n/$total セリフを録音済み';
  }

  @override
  String get recordIncludeMine => '自分のセリフも表示';

  @override
  String get recordNone => '録音するセリフがありません。';

  @override
  String get recordingNow => '録音中…';

  @override
  String get recordedBadge => '録音済み';
}
