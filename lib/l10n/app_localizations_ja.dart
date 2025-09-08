// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'トリップイーズ';

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
}
