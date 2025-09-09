import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
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
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('hi'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('pt'),
    Locale('ru'),
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

  /// Button text for uploading new document
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

  /// Portuguese language
  ///
  /// In en, this message translates to:
  /// **'Português'**
  String get portuguese;

  /// Russian language
  ///
  /// In en, this message translates to:
  /// **'Русский'**
  String get russian;

  /// Arabic language
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get arabic;

  /// Hindi language
  ///
  /// In en, this message translates to:
  /// **'हिन्दी'**
  String get hindi;

  /// Dutch language
  ///
  /// In en, this message translates to:
  /// **'Nederlands'**
  String get dutch;

  /// Title label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Description label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Amount label
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Date label
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// Edit action
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Add action
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Update action
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Close action
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Failed to load error message
  ///
  /// In en, this message translates to:
  /// **'Failed to load'**
  String get failedToLoad;

  /// No data available message
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get noDataYet;

  /// Empty state message for planning
  ///
  /// In en, this message translates to:
  /// **'Start planning your next adventure!'**
  String get startPlanning;

  /// Create trip button
  ///
  /// In en, this message translates to:
  /// **'Create Trip'**
  String get createTrip;

  /// Add document button
  ///
  /// In en, this message translates to:
  /// **'Add Document'**
  String get addDocument;

  /// Add expense button
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get addExpense;

  /// Add activity button text
  ///
  /// In en, this message translates to:
  /// **'Add Activity'**
  String get addActivity;

  /// Add booking button
  ///
  /// In en, this message translates to:
  /// **'Add Booking'**
  String get addBooking;

  /// Total expenses label
  ///
  /// In en, this message translates to:
  /// **'Total Expenses'**
  String get totalExpenses;

  /// To-do items label
  ///
  /// In en, this message translates to:
  /// **'To-Do Items'**
  String get toDoItems;

  /// Expense details title
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expenseDetails;

  /// Expense title field
  ///
  /// In en, this message translates to:
  /// **'Expense Title'**
  String get expenseTitle;

  /// Category field
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Paid by field
  ///
  /// In en, this message translates to:
  /// **'Paid By'**
  String get paidBy;

  /// You pronoun
  ///
  /// In en, this message translates to:
  /// **'You'**
  String get you;

  /// All day option
  ///
  /// In en, this message translates to:
  /// **'All Day'**
  String get allDay;

  /// Start time field
  ///
  /// In en, this message translates to:
  /// **'Start Time'**
  String get startTime;

  /// End time field
  ///
  /// In en, this message translates to:
  /// **'End Time'**
  String get endTime;

  /// Activity title field
  ///
  /// In en, this message translates to:
  /// **'Activity Title'**
  String get activityTitle;

  /// Activity type field
  ///
  /// In en, this message translates to:
  /// **'Activity Type'**
  String get activityType;

  /// Booking title field
  ///
  /// In en, this message translates to:
  /// **'Booking Title'**
  String get bookingTitle;

  /// Activity type for bookings
  ///
  /// In en, this message translates to:
  /// **'Booking'**
  String get bookingType;

  /// Status field
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// Add file button
  ///
  /// In en, this message translates to:
  /// **'Add File'**
  String get addFile;

  /// File not found error
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get fileNotFound;

  /// File moved or deleted message
  ///
  /// In en, this message translates to:
  /// **'The file may have been moved or deleted'**
  String get fileMovedOrDeleted;

  /// Cannot display image error
  ///
  /// In en, this message translates to:
  /// **'Cannot display image'**
  String get cannotDisplayImage;

  /// Open externally button
  ///
  /// In en, this message translates to:
  /// **'Open Externally'**
  String get openExternally;

  /// Failed to read file error
  ///
  /// In en, this message translates to:
  /// **'Failed to read file data'**
  String get failedToReadFile;

  /// Delete expense title
  ///
  /// In en, this message translates to:
  /// **'Delete Expense'**
  String get deleteExpense;

  /// Delete expense confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this expense?'**
  String get deleteExpenseConfirmation;

  /// Expense breakdown title
  ///
  /// In en, this message translates to:
  /// **'Expense Breakdown'**
  String get expenseBreakdown;

  /// Breakdown button
  ///
  /// In en, this message translates to:
  /// **'Breakdown'**
  String get breakdown;

  /// No expenses message
  ///
  /// In en, this message translates to:
  /// **'No Expenses Yet'**
  String get noExpensesYet;

  /// No activities message
  ///
  /// In en, this message translates to:
  /// **'No activities planned'**
  String get noActivitiesPlanned;

  /// Split details label
  ///
  /// In en, this message translates to:
  /// **'Split Details'**
  String get splitDetails;

  /// Edit expense title
  ///
  /// In en, this message translates to:
  /// **'Edit Expense'**
  String get editExpense;

  /// Add new expense title
  ///
  /// In en, this message translates to:
  /// **'Add New Expense'**
  String get addNewExpense;

  /// Edit activity title
  ///
  /// In en, this message translates to:
  /// **'Edit Activity'**
  String get editActivity;

  /// Add new activity title
  ///
  /// In en, this message translates to:
  /// **'Add New Activity'**
  String get addNewActivity;

  /// Edit booking title
  ///
  /// In en, this message translates to:
  /// **'Edit Booking'**
  String get editBooking;

  /// Add new booking title
  ///
  /// In en, this message translates to:
  /// **'Add New Booking'**
  String get addNewBooking;

  /// Update expense button
  ///
  /// In en, this message translates to:
  /// **'Update Expense'**
  String get updateExpense;

  /// Update activity button
  ///
  /// In en, this message translates to:
  /// **'Update Activity'**
  String get updateActivity;

  /// Update booking button
  ///
  /// In en, this message translates to:
  /// **'Update Booking'**
  String get updateBooking;

  /// Transport category
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transport;

  /// Accommodation category
  ///
  /// In en, this message translates to:
  /// **'Accommodation'**
  String get accommodation;

  /// Activities category
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// Shopping category
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get shopping;

  /// Sightseeing category
  ///
  /// In en, this message translates to:
  /// **'Sightseeing'**
  String get sightseeing;

  /// Meal category
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get meal;

  /// Entertainment category
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// Other category
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No bookings message
  ///
  /// In en, this message translates to:
  /// **'No Bookings Yet'**
  String get noBookingsYet;

  /// Add first booking button
  ///
  /// In en, this message translates to:
  /// **'Add First Booking'**
  String get addFirstBooking;

  /// Booking details title
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get bookingDetails;

  /// Vendor label
  ///
  /// In en, this message translates to:
  /// **'Vendor'**
  String get vendor;

  /// Confirmation number label
  ///
  /// In en, this message translates to:
  /// **'Confirmation Number'**
  String get confirmationNumber;

  /// Attachments label
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// Error message when todos fail to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load todos'**
  String get failedToLoadTodos;

  /// Task label
  ///
  /// In en, this message translates to:
  /// **'Task'**
  String get task;

  /// All items with count
  ///
  /// In en, this message translates to:
  /// **'All ({count})'**
  String allWithCount(int count);

  /// No to-do items message
  ///
  /// In en, this message translates to:
  /// **'No To-Do Items'**
  String get noToDoItems;

  /// Message encouraging users to add tasks
  ///
  /// In en, this message translates to:
  /// **'Stay organized by adding tasks for your trip planning!'**
  String get stayOrganizedMessage;

  /// Add first task button
  ///
  /// In en, this message translates to:
  /// **'Add First Task'**
  String get addFirstTask;

  /// Task details title
  ///
  /// In en, this message translates to:
  /// **'Task Details'**
  String get taskDetails;

  /// Completed status
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// Pending status
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// Priority label
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// Due date label
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get dueDate;

  /// Edit task title
  ///
  /// In en, this message translates to:
  /// **'Edit Task'**
  String get editTask;

  /// Add new task title
  ///
  /// In en, this message translates to:
  /// **'Add New Task'**
  String get addNewTask;

  /// Update task button
  ///
  /// In en, this message translates to:
  /// **'Update Task'**
  String get updateTask;

  /// Add task button
  ///
  /// In en, this message translates to:
  /// **'Add Task'**
  String get addTask;

  /// Delete task button
  ///
  /// In en, this message translates to:
  /// **'Delete Task'**
  String get deleteTask;

  /// Delete task confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"? This action cannot be undone.'**
  String deleteTaskConfirmation(String title);

  /// Message encouraging users to add bookings
  ///
  /// In en, this message translates to:
  /// **'Keep track of your flights, hotels, and activities!'**
  String get keepTrackMessage;

  /// Preview not available message
  ///
  /// In en, this message translates to:
  /// **'Preview not available for this file type.\nTap \"Open Externally\" to view with another app.'**
  String get previewNotAvailable;

  /// App version with beta label
  ///
  /// In en, this message translates to:
  /// **'1.0.0 (Beta)'**
  String get appVersionBeta;

  /// Default user name
  ///
  /// In en, this message translates to:
  /// **'John Doe'**
  String get defaultUserName;

  /// Default user email
  ///
  /// In en, this message translates to:
  /// **'john.doe@email.com'**
  String get defaultUserEmail;

  /// Task title field label
  ///
  /// In en, this message translates to:
  /// **'Task Title'**
  String get taskTitle;

  /// Optional description field label
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get descriptionOptional;

  /// Set due date field label
  ///
  /// In en, this message translates to:
  /// **'Set Due Date (Optional)'**
  String get setDueDateOptional;

  /// Due date with specific date format
  ///
  /// In en, this message translates to:
  /// **'Due: {day}/{month}/{year}'**
  String dueWithDate(int day, int month, int year);

  /// Urgent priority level
  ///
  /// In en, this message translates to:
  /// **'Urgent'**
  String get urgent;

  /// High priority level
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// Medium priority level
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Low priority level
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// Error message for task operations
  ///
  /// In en, this message translates to:
  /// **'Failed to {action} task: {error}'**
  String failedToAddUpdateTask(String action, String error);

  /// Vendor/Company field label
  ///
  /// In en, this message translates to:
  /// **'Vendor/Company (Optional)'**
  String get vendorCompanyOptional;

  /// Confirmation number field label
  ///
  /// In en, this message translates to:
  /// **'Confirmation Number (Optional)'**
  String get confirmationNumberOptional;

  /// Amount field with currency
  ///
  /// In en, this message translates to:
  /// **'Amount ({currency})'**
  String amountCurrency(String currency);

  /// Set booking date field label
  ///
  /// In en, this message translates to:
  /// **'Set Booking Date (Optional)'**
  String get setBookingDateOptional;

  /// Date with specific date format
  ///
  /// In en, this message translates to:
  /// **'Date: {day}/{month}/{year}'**
  String dateWithDate(int day, int month, int year);

  /// Attachments section label
  ///
  /// In en, this message translates to:
  /// **'Attachments (Optional)'**
  String get attachmentsOptional;

  /// File upload constraints message
  ///
  /// In en, this message translates to:
  /// **'Max file size: 5MB\nSupported formats: PDF, DOC, DOCX, JPG, PNG, GIF'**
  String get maxFileSizeSupported;

  /// Error message for booking operations
  ///
  /// In en, this message translates to:
  /// **'Failed to {action} booking: {error}'**
  String failedToAddUpdateBooking(String action, String error);

  /// File attachment success message
  ///
  /// In en, this message translates to:
  /// **'{filename} attached successfully'**
  String fileAttachedSuccessfully(String filename);

  /// File size error message
  ///
  /// In en, this message translates to:
  /// **'File size must be less than 5MB'**
  String get fileSizeMustBeLess;

  /// File picker error message
  ///
  /// In en, this message translates to:
  /// **'Failed to pick file: {error}'**
  String failedToPickFile(String error);

  /// File sharing error message
  ///
  /// In en, this message translates to:
  /// **'Error sharing file: {error}'**
  String errorSharingFile(String error);

  /// Unknown value placeholder
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// Edit trip screen title
  ///
  /// In en, this message translates to:
  /// **'Edit Trip'**
  String get editTrip;

  /// Update trip button text
  ///
  /// In en, this message translates to:
  /// **'Update Trip'**
  String get updateTrip;

  /// Success message when trip is updated
  ///
  /// In en, this message translates to:
  /// **'Trip updated successfully'**
  String get tripUpdatedSuccessfully;

  /// Error message when trip update fails
  ///
  /// In en, this message translates to:
  /// **'Failed to update trip'**
  String get failedToUpdateTrip;

  /// Delete trip action
  ///
  /// In en, this message translates to:
  /// **'Delete Trip'**
  String get deleteTrip;

  /// Confirmation message for deleting a trip
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this trip? This action cannot be undone.'**
  String get deleteTripConfirmation;

  /// Success message when trip is deleted
  ///
  /// In en, this message translates to:
  /// **'Trip deleted successfully'**
  String get tripDeletedSuccessfully;

  /// Error message when trip deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete trip'**
  String get failedToDeleteTrip;

  /// Success message when trip is created
  ///
  /// In en, this message translates to:
  /// **'Trip created successfully!'**
  String get tripCreatedSuccessfully;

  /// Error message when trip creation fails
  ///
  /// In en, this message translates to:
  /// **'Failed to create trip'**
  String get failedToCreateTrip;

  /// Error when trying to select end date without start date
  ///
  /// In en, this message translates to:
  /// **'Please select start date first'**
  String get selectStartDateFirst;

  /// Error when no destinations are added
  ///
  /// In en, this message translates to:
  /// **'Please add at least one destination'**
  String get addAtLeastOneDestination;

  /// Error when dates are not selected
  ///
  /// In en, this message translates to:
  /// **'Please select both start and end dates'**
  String get selectBothStartAndEndDates;

  /// Validation error when title is missing
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleIsRequired;

  /// Validation error when title is too long
  ///
  /// In en, this message translates to:
  /// **'Title must be {limit} characters or less'**
  String titleTooLong(int limit);

  /// Validation error when description is too long
  ///
  /// In en, this message translates to:
  /// **'Description must be {limit} characters or less'**
  String descriptionTooLong(int limit);

  /// Validation error when vendor name is too long
  ///
  /// In en, this message translates to:
  /// **'Vendor/Company must be {limit} characters or less'**
  String vendorTooLong(int limit);

  /// Validation error when confirmation number is too long
  ///
  /// In en, this message translates to:
  /// **'Confirmation number must be {limit} characters or less'**
  String confirmationNumberTooLong(int limit);

  /// Validation error when paid by name is too long
  ///
  /// In en, this message translates to:
  /// **'Paid by must be {limit} characters or less'**
  String paidByTooLong(int limit);

  /// Validation error when location is too long
  ///
  /// In en, this message translates to:
  /// **'Location must be {limit} characters or less'**
  String locationTooLong(int limit);

  /// Validation error when itinerary description is too long
  ///
  /// In en, this message translates to:
  /// **'Description must be {limit} characters or less'**
  String itineraryDescriptionTooLong(int limit);

  /// Validation error when amount is missing
  ///
  /// In en, this message translates to:
  /// **'Amount is required'**
  String get amountIsRequired;

  /// Validation error when amount format is invalid
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get enterValidAmount;

  /// Validation error when amount is negative or zero
  ///
  /// In en, this message translates to:
  /// **'Amount must be positive'**
  String get amountMustBePositive;

  /// Generic required field validation error
  ///
  /// In en, this message translates to:
  /// **'{fieldName} is required'**
  String fieldIsRequired(String fieldName);

  /// Validation error when destination is missing
  ///
  /// In en, this message translates to:
  /// **'Destination is required'**
  String get destinationIsRequired;

  /// Validation error when destination name is too long
  ///
  /// In en, this message translates to:
  /// **'Destination must be {limit} characters or less'**
  String destinationTooLong(int limit);

  /// Label for optional fields
  ///
  /// In en, this message translates to:
  /// **'{labelText} (Optional)'**
  String fieldOptional(String labelText);

  /// Character limit indicator
  ///
  /// In en, this message translates to:
  /// **'{maxLength} max'**
  String maxCharacters(int maxLength);

  /// Search input placeholder for trips
  ///
  /// In en, this message translates to:
  /// **'Search trips...'**
  String get searchTripsPlaceholder;

  /// Filter option showing all items with count
  ///
  /// In en, this message translates to:
  /// **'All ({total})'**
  String allWithTotal(int total);

  /// Filter option for upcoming trips with count
  ///
  /// In en, this message translates to:
  /// **'Upcoming ({count})'**
  String upcomingWithCount(int count);

  /// Filter option for active trips with count
  ///
  /// In en, this message translates to:
  /// **'Active ({count})'**
  String activeWithCount(int count);

  /// Filter option for completed trips with count
  ///
  /// In en, this message translates to:
  /// **'Completed ({count})'**
  String completedWithCount(int count);

  /// Section title for user's trips
  ///
  /// In en, this message translates to:
  /// **'Your Trips'**
  String get yourTripsTitle;

  /// Active trips counter
  ///
  /// In en, this message translates to:
  /// **'{count} Active'**
  String activeTripsCount(int count);

  /// Bookings tab title in trip detail screen
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookingsTabTitle;

  /// Expenses tab title in trip detail screen
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesTabTitle;

  /// Overview tab title in trip detail screen
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overviewTabTitle;

  /// To-Do tab title in trip detail screen
  ///
  /// In en, this message translates to:
  /// **'To-Do'**
  String get todoTabTitle;

  /// Itinerary tab title in trip detail screen
  ///
  /// In en, this message translates to:
  /// **'Itinerary'**
  String get itineraryTabTitle;

  /// Error message when trip fails to load
  ///
  /// In en, this message translates to:
  /// **'Failed to load trip'**
  String get failedToLoadTrip;

  /// Error message when trip is not found
  ///
  /// In en, this message translates to:
  /// **'Trip not found'**
  String get tripNotFound;

  /// Dialog title for saving images
  ///
  /// In en, this message translates to:
  /// **'Save Image'**
  String get saveImage;

  /// Option to save image to photo gallery
  ///
  /// In en, this message translates to:
  /// **'Save to Photos'**
  String get saveToPhotos;

  /// Description for save to photos option
  ///
  /// In en, this message translates to:
  /// **'Save directly to your photo gallery'**
  String get saveToPhotosDescription;

  /// Option to save file to specific location
  ///
  /// In en, this message translates to:
  /// **'Save to Files'**
  String get saveToFiles;

  /// Description for save to files option
  ///
  /// In en, this message translates to:
  /// **'Choose a specific folder to save'**
  String get saveToFilesDescription;

  /// Success message when image is saved to photos
  ///
  /// In en, this message translates to:
  /// **'Image saved to Photos'**
  String get imageSavedToPhotos;

  /// Success message when file is saved
  ///
  /// In en, this message translates to:
  /// **'File saved successfully'**
  String get fileSavedSuccessfully;

  /// Action to open something
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Error message when file download fails
  ///
  /// In en, this message translates to:
  /// **'Error downloading file: {error}'**
  String errorDownloadingFile(String error);

  /// Error message when saving to photos fails
  ///
  /// In en, this message translates to:
  /// **'Error saving to Photos: {error}'**
  String errorSavingToPhotos(String error);

  /// Error message when saving file fails
  ///
  /// In en, this message translates to:
  /// **'Error saving file: {error}'**
  String errorSavingFile(String error);

  /// Dialog title for selecting documents
  ///
  /// In en, this message translates to:
  /// **'Select Document'**
  String get selectDocument;

  /// Option title for choosing from gallery
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGalleryTitle;

  /// Description for gallery option
  ///
  /// In en, this message translates to:
  /// **'Select from photo library'**
  String get chooseFromGalleryDescription;

  /// Option title for choosing files
  ///
  /// In en, this message translates to:
  /// **'Choose File'**
  String get chooseFileTitle;

  /// Description for file picker option
  ///
  /// In en, this message translates to:
  /// **'Select PDF or other files'**
  String get chooseFileDescription;

  /// Error when camera capture fails
  ///
  /// In en, this message translates to:
  /// **'Failed to capture image'**
  String get failedToCaptureImage;

  /// Error when image selection fails
  ///
  /// In en, this message translates to:
  /// **'Failed to select image'**
  String get failedToSelectImage;

  /// Error when file selection fails
  ///
  /// In en, this message translates to:
  /// **'Failed to select file'**
  String get failedToSelectFile;

  /// Success message when document is added
  ///
  /// In en, this message translates to:
  /// **'Document added successfully'**
  String get documentAddedSuccessfully;

  /// Success message when document is updated
  ///
  /// In en, this message translates to:
  /// **'Document updated successfully'**
  String get documentUpdatedSuccessfully;

  /// Error message when document save fails
  ///
  /// In en, this message translates to:
  /// **'Failed to save document'**
  String get failedToSaveDocument;

  /// Required document title field
  ///
  /// In en, this message translates to:
  /// **'Document Title *'**
  String get documentTitle;

  /// Document category field
  ///
  /// In en, this message translates to:
  /// **'Document Category'**
  String get documentCategory;

  /// Button text for changing existing document
  ///
  /// In en, this message translates to:
  /// **'Change Document'**
  String get changeDocument;

  /// Documents screen title
  ///
  /// In en, this message translates to:
  /// **'Documents'**
  String get documentsTitle;

  /// Empty state message when no documents exist
  ///
  /// In en, this message translates to:
  /// **'No documents yet'**
  String get noDocumentsYet;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No documents found'**
  String get noDocumentsFound;

  /// Button to clear search filters
  ///
  /// In en, this message translates to:
  /// **'Clear search'**
  String get clearSearch;

  /// Dialog title for document details
  ///
  /// In en, this message translates to:
  /// **'Document Details'**
  String get documentDetails;

  /// Label for file size information
  ///
  /// In en, this message translates to:
  /// **'File Size'**
  String get fileSize;

  /// Label for file name information
  ///
  /// In en, this message translates to:
  /// **'File Name'**
  String get fileName;

  /// Dialog title for deleting document
  ///
  /// In en, this message translates to:
  /// **'Delete Document'**
  String get deleteDocument;

  /// Confirmation message for deleting document
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{title}\"? This action cannot be undone.'**
  String deleteDocumentConfirmation(String title);

  /// Success message when document is deleted
  ///
  /// In en, this message translates to:
  /// **'Document \"{title}\" deleted successfully'**
  String documentDeletedSuccessfully(String title);

  /// Error message when document deletion fails
  ///
  /// In en, this message translates to:
  /// **'Failed to delete document: {error}'**
  String failedToDeleteDocument(String error);

  /// Location field label
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Activity title field label
  ///
  /// In en, this message translates to:
  /// **'Activity Title'**
  String get activityTitleLabel;

  /// Activity type field label
  ///
  /// In en, this message translates to:
  /// **'Activity Type'**
  String get activityTypeLabel;

  /// Expense title field label
  ///
  /// In en, this message translates to:
  /// **'Expense Title'**
  String get expenseTitleLabel;

  /// Destinations field label
  ///
  /// In en, this message translates to:
  /// **'Destinations'**
  String get destinations;

  /// Currency field label
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Status text for ongoing trips
  ///
  /// In en, this message translates to:
  /// **'Trip in Progress'**
  String get tripInProgressStatus;

  /// Status text for completed items
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completedStatus;

  /// Section header for trip dates
  ///
  /// In en, this message translates to:
  /// **'Trip Dates'**
  String get tripDates;

  /// Activity type for expenses
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expenseType;

  /// Dialog title for expense details
  ///
  /// In en, this message translates to:
  /// **'Expense Details'**
  String get expenseDetailsTitle;

  /// Dialog title for activity details
  ///
  /// In en, this message translates to:
  /// **'Activity Details'**
  String get activityDetailsTitle;

  /// Dialog title for deleting activity
  ///
  /// In en, this message translates to:
  /// **'Delete Activity'**
  String get deleteActivity;

  /// Dialog title for deleting booking
  ///
  /// In en, this message translates to:
  /// **'Delete Booking'**
  String get deleteBooking;

  /// January month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get january;

  /// February month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get february;

  /// March month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get march;

  /// April month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get april;

  /// May month abbreviation
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// June month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get june;

  /// July month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get july;

  /// August month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get august;

  /// September month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Sept'**
  String get september;

  /// October month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get october;

  /// November month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get november;

  /// December month abbreviation
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get december;

  /// Food expense category
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get food;

  /// Confirmed status
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// Cancelled status
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// Passport document type
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// Visa document type
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get visa;

  /// Ticket document type
  ///
  /// In en, this message translates to:
  /// **'Ticket'**
  String get ticket;

  /// Hotel document type
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotel;

  /// Insurance document type
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get insurance;

  /// Edit document title
  ///
  /// In en, this message translates to:
  /// **'Edit Document'**
  String get editDocument;

  /// Update document button text
  ///
  /// In en, this message translates to:
  /// **'Update Document'**
  String get updateDocument;

  /// Save to gallery option
  ///
  /// In en, this message translates to:
  /// **'Save to Gallery'**
  String get saveToGallery;
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
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'hi',
    'it',
    'ja',
    'ko',
    'nl',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'hi':
      return AppLocalizationsHi();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
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
