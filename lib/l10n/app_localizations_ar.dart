// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'الرحلات';

  @override
  String get documents => 'الوثائق';

  @override
  String get settings => 'الإعدادات';

  @override
  String get quickStats => 'إحصائيات سريعة';

  @override
  String get activeTrips => 'الرحلات النشطة';

  @override
  String get pendingTasks => 'المهام المعلقة';

  @override
  String get totalBudget => 'الميزانية الإجمالية';

  @override
  String nextTripStartsIn(int days) {
    return 'تبدأ الرحلة التالية خلال $days أيام';
  }

  @override
  String get yourTrips => 'رحلاتك';

  @override
  String get searchTrips => 'البحث عن الرحلات...';

  @override
  String get daysUntilStart => 'أيام حتى البداية';

  @override
  String get dateCreated => 'تاريخ الإنشاء';

  @override
  String get alphabetical => 'أبجدي';

  @override
  String get budget => 'الميزانية';

  @override
  String get tasks => 'المهام';

  @override
  String get tripInProgress => 'رحلة قيد التنفيذ';

  @override
  String get startingToday => 'تبدأ اليوم!';

  @override
  String daysToGo(int days) {
    return '$days أيام متبقية';
  }

  @override
  String active(int count) {
    return '$count نشطة';
  }

  @override
  String get searchDocuments => 'البحث عن الوثائق...';

  @override
  String get personal => 'شخصي';

  @override
  String get tripRelated => 'مرتبطة بالرحلة';

  @override
  String get uploadDocument => 'رفع وثيقة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get captureDocumentWithCamera => 'التقط الوثيقة بالكاميرا';

  @override
  String get chooseFromGallery => 'اختر من المعرض';

  @override
  String get selectFromPhotoLibrary => 'اختر من مكتبة الصور';

  @override
  String get chooseFile => 'اختر ملف';

  @override
  String get selectPdfOrOtherFiles => 'اختر PDF أو ملفات أخرى';

  @override
  String expires(String date) {
    return 'تنتهي صلاحيته: $date';
  }

  @override
  String get view => 'عرض';

  @override
  String get share => 'مشاركة';

  @override
  String get download => 'تحميل';

  @override
  String get delete => 'حذف';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get darkMode => 'الوضع المظلم';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'التبديل بين الثيم الفاتح والداكن';

  @override
  String get language => 'اللغة';

  @override
  String get selectYourPreferredLanguage => 'اختر لغتك المفضلة';

  @override
  String get defaultCurrency => 'العملة الافتراضية';

  @override
  String get currencyUsedForNewTrips => 'العملة المستخدمة للرحلات الجديدة';

  @override
  String get dateFormat => 'تنسيق التاريخ';

  @override
  String get howDatesAreDisplayed => 'كيفية عرض التواريخ';

  @override
  String get temperatureUnit => 'وحدة درجة الحرارة';

  @override
  String get temperatureScalePreference => 'تفضيل مقياس درجة الحرارة';

  @override
  String get appSettings => 'إعدادات التطبيق';

  @override
  String get backupAndSync => 'النسخ الاحتياطي والمزامنة';

  @override
  String get manageYourDataBackup => 'إدارة النسخ الاحتياطي للبيانات';

  @override
  String get importData => 'استيراد البيانات';

  @override
  String get importTripsFromOtherApps => 'استيراد الرحلات من تطبيقات أخرى';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get exportYourTripData => 'تصدير بيانات رحلتك';

  @override
  String get about => 'حول';

  @override
  String get appVersion => 'إصدار التطبيق';

  @override
  String get rateApp => 'قيم التطبيق';

  @override
  String get leaveAReviewOnTheAppStore => 'اترك مراجعة في متجر التطبيقات';

  @override
  String get helpAndSupport => 'المساعدة والدعم';

  @override
  String get faqsAndContactInformation => 'الأسئلة الشائعة ومعلومات الاتصال';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get readOurPrivacyPolicy => 'اقرأ سياسة الخصوصية الخاصة بنا';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get readOurTermsAndConditions => 'اقرأ الشروط والأحكام الخاصة بنا';

  @override
  String get dangerZone => 'منطقة الخطر';

  @override
  String get clearAllData => 'مسح جميع البيانات';

  @override
  String get removeAllTripsAndDocuments => 'إزالة جميع الرحلات والوثائق';

  @override
  String get clearAllDataConfirmation =>
      'لا يمكن التراجع عن هذا الإجراء. سيتم حذف جميع رحلاتك ووثائقك وإعداداتك نهائياً.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get clearAll => 'مسح الكل';

  @override
  String get celsius => 'مئوية';

  @override
  String get fahrenheit => 'فهرنهايت';

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
  String get title => 'العنوان';

  @override
  String get description => 'الوصف';

  @override
  String get amount => 'المبلغ';

  @override
  String get date => 'التاريخ';

  @override
  String get edit => 'تحرير';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get add => 'إضافة';

  @override
  String get update => 'تحديث';

  @override
  String get close => 'إغلاق';

  @override
  String get failedToLoad => 'فشل في التحميل';

  @override
  String get noDataYet => 'لا توجد بيانات بعد';

  @override
  String get startPlanning => 'ابدأ التخطيط لمغامرتك القادمة!';

  @override
  String get createTrip => 'إنشاء رحلة';

  @override
  String get addDocument => 'إضافة وثيقة';

  @override
  String get addExpense => 'إضافة مصروف';

  @override
  String get addActivity => 'إضافة نشاط';

  @override
  String get addBooking => 'إضافة حجز';

  @override
  String get totalExpenses => 'إجمالي المصروفات';

  @override
  String get toDoItems => 'قائمة المهام';

  @override
  String get expenseDetails => 'تفاصيل المصروف';

  @override
  String get expenseTitle => 'عنوان المصروف';

  @override
  String get category => 'الفئة';

  @override
  String get paidBy => 'دفع بواسطة';

  @override
  String get you => 'أنت';

  @override
  String get allDay => 'طوال اليوم';

  @override
  String get startTime => 'وقت البداية';

  @override
  String get endTime => 'وقت الانتهاء';

  @override
  String get activityTitle => 'عنوان النشاط';

  @override
  String get activityType => 'نوع النشاط';

  @override
  String get bookingTitle => 'عنوان الحجز';

  @override
  String get bookingType => 'نوع الحجز';

  @override
  String get status => 'الحالة';

  @override
  String get addFile => 'إضافة ملف';

  @override
  String get fileNotFound => 'الملف غير موجود';

  @override
  String get fileMovedOrDeleted => 'قد يكون الملف قد تم نقله أو حذفه';

  @override
  String get cannotDisplayImage => 'لا يمكن عرض الصورة';

  @override
  String get openExternally => 'فتح خارجياً';

  @override
  String get failedToReadFile => 'فشل في قراءة بيانات الملف';

  @override
  String get deleteExpense => 'حذف المصروف';

  @override
  String get deleteExpenseConfirmation =>
      'هل أنت متأكد من رغبتك في حذف هذا المصروف؟';

  @override
  String get expenseBreakdown => 'تفصيل المصروفات';

  @override
  String get breakdown => 'تفصيل';

  @override
  String get noExpensesYet => 'لا توجد مصروفات بعد';

  @override
  String get noActivitiesPlanned => 'لا توجد أنشطة مخططة';

  @override
  String get splitDetails => 'تفاصيل التقسيم';

  @override
  String get editExpense => 'تحرير المصروف';

  @override
  String get addNewExpense => 'إضافة مصروف جديد';

  @override
  String get editActivity => 'تحرير النشاط';

  @override
  String get addNewActivity => 'إضافة نشاط جديد';

  @override
  String get editBooking => 'تحرير الحجز';

  @override
  String get addNewBooking => 'إضافة حجز جديد';

  @override
  String get updateExpense => 'تحديث المصروف';

  @override
  String get updateActivity => 'تحديث النشاط';

  @override
  String get updateBooking => 'تحديث الحجز';

  @override
  String get transport => 'نقل';

  @override
  String get accommodation => 'إقامة';

  @override
  String get activities => 'أنشطة';

  @override
  String get shopping => 'تسوق';

  @override
  String get sightseeing => 'جولة سياحية';

  @override
  String get meal => 'وجبة';

  @override
  String get entertainment => 'ترفيه';

  @override
  String get other => 'أخرى';

  @override
  String get noBookingsYet => 'لا توجد حجوزات بعد';

  @override
  String get addFirstBooking => 'إضافة أول حجز';

  @override
  String get bookingDetails => 'تفاصيل الحجز';

  @override
  String get vendor => 'البائع';

  @override
  String get confirmationNumber => 'رقم التأكيد';

  @override
  String get attachments => 'مرفقات';

  @override
  String get failedToLoadTodos => 'فشل في تحميل المهام';

  @override
  String get task => 'مهمة';

  @override
  String allWithCount(int count) {
    return 'الكل ($count)';
  }

  @override
  String get noToDoItems => 'لا توجد مهام';

  @override
  String get stayOrganizedMessage => 'ابق منظماً بإضافة مهام لتخطيط رحلتك!';

  @override
  String get addFirstTask => 'إضافة أول مهمة';

  @override
  String get taskDetails => 'تفاصيل المهمة';

  @override
  String get completed => 'مكتمل';

  @override
  String get pending => 'معلق';

  @override
  String get priority => 'الأولوية';

  @override
  String get dueDate => 'تاريخ الاستحقاق';

  @override
  String get editTask => 'تحرير المهمة';

  @override
  String get addNewTask => 'إضافة مهمة جديدة';

  @override
  String get updateTask => 'تحديث المهمة';

  @override
  String get addTask => 'إضافة مهمة';

  @override
  String get deleteTask => 'حذف المهمة';

  @override
  String deleteTaskConfirmation(String title) {
    return 'هل أنت متأكد من رغبتك في حذف \"$title\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String get keepTrackMessage => 'تتبع رحلاتك الجوية وفنادقك وأنشطتك!';

  @override
  String get previewNotAvailable =>
      'المعاينة غير متاحة لهذا النوع من الملفات.\nانقر على \"فتح خارجياً\" للعرض مع تطبيق آخر.';

  @override
  String get appVersionBeta => '1.0.0 (بيتا)';

  @override
  String get defaultUserName => 'جون دو';

  @override
  String get defaultUserEmail => 'john.doe@email.com';

  @override
  String get taskTitle => 'عنوان المهمة';

  @override
  String get descriptionOptional => 'الوصف (اختياري)';

  @override
  String get setDueDateOptional => 'تحديد تاريخ الاستحقاق (اختياري)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'مستحق: $day/$month/$year';
  }

  @override
  String get urgent => 'عاجل';

  @override
  String get high => 'عالي';

  @override
  String get medium => 'متوسط';

  @override
  String get low => 'منخفض';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'فشل في $action المهمة: $error';
  }

  @override
  String get vendorCompanyOptional => 'البائع/الشركة (اختياري)';

  @override
  String get confirmationNumberOptional => 'رقم التأكيد (اختياري)';

  @override
  String amountCurrency(String currency) {
    return 'المبلغ ($currency)';
  }

  @override
  String get setBookingDateOptional => 'تحديد تاريخ الحجز (اختياري)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'التاريخ: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'مرفقات (اختياري)';

  @override
  String get maxFileSizeSupported =>
      'الحد الأقصى لحجم الملف: 5 ميجابايت\nالتنسيقات المدعومة: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'فشل في $action الحجز: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return 'تم إرفاق $filename بنجاح';
  }

  @override
  String get fileSizeMustBeLess => 'يجب أن يكون حجم الملف أقل من 5 ميجابايت';

  @override
  String failedToPickFile(String error) {
    return 'فشل في اختيار الملف: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'خطأ في مشاركة الملف: $error';
  }

  @override
  String get unknown => 'غير معروف';

  @override
  String get editTrip => 'تحرير الرحلة';

  @override
  String get updateTrip => 'تحديث الرحلة';

  @override
  String get tripUpdatedSuccessfully => 'تم تحديث الرحلة بنجاح';

  @override
  String get failedToUpdateTrip => 'فشل في تحديث الرحلة';

  @override
  String get deleteTrip => 'حذف الرحلة';

  @override
  String get deleteTripConfirmation =>
      'هل أنت متأكد من رغبتك في حذف هذه الرحلة؟ لا يمكن التراجع عن هذا الإجراء.';

  @override
  String get tripDeletedSuccessfully => 'تم حذف الرحلة بنجاح';

  @override
  String get failedToDeleteTrip => 'فشل في حذف الرحلة';

  @override
  String get tripCreatedSuccessfully => 'تم إنشاء الرحلة بنجاح!';

  @override
  String get failedToCreateTrip => 'فشل في إنشاء الرحلة';

  @override
  String get selectStartDateFirst => 'يرجى اختيار تاريخ البداية أولاً';

  @override
  String get addAtLeastOneDestination => 'يرجى إضافة وجهة واحدة على الأقل';

  @override
  String get selectBothStartAndEndDates =>
      'يرجى اختيار تاريخي البداية والنهاية';

  @override
  String get titleIsRequired => 'العنوان مطلوب';

  @override
  String titleTooLong(int limit) {
    return 'يجب أن يكون العنوان $limit حرف أو أقل';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'يجب أن يكون الوصف $limit حرف أو أقل';
  }

  @override
  String vendorTooLong(int limit) {
    return 'يجب أن يكون اسم البائع/الشركة $limit حرف أو أقل';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'يجب أن يكون رقم التأكيد $limit حرف أو أقل';
  }

  @override
  String paidByTooLong(int limit) {
    return 'يجب أن يكون اسم الدافع $limit حرف أو أقل';
  }

  @override
  String locationTooLong(int limit) {
    return 'يجب أن يكون الموقع $limit حرف أو أقل';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'يجب أن يكون الوصف $limit حرف أو أقل';
  }

  @override
  String get amountIsRequired => 'المبلغ مطلوب';

  @override
  String get enterValidAmount => 'يرجى إدخال مبلغ صحيح';

  @override
  String get amountMustBePositive => 'يجب أن يكون المبلغ موجباً';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName مطلوب';
  }

  @override
  String get destinationIsRequired => 'الوجهة مطلوبة';

  @override
  String destinationTooLong(int limit) {
    return 'يجب أن تكون الوجهة $limit حرف أو أقل';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (اختياري)';
  }

  @override
  String maxCharacters(int maxLength) {
    return 'الحد الأقصى $maxLength';
  }

  @override
  String get searchTripsPlaceholder => 'البحث في الرحلات...';

  @override
  String allWithTotal(int total) {
    return 'الكل ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'قادم ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'نشط ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'مكتمل ($count)';
  }

  @override
  String get yourTripsTitle => 'رحلاتك';

  @override
  String activeTripsCount(int count) {
    return '$count نشط';
  }

  @override
  String get bookingsTabTitle => 'الحجوزات';

  @override
  String get expensesTabTitle => 'المصروفات';

  @override
  String get overviewTabTitle => 'نظرة عامة';

  @override
  String get todoTabTitle => 'المهام';

  @override
  String get itineraryTabTitle => 'Itinerary';

  @override
  String get failedToLoadTrip => 'فشل في تحميل الرحلة';

  @override
  String get tripNotFound => 'الرحلة غير موجودة';

  @override
  String get saveImage => 'حفظ الصورة';

  @override
  String get saveToPhotos => 'حفظ في الصور';

  @override
  String get saveToPhotosDescription => 'حفظ مباشرة في معرض الصور';

  @override
  String get saveToFiles => 'حفظ في الملفات';

  @override
  String get saveToFilesDescription => 'اختر مجلد محدد للحفظ';

  @override
  String get imageSavedToPhotos => 'تم حفظ الصورة في الصور';

  @override
  String get fileSavedSuccessfully => 'تم حفظ الملف بنجاح';

  @override
  String get open => 'فتح';

  @override
  String errorDownloadingFile(String error) {
    return 'خطأ في تحميل الملف: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'خطأ في الحفظ في الصور: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'خطأ في حفظ الملف: $error';
  }

  @override
  String get selectDocument => 'اختر وثيقة';

  @override
  String get chooseFromGalleryTitle => 'اختر من المعرض';

  @override
  String get chooseFromGalleryDescription => 'اختر من مكتبة الصور';

  @override
  String get chooseFileTitle => 'اختر ملف';

  @override
  String get chooseFileDescription => 'اختر PDF أو ملفات أخرى';

  @override
  String get failedToCaptureImage => 'فشل في التقاط الصورة';

  @override
  String get failedToSelectImage => 'فشل في اختيار الصورة';

  @override
  String get failedToSelectFile => 'فشل في اختيار الملف';

  @override
  String get documentAddedSuccessfully => 'تم إضافة الوثيقة بنجاح';

  @override
  String get documentUpdatedSuccessfully => 'تم تحديث الوثيقة بنجاح';

  @override
  String get failedToSaveDocument => 'فشل في حفظ الوثيقة';

  @override
  String get documentTitle => 'عنوان الوثيقة *';

  @override
  String get documentCategory => 'فئة الوثيقة';

  @override
  String get changeDocument => 'تغيير الوثيقة';

  @override
  String get documentsTitle => 'الوثائق';

  @override
  String get noDocumentsYet => 'لا توجد وثائق بعد';

  @override
  String get noDocumentsFound => 'لم يتم العثور على وثائق';

  @override
  String get clearSearch => 'مسح البحث';

  @override
  String get documentDetails => 'تفاصيل الوثيقة';

  @override
  String get fileSize => 'حجم الملف';

  @override
  String get fileName => 'اسم الملف';

  @override
  String get deleteDocument => 'حذف الوثيقة';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'هل أنت متأكد من رغبتك في حذف \"$title\"؟ لا يمكن التراجع عن هذا الإجراء.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'تم حذف الوثيقة \"$title\" بنجاح';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'فشل في حذف الوثيقة: $error';
  }

  @override
  String get location => 'الموقع';

  @override
  String get activityTitleLabel => 'عنوان النشاط';

  @override
  String get activityTypeLabel => 'نوع النشاط';

  @override
  String get expenseTitleLabel => 'عنوان المصروف';

  @override
  String get destinations => 'الوجهات';

  @override
  String get currency => 'العملة';

  @override
  String get tripInProgressStatus => 'الرحلة قيد التقدم';

  @override
  String get completedStatus => 'مكتمل';

  @override
  String get tripDates => 'تواريخ الرحلة';

  @override
  String get expenseType => 'مصروف';

  @override
  String get expenseDetailsTitle => 'تفاصيل المصروف';

  @override
  String get activityDetailsTitle => 'تفاصيل النشاط';

  @override
  String get deleteActivity => 'حذف النشاط';

  @override
  String get deleteBooking => 'حذف الحجز';

  @override
  String get january => 'يناير';

  @override
  String get february => 'فبراير';

  @override
  String get march => 'مارس';

  @override
  String get april => 'أبريل';

  @override
  String get may => 'مايو';

  @override
  String get june => 'يونيو';

  @override
  String get july => 'يوليو';

  @override
  String get august => 'أغسطس';

  @override
  String get september => 'سبتمبر';

  @override
  String get october => 'أكتوبر';

  @override
  String get november => 'نوفمبر';

  @override
  String get december => 'ديسمبر';

  @override
  String get food => 'طعام';

  @override
  String get confirmed => 'مؤكد';

  @override
  String get cancelled => 'ملغى';

  @override
  String get passport => 'جواز سفر';

  @override
  String get visa => 'تأشيرة';

  @override
  String get ticket => 'تذكرة';

  @override
  String get hotel => 'فندق';

  @override
  String get insurance => 'تأمين';

  @override
  String get editDocument => 'تحرير الوثيقة';

  @override
  String get updateDocument => 'تحديث الوثيقة';

  @override
  String get saveToGallery => 'حفظ في المعرض';

  @override
  String get flight => 'طائرة';

  @override
  String get restaurant => 'مطعم';

  @override
  String get bookingLimitReached =>
      'تم الوصول لحد الحجوزات. يمكنك إضافة 15 حجز فقط لكل رحلة.';

  @override
  String get documentLimitReached =>
      'تم الوصول لحد المستندات. يمكنك إضافة 10 مستندات فقط في المجموع.';

  @override
  String get clearFilters => 'مسح المرشحات';

  @override
  String get travelDates => 'تواريخ السفر';

  @override
  String get selectDateRange => 'اختر نطاق التاريخ';

  @override
  String get activityDetails => 'تفاصيل النشاط';

  @override
  String get quickActions => 'الإجراءات السريعة';

  @override
  String get addNewItemsToTrip => 'إضافة عناصر جديدة للرحلة';

  @override
  String get booking => 'حجز';

  @override
  String get expense => 'مصروف';

  @override
  String get itinerary => 'خط السير';

  @override
  String get duration => 'المدة';

  @override
  String get noExpensesFound => 'لم يتم العثور على مصروفات';

  @override
  String get noExpensesFoundForCategory =>
      'لم يتم العثور على مصروفات لهذه الفئة';

  @override
  String get noTasksFound => 'لم يتم العثور على مهام';

  @override
  String get noBookingsFound => 'لم يتم العثور على حجوزات';

  @override
  String get noTripsFound => 'لم يتم العثور على رحلات';

  @override
  String get tryAdjustingFilters => 'حاول تعديل المرشحات';

  @override
  String get searchTasks => 'البحث عن المهام';

  @override
  String get searchBookings => 'البحث عن الحجوزات';

  @override
  String get urgentPriority => 'عاجل';

  @override
  String get highPriority => 'عالي';

  @override
  String get mediumPriority => 'متوسط';

  @override
  String get lowPriority => 'منخفض';

  @override
  String get overdue => 'متأخر';

  @override
  String get dueToday => 'مستحق اليوم';

  @override
  String get dueTomorrow => 'مستحق غداً';

  @override
  String get activeStatus => 'الحالة النشطة';

  @override
  String get selectBackupFile => 'اختر ملف النسخ الاحتياطي';

  @override
  String get selectFile => 'اختر ملف';

  @override
  String get importBackup => 'استيراد النسخة الاحتياطية';

  @override
  String get importSuccessful => 'نجح الاستيراد';

  @override
  String get importFailed => 'فشل الاستيراد';

  @override
  String get couldNotOpenAppStore => 'لا يمكن فتح متجر التطبيقات';

  @override
  String get couldNotOpenHelpSection => 'لا يمكن فتح قسم المساعدة';

  @override
  String get couldNotOpenPrivacyPolicy => 'لا يمكن فتح سياسة الخصوصية';

  @override
  String get couldNotOpenTermsOfService => 'لا يمكن فتح شروط الخدمة';

  @override
  String get confirmActionWarning => 'لا يمكن التراجع عن هذا الإجراء!';

  @override
  String get finalConfirmationTitle => 'التأكيد النهائي';

  @override
  String finalConfirmationPrompt(String word) {
    return 'اكتب $word في المربع أدناه للتأكيد:';
  }

  @override
  String get deletingAllData => 'حذف جميع البيانات...';

  @override
  String get pleaseWait => 'يرجى الانتظار، قد يستغرق هذا لحظة.';

  @override
  String get dataClearedTitle => 'تم محو البيانات';

  @override
  String get dataClearedMessage =>
      'تم حذف جميع بياناتك بنجاح. تم إعادة تعيين التطبيق إلى حالته الأولية.';

  @override
  String get errorTitle => 'خطأ';

  @override
  String failedToClearAllData(String error) {
    return 'فشل في محو جميع البيانات: $error';
  }

  @override
  String get exportIntroTitle =>
      'إنشاء نسخة احتياطية آمنة لجميع بيانات Voythrix الخاصة بك:';

  @override
  String get exportEncryptionInfo => 'سيتم تشفير بياناتك وضغطها في ملف .tripe.';

  @override
  String get backupPasswordTitle => 'كلمة مرور النسخ الاحتياطي (اختياري)';

  @override
  String get backupPasswordHint => 'أدخل كلمة المرور (اختياري)';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get passwordsMatch => 'كلمات المرور متطابقة';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get creatingBackup => 'جاري إنشاء النسخة الاحتياطية...';

  @override
  String get collectingAndEncrypting => 'تجميع وتشفير بياناتك...';

  @override
  String get backupCreatedTitle => 'تم إنشاء النسخة الاحتياطية';

  @override
  String get backupCreatedMessage => 'تم إنشاء النسخة الاحتياطية بنجاح!';

  @override
  String get fileInfoLabel => 'معلومات الملف:';

  @override
  String get fileInfoFormat => '• التنسيق: ملف .tripe مشفّر';

  @override
  String get fileInfoSecurityPassword => '• الأمان: محمي بكلمة مرور';

  @override
  String get fileInfoSecurityStandard => '• الأمان: تشفير قياسي';

  @override
  String get fileInfoCompression => '• الضغط: مضغوط GZip';

  @override
  String get keepFileSafeNote =>
      'احتفظ بهذا الملف في مكان آمن — ستحتاجه لاستعادة بياناتك!';

  @override
  String get exportFailedTitle => 'فشل التصدير';

  @override
  String failedToCreateBackup(String error) {
    return 'فشل في إنشاء النسخة الاحتياطية: $error';
  }

  @override
  String get continueAction => 'متابعة';

  @override
  String get deleteEverything => 'حذف كل شيء';

  @override
  String get createBackup => 'إنشاء نسخة احتياطية';

  @override
  String get ok => 'موافق';
}
