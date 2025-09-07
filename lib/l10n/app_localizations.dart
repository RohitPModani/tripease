import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Tripease'**
  String get appTitle;

  /// Trips tab title
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// Documents tab title
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documents;

  /// Settings tab title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Quick stats card title
  ///
  /// In en, this message translates to:
  /// **'Quick Stats'**
  String get quickStats;

  /// Active trips label
  ///
  /// In en, this message translates to:
  /// **'Active Trips'**
  String get activeTrips;

  /// Pending tasks label
  ///
  /// In en, this message translates to:
  /// **'Pending Tasks'**
  String get pendingTasks;

  /// Total budget label
  ///
  /// In en, this message translates to:
  /// **'Total Budget'**
  String get totalBudget;

  /// Next trip countdown message
  ///
  /// In en, this message translates to:
  /// **'Next trip starts in {days} days'**
  String nextTripStartsIn(int days);

  /// Your trips section title
  ///
  /// In en, this message translates to:
  /// **'Your Trips'**
  String get yourTrips;

  /// Search trips placeholder
  ///
  /// In en, this message translates to:
  /// **'Search trips...'**
  String get searchTrips;

  /// Sort by days until start
  ///
  /// In en, this message translates to:
  /// **'Days Until Start'**
  String get daysUntilStart;

  /// Sort by date created
  ///
  /// In en, this message translates to:
  /// **'Date Created'**
  String get dateCreated;

  /// Sort alphabetically
  ///
  /// In en, this message translates to:
  /// **'Alphabetical'**
  String get alphabetical;

  /// Budget label
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// Tasks label
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// Trip in progress status
  ///
  /// In en, this message translates to:
  /// **'Trip in Progress'**
  String get tripInProgress;

  /// Trip starting today message
  ///
  /// In en, this message translates to:
  /// **'Starting Today!'**
  String get startingToday;

  /// Days to go message
  ///
  /// In en, this message translates to:
  /// **'{days} days to go'**
  String daysToGo(int days);

  /// Active count label
  ///
  /// In en, this message translates to:
  /// **'{count} Active'**
  String active(int count);

  /// Search documents placeholder
  ///
  /// In en, this message translates to:
  /// **'Search documents...'**
  String get searchDocuments;

  /// Personal documents tab
  ///
  /// In en, this message translates to:
  /// **'Personal'**
  String get personal;

  /// Trip related documents tab
  ///
  /// In en, this message translates to:
  /// **'Trip Related'**
  String get tripRelated;

  /// Upload document title
  ///
  /// In en, this message translates to:
  /// **'Upload Document'**
  String get uploadDocument;

  /// Take photo option
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// Take photo description
  ///
  /// In en, this message translates to:
  /// **'Capture document with camera'**
  String get captureDocumentWithCamera;

  /// Choose from gallery option
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// Choose from gallery description
  ///
  /// In en, this message translates to:
  /// **'Select from photo library'**
  String get selectFromPhotoLibrary;

  /// Choose file option
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get chooseFile;

  /// Choose file description
  ///
  /// In en, this message translates to:
  /// **'Select PDF or other files'**
  String get selectPdfOrOtherFiles;

  /// Document expiry date
  ///
  /// In en, this message translates to:
  /// **'Expires: {date}'**
  String expires(String date);

  /// View action
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// Share action
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Download action
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// Delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Profile section title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Preferences section title
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Dark mode description
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark theme'**
  String get switchBetweenLightAndDarkTheme;

  /// Language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Language description
  ///
  /// In en, this message translates to:
  /// **'Select your preferred language'**
  String get selectYourPreferredLanguage;

  /// Default currency setting
  ///
  /// In en, this message translates to:
  /// **'Default Currency'**
  String get defaultCurrency;

  /// Default currency description
  ///
  /// In en, this message translates to:
  /// **'Currency used for new trips'**
  String get currencyUsedForNewTrips;

  /// Date format setting
  ///
  /// In en, this message translates to:
  /// **'Date Format'**
  String get dateFormat;

  /// Date format description
  ///
  /// In en, this message translates to:
  /// **'How dates are displayed'**
  String get howDatesAreDisplayed;

  /// Temperature unit setting
  ///
  /// In en, this message translates to:
  /// **'Temperature Unit'**
  String get temperatureUnit;

  /// Temperature unit description
  ///
  /// In en, this message translates to:
  /// **'Temperature scale preference'**
  String get temperatureScalePreference;

  /// App settings section title
  ///
  /// In en, this message translates to:
  /// **'App Settings'**
  String get appSettings;

  /// Push notifications setting
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// Push notifications description
  ///
  /// In en, this message translates to:
  /// **'Get reminders and updates'**
  String get getRemindersAndUpdates;

  /// Location services setting
  ///
  /// In en, this message translates to:
  /// **'Location Services'**
  String get locationServices;

  /// Location services description
  ///
  /// In en, this message translates to:
  /// **'Allow location-based features'**
  String get allowLocationBasedFeatures;

  /// Backup and sync setting
  ///
  /// In en, this message translates to:
  /// **'Backup & Sync'**
  String get backupAndSync;

  /// Backup and sync description
  ///
  /// In en, this message translates to:
  /// **'Manage your data backup'**
  String get manageYourDataBackup;

  /// Import data setting
  ///
  /// In en, this message translates to:
  /// **'Import Data'**
  String get importData;

  /// Import data description
  ///
  /// In en, this message translates to:
  /// **'Import trips from other apps'**
  String get importTripsFromOtherApps;

  /// Export data setting
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// Export data description
  ///
  /// In en, this message translates to:
  /// **'Export your trip data'**
  String get exportYourTripData;

  /// About section title
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// App version setting
  ///
  /// In en, this message translates to:
  /// **'App Version'**
  String get appVersion;

  /// Rate app setting
  ///
  /// In en, this message translates to:
  /// **'Rate App'**
  String get rateApp;

  /// Rate app description
  ///
  /// In en, this message translates to:
  /// **'Leave a review on the app store'**
  String get leaveAReviewOnTheAppStore;

  /// Help and support setting
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// Help and support description
  ///
  /// In en, this message translates to:
  /// **'FAQs and contact information'**
  String get faqsAndContactInformation;

  /// Privacy policy setting
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Privacy policy description
  ///
  /// In en, this message translates to:
  /// **'Read our privacy policy'**
  String get readOurPrivacyPolicy;

  /// Terms of service setting
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Terms of service description
  ///
  /// In en, this message translates to:
  /// **'Read our terms and conditions'**
  String get readOurTermsAndConditions;

  /// Danger zone section title
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// Clear all data setting
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// Clear all data description
  ///
  /// In en, this message translates to:
  /// **'Remove all trips and documents'**
  String get removeAllTripsAndDocuments;

  /// Clear all data confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. All your trips, documents, and settings will be permanently deleted.'**
  String get clearAllDataConfirmation;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Clear all button
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// Celsius temperature unit
  ///
  /// In en, this message translates to:
  /// **'Celsius'**
  String get celsius;

  /// Fahrenheit temperature unit
  ///
  /// In en, this message translates to:
  /// **'Fahrenheit'**
  String get fahrenheit;

  /// English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Mandarin Chinese language
  ///
  /// In en, this message translates to:
  /// **'中文'**
  String get mandarin;

  /// Japanese language
  ///
  /// In en, this message translates to:
  /// **'日本語'**
  String get japanese;

  /// Korean language
  ///
  /// In en, this message translates to:
  /// **'한국어'**
  String get korean;

  /// Spanish language
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get spanish;

  /// French language
  ///
  /// In en, this message translates to:
  /// **'Français'**
  String get french;

  /// German language
  ///
  /// In en, this message translates to:
  /// **'Deutsch'**
  String get german;

  /// Italian language
  ///
  /// In en, this message translates to:
  /// **'Italiano'**
  String get italian;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ja',
    'ko',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
