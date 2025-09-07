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
  String get pushNotifications => 'プッシュ通知';

  @override
  String get getRemindersAndUpdates => 'リマインダーと更新を取得';

  @override
  String get locationServices => '位置情報サービス';

  @override
  String get allowLocationBasedFeatures => '位置情報ベースの機能を許可';

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
}
