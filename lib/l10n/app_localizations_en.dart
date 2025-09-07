// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tripease';

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
  String get pushNotifications => 'Push Notifications';

  @override
  String get getRemindersAndUpdates => 'Get reminders and updates';

  @override
  String get locationServices => 'Location Services';

  @override
  String get allowLocationBasedFeatures => 'Allow location-based features';

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
}
