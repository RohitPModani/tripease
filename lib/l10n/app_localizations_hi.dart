// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'यात्राएं';

  @override
  String get documents => 'दस्तावेज़';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get quickStats => 'त्वरित आंकड़े';

  @override
  String get activeTrips => 'सक्रिय यात्राएं';

  @override
  String get pendingTasks => 'लंबित कार्य';

  @override
  String get totalBudget => 'कुल बजट';

  @override
  String nextTripStartsIn(int days) {
    return 'अगली यात्रा $days दिनों में शुरू होगी';
  }

  @override
  String get yourTrips => 'आपकी यात्राएं';

  @override
  String get searchTrips => 'यात्राएं खोजें...';

  @override
  String get daysUntilStart => 'शुरू होने तक के दिन';

  @override
  String get dateCreated => 'बनाने की तारीख';

  @override
  String get alphabetical => 'वर्णानुक्रम';

  @override
  String get budget => 'बजट';

  @override
  String get tasks => 'कार्य';

  @override
  String get tripInProgress => 'यात्रा चल रही है';

  @override
  String get startingToday => 'आज शुरू हो रही है!';

  @override
  String daysToGo(int days) {
    return '$days दिन बाकी हैं';
  }

  @override
  String active(int count) {
    return '$count सक्रिय';
  }

  @override
  String get searchDocuments => 'दस्तावेज़ खोजें...';

  @override
  String get personal => 'व्यक्तिगत';

  @override
  String get tripRelated => 'यात्रा संबंधी';

  @override
  String get uploadDocument => 'दस्तावेज़ अपलोड करें';

  @override
  String get takePhoto => 'फोटो लें';

  @override
  String get captureDocumentWithCamera => 'कैमरे से दस्तावेज़ कैप्चर करें';

  @override
  String get chooseFromGallery => 'गैलरी से चुनें';

  @override
  String get selectFromPhotoLibrary => 'फोटो लाइब्रेरी से चुनें';

  @override
  String get chooseFile => 'फाइल चुनें';

  @override
  String get selectPdfOrOtherFiles => 'PDF या अन्य फाइलें चुनें';

  @override
  String expires(String date) {
    return 'समाप्ति: $date';
  }

  @override
  String get view => 'देखें';

  @override
  String get share => 'साझा करें';

  @override
  String get download => 'डाउनलोड';

  @override
  String get delete => 'हटाएं';

  @override
  String get profile => 'प्रोफाइल';

  @override
  String get preferences => 'प्राथमिकताएं';

  @override
  String get darkMode => 'डार्क मोड';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'हल्के और गहरे थीम के बीच स्विच करें';

  @override
  String get language => 'भाषा';

  @override
  String get selectYourPreferredLanguage => 'अपनी पसंदीदा भाषा चुनें';

  @override
  String get defaultCurrency => 'डिफ़ॉल्ट मुद्रा';

  @override
  String get currencyUsedForNewTrips =>
      'नई यात्राओं के लिए उपयोग की जाने वाली मुद्रा';

  @override
  String get dateFormat => 'तारीख प्रारूप';

  @override
  String get howDatesAreDisplayed => 'तारीखें कैसे प्रदर्शित होती हैं';

  @override
  String get temperatureUnit => 'तापमान इकाई';

  @override
  String get temperatureScalePreference => 'तापमान पैमाना प्राथमिकता';

  @override
  String get appSettings => 'ऐप सेटिंग्स';

  @override
  String get backupAndSync => 'बैकअप और सिंक';

  @override
  String get manageYourDataBackup => 'अपना डेटा बैकअप प्रबंधित करें';

  @override
  String get importData => 'डेटा आयात करें';

  @override
  String get importTripsFromOtherApps => 'अन्य ऐप्स से यात्राएं आयात करें';

  @override
  String get exportData => 'डेटा निर्यात करें';

  @override
  String get exportYourTripData => 'अपना यात्रा डेटा निर्यात करें';

  @override
  String get about => 'के बारे में';

  @override
  String get appVersion => 'ऐप संस्करण';

  @override
  String get rateApp => 'ऐप को रेट करें';

  @override
  String get leaveAReviewOnTheAppStore => 'ऐप स्टोर पर समीक्षा छोड़ें';

  @override
  String get helpAndSupport => 'सहायता और समर्थन';

  @override
  String get faqsAndContactInformation => 'FAQ और संपर्क जानकारी';

  @override
  String get privacyPolicy => 'गोपनीयता नीति';

  @override
  String get readOurPrivacyPolicy => 'हमारी गोपनीयता नीति पढ़ें';

  @override
  String get termsOfService => 'सेवा की शर्तें';

  @override
  String get readOurTermsAndConditions => 'हमारे नियम और शर्तें पढ़ें';

  @override
  String get dangerZone => 'खतरनाक क्षेत्र';

  @override
  String get clearAllData => 'सभी डेटा साफ करें';

  @override
  String get removeAllTripsAndDocuments => 'सभी यात्राएं और दस्तावेज़ हटाएं';

  @override
  String get clearAllDataConfirmation =>
      'यह क्रिया पूर्ववत नहीं की जा सकती। आपकी सभी यात्राएं, दस्तावेज़ और सेटिंग्स स्थायी रूप से हटा दी जाएंगी।';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get clearAll => 'सब साफ करें';

  @override
  String get celsius => 'सेल्सियस';

  @override
  String get fahrenheit => 'फारेनहाइट';

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
  String get title => 'शीर्षक';

  @override
  String get description => 'विवरण';

  @override
  String get amount => 'राशि';

  @override
  String get date => 'तारीख';

  @override
  String get edit => 'संपादित करें';

  @override
  String get retry => 'पुनः प्रयास करें';

  @override
  String get add => 'जोड़ें';

  @override
  String get update => 'अपडेट करें';

  @override
  String get close => 'बंद करें';

  @override
  String get failedToLoad => 'लोड करने में विफल';

  @override
  String get noDataYet => 'अभी तक कोई डेटा नहीं';

  @override
  String get startPlanning => 'अपने अगले रोमांच की योजना शुरू करें!';

  @override
  String get createTrip => 'यात्रा बनाएं';

  @override
  String get addDocument => 'दस्तावेज़ जोड़ें';

  @override
  String get addExpense => 'खर्च जोड़ें';

  @override
  String get addActivity => 'गतिविधि जोड़ें';

  @override
  String get addBooking => 'बुकिंग जोड़ें';

  @override
  String get totalExpenses => 'कुल खर्च';

  @override
  String get toDoItems => 'कार्य सूची';

  @override
  String get expenseDetails => 'खर्च विवरण';

  @override
  String get expenseTitle => 'खर्च शीर्षक';

  @override
  String get category => 'श्रेणी';

  @override
  String get paidBy => 'द्वारा भुगतान';

  @override
  String get you => 'आप';

  @override
  String get allDay => 'पूरा दिन';

  @override
  String get startTime => 'शुरुआत का समय';

  @override
  String get endTime => 'समाप्ति समय';

  @override
  String get activityTitle => 'गतिविधि शीर्षक';

  @override
  String get activityType => 'गतिविधि प्रकार';

  @override
  String get bookingTitle => 'बुकिंग शीर्षक';

  @override
  String get bookingType => 'बुकिंग प्रकार';

  @override
  String get status => 'स्थिति';

  @override
  String get addFile => 'फाइल जोड़ें';

  @override
  String get fileNotFound => 'फाइल नहीं मिली';

  @override
  String get fileMovedOrDeleted => 'फाइल स्थानांतरित या हटाई गई हो सकती है';

  @override
  String get cannotDisplayImage => 'छवि प्रदर्शित नहीं की जा सकती';

  @override
  String get openExternally => 'बाहरी रूप से खोलें';

  @override
  String get failedToReadFile => 'फाइल डेटा पढ़ने में विफल';

  @override
  String get deleteExpense => 'खर्च हटाएं';

  @override
  String get deleteExpenseConfirmation =>
      'क्या आप वाकई इस खर्च को हटाना चाहते हैं?';

  @override
  String get expenseBreakdown => 'खर्च विवरण';

  @override
  String get breakdown => 'विवरण';

  @override
  String get noExpensesYet => 'अभी तक कोई खर्च नहीं';

  @override
  String get noActivitiesPlanned => 'कोई गतिविधियां नियोजित नहीं';

  @override
  String get splitDetails => 'विभाजन विवरण';

  @override
  String get editExpense => 'खर्च संपादित करें';

  @override
  String get addNewExpense => 'नया खर्च जोड़ें';

  @override
  String get editActivity => 'गतिविधि संपादित करें';

  @override
  String get addNewActivity => 'नई गतिविधि जोड़ें';

  @override
  String get editBooking => 'बुकिंग संपादित करें';

  @override
  String get addNewBooking => 'नई बुकिंग जोड़ें';

  @override
  String get updateExpense => 'खर्च अपडेट करें';

  @override
  String get updateActivity => 'गतिविधि अपडेट करें';

  @override
  String get updateBooking => 'बुकिंग अपडेट करें';

  @override
  String get transport => 'परिवहन';

  @override
  String get accommodation => 'आवास';

  @override
  String get activities => 'गतिविधियां';

  @override
  String get shopping => 'खरीदारी';

  @override
  String get sightseeing => 'दर्शनीय स्थल';

  @override
  String get meal => 'भोजन';

  @override
  String get entertainment => 'मनोरंजन';

  @override
  String get other => 'अन्य';

  @override
  String get noBookingsYet => 'अभी तक कोई बुकिंग नहीं';

  @override
  String get addFirstBooking => 'पहली बुकिंग जोड़ें';

  @override
  String get bookingDetails => 'बुकिंग विवरण';

  @override
  String get vendor => 'विक्रेता';

  @override
  String get confirmationNumber => 'पुष्टि संख्या';

  @override
  String get attachments => 'अनुलग्नक';

  @override
  String get failedToLoadTodos => 'कार्य लोड करने में विफल';

  @override
  String get task => 'कार्य';

  @override
  String allWithCount(int count) {
    return 'सभी ($count)';
  }

  @override
  String get noToDoItems => 'कोई कार्य नहीं';

  @override
  String get stayOrganizedMessage =>
      'अपनी यात्रा की योजना के लिए कार्य जोड़कर व्यवस्थित रहें!';

  @override
  String get addFirstTask => 'पहला कार्य जोड़ें';

  @override
  String get taskDetails => 'कार्य विवरण';

  @override
  String get completed => 'पूर्ण';

  @override
  String get pending => 'लंबित';

  @override
  String get priority => 'प्राथमिकता';

  @override
  String get dueDate => 'नियत तारीख';

  @override
  String get editTask => 'कार्य संपादित करें';

  @override
  String get addNewTask => 'नया कार्य जोड़ें';

  @override
  String get updateTask => 'कार्य अपडेट करें';

  @override
  String get addTask => 'कार्य जोड़ें';

  @override
  String get deleteTask => 'कार्य हटाएं';

  @override
  String deleteTaskConfirmation(String title) {
    return 'क्या आप वाकई \"$title\" को हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।';
  }

  @override
  String get keepTrackMessage =>
      'अपनी फ्लाइट्स, होटल और गतिविधियों का ट्रैक रखें!';

  @override
  String get previewNotAvailable =>
      'इस फाइल प्रकार के लिए पूर्वावलोकन उपलब्ध नहीं है।\nदूसरे ऐप के साथ देखने के लिए \"बाहरी रूप से खोलें\" पर टैप करें।';

  @override
  String get appVersionBeta => '1.0.0 (बीटा)';

  @override
  String get defaultUserName => 'जॉन डो';

  @override
  String get defaultUserEmail => 'john.doe@email.com';

  @override
  String get taskTitle => 'कार्य शीर्षक';

  @override
  String get descriptionOptional => 'विवरण (वैकल्पिक)';

  @override
  String get setDueDateOptional => 'नियत तारीख सेट करें (वैकल्पिक)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'देय: $day/$month/$year';
  }

  @override
  String get urgent => 'तत्काल';

  @override
  String get high => 'उच्च';

  @override
  String get medium => 'मध्यम';

  @override
  String get low => 'निम्न';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return '$action कार्य में विफल: $error';
  }

  @override
  String get vendorCompanyOptional => 'विक्रेता/कंपनी (वैकल्पिक)';

  @override
  String get confirmationNumberOptional => 'पुष्टि संख्या (वैकल्पिक)';

  @override
  String amountCurrency(String currency) {
    return 'राशि ($currency)';
  }

  @override
  String get setBookingDateOptional => 'बुकिंग तारीख सेट करें (वैकल्पिक)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'तारीख: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'अनुलग्नक (वैकल्पिक)';

  @override
  String get maxFileSizeSupported =>
      'अधिकतम फाइल आकार: 5MB\nसमर्थित प्रारूप: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return '$action बुकिंग में विफल: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename सफलतापूर्वक संलग्न किया गया';
  }

  @override
  String get fileSizeMustBeLess => 'फाइल का आकार 5MB से कम होना चाहिए';

  @override
  String failedToPickFile(String error) {
    return 'फाइल चुनने में विफल: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'फाइल साझा करने में त्रुटि: $error';
  }

  @override
  String get unknown => 'अज्ञात';

  @override
  String get editTrip => 'यात्रा संपादित करें';

  @override
  String get updateTrip => 'यात्रा अपडेट करें';

  @override
  String get tripUpdatedSuccessfully => 'यात्रा सफलतापूर्वक अपडेट की गई';

  @override
  String get failedToUpdateTrip => 'यात्रा अपडेट करने में विफल';

  @override
  String get deleteTrip => 'यात्रा हटाएं';

  @override
  String get deleteTripConfirmation =>
      'क्या आप वाकई इस यात्रा को हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।';

  @override
  String get tripDeletedSuccessfully => 'यात्रा सफलतापूर्वक हटाई गई';

  @override
  String get failedToDeleteTrip => 'यात्रा हटाने में विफल';

  @override
  String get tripCreatedSuccessfully => 'यात्रा सफलतापूर्वक बनाई गई!';

  @override
  String get failedToCreateTrip => 'यात्रा बनाने में विफल';

  @override
  String get selectStartDateFirst => 'कृपया पहले शुरुआत की तारीख चुनें';

  @override
  String get addAtLeastOneDestination => 'कृपया कम से कम एक गंतव्य जोड़ें';

  @override
  String get selectBothStartAndEndDates =>
      'कृपया शुरुआत और समाप्ति दोनों तारीखें चुनें';

  @override
  String get titleIsRequired => 'शीर्षक आवश्यक है';

  @override
  String titleTooLong(int limit) {
    return 'शीर्षक $limit वर्णों या उससे कम होना चाहिए';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'विवरण $limit वर्णों या उससे कम होना चाहिए';
  }

  @override
  String vendorTooLong(int limit) {
    return 'विक्रेता/कंपनी $limit वर्णों या उससे कम होना चाहिए';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'पुष्टि संख्या $limit वर्णों या उससे कम होनी चाहिए';
  }

  @override
  String paidByTooLong(int limit) {
    return 'भुगतानकर्ता $limit वर्णों या उससे कम होना चाहिए';
  }

  @override
  String locationTooLong(int limit) {
    return 'स्थान $limit वर्णों या उससे कम होना चाहिए';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'विवरण $limit वर्ण या उससे कम होना चाहिए';
  }

  @override
  String get amountIsRequired => 'राशि आवश्यक है';

  @override
  String get enterValidAmount => 'कृपया एक वैध राशि दर्ज करें';

  @override
  String get amountMustBePositive => 'राशि धनात्मक होनी चाहिए';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName आवश्यक है';
  }

  @override
  String get destinationIsRequired => 'गंतव्य आवश्यक है';

  @override
  String destinationTooLong(int limit) {
    return 'गंतव्य $limit वर्णों या उससे कम होना चाहिए';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (वैकल्पिक)';
  }

  @override
  String maxCharacters(int maxLength) {
    return '$maxLength अधिकतम';
  }

  @override
  String get searchTripsPlaceholder => 'यात्राएं खोजें...';

  @override
  String allWithTotal(int total) {
    return 'सभी ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'आगामी ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'सक्रिय ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'पूर्ण ($count)';
  }

  @override
  String get yourTripsTitle => 'आपकी यात्राएं';

  @override
  String activeTripsCount(int count) {
    return '$count सक्रिय';
  }

  @override
  String get bookingsTabTitle => 'बुकिंग्स';

  @override
  String get expensesTabTitle => 'खर्च';

  @override
  String get overviewTabTitle => 'अवलोकन';

  @override
  String get todoTabTitle => 'करने के लिए';

  @override
  String get itineraryTabTitle => 'यात्रा कार्यक्रम';

  @override
  String get failedToLoadTrip => 'यात्रा लोड करने में विफल';

  @override
  String get tripNotFound => 'यात्रा नहीं मिली';

  @override
  String get saveImage => 'छवि सेव करें';

  @override
  String get saveToPhotos => 'फोटोज़ में सेव करें';

  @override
  String get saveToPhotosDescription => 'सीधे अपनी फोटो गैलरी में सेव करें';

  @override
  String get saveToFiles => 'फाइलों में सेव करें';

  @override
  String get saveToFilesDescription => 'सेव करने के लिए विशिष्ट फोल्डर चुनें';

  @override
  String get imageSavedToPhotos => 'छवि फोटोज़ में सेव की गई';

  @override
  String get fileSavedSuccessfully => 'फाइल सफलतापूर्वक सेव की गई';

  @override
  String get open => 'खोलें';

  @override
  String errorDownloadingFile(String error) {
    return 'फाइल डाउनलोड करने में त्रुटि: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'फोटोज़ में सेव करने में त्रुटि: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'फाइल सेव करने में त्रुटि: $error';
  }

  @override
  String get selectDocument => 'दस्तावेज़ चुनें';

  @override
  String get chooseFromGalleryTitle => 'गैलरी से चुनें';

  @override
  String get chooseFromGalleryDescription => 'फोटो लाइब्रेरी से चुनें';

  @override
  String get chooseFileTitle => 'फाइल चुनें';

  @override
  String get chooseFileDescription => 'PDF या अन्य फाइलें चुनें';

  @override
  String get failedToCaptureImage => 'छवि कैप्चर करने में विफल';

  @override
  String get failedToSelectImage => 'छवि चुनने में विफल';

  @override
  String get failedToSelectFile => 'फाइल चुनने में विफल';

  @override
  String get documentAddedSuccessfully => 'दस्तावेज़ सफलतापूर्वक जोड़ा गया';

  @override
  String get documentUpdatedSuccessfully =>
      'दस्तावेज़ सफलतापूर्वक अपडेट किया गया';

  @override
  String get failedToSaveDocument => 'दस्तावेज़ सेव करने में विफल';

  @override
  String get documentTitle => 'दस्तावेज़ शीर्षक *';

  @override
  String get documentCategory => 'दस्तावेज़ श्रेणी';

  @override
  String get changeDocument => 'दस्तावेज़ बदलें';

  @override
  String get documentsTitle => 'दस्तावेज़';

  @override
  String get noDocumentsYet => 'अभी तक कोई दस्तावेज़ नहीं';

  @override
  String get noDocumentsFound => 'कोई दस्तावेज़ नहीं मिला';

  @override
  String get clearSearch => 'खोज साफ करें';

  @override
  String get documentDetails => 'दस्तावेज़ विवरण';

  @override
  String get fileSize => 'फ़ाइल का आकार';

  @override
  String get fileName => 'फ़ाइल का नाम';

  @override
  String get deleteDocument => 'दस्तावेज़ हटाएं';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'क्या आप वाकई \"$title\" को हटाना चाहते हैं? यह क्रिया पूर्ववत नहीं की जा सकती।';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'दस्तावेज़ \"$title\" सफलतापूर्वक हटाया गया';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'दस्तावेज़ हटाने में विफल: $error';
  }

  @override
  String get location => 'स्थान';

  @override
  String get activityTitleLabel => 'गतिविधि शीर्षक';

  @override
  String get activityTypeLabel => 'गतिविधि प्रकार';

  @override
  String get expenseTitleLabel => 'खर्च शीर्षक';

  @override
  String get destinations => 'गंतव्य';

  @override
  String get currency => 'मुद्रा';

  @override
  String get tripInProgressStatus => 'यात्रा चल रही है';

  @override
  String get completedStatus => 'पूर्ण';

  @override
  String get tripDates => 'यात्रा की तारीखें';

  @override
  String get expenseType => 'खर्च';

  @override
  String get expenseDetailsTitle => 'खर्च विवरण';

  @override
  String get activityDetailsTitle => 'गतिविधि विवरण';

  @override
  String get deleteActivity => 'गतिविधि हटाएं';

  @override
  String get deleteBooking => 'बुकिंग हटाएं';

  @override
  String get january => 'जनवरी';

  @override
  String get february => 'फरवरी';

  @override
  String get march => 'मार्च';

  @override
  String get april => 'अप्रैल';

  @override
  String get may => 'मई';

  @override
  String get june => 'जून';

  @override
  String get july => 'जुलाई';

  @override
  String get august => 'अगस्त';

  @override
  String get september => 'सितंबर';

  @override
  String get october => 'अक्टूबर';

  @override
  String get november => 'नवंबर';

  @override
  String get december => 'दिसंबर';

  @override
  String get food => 'भोजन';

  @override
  String get confirmed => 'पुष्टि';

  @override
  String get cancelled => 'रद्द';

  @override
  String get passport => 'पासपोर्ट';

  @override
  String get visa => 'वीज़ा';

  @override
  String get ticket => 'टिकट';

  @override
  String get hotel => 'होटल';

  @override
  String get insurance => 'बीमा';

  @override
  String get editDocument => 'दस्तावेज़ संपादित करें';

  @override
  String get updateDocument => 'दस्तावेज़ अपडेट करें';

  @override
  String get saveToGallery => 'गैलरी में सेव करें';

  @override
  String get flight => 'फ्लाइट';

  @override
  String get restaurant => 'रेस्टोरेंट';

  @override
  String get bookingLimitReached =>
      'बुकिंग सीमा पूरी हो गई। आप प्रति यात्रा केवल 15 बुकिंग जोड़ सकते हैं।';

  @override
  String get documentLimitReached =>
      'दस्तावेज़ सीमा पूरी हो गई। आप कुल मिलाकर केवल 10 दस्तावेज़ जोड़ सकते हैं।';

  @override
  String get clearFilters => 'फिल्टर साफ़ करें';

  @override
  String get travelDates => 'यात्रा तिथियां';

  @override
  String get selectDateRange => 'तारीख रेंज चुनें';

  @override
  String get activityDetails => 'गतिविधि विवरण';

  @override
  String get quickActions => 'त्वरित क्रियाएं';

  @override
  String get addNewItemsToTrip => 'यात्रा में नए आइटम जोड़ें';

  @override
  String get booking => 'बुकिंग';

  @override
  String get expense => 'खर्च';

  @override
  String get itinerary => 'यात्रा कार्यक्रम';

  @override
  String get duration => 'अवधि';

  @override
  String get noExpensesFound => 'कोई खर्च नहीं मिला';

  @override
  String get noExpensesFoundForCategory =>
      'इस श्रेणी के लिए कोई खर्च नहीं मिला';

  @override
  String get noTasksFound => 'कोई कार्य नहीं मिला';

  @override
  String get noBookingsFound => 'कोई बुकिंग नहीं मिली';

  @override
  String get noTripsFound => 'कोई यात्रा नहीं मिली';

  @override
  String get tryAdjustingFilters => 'फिल्टर समायोजित करने का प्रयास करें';

  @override
  String get searchTasks => 'कार्य खोजें';

  @override
  String get searchBookings => 'बुकिंग खोजें';

  @override
  String get urgentPriority => 'तत्काल';

  @override
  String get highPriority => 'उच्च';

  @override
  String get mediumPriority => 'मध्यम';

  @override
  String get lowPriority => 'निम्न';

  @override
  String get overdue => 'विलंबित';

  @override
  String get dueToday => 'आज देय';

  @override
  String get dueTomorrow => 'कल देय';

  @override
  String get activeStatus => 'सक्रिय स्थिति';

  @override
  String get selectBackupFile => 'बैकअप फाइल चुनें';

  @override
  String get selectFile => 'फाइल चुनें';

  @override
  String get importBackup => 'बैकअप आयात करें';

  @override
  String get importSuccessful => 'आयात सफल';

  @override
  String get importFailed => 'आयात असफल';

  @override
  String get couldNotOpenAppStore => 'ऐप स्टोर नहीं खोला जा सका';

  @override
  String get couldNotOpenHelpSection => 'सहायता अनुभाग नहीं खोला जा सका';

  @override
  String get couldNotOpenPrivacyPolicy => 'गोपनीयता नीति नहीं खोली जा सकी';

  @override
  String get couldNotOpenTermsOfService => 'सेवा की शर्तें नहीं खोली जा सकीं';

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
      'इस फाइल को सुरक्षित रखें — आपको अपना डेटा पुनर्स्थापित करने के लिए इसकी जरूरत होगी!';

  @override
  String get exportFailedTitle => 'निर्यात विफल';

  @override
  String failedToCreateBackup(String error) {
    return 'बैकअप बनाने में विफल: $error';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get deleteEverything => 'सब कुछ हटाएं';

  @override
  String get createBackup => 'बैकअप बनाएं';

  @override
  String get ok => 'OK';
}
