// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'Reizen';

  @override
  String get documents => 'Documenten';

  @override
  String get settings => 'Instellingen';

  @override
  String get quickStats => 'Snelle statistieken';

  @override
  String get activeTrips => 'Actieve reizen';

  @override
  String get pendingTasks => 'Lopende taken';

  @override
  String get totalBudget => 'Totaal budget';

  @override
  String nextTripStartsIn(int days) {
    return 'Volgende reis begint over $days dagen';
  }

  @override
  String get yourTrips => 'Jouw reizen';

  @override
  String get searchTrips => 'Reizen zoeken...';

  @override
  String get daysUntilStart => 'Dagen tot start';

  @override
  String get dateCreated => 'Datum aangemaakt';

  @override
  String get alphabetical => 'Alfabetisch';

  @override
  String get budget => 'Budget';

  @override
  String get tasks => 'Taken';

  @override
  String get tripInProgress => 'Reis in uitvoering';

  @override
  String get startingToday => 'Begint vandaag!';

  @override
  String daysToGo(int days) {
    return '$days dagen te gaan';
  }

  @override
  String active(int count) {
    return '$count actief';
  }

  @override
  String get searchDocuments => 'Documenten zoeken...';

  @override
  String get personal => 'Persoonlijk';

  @override
  String get tripRelated => 'Reis gerelateerd';

  @override
  String get uploadDocument => 'Document uploaden';

  @override
  String get takePhoto => 'Foto maken';

  @override
  String get captureDocumentWithCamera => 'Document vastleggen met camera';

  @override
  String get chooseFromGallery => 'Kiezen uit galerij';

  @override
  String get selectFromPhotoLibrary => 'Selecteren uit fotobibliotheek';

  @override
  String get chooseFile => 'Bestand kiezen';

  @override
  String get selectPdfOrOtherFiles => 'PDF of andere bestanden selecteren';

  @override
  String expires(String date) {
    return 'Verloopt: $date';
  }

  @override
  String get view => 'Bekijken';

  @override
  String get share => 'Delen';

  @override
  String get download => 'Downloaden';

  @override
  String get delete => 'Verwijderen';

  @override
  String get profile => 'Profiel';

  @override
  String get preferences => 'Voorkeuren';

  @override
  String get darkMode => 'Donkere modus';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'Schakel tussen licht en donker thema';

  @override
  String get language => 'Taal';

  @override
  String get selectYourPreferredLanguage => 'Selecteer je voorkeurstaal';

  @override
  String get defaultCurrency => 'Standaard valuta';

  @override
  String get currencyUsedForNewTrips => 'Valuta voor nieuwe reizen';

  @override
  String get dateFormat => 'Datumformaat';

  @override
  String get howDatesAreDisplayed => 'Hoe datums worden weergegeven';

  @override
  String get temperatureUnit => 'Temperatuur eenheid';

  @override
  String get temperatureScalePreference => 'Temperatuurschaal voorkeur';

  @override
  String get appSettings => 'App instellingen';

  @override
  String get backupAndSync => 'Back-up en synchronisatie';

  @override
  String get manageYourDataBackup => 'Je data back-up beheren';

  @override
  String get importData => 'Gegevens importeren';

  @override
  String get importTripsFromOtherApps => 'Reizen uit andere apps importeren';

  @override
  String get exportData => 'Gegevens exporteren';

  @override
  String get exportYourTripData => 'Je reisgegevens exporteren';

  @override
  String get about => 'Over';

  @override
  String get appVersion => 'App versie';

  @override
  String get rateApp => 'App beoordelen';

  @override
  String get leaveAReviewOnTheAppStore =>
      'Laat een review achter in de app store';

  @override
  String get helpAndSupport => 'Help en ondersteuning';

  @override
  String get faqsAndContactInformation => 'FAQ\'s en contactinformatie';

  @override
  String get privacyPolicy => 'Privacybeleid';

  @override
  String get readOurPrivacyPolicy => 'Lees ons privacybeleid';

  @override
  String get termsOfService => 'Servicevoorwaarden';

  @override
  String get readOurTermsAndConditions => 'Lees onze algemene voorwaarden';

  @override
  String get dangerZone => 'Gevaarzone';

  @override
  String get clearAllData => 'Alle gegevens wissen';

  @override
  String get removeAllTripsAndDocuments =>
      'Alle reizen en documenten verwijderen';

  @override
  String get clearAllDataConfirmation =>
      'Deze actie kan niet ongedaan gemaakt worden. Al je reizen, documenten en instellingen worden permanent verwijderd.';

  @override
  String get cancel => 'Annuleren';

  @override
  String get clearAll => 'Alles wissen';

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
  String get title => 'Titel';

  @override
  String get description => 'Beschrijving';

  @override
  String get amount => 'Bedrag';

  @override
  String get date => 'Datum';

  @override
  String get edit => 'Bewerken';

  @override
  String get retry => 'Opnieuw proberen';

  @override
  String get add => 'Toevoegen';

  @override
  String get update => 'Bijwerken';

  @override
  String get close => 'Sluiten';

  @override
  String get failedToLoad => 'Mislukt om te laden';

  @override
  String get noDataYet => 'Nog geen gegevens';

  @override
  String get startPlanning => 'Begin met plannen van je volgende avontuur!';

  @override
  String get createTrip => 'Reis aanmaken';

  @override
  String get addDocument => 'Document toevoegen';

  @override
  String get addExpense => 'Uitgave toevoegen';

  @override
  String get addActivity => 'Activiteit toevoegen';

  @override
  String get addBooking => 'Boeking toevoegen';

  @override
  String get totalExpenses => 'Totale uitgaven';

  @override
  String get toDoItems => 'Takenlijst';

  @override
  String get expenseDetails => 'Uitgave Details';

  @override
  String get expenseTitle => 'Uitgave titel';

  @override
  String get category => 'Categorie';

  @override
  String get paidBy => 'Betaald door';

  @override
  String get you => 'Jij';

  @override
  String get allDay => 'Hele dag';

  @override
  String get startTime => 'Starttijd';

  @override
  String get endTime => 'Eindtijd';

  @override
  String get activityTitle => 'Activiteit titel';

  @override
  String get activityType => 'Activiteit type';

  @override
  String get bookingTitle => 'Boeking Titel';

  @override
  String get bookingType => 'Boeking type';

  @override
  String get status => 'Status';

  @override
  String get addFile => 'Bestand toevoegen';

  @override
  String get fileNotFound => 'Bestand niet gevonden';

  @override
  String get fileMovedOrDeleted =>
      'Het bestand is mogelijk verplaatst of verwijderd';

  @override
  String get cannotDisplayImage => 'Kan afbeelding niet weergeven';

  @override
  String get openExternally => 'Extern openen';

  @override
  String get failedToReadFile => 'Mislukt om bestandsgegevens te lezen';

  @override
  String get deleteExpense => 'Uitgave verwijderen';

  @override
  String get deleteExpenseConfirmation =>
      'Weet je zeker dat je deze uitgave wilt verwijderen?';

  @override
  String get expenseBreakdown => 'Uitgaven uitsplitsing';

  @override
  String get breakdown => 'Uitsplitsing';

  @override
  String get noExpensesYet => 'Nog geen uitgaven';

  @override
  String get noActivitiesPlanned => 'Geen activiteiten gepland';

  @override
  String get splitDetails => 'Verdeel Details';

  @override
  String get editExpense => 'Uitgave bewerken';

  @override
  String get addNewExpense => 'Nieuwe uitgave toevoegen';

  @override
  String get editActivity => 'Activiteit bewerken';

  @override
  String get addNewActivity => 'Nieuwe activiteit toevoegen';

  @override
  String get editBooking => 'Boeking bewerken';

  @override
  String get addNewBooking => 'Nieuwe boeking toevoegen';

  @override
  String get updateExpense => 'Uitgave bijwerken';

  @override
  String get updateActivity => 'Activiteit bijwerken';

  @override
  String get updateBooking => 'Boeking bijwerken';

  @override
  String get transport => 'Vervoer';

  @override
  String get accommodation => 'Accommodatie';

  @override
  String get activities => 'Activiteiten';

  @override
  String get shopping => 'Winkelen';

  @override
  String get sightseeing => 'Sightseeing';

  @override
  String get meal => 'Maaltijd';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get other => 'Overig';

  @override
  String get noBookingsYet => 'Nog Geen Boekingen';

  @override
  String get addFirstBooking => 'Eerste boeking toevoegen';

  @override
  String get bookingDetails => 'Boeking details';

  @override
  String get vendor => 'Leverancier';

  @override
  String get confirmationNumber => 'Bevestigingsnummer';

  @override
  String get attachments => 'Bijlagen';

  @override
  String get failedToLoadTodos => 'Mislukt om taken te laden';

  @override
  String get task => 'Taak';

  @override
  String allWithCount(int count) {
    return 'Alle ($count)';
  }

  @override
  String get noToDoItems => 'Geen taken';

  @override
  String get stayOrganizedMessage =>
      'Blijf georganiseerd door taken toe te voegen voor je reisplanning!';

  @override
  String get addFirstTask => 'Eerste taak toevoegen';

  @override
  String get taskDetails => 'Taak Details';

  @override
  String get completed => 'Voltooid';

  @override
  String get pending => 'In behandeling';

  @override
  String get priority => 'Prioriteit';

  @override
  String get dueDate => 'Vervaldatum';

  @override
  String get editTask => 'Taak bewerken';

  @override
  String get addNewTask => 'Nieuwe taak toevoegen';

  @override
  String get updateTask => 'Taak bijwerken';

  @override
  String get addTask => 'Taak toevoegen';

  @override
  String get deleteTask => 'Taak verwijderen';

  @override
  String deleteTaskConfirmation(String title) {
    return 'Weet je zeker dat je \"$title\" wilt verwijderen? Deze actie kan niet ongedaan gemaakt worden.';
  }

  @override
  String get keepTrackMessage =>
      'Houd je vluchten, hotels en activiteiten bij!';

  @override
  String get previewNotAvailable =>
      'Voorbeeld niet beschikbaar voor dit bestandstype.\nTik op \"Extern openen\" om te bekijken met een andere app.';

  @override
  String get appVersionBeta => '1.0.0 (Beta)';

  @override
  String get defaultUserName => 'John Doe';

  @override
  String get defaultUserEmail => 'john.doe@email.com';

  @override
  String get taskTitle => 'Taak titel';

  @override
  String get descriptionOptional => 'Beschrijving (optioneel)';

  @override
  String get setDueDateOptional => 'Vervaldatum instellen (optioneel)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Vervalt: $day/$month/$year';
  }

  @override
  String get urgent => 'Urgent';

  @override
  String get high => 'Hoog';

  @override
  String get medium => 'Gemiddeld';

  @override
  String get low => 'Laag';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Mislukt om taak te $action: $error';
  }

  @override
  String get vendorCompanyOptional => 'Leverancier/Bedrijf (optioneel)';

  @override
  String get confirmationNumberOptional => 'Bevestigingsnummer (optioneel)';

  @override
  String amountCurrency(String currency) {
    return 'Bedrag ($currency)';
  }

  @override
  String get setBookingDateOptional => 'Boekingsdatum instellen (optioneel)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Datum: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Bijlagen (optioneel)';

  @override
  String get maxFileSizeSupported =>
      'Max bestandsgrootte: 5MB\nOndersteunde formaten: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Mislukt om boeking te $action: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename succesvol bijgevoegd';
  }

  @override
  String get fileSizeMustBeLess => 'Bestandsgrootte moet minder dan 5MB zijn';

  @override
  String failedToPickFile(String error) {
    return 'Mislukt om bestand te kiezen: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Fout bij delen bestand: $error';
  }

  @override
  String get unknown => 'Onbekend';

  @override
  String get editTrip => 'Reis bewerken';

  @override
  String get updateTrip => 'Reis bijwerken';

  @override
  String get tripUpdatedSuccessfully => 'Reis succesvol bijgewerkt';

  @override
  String get failedToUpdateTrip => 'Mislukt om reis bij te werken';

  @override
  String get deleteTrip => 'Reis verwijderen';

  @override
  String get deleteTripConfirmation =>
      'Weet je zeker dat je deze reis wilt verwijderen? Deze actie kan niet ongedaan gemaakt worden.';

  @override
  String get tripDeletedSuccessfully => 'Reis succesvol verwijderd';

  @override
  String get failedToDeleteTrip => 'Mislukt om reis te verwijderen';

  @override
  String get tripCreatedSuccessfully => 'Reis succesvol aangemaakt!';

  @override
  String get failedToCreateTrip => 'Mislukt om reis aan te maken';

  @override
  String get selectStartDateFirst => 'Selecteer eerst de startdatum';

  @override
  String get addAtLeastOneDestination => 'Voeg minstens één bestemming toe';

  @override
  String get selectBothStartAndEndDates =>
      'Selecteer zowel start- als einddatum';

  @override
  String get titleIsRequired => 'Titel is verplicht';

  @override
  String titleTooLong(int limit) {
    return 'Titel moet $limit tekens of minder zijn';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'Beschrijving moet $limit tekens of minder zijn';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Leverancier/Bedrijf moet $limit tekens of minder zijn';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'Bevestigingsnummer moet $limit tekens of minder zijn';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Betaald door moet $limit tekens of minder zijn';
  }

  @override
  String locationTooLong(int limit) {
    return 'Locatie moet $limit tekens of minder zijn';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'Beschrijving moet $limit tekens of minder zijn';
  }

  @override
  String get amountIsRequired => 'Bedrag is verplicht';

  @override
  String get enterValidAmount => 'Voer een geldig bedrag in';

  @override
  String get amountMustBePositive => 'Bedrag moet positief zijn';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName is verplicht';
  }

  @override
  String get destinationIsRequired => 'Bestemming is verplicht';

  @override
  String destinationTooLong(int limit) {
    return 'Bestemming moet $limit tekens of minder zijn';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (optioneel)';
  }

  @override
  String maxCharacters(int maxLength) {
    return '$maxLength max';
  }

  @override
  String get searchTripsPlaceholder => 'Zoek reizen...';

  @override
  String allWithTotal(int total) {
    return 'Alle ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'Aankomend ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Actief ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Voltooid ($count)';
  }

  @override
  String get yourTripsTitle => 'Jouw reizen';

  @override
  String activeTripsCount(int count) {
    return '$count actief';
  }

  @override
  String get bookingsTabTitle => 'Boekingen';

  @override
  String get expensesTabTitle => 'Uitgaven';

  @override
  String get overviewTabTitle => 'Overzicht';

  @override
  String get todoTabTitle => 'Taken';

  @override
  String get itineraryTabTitle => 'Itinerary';

  @override
  String get failedToLoadTrip => 'Laden van reis mislukt';

  @override
  String get tripNotFound => 'Reis niet gevonden';

  @override
  String get saveImage => 'Afbeelding opslaan';

  @override
  String get saveToPhotos => 'Opslaan in foto\'s';

  @override
  String get saveToPhotosDescription => 'Direct opslaan in je fotogalerij';

  @override
  String get saveToFiles => 'Opslaan in bestanden';

  @override
  String get saveToFilesDescription => 'Kies een specifieke map om op te slaan';

  @override
  String get imageSavedToPhotos => 'Afbeelding opgeslagen in foto\'s';

  @override
  String get fileSavedSuccessfully => 'Bestand succesvol opgeslagen';

  @override
  String get open => 'Openen';

  @override
  String errorDownloadingFile(String error) {
    return 'Fout bij downloaden bestand: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Fout bij opslaan naar foto\'s: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Fout bij opslaan bestand: $error';
  }

  @override
  String get selectDocument => 'Document selecteren';

  @override
  String get chooseFromGalleryTitle => 'Kiezen uit galerij';

  @override
  String get chooseFromGalleryDescription => 'Selecteren uit fotobibliotheek';

  @override
  String get chooseFileTitle => 'Bestand kiezen';

  @override
  String get chooseFileDescription => 'PDF of andere bestanden selecteren';

  @override
  String get failedToCaptureImage => 'Mislukt om afbeelding vast te leggen';

  @override
  String get failedToSelectImage => 'Mislukt om afbeelding te selecteren';

  @override
  String get failedToSelectFile => 'Mislukt om bestand te selecteren';

  @override
  String get documentAddedSuccessfully => 'Document succesvol toegevoegd';

  @override
  String get documentUpdatedSuccessfully => 'Document succesvol bijgewerkt';

  @override
  String get failedToSaveDocument => 'Mislukt om document op te slaan';

  @override
  String get documentTitle => 'Document titel *';

  @override
  String get documentCategory => 'Document categorie';

  @override
  String get changeDocument => 'Document wijzigen';

  @override
  String get documentsTitle => 'Documenten';

  @override
  String get noDocumentsYet => 'Nog geen documenten';

  @override
  String get noDocumentsFound => 'Geen documenten gevonden';

  @override
  String get clearSearch => 'Zoeken wissen';

  @override
  String get documentDetails => 'Documentdetails';

  @override
  String get fileSize => 'Bestandsgrootte';

  @override
  String get fileName => 'Bestandsnaam';

  @override
  String get deleteDocument => 'Document verwijderen';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Weet je zeker dat je \"$title\" wilt verwijderen? Deze actie kan niet ongedaan gemaakt worden.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Document \"$title\" succesvol verwijderd';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Mislukt om document te verwijderen: $error';
  }

  @override
  String get location => 'Locatie';

  @override
  String get activityTitleLabel => 'Activiteit titel';

  @override
  String get activityTypeLabel => 'Activiteit type';

  @override
  String get expenseTitleLabel => 'Uitgave titel';

  @override
  String get destinations => 'Bestemmingen';

  @override
  String get currency => 'Valuta';

  @override
  String get tripInProgressStatus => 'Reis bezig';

  @override
  String get completedStatus => 'Voltooid';

  @override
  String get tripDates => 'Reisdata';

  @override
  String get expenseType => 'Uitgave';

  @override
  String get expenseDetailsTitle => 'Uitgave details';

  @override
  String get activityDetailsTitle => 'Activiteit details';

  @override
  String get deleteActivity => 'Activiteit verwijderen';

  @override
  String get deleteBooking => 'Boeking verwijderen';

  @override
  String get january => 'Januari';

  @override
  String get february => 'Februari';

  @override
  String get march => 'Maart';

  @override
  String get april => 'April';

  @override
  String get may => 'Mei';

  @override
  String get june => 'Juni';

  @override
  String get july => 'Juli';

  @override
  String get august => 'Augustus';

  @override
  String get september => 'September';

  @override
  String get october => 'Oktober';

  @override
  String get november => 'November';

  @override
  String get december => 'December';

  @override
  String get food => 'Eten';

  @override
  String get confirmed => 'Bevestigd';

  @override
  String get cancelled => 'Geannuleerd';

  @override
  String get passport => 'Paspoort';

  @override
  String get visa => 'Visum';

  @override
  String get ticket => 'Ticket';

  @override
  String get hotel => 'Hotel';

  @override
  String get insurance => 'Verzekering';

  @override
  String get editDocument => 'Document bewerken';

  @override
  String get updateDocument => 'Document bijwerken';

  @override
  String get saveToGallery => 'Opslaan in galerij';

  @override
  String get flight => 'Vlucht';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get bookingLimitReached =>
      'Boekingslimiet bereikt. Je kunt slechts 15 boekingen per reis toevoegen.';

  @override
  String get documentLimitReached =>
      'Documentlimiet bereikt. Je kunt slechts 10 documenten in totaal toevoegen.';

  @override
  String get clearFilters => 'Filters wissen';

  @override
  String get travelDates => 'Reisdatums';

  @override
  String get selectDateRange => 'Datumbereik selecteren';

  @override
  String get activityDetails => 'Activiteit details';

  @override
  String get quickActions => 'Snelle acties';

  @override
  String get addNewItemsToTrip => 'Nieuwe items aan reis toevoegen';

  @override
  String get booking => 'Boeking';

  @override
  String get expense => 'Uitgave';

  @override
  String get itinerary => 'Reisroute';

  @override
  String get duration => 'Duur';

  @override
  String get noExpensesFound => 'Geen uitgaven gevonden';

  @override
  String get noExpensesFoundForCategory =>
      'Geen uitgaven gevonden voor deze categorie';

  @override
  String get noTasksFound => 'Geen taken gevonden';

  @override
  String get noBookingsFound => 'Geen boekingen gevonden';

  @override
  String get noTripsFound => 'Geen reizen gevonden';

  @override
  String get tryAdjustingFilters => 'Probeer de filters aan te passen';

  @override
  String get searchTasks => 'Taken zoeken';

  @override
  String get searchBookings => 'Boekingen zoeken';

  @override
  String get urgentPriority => 'Urgent';

  @override
  String get highPriority => 'Hoog';

  @override
  String get mediumPriority => 'Gemiddeld';

  @override
  String get lowPriority => 'Laag';

  @override
  String get overdue => 'Achterstallig';

  @override
  String get dueToday => 'Vervalt vandaag';

  @override
  String get dueTomorrow => 'Vervalt morgen';

  @override
  String get activeStatus => 'Actieve status';

  @override
  String get selectBackupFile => 'Back-up bestand selecteren';

  @override
  String get selectFile => 'Bestand selecteren';

  @override
  String get importBackup => 'Backup Importeren';

  @override
  String get importSuccessful => 'Import Succesvol';

  @override
  String get importFailed => 'Import Mislukt';

  @override
  String get couldNotOpenAppStore => 'Kon app store niet openen';

  @override
  String get couldNotOpenHelpSection => 'Kon help sectie niet openen';

  @override
  String get couldNotOpenPrivacyPolicy => 'Kon privacybeleid niet openen';

  @override
  String get couldNotOpenTermsOfService => 'Kon servicevoorwaarden niet openen';

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
      'Bewaar dit bestand veilig — u heeft het nodig om uw gegevens te herstellen!';

  @override
  String get exportFailedTitle => 'Export Mislukt';

  @override
  String failedToCreateBackup(String error) {
    return 'Maken van back-up mislukt: $error';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get deleteEverything => 'Alles Verwijderen';

  @override
  String get createBackup => 'Back-up Maken';

  @override
  String get ok => 'OK';
}
