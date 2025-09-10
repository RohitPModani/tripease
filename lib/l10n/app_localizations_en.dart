// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'Trips';

  @override
  String get documents => 'Documents';

  @override
  String get settings => 'Settings';

  @override
  String get quickStats => 'Quick Stats';

  @override
  String get activeTrips => 'Active Trips';

  @override
  String get pendingTasks => 'Pending Tasks';

  @override
  String get totalBudget => 'Total Budget';

  @override
  String nextTripStartsIn(int days) {
    return 'Next trip starts in $days days';
  }

  @override
  String get yourTrips => 'Your Trips';

  @override
  String get searchTrips => 'Search trips...';

  @override
  String get daysUntilStart => 'Days Until Start';

  @override
  String get dateCreated => 'Date Created';

  @override
  String get alphabetical => 'Alphabetical';

  @override
  String get budget => 'Budget';

  @override
  String get tasks => 'Tasks';

  @override
  String get tripInProgress => 'Trip in Progress';

  @override
  String get startingToday => 'Starting Today!';

  @override
  String daysToGo(int days) {
    return '$days days to go';
  }

  @override
  String active(int count) {
    return '$count Active';
  }

  @override
  String get searchDocuments => 'Search documents...';

  @override
  String get personal => 'Personal';

  @override
  String get tripRelated => 'Trip Related';

  @override
  String get uploadDocument => 'Upload Document';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get captureDocumentWithCamera => 'Capture document with camera';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get selectFromPhotoLibrary => 'Select from photo library';

  @override
  String get chooseFile => 'Choose File';

  @override
  String get selectPdfOrOtherFiles => 'Select PDF or other files';

  @override
  String expires(String date) {
    return 'Expires: $date';
  }

  @override
  String get view => 'View';

  @override
  String get share => 'Share';

  @override
  String get download => 'Download';

  @override
  String get delete => 'Delete';

  @override
  String get profile => 'Profile';

  @override
  String get preferences => 'Preferences';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'Switch between light and dark theme';

  @override
  String get language => 'Language';

  @override
  String get selectYourPreferredLanguage => 'Select your preferred language';

  @override
  String get defaultCurrency => 'Default Currency';

  @override
  String get currencyUsedForNewTrips => 'Currency used for new trips';

  @override
  String get dateFormat => 'Date Format';

  @override
  String get howDatesAreDisplayed => 'How dates are displayed';

  @override
  String get temperatureUnit => 'Temperature Unit';

  @override
  String get temperatureScalePreference => 'Temperature scale preference';

  @override
  String get appSettings => 'App Settings';

  @override
  String get backupAndSync => 'Backup & Sync';

  @override
  String get manageYourDataBackup => 'Manage your data backup';

  @override
  String get importData => 'Import Data';

  @override
  String get importTripsFromOtherApps => 'Import trips from other apps';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportYourTripData => 'Export your trip data';

  @override
  String get about => 'About';

  @override
  String get appVersion => 'App Version';

  @override
  String get rateApp => 'Rate App';

  @override
  String get leaveAReviewOnTheAppStore => 'Leave a review on the app store';

  @override
  String get helpAndSupport => 'Help & Support';

  @override
  String get faqsAndContactInformation => 'FAQs and contact information';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get readOurPrivacyPolicy => 'Read our privacy policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get readOurTermsAndConditions => 'Read our terms and conditions';

  @override
  String get dangerZone => 'Danger Zone';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get removeAllTripsAndDocuments => 'Remove all trips and documents';

  @override
  String get clearAllDataConfirmation =>
      'This action cannot be undone. All your trips, documents, and settings will be permanently deleted.';

  @override
  String get cancel => 'Cancel';

  @override
  String get clearAll => 'Clear All';

  @override
  String get celsius => 'Celsius';

  @override
  String get fahrenheit => 'Fahrenheit';

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
  String get title => 'Title';

  @override
  String get description => 'Description';

  @override
  String get amount => 'Amount';

  @override
  String get date => 'Date';

  @override
  String get edit => 'Edit';

  @override
  String get retry => 'Retry';

  @override
  String get add => 'Add';

  @override
  String get update => 'Update';

  @override
  String get close => 'Close';

  @override
  String get failedToLoad => 'Failed to load';

  @override
  String get noDataYet => 'No data yet';

  @override
  String get startPlanning => 'Start planning your next adventure!';

  @override
  String get createTrip => 'Create Trip';

  @override
  String get addDocument => 'Add Document';

  @override
  String get addExpense => 'Add Expense';

  @override
  String get addActivity => 'Add Activity';

  @override
  String get addBooking => 'Add Booking';

  @override
  String get totalExpenses => 'Total Expenses';

  @override
  String get toDoItems => 'To-Do Items';

  @override
  String get expenseDetails => 'Expense Details';

  @override
  String get expenseTitle => 'Expense Title';

  @override
  String get category => 'Category';

  @override
  String get paidBy => 'Paid By';

  @override
  String get you => 'You';

  @override
  String get allDay => 'All Day';

  @override
  String get startTime => 'Start Time';

  @override
  String get endTime => 'End Time';

  @override
  String get activityTitle => 'Activity Title';

  @override
  String get activityType => 'Activity Type';

  @override
  String get bookingTitle => 'Booking Title';

  @override
  String get bookingType => 'Booking';

  @override
  String get status => 'Status';

  @override
  String get addFile => 'Add File';

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileMovedOrDeleted => 'The file may have been moved or deleted';

  @override
  String get cannotDisplayImage => 'Cannot display image';

  @override
  String get openExternally => 'Open Externally';

  @override
  String get failedToReadFile => 'Failed to read file data';

  @override
  String get deleteExpense => 'Delete Expense';

  @override
  String get deleteExpenseConfirmation =>
      'Are you sure you want to delete this expense?';

  @override
  String get expenseBreakdown => 'Expense Breakdown';

  @override
  String get breakdown => 'Breakdown';

  @override
  String get noExpensesYet => 'No Expenses Yet';

  @override
  String get noActivitiesPlanned => 'No activities planned';

  @override
  String get splitDetails => 'Split Details';

  @override
  String get editExpense => 'Edit Expense';

  @override
  String get addNewExpense => 'Add New Expense';

  @override
  String get editActivity => 'Edit Activity';

  @override
  String get addNewActivity => 'Add New Activity';

  @override
  String get editBooking => 'Edit Booking';

  @override
  String get addNewBooking => 'Add New Booking';

  @override
  String get updateExpense => 'Update Expense';

  @override
  String get updateActivity => 'Update Activity';

  @override
  String get updateBooking => 'Update Booking';

  @override
  String get transport => 'Transport';

  @override
  String get accommodation => 'Accommodation';

  @override
  String get activities => 'Activities';

  @override
  String get shopping => 'Shopping';

  @override
  String get sightseeing => 'Sightseeing';

  @override
  String get meal => 'Meal';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get other => 'Other';

  @override
  String get noBookingsYet => 'No Bookings Yet';

  @override
  String get addFirstBooking => 'Add First Booking';

  @override
  String get bookingDetails => 'Booking Details';

  @override
  String get vendor => 'Vendor';

  @override
  String get confirmationNumber => 'Confirmation Number';

  @override
  String get attachments => 'Attachments';

  @override
  String get failedToLoadTodos => 'Failed to load todos';

  @override
  String get task => 'Task';

  @override
  String allWithCount(int count) {
    return 'All ($count)';
  }

  @override
  String get noToDoItems => 'No To-Do Items';

  @override
  String get stayOrganizedMessage =>
      'Stay organized by adding tasks for your trip planning!';

  @override
  String get addFirstTask => 'Add First Task';

  @override
  String get taskDetails => 'Task Details';

  @override
  String get completed => 'Completed';

  @override
  String get pending => 'Pending';

  @override
  String get priority => 'Priority';

  @override
  String get dueDate => 'Due Date';

  @override
  String get editTask => 'Edit Task';

  @override
  String get addNewTask => 'Add New Task';

  @override
  String get updateTask => 'Update Task';

  @override
  String get addTask => 'Add Task';

  @override
  String get deleteTask => 'Delete Task';

  @override
  String deleteTaskConfirmation(String title) {
    return 'Are you sure you want to delete \"$title\"? This action cannot be undone.';
  }

  @override
  String get keepTrackMessage =>
      'Keep track of your flights, hotels, and activities!';

  @override
  String get previewNotAvailable =>
      'Preview not available for this file type.\nTap \"Open Externally\" to view with another app.';

  @override
  String get appVersionBeta => '1.0.0 (Beta)';

  @override
  String get defaultUserName => 'John Doe';

  @override
  String get defaultUserEmail => 'john.doe@email.com';

  @override
  String get taskTitle => 'Task Title';

  @override
  String get descriptionOptional => 'Description (Optional)';

  @override
  String get setDueDateOptional => 'Set Due Date (Optional)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Due: $day/$month/$year';
  }

  @override
  String get urgent => 'Urgent';

  @override
  String get high => 'High';

  @override
  String get medium => 'Medium';

  @override
  String get low => 'Low';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Failed to $action task: $error';
  }

  @override
  String get vendorCompanyOptional => 'Vendor/Company (Optional)';

  @override
  String get confirmationNumberOptional => 'Confirmation Number (Optional)';

  @override
  String amountCurrency(String currency) {
    return 'Amount ($currency)';
  }

  @override
  String get setBookingDateOptional => 'Set Booking Date (Optional)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Date: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Attachments (Optional)';

  @override
  String get maxFileSizeSupported =>
      'Max file size: 5MB\nSupported formats: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Failed to $action booking: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename attached successfully';
  }

  @override
  String get fileSizeMustBeLess => 'File size must be less than 5MB';

  @override
  String failedToPickFile(String error) {
    return 'Failed to pick file: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Error sharing file: $error';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String get editTrip => 'Edit Trip';

  @override
  String get updateTrip => 'Update Trip';

  @override
  String get tripUpdatedSuccessfully => 'Trip updated successfully';

  @override
  String get failedToUpdateTrip => 'Failed to update trip';

  @override
  String get deleteTrip => 'Delete Trip';

  @override
  String get deleteTripConfirmation =>
      'Are you sure you want to delete this trip? This action cannot be undone.';

  @override
  String get tripDeletedSuccessfully => 'Trip deleted successfully';

  @override
  String get failedToDeleteTrip => 'Failed to delete trip';

  @override
  String get tripCreatedSuccessfully => 'Trip created successfully!';

  @override
  String get failedToCreateTrip => 'Failed to create trip';

  @override
  String get selectStartDateFirst => 'Please select start date first';

  @override
  String get addAtLeastOneDestination => 'Please add at least one destination';

  @override
  String get selectBothStartAndEndDates =>
      'Please select both start and end dates';

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
      'Your data will be encrypted and compressed into a .voy file.';

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
  String get fileInfoFormat => '• Format: Encrypted .voy file';

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
