// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => '畅游易';

  @override
  String get trips => '行程';

  @override
  String get documents => '文档';

  @override
  String get settings => '设置';

  @override
  String get quickStats => '快速统计';

  @override
  String get activeTrips => '进行中行程';

  @override
  String get pendingTasks => '待办任务';

  @override
  String get totalBudget => '总预算';

  @override
  String nextTripStartsIn(int days) {
    return '下次行程还有 $days 天开始';
  }

  @override
  String get yourTrips => '您的行程';

  @override
  String get searchTrips => '搜索行程...';

  @override
  String get daysUntilStart => '距离开始天数';

  @override
  String get dateCreated => '创建日期';

  @override
  String get alphabetical => '字母顺序';

  @override
  String get budget => '预算';

  @override
  String get tasks => '任务';

  @override
  String get tripInProgress => '行程进行中';

  @override
  String get startingToday => '今天开始！';

  @override
  String daysToGo(int days) {
    return '还有 $days 天';
  }

  @override
  String active(int count) {
    return '$count 个活跃';
  }

  @override
  String get searchDocuments => '搜索文档...';

  @override
  String get personal => '个人';

  @override
  String get tripRelated => '行程相关';

  @override
  String get uploadDocument => '上传文档';

  @override
  String get takePhoto => '拍照';

  @override
  String get captureDocumentWithCamera => '用相机拍摄文档';

  @override
  String get chooseFromGallery => '从相册选择';

  @override
  String get selectFromPhotoLibrary => '从照片库中选择';

  @override
  String get chooseFile => '选择文件';

  @override
  String get selectPdfOrOtherFiles => '选择PDF或其他文件';

  @override
  String expires(String date) {
    return '到期时间：$date';
  }

  @override
  String get view => '查看';

  @override
  String get share => '分享';

  @override
  String get download => '下载';

  @override
  String get delete => '删除';

  @override
  String get profile => '个人资料';

  @override
  String get preferences => '偏好设置';

  @override
  String get darkMode => '深色模式';

  @override
  String get switchBetweenLightAndDarkTheme => '在明亮和深色主题之间切换';

  @override
  String get language => '语言';

  @override
  String get selectYourPreferredLanguage => '选择您的首选语言';

  @override
  String get defaultCurrency => '默认货币';

  @override
  String get currencyUsedForNewTrips => '新行程使用的货币';

  @override
  String get dateFormat => '日期格式';

  @override
  String get howDatesAreDisplayed => '日期显示格式';

  @override
  String get temperatureUnit => '温度单位';

  @override
  String get temperatureScalePreference => '温度刻度偏好';

  @override
  String get appSettings => '应用设置';

  @override
  String get pushNotifications => '推送通知';

  @override
  String get getRemindersAndUpdates => '获取提醒和更新';

  @override
  String get locationServices => '位置服务';

  @override
  String get allowLocationBasedFeatures => '允许基于位置的功能';

  @override
  String get backupAndSync => '备份和同步';

  @override
  String get manageYourDataBackup => '管理您的数据备份';

  @override
  String get importData => '导入数据';

  @override
  String get importTripsFromOtherApps => '从其他应用导入行程';

  @override
  String get exportData => '导出数据';

  @override
  String get exportYourTripData => '导出您的行程数据';

  @override
  String get about => '关于';

  @override
  String get appVersion => '应用版本';

  @override
  String get rateApp => '评价应用';

  @override
  String get leaveAReviewOnTheAppStore => '在应用商店留下评价';

  @override
  String get helpAndSupport => '帮助与支持';

  @override
  String get faqsAndContactInformation => '常见问题和联系信息';

  @override
  String get privacyPolicy => '隐私政策';

  @override
  String get readOurPrivacyPolicy => '阅读我们的隐私政策';

  @override
  String get termsOfService => '服务条款';

  @override
  String get readOurTermsAndConditions => '阅读我们的条款和条件';

  @override
  String get dangerZone => '危险区域';

  @override
  String get clearAllData => '清除所有数据';

  @override
  String get removeAllTripsAndDocuments => '删除所有行程和文档';

  @override
  String get clearAllDataConfirmation => '此操作无法撤销。您的所有行程、文档和设置将被永久删除。';

  @override
  String get cancel => '取消';

  @override
  String get clearAll => '全部清除';

  @override
  String get celsius => '摄氏度';

  @override
  String get fahrenheit => '华氏度';

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
