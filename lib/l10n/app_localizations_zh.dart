// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

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
  String get title => '标题';

  @override
  String get description => '描述';

  @override
  String get amount => '金额';

  @override
  String get date => '日期';

  @override
  String get edit => '编辑';

  @override
  String get retry => '重试';

  @override
  String get add => '添加';

  @override
  String get update => '更新';

  @override
  String get close => '关闭';

  @override
  String get failedToLoad => '加载失败';

  @override
  String get noDataYet => '暂无数据';

  @override
  String get startPlanning => '开始规划您的下一次冒险！';

  @override
  String get createTrip => '创建旅行';

  @override
  String get addDocument => '添加文档';

  @override
  String get addExpense => '添加支出';

  @override
  String get addActivity => '添加活动';

  @override
  String get addBooking => '添加预订';

  @override
  String get totalExpenses => '总支出';

  @override
  String get toDoItems => '待办事项';

  @override
  String get expenseDetails => '支出详情';

  @override
  String get expenseTitle => '支出标题';

  @override
  String get category => '类别';

  @override
  String get paidBy => '付款人';

  @override
  String get you => '您';

  @override
  String get allDay => '全天';

  @override
  String get startTime => '开始时间';

  @override
  String get endTime => '结束时间';

  @override
  String get activityTitle => '活动标题';

  @override
  String get activityType => '活动类型';

  @override
  String get bookingTitle => '预订标题';

  @override
  String get bookingType => '预订类型';

  @override
  String get status => '状态';

  @override
  String get addFile => '添加文件';

  @override
  String get fileNotFound => '文件未找到';

  @override
  String get fileMovedOrDeleted => '文件可能已被移动或删除';

  @override
  String get cannotDisplayImage => '无法显示图像';

  @override
  String get openExternally => '外部打开';

  @override
  String get failedToReadFile => '读取文件数据失败';

  @override
  String get deleteExpense => '删除支出';

  @override
  String get deleteExpenseConfirmation => '您确定要删除此支出吗？';

  @override
  String get expenseBreakdown => '支出明细';

  @override
  String get breakdown => '明细';

  @override
  String get noExpensesYet => '暂无支出';

  @override
  String get noActivitiesPlanned => '暂无计划的活动';

  @override
  String get splitDetails => '分摊详情';

  @override
  String get editExpense => '编辑支出';

  @override
  String get addNewExpense => '添加新支出';

  @override
  String get editActivity => '编辑活动';

  @override
  String get addNewActivity => '添加新活动';

  @override
  String get editBooking => '编辑预订';

  @override
  String get addNewBooking => '添加新预订';

  @override
  String get updateExpense => '更新支出';

  @override
  String get updateActivity => '更新活动';

  @override
  String get updateBooking => '更新预订';

  @override
  String get transport => '交通';

  @override
  String get accommodation => '住宿';

  @override
  String get activities => '活动';

  @override
  String get shopping => '购物';

  @override
  String get sightseeing => '观光';

  @override
  String get meal => '餐饮';

  @override
  String get entertainment => '娱乐';

  @override
  String get other => '其他';

  @override
  String get noBookingsYet => '暂无预订';

  @override
  String get addFirstBooking => '添加第一个预订';

  @override
  String get bookingDetails => '预订详情';

  @override
  String get vendor => '供应商';

  @override
  String get confirmationNumber => '确认号';

  @override
  String get attachments => '附件';

  @override
  String get failedToLoadTodos => '加载待办事项失败';

  @override
  String get task => '任务';

  @override
  String allWithCount(int count) {
    return '全部 ($count)';
  }

  @override
  String get noToDoItems => '暂无待办事项';

  @override
  String get stayOrganizedMessage => '通过为旅行规划添加任务来保持井然有序！';

  @override
  String get addFirstTask => '添加第一个任务';

  @override
  String get taskDetails => '任务详情';

  @override
  String get completed => '已完成';

  @override
  String get pending => '待处理';

  @override
  String get priority => '优先级';

  @override
  String get dueDate => '截止日期';

  @override
  String get editTask => '编辑任务';

  @override
  String get addNewTask => '添加新任务';

  @override
  String get updateTask => '更新任务';

  @override
  String get addTask => '添加任务';

  @override
  String get deleteTask => '删除任务';

  @override
  String deleteTaskConfirmation(String title) {
    return '您确定要删除\"$title\"吗？此操作无法撤销。';
  }

  @override
  String get keepTrackMessage => '跟踪您的航班、酒店和活动！';

  @override
  String get previewNotAvailable => '此文件类型不支持预览。\n点击\"外部打开\"以使用其他应用查看。';

  @override
  String get appVersionBeta => '1.0.0 (测试版)';

  @override
  String get defaultUserName => '张三';

  @override
  String get defaultUserEmail => 'zhang.san@email.com';

  @override
  String get taskTitle => '任务标题';

  @override
  String get descriptionOptional => '描述（可选）';

  @override
  String get setDueDateOptional => '设置截止日期（可选）';

  @override
  String dueWithDate(int day, int month, int year) {
    return '截止日期：$year/$month/$day';
  }

  @override
  String get urgent => '紧急';

  @override
  String get high => '高';

  @override
  String get medium => '中等';

  @override
  String get low => '低';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return '任务$action失败：$error';
  }

  @override
  String get vendorCompanyOptional => '供应商/公司（可选）';

  @override
  String get confirmationNumberOptional => '确认号码（可选）';

  @override
  String amountCurrency(String currency) {
    return '金额（$currency）';
  }

  @override
  String get setBookingDateOptional => '设置预订日期（可选）';

  @override
  String dateWithDate(int day, int month, int year) {
    return '日期：$year/$month/$day';
  }

  @override
  String get attachmentsOptional => '附件（可选）';

  @override
  String get maxFileSizeSupported =>
      '最大文件大小：5MB\n支持格式：PDF、DOC、DOCX、JPG、PNG、GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return '预订$action失败：$error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename 附加成功';
  }

  @override
  String get fileSizeMustBeLess => '文件大小必须小于5MB';

  @override
  String failedToPickFile(String error) {
    return '文件选择失败：$error';
  }

  @override
  String errorSharingFile(String error) {
    return '文件分享错误：$error';
  }

  @override
  String get unknown => '未知';

  @override
  String get editTrip => '编辑旅行';

  @override
  String get updateTrip => '更新旅行';

  @override
  String get tripUpdatedSuccessfully => '旅行更新成功';

  @override
  String get failedToUpdateTrip => '旅行更新失败';

  @override
  String get deleteTrip => '删除旅行';

  @override
  String get deleteTripConfirmation => '您确定要删除这次旅行吗？此操作无法撤销。';

  @override
  String get tripDeletedSuccessfully => '旅行删除成功';

  @override
  String get failedToDeleteTrip => '旅行删除失败';

  @override
  String get tripCreatedSuccessfully => '旅行创建成功！';

  @override
  String get failedToCreateTrip => '旅行创建失败';

  @override
  String get selectStartDateFirst => '请先选择开始日期';

  @override
  String get addAtLeastOneDestination => '请至少添加一个目的地';

  @override
  String get selectBothStartAndEndDates => '请选择开始和结束日期';

  @override
  String get titleIsRequired => 'Title is required';

  @override
  String titleTooLong(int limit) {
    return 'Title must be $limit characters or less';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'Description must be $limit characters or less';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Vendor/Company must be $limit characters or less';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'Confirmation number must be $limit characters or less';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Paid by must be $limit characters or less';
  }

  @override
  String locationTooLong(int limit) {
    return 'Location must be $limit characters or less';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'Description must be $limit characters or less';
  }

  @override
  String get amountIsRequired => 'Amount is required';

  @override
  String get enterValidAmount => 'Please enter a valid amount';

  @override
  String get amountMustBePositive => 'Amount must be positive';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName is required';
  }

  @override
  String get destinationIsRequired => 'Destination is required';

  @override
  String destinationTooLong(int limit) {
    return 'Destination must be $limit characters or less';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (Optional)';
  }

  @override
  String maxCharacters(int maxLength) {
    return '$maxLength max';
  }

  @override
  String get searchTripsPlaceholder => 'Search trips...';

  @override
  String allWithTotal(int total) {
    return 'All ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'Upcoming ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Active ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Completed ($count)';
  }

  @override
  String get yourTripsTitle => 'Your Trips';

  @override
  String activeTripsCount(int count) {
    return '$count Active';
  }

  @override
  String get bookingsTabTitle => 'Bookings';

  @override
  String get expensesTabTitle => 'Expenses';

  @override
  String get overviewTabTitle => 'Overview';

  @override
  String get todoTabTitle => 'To-Do';

  @override
  String get itineraryTabTitle => 'Itinerary';

  @override
  String get failedToLoadTrip => 'Failed to load trip';

  @override
  String get tripNotFound => 'Trip not found';

  @override
  String get saveImage => 'Save Image';

  @override
  String get saveToPhotos => 'Save to Photos';

  @override
  String get saveToPhotosDescription => 'Save directly to your photo gallery';

  @override
  String get saveToFiles => 'Save to Files';

  @override
  String get saveToFilesDescription => 'Choose a specific folder to save';

  @override
  String get imageSavedToPhotos => 'Image saved to Photos';

  @override
  String get fileSavedSuccessfully => 'File saved successfully';

  @override
  String get open => 'Open';

  @override
  String errorDownloadingFile(String error) {
    return 'Error downloading file: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Error saving to Photos: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Error saving file: $error';
  }

  @override
  String get selectDocument => 'Select Document';

  @override
  String get chooseFromGalleryTitle => 'Choose from Gallery';

  @override
  String get chooseFromGalleryDescription => 'Select from photo library';

  @override
  String get chooseFileTitle => 'Choose File';

  @override
  String get chooseFileDescription => 'Select PDF or other files';

  @override
  String get failedToCaptureImage => 'Failed to capture image';

  @override
  String get failedToSelectImage => 'Failed to select image';

  @override
  String get failedToSelectFile => 'Failed to select file';

  @override
  String get documentAddedSuccessfully => 'Document added successfully';

  @override
  String get documentUpdatedSuccessfully => 'Document updated successfully';

  @override
  String get failedToSaveDocument => 'Failed to save document';

  @override
  String get documentTitle => 'Document Title *';

  @override
  String get documentCategory => 'Document Category';

  @override
  String get changeDocument => 'Change Document';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get noDocumentsYet => 'No documents yet';

  @override
  String get noDocumentsFound => 'No documents found';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get documentDetails => 'Document Details';

  @override
  String get fileSize => 'File Size';

  @override
  String get fileName => 'File Name';

  @override
  String get deleteDocument => 'Delete Document';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Are you sure you want to delete \"$title\"? This action cannot be undone.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Document \"$title\" deleted successfully';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Failed to delete document: $error';
  }

  @override
  String get location => 'Location';

  @override
  String get activityTitleLabel => 'Activity Title';

  @override
  String get activityTypeLabel => 'Activity Type';

  @override
  String get expenseTitleLabel => 'Expense Title';

  @override
  String get destinations => 'Destinations';

  @override
  String get currency => 'Currency';

  @override
  String get tripInProgressStatus => 'Trip in Progress';

  @override
  String get completedStatus => 'Completed';

  @override
  String get tripDates => 'Trip Dates';

  @override
  String get expenseType => 'Expense';

  @override
  String get expenseDetailsTitle => 'Expense Details';

  @override
  String get activityDetailsTitle => 'Activity Details';

  @override
  String get deleteActivity => 'Delete Activity';

  @override
  String get deleteBooking => 'Delete Booking';

  @override
  String get january => 'Jan';

  @override
  String get february => 'Feb';

  @override
  String get march => 'Mar';

  @override
  String get april => 'Apr';

  @override
  String get may => 'May';

  @override
  String get june => 'Jun';

  @override
  String get july => 'Jul';

  @override
  String get august => 'Aug';

  @override
  String get september => 'Sept';

  @override
  String get october => 'Oct';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Dec';

  @override
  String get food => 'Food';

  @override
  String get confirmed => 'Confirmed';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get passport => 'Passport';

  @override
  String get visa => 'Visa';

  @override
  String get ticket => 'Ticket';

  @override
  String get hotel => 'Hotel';

  @override
  String get insurance => 'Insurance';

  @override
  String get editDocument => 'Edit Document';

  @override
  String get updateDocument => 'Update Document';

  @override
  String get saveToGallery => 'Save to Gallery';

  @override
  String get flight => '航班';

  @override
  String get restaurant => '餐厅';

  @override
  String get bookingLimitReached => '预订限制已达到。每次旅行最多只能添加15个预订。';

  @override
  String get documentLimitReached => '文档限制已达到。总共最多只能添加10个文档。';

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
  String get keepFileSafeNote =>
      'Keep this file safe — you\'ll need it to restore your data!';

  @override
  String get exportFailedTitle => 'Export Failed';

  @override
  String failedToCreateBackup(String error) {
    return 'Failed to create backup: $error';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get deleteEverything => 'Delete Everything';

  @override
  String get createBackup => 'Create Backup';

  @override
  String get ok => 'OK';
}
