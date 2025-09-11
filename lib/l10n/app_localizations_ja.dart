// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => '旅行';

  @override
  String get documents => '書類';

  @override
  String get settings => '設定';

  @override
  String get quickStats => 'クイック統計';

  @override
  String get activeTrips => 'アクティブな旅行';

  @override
  String get pendingTasks => '保留中のタスク';

  @override
  String get totalBudget => '総予算';

  @override
  String nextTripStartsIn(int days) {
    return '次の旅行まで $days 日';
  }

  @override
  String get yourTrips => 'あなたの旅行';

  @override
  String get searchTrips => '旅行を検索...';

  @override
  String get daysUntilStart => '開始まで日数';

  @override
  String get dateCreated => '作成日';

  @override
  String get alphabetical => 'アルファベット順';

  @override
  String get budget => '予算';

  @override
  String get tasks => 'タスク';

  @override
  String get tripInProgress => '旅行進行中';

  @override
  String get startingToday => '今日開始！';

  @override
  String daysToGo(int days) {
    return 'あと $days 日';
  }

  @override
  String active(int count) {
    return '$count 個アクティブ';
  }

  @override
  String get searchDocuments => '書類を検索...';

  @override
  String get personal => '個人';

  @override
  String get tripRelated => '旅行関連';

  @override
  String get uploadDocument => '書類をアップロード';

  @override
  String get takePhoto => '写真を撮る';

  @override
  String get captureDocumentWithCamera => 'カメラで書類を撮影';

  @override
  String get chooseFromGallery => 'ギャラリーから選択';

  @override
  String get selectFromPhotoLibrary => 'フォトライブラリから選択';

  @override
  String get chooseFile => 'ファイルを選択';

  @override
  String get selectPdfOrOtherFiles => 'PDFまたは他のファイルを選択';

  @override
  String expires(String date) {
    return '有効期限：$date';
  }

  @override
  String get view => '表示';

  @override
  String get share => '共有';

  @override
  String get download => 'ダウンロード';

  @override
  String get delete => '削除';

  @override
  String get profile => 'プロフィール';

  @override
  String get preferences => '設定';

  @override
  String get darkMode => 'ダークモード';

  @override
  String get switchBetweenLightAndDarkTheme => 'ライトとダークテーマを切り替え';

  @override
  String get language => '言語';

  @override
  String get selectYourPreferredLanguage => '優先言語を選択';

  @override
  String get defaultCurrency => 'デフォルト通貨';

  @override
  String get currencyUsedForNewTrips => '新しい旅行で使用する通貨';

  @override
  String get dateFormat => '日付形式';

  @override
  String get howDatesAreDisplayed => '日付の表示方法';

  @override
  String get temperatureUnit => '温度単位';

  @override
  String get temperatureScalePreference => '温度スケールの設定';

  @override
  String get appSettings => 'アプリ設定';

  @override
  String get backupAndSync => 'バックアップと同期';

  @override
  String get manageYourDataBackup => 'データバックアップの管理';

  @override
  String get importData => 'データをインポート';

  @override
  String get importTripsFromOtherApps => '他のアプリから旅行をインポート';

  @override
  String get exportData => 'データをエクスポート';

  @override
  String get exportYourTripData => '旅行データをエクスポート';

  @override
  String get about => 'について';

  @override
  String get appVersion => 'アプリバージョン';

  @override
  String get rateApp => 'アプリを評価';

  @override
  String get leaveAReviewOnTheAppStore => 'App Storeでレビューを残す';

  @override
  String get helpAndSupport => 'ヘルプとサポート';

  @override
  String get faqsAndContactInformation => 'FAQと連絡先情報';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get readOurPrivacyPolicy => 'プライバシーポリシーを読む';

  @override
  String get termsOfService => '利用規約';

  @override
  String get readOurTermsAndConditions => '利用規約を読む';

  @override
  String get dangerZone => '危険ゾーン';

  @override
  String get clearAllData => 'すべてのデータを削除';

  @override
  String get removeAllTripsAndDocuments => 'すべての旅行と書類を削除';

  @override
  String get clearAllDataConfirmation => 'この操作は元に戻せません。すべての旅行、書類、設定が永久に削除されます。';

  @override
  String get cancel => 'キャンセル';

  @override
  String get clearAll => 'すべて削除';

  @override
  String get celsius => '摂氏';

  @override
  String get fahrenheit => '華氏';

  @override
  String get english => 'English';

  @override
  String get mandarin => '中文';

  @override
  String get japanese => '日本語';

  @override
  String get korean => '한국어';

  @override
  String get spanish => 'Español';

  @override
  String get french => 'Français';

  @override
  String get german => 'Deutsch';

  @override
  String get italian => 'Italiano';

  @override
  String get portuguese => 'Português';

  @override
  String get russian => 'Русский';

  @override
  String get arabic => 'العربية';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get dutch => 'Nederlands';

  @override
  String get title => 'タイトル';

  @override
  String get description => '説明';

  @override
  String get amount => '金額';

  @override
  String get date => '日付';

  @override
  String get edit => '編集';

  @override
  String get retry => '再試行';

  @override
  String get add => '追加';

  @override
  String get update => '更新';

  @override
  String get close => '閉じる';

  @override
  String get failedToLoad => '読み込みに失敗しました';

  @override
  String get noDataYet => 'まだデータがありません';

  @override
  String get startPlanning => '次の冒険の計画を始めましょう！';

  @override
  String get createTrip => '旅行を作成';

  @override
  String get addDocument => 'ドキュメントを追加';

  @override
  String get addExpense => '支出を追加';

  @override
  String get addActivity => 'アクティビティを追加';

  @override
  String get addBooking => '予約を追加';

  @override
  String get totalExpenses => '総支出';

  @override
  String get toDoItems => 'やることリスト';

  @override
  String get expenseDetails => '支出詳細';

  @override
  String get expenseTitle => '支出タイトル';

  @override
  String get category => 'カテゴリ';

  @override
  String get paidBy => '支払者';

  @override
  String get you => 'あなた';

  @override
  String get allDay => '終日';

  @override
  String get startTime => '開始時間';

  @override
  String get endTime => '終了時間';

  @override
  String get activityTitle => 'アクティビティタイトル';

  @override
  String get activityType => 'アクティビティタイプ';

  @override
  String get bookingTitle => '予約タイトル';

  @override
  String get bookingType => '予約タイプ';

  @override
  String get status => 'ステータス';

  @override
  String get addFile => 'ファイルを追加';

  @override
  String get fileNotFound => 'ファイルが見つかりません';

  @override
  String get fileMovedOrDeleted => 'ファイルが移動または削除された可能性があります';

  @override
  String get cannotDisplayImage => '画像を表示できません';

  @override
  String get openExternally => '外部で開く';

  @override
  String get failedToReadFile => 'ファイルデータの読み込みに失敗しました';

  @override
  String get deleteExpense => '支出を削除';

  @override
  String get deleteExpenseConfirmation => 'この支出を削除してもよろしいですか？';

  @override
  String get expenseBreakdown => '支出内訳';

  @override
  String get breakdown => '内訳';

  @override
  String get noExpensesYet => 'まだ支出がありません';

  @override
  String get noActivitiesPlanned => '計画されたアクティビティがありません';

  @override
  String get splitDetails => '分割詳細';

  @override
  String get editExpense => '支出を編集';

  @override
  String get addNewExpense => '新しい支出を追加';

  @override
  String get editActivity => 'アクティビティを編集';

  @override
  String get addNewActivity => '新しいアクティビティを追加';

  @override
  String get editBooking => '予約を編集';

  @override
  String get addNewBooking => '新しい予約を追加';

  @override
  String get updateExpense => '支出を更新';

  @override
  String get updateActivity => 'アクティビティを更新';

  @override
  String get updateBooking => '予約を更新';

  @override
  String get transport => '交通';

  @override
  String get accommodation => '宿泊';

  @override
  String get activities => 'アクティビティ';

  @override
  String get shopping => 'ショッピング';

  @override
  String get sightseeing => '観光';

  @override
  String get meal => '食事';

  @override
  String get entertainment => 'エンターテイメント';

  @override
  String get other => 'その他';

  @override
  String get noBookingsYet => 'まだ予約がありません';

  @override
  String get addFirstBooking => '最初の予約を追加';

  @override
  String get bookingDetails => '予約詳細';

  @override
  String get vendor => 'ベンダー';

  @override
  String get confirmationNumber => '確認番号';

  @override
  String get attachments => '添付ファイル';

  @override
  String get failedToLoadTodos => 'タスクの読み込みに失敗しました';

  @override
  String get task => 'タスク';

  @override
  String allWithCount(int count) {
    return 'すべて ($count)';
  }

  @override
  String get noToDoItems => 'タスクがありません';

  @override
  String get stayOrganizedMessage => '旅行計画のタスクを追加して整理整頓を保ちましょう！';

  @override
  String get addFirstTask => '最初のタスクを追加';

  @override
  String get taskDetails => 'タスク詳細';

  @override
  String get completed => '完了';

  @override
  String get pending => '保留中';

  @override
  String get priority => '優先度';

  @override
  String get dueDate => '期限';

  @override
  String get editTask => 'タスクを編集';

  @override
  String get addNewTask => '新しいタスクを追加';

  @override
  String get updateTask => 'タスクを更新';

  @override
  String get addTask => 'タスクを追加';

  @override
  String get deleteTask => 'タスクを削除';

  @override
  String deleteTaskConfirmation(String title) {
    return '\"$title\"を削除してもよろしいですか？この操作は元に戻せません。';
  }

  @override
  String get keepTrackMessage => 'フライト、ホテル、アクティビティを追跡しましょう！';

  @override
  String get previewNotAvailable =>
      'このファイルタイプのプレビューは利用できません。\n「外部で開く」をタップして他のアプリで表示してください。';

  @override
  String get appVersionBeta => '1.0.0 (ベータ)';

  @override
  String get defaultUserName => '田中太郎';

  @override
  String get defaultUserEmail => 'tanaka.taro@email.com';

  @override
  String get taskTitle => 'タスクタイトル';

  @override
  String get descriptionOptional => '説明（任意）';

  @override
  String get setDueDateOptional => '期限を設定（任意）';

  @override
  String dueWithDate(int day, int month, int year) {
    return '期限：$year/$month/$day';
  }

  @override
  String get urgent => '至急';

  @override
  String get high => '高';

  @override
  String get medium => '中';

  @override
  String get low => '低';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'タスクの$actionに失敗しました：$error';
  }

  @override
  String get vendorCompanyOptional => 'ベンダー/会社（任意）';

  @override
  String get confirmationNumberOptional => '確認番号（任意）';

  @override
  String amountCurrency(String currency) {
    return '金額（$currency）';
  }

  @override
  String get setBookingDateOptional => '予約日を設定（任意）';

  @override
  String dateWithDate(int day, int month, int year) {
    return '日付：$year/$month/$day';
  }

  @override
  String get attachmentsOptional => '添付ファイル（任意）';

  @override
  String get maxFileSizeSupported =>
      '最大ファイルサイズ：5MB\nサポート形式：PDF、DOC、DOCX、JPG、PNG、GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return '予約の$actionに失敗しました：$error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filenameが正常に添付されました';
  }

  @override
  String get fileSizeMustBeLess => 'ファイルサイズは5MB未満である必要があります';

  @override
  String failedToPickFile(String error) {
    return 'ファイルの選択に失敗しました：$error';
  }

  @override
  String errorSharingFile(String error) {
    return 'ファイルの共有エラー：$error';
  }

  @override
  String get unknown => '不明';

  @override
  String get editTrip => '旅行を編集';

  @override
  String get updateTrip => '旅行を更新';

  @override
  String get tripUpdatedSuccessfully => '旅行が正常に更新されました';

  @override
  String get failedToUpdateTrip => '旅行の更新に失敗しました';

  @override
  String get deleteTrip => '旅行を削除';

  @override
  String get deleteTripConfirmation => 'この旅行を削除してもよろしいですか？この操作は取り消すことができません。';

  @override
  String get tripDeletedSuccessfully => '旅行が正常に削除されました';

  @override
  String get failedToDeleteTrip => '旅行の削除に失敗しました';

  @override
  String get tripCreatedSuccessfully => '旅行が正常に作成されました！';

  @override
  String get failedToCreateTrip => '旅行の作成に失敗しました';

  @override
  String get selectStartDateFirst => 'まず開始日を選択してください';

  @override
  String get addAtLeastOneDestination => '少なくとも1つの目的地を追加してください';

  @override
  String get selectBothStartAndEndDates => '開始日と終了日の両方を選択してください';

  @override
  String get titleIsRequired => 'タイトルは必須です';

  @override
  String titleTooLong(int limit) {
    return 'タイトルは$limit文字以下にしてください';
  }

  @override
  String descriptionTooLong(int limit) {
    return '説明は$limit文字以下にしてください';
  }

  @override
  String vendorTooLong(int limit) {
    return 'ベンダー/会社は$limit文字以下にしてください';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return '確認番号は$limit文字以下にしてください';
  }

  @override
  String paidByTooLong(int limit) {
    return '支払者は$limit文字以下にしてください';
  }

  @override
  String locationTooLong(int limit) {
    return '場所は$limit文字以下にしてください';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return '説明は$limit文字以下にしてください';
  }

  @override
  String get amountIsRequired => '金額は必須です';

  @override
  String get enterValidAmount => '有効な金額を入力してください';

  @override
  String get amountMustBePositive => '金額は正の数にしてください';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldNameは必須です';
  }

  @override
  String get destinationIsRequired => '目的地は必須です';

  @override
  String destinationTooLong(int limit) {
    return '目的地は$limit文字以下にしてください';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText（任意）';
  }

  @override
  String maxCharacters(int maxLength) {
    return '最大$maxLength文字';
  }

  @override
  String get searchTripsPlaceholder => '旅行を検索...';

  @override
  String allWithTotal(int total) {
    return 'すべて ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return '予定 ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'アクティブ ($count)';
  }

  @override
  String completedWithCount(int count) {
    return '完了 ($count)';
  }

  @override
  String get yourTripsTitle => 'あなたの旅行';

  @override
  String activeTripsCount(int count) {
    return '$count個アクティブ';
  }

  @override
  String get bookingsTabTitle => '予約';

  @override
  String get expensesTabTitle => '支出';

  @override
  String get overviewTabTitle => '概要';

  @override
  String get todoTabTitle => 'やることリスト';

  @override
  String get itineraryTabTitle => '旅程';

  @override
  String get failedToLoadTrip => '旅行の読み込みに失敗しました';

  @override
  String get tripNotFound => '旅行が見つかりません';

  @override
  String get saveImage => '画像を保存';

  @override
  String get saveToPhotos => '写真に保存';

  @override
  String get saveToPhotosDescription => '写真ギャラリーに直接保存';

  @override
  String get saveToFiles => 'ファイルに保存';

  @override
  String get saveToFilesDescription => '保存する特定のフォルダを選択';

  @override
  String get imageSavedToPhotos => '画像が写真に保存されました';

  @override
  String get fileSavedSuccessfully => 'ファイルが正常に保存されました';

  @override
  String get open => '開く';

  @override
  String errorDownloadingFile(String error) {
    return 'ファイルダウンロードエラー：$error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return '写真保存エラー：$error';
  }

  @override
  String errorSavingFile(String error) {
    return 'ファイル保存エラー：$error';
  }

  @override
  String get selectDocument => '書類を選択';

  @override
  String get chooseFromGalleryTitle => 'ギャラリーから選択';

  @override
  String get chooseFromGalleryDescription => 'フォトライブラリから選択';

  @override
  String get chooseFileTitle => 'ファイルを選択';

  @override
  String get chooseFileDescription => 'PDFまたは他のファイルを選択';

  @override
  String get failedToCaptureImage => '画像の撮影に失敗しました';

  @override
  String get failedToSelectImage => '画像の選択に失敗しました';

  @override
  String get failedToSelectFile => 'ファイルの選択に失敗しました';

  @override
  String get documentAddedSuccessfully => '書類が正常に追加されました';

  @override
  String get documentUpdatedSuccessfully => '書類が正常に更新されました';

  @override
  String get failedToSaveDocument => '書類の保存に失敗しました';

  @override
  String get documentTitle => '書類タイトル *';

  @override
  String get documentCategory => '書類カテゴリ';

  @override
  String get changeDocument => '書類を変更';

  @override
  String get documentsTitle => '書類';

  @override
  String get noDocumentsYet => 'まだドキュメントがありません';

  @override
  String get noDocumentsFound => 'ドキュメントが見つかりません';

  @override
  String get clearSearch => '検索をクリア';

  @override
  String get documentDetails => 'ドキュメント詳細';

  @override
  String get fileSize => 'ファイルサイズ';

  @override
  String get fileName => 'ファイル名';

  @override
  String get deleteDocument => '書類を削除';

  @override
  String deleteDocumentConfirmation(String title) {
    return '「$title」を削除しますか？この操作は元に戻せません。';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return '書類「$title」が正常に削除されました';
  }

  @override
  String failedToDeleteDocument(String error) {
    return '書類の削除に失敗しました：$error';
  }

  @override
  String get location => '場所';

  @override
  String get activityTitleLabel => '活動タイトル';

  @override
  String get activityTypeLabel => '活動タイプ';

  @override
  String get expenseTitleLabel => '支出タイトル';

  @override
  String get destinations => '目的地';

  @override
  String get currency => '通貨';

  @override
  String get tripInProgressStatus => '旅行進行中';

  @override
  String get completedStatus => '完了';

  @override
  String get tripDates => '旅行日程';

  @override
  String get expenseType => '支出';

  @override
  String get expenseDetailsTitle => '支出詳細';

  @override
  String get activityDetailsTitle => '活動詳細';

  @override
  String get deleteActivity => '活動を削除';

  @override
  String get deleteBooking => '予約を削除';

  @override
  String get january => '1月';

  @override
  String get february => '2月';

  @override
  String get march => '3月';

  @override
  String get april => '4月';

  @override
  String get may => '5月';

  @override
  String get june => '6月';

  @override
  String get july => '7月';

  @override
  String get august => '8月';

  @override
  String get september => '9月';

  @override
  String get october => '10月';

  @override
  String get november => '11月';

  @override
  String get december => '12月';

  @override
  String get food => '食事';

  @override
  String get confirmed => '確認済み';

  @override
  String get cancelled => 'キャンセル';

  @override
  String get passport => 'パスポート';

  @override
  String get visa => 'ビザ';

  @override
  String get ticket => 'チケット';

  @override
  String get hotel => 'ホテル';

  @override
  String get insurance => '保険';

  @override
  String get editDocument => '書類を編集';

  @override
  String get updateDocument => '書類を更新';

  @override
  String get saveToGallery => 'ギャラリーに保存';

  @override
  String get flight => 'フライト';

  @override
  String get restaurant => 'レストラン';

  @override
  String get bookingLimitReached => '予約制限に達しました。1回の旅行につき15件までしか予約を追加できません。';

  @override
  String get documentLimitReached => 'ドキュメント制限に達しました。合計10件までしかドキュメントを追加できません。';

  @override
  String get clearFilters => 'フィルターをクリア';

  @override
  String get travelDates => '旅行日程';

  @override
  String get selectDateRange => '日付範囲を選択';

  @override
  String get activityDetails => '活動詳細';

  @override
  String get quickActions => 'クイックアクション';

  @override
  String get addNewItemsToTrip => '旅行に新しいアイテムを追加';

  @override
  String get booking => '予約';

  @override
  String get expense => '支出';

  @override
  String get itinerary => '旅程';

  @override
  String get duration => '期間';

  @override
  String get noExpensesFound => '支出が見つかりません';

  @override
  String get noExpensesFoundForCategory => 'このカテゴリの支出が見つかりません';

  @override
  String get noTasksFound => 'タスクが見つかりません';

  @override
  String get noBookingsFound => '予約が見つかりません';

  @override
  String get noTripsFound => '旅行が見つかりません';

  @override
  String get tryAdjustingFilters => 'フィルターを調整してみてください';

  @override
  String get searchTasks => 'タスクを検索';

  @override
  String get searchBookings => '予約を検索';

  @override
  String get urgentPriority => '緊急';

  @override
  String get highPriority => '高';

  @override
  String get mediumPriority => '中';

  @override
  String get lowPriority => '低';

  @override
  String get overdue => '期限切れ';

  @override
  String get dueToday => '今日が期限';

  @override
  String get dueTomorrow => '明日が期限';

  @override
  String get activeStatus => 'アクティブ状態';

  @override
  String get selectBackupFile => 'バックアップファイルを選択';

  @override
  String get selectFile => 'ファイルを選択';

  @override
  String get importBackup => 'バックアップをインポート';

  @override
  String get importSuccessful => 'インポート成功';

  @override
  String get importFailed => 'インポート失敗';

  @override
  String get couldNotOpenAppStore => 'App Storeを開けませんでした';

  @override
  String get couldNotOpenHelpSection => 'ヘルプセクションを開けませんでした';

  @override
  String get couldNotOpenPrivacyPolicy => 'プライバシーポリシーを開けませんでした';

  @override
  String get couldNotOpenTermsOfService => '利用規約を開けませんでした';

  @override
  String get confirmActionWarning => 'This action cannot be undone!';

  @override
  String get finalConfirmationTitle => 'Final Confirmation';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Type $word in the box below to confirm:';
  }

  @override
  String get deletingAllData => 'Deleting all data...';

  @override
  String get pleaseWait => 'Please wait, this may take a moment.';

  @override
  String get dataClearedTitle => 'Data Cleared';

  @override
  String get dataClearedMessage =>
      'All your data has been successfully deleted. The app has been reset to its initial state.';

  @override
  String get errorTitle => 'Error';

  @override
  String failedToClearAllData(String error) {
    return 'Failed to clear all data: $error';
  }

  @override
  String get exportIntroTitle =>
      'Create a secure backup of all your Voythrix data:';

  @override
  String get exportEncryptionInfo =>
      'Your data will be encrypted and compressed into a .tripe file.';

  @override
  String get backupPasswordTitle => 'Backup Password (Optional)';

  @override
  String get backupPasswordHint => 'Enter password (optional)';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get passwordsMatch => 'Passwords match';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get creatingBackup => 'Creating backup...';

  @override
  String get collectingAndEncrypting =>
      'Collecting and encrypting your data...';

  @override
  String get backupCreatedTitle => 'Backup Created';

  @override
  String get backupCreatedMessage =>
      'Your backup has been created successfully!';

  @override
  String get fileInfoLabel => 'File Info:';

  @override
  String get fileInfoFormat => '• Format: Encrypted .tripe file';

  @override
  String get fileInfoSecurityPassword => '• Security: Password protected';

  @override
  String get fileInfoSecurityStandard => '• Security: Standard encryption';

  @override
  String get fileInfoCompression => '• Compression: GZip compressed';

  @override
  String get keepFileSafeNote => 'このファイルを安全に保管してください—データの復元に必要です！';

  @override
  String get exportFailedTitle => 'エクスポート失敗';

  @override
  String failedToCreateBackup(String error) {
    return 'バックアップ作成に失敗しました：$error';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get deleteEverything => 'すべて削除';

  @override
  String get createBackup => 'バックアップ作成';

  @override
  String get ok => 'OK';
}
