// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'Reisen';

  @override
  String get documents => 'Dokumente';

  @override
  String get settings => 'Einstellungen';

  @override
  String get quickStats => 'Schnellstatistiken';

  @override
  String get activeTrips => 'Aktive Reisen';

  @override
  String get pendingTasks => 'Ausstehende Aufgaben';

  @override
  String get totalBudget => 'Gesamtbudget';

  @override
  String nextTripStartsIn(int days) {
    return 'Die nächste Reise beginnt in $days Tagen';
  }

  @override
  String get yourTrips => 'Ihre Reisen';

  @override
  String get searchTrips => 'Reisen suchen...';

  @override
  String get daysUntilStart => 'Tage bis zum Beginn';

  @override
  String get dateCreated => 'Erstellungsdatum';

  @override
  String get alphabetical => 'Alphabetisch';

  @override
  String get budget => 'Budget';

  @override
  String get tasks => 'Aufgaben';

  @override
  String get tripInProgress => 'Reise läuft';

  @override
  String get startingToday => 'Beginnt heute!';

  @override
  String daysToGo(int days) {
    return '$days Tage verbleibend';
  }

  @override
  String active(int count) {
    return '$count Aktiv';
  }

  @override
  String get searchDocuments => 'Dokumente suchen...';

  @override
  String get personal => 'Persönlich';

  @override
  String get tripRelated => 'Reisebezogen';

  @override
  String get uploadDocument => 'Dokument hochladen';

  @override
  String get takePhoto => 'Foto aufnehmen';

  @override
  String get captureDocumentWithCamera => 'Dokument mit Kamera erfassen';

  @override
  String get chooseFromGallery => 'Aus Galerie wählen';

  @override
  String get selectFromPhotoLibrary => 'Aus Fotobibliothek auswählen';

  @override
  String get chooseFile => 'Datei wählen';

  @override
  String get selectPdfOrOtherFiles => 'PDF oder andere Dateien auswählen';

  @override
  String expires(String date) {
    return 'Läuft ab: $date';
  }

  @override
  String get view => 'Anzeigen';

  @override
  String get share => 'Teilen';

  @override
  String get download => 'Herunterladen';

  @override
  String get delete => 'Löschen';

  @override
  String get profile => 'Profil';

  @override
  String get preferences => 'Einstellungen';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'Zwischen hellem und dunklem Design wechseln';

  @override
  String get language => 'Sprache';

  @override
  String get selectYourPreferredLanguage =>
      'Wählen Sie Ihre bevorzugte Sprache';

  @override
  String get defaultCurrency => 'Standardwährung';

  @override
  String get currencyUsedForNewTrips => 'Währung für neue Reisen';

  @override
  String get dateFormat => 'Datumsformat';

  @override
  String get howDatesAreDisplayed => 'Wie Daten angezeigt werden';

  @override
  String get temperatureUnit => 'Temperatureinheit';

  @override
  String get temperatureScalePreference => 'Temperaturskala-Einstellung';

  @override
  String get appSettings => 'App-Einstellungen';

  @override
  String get backupAndSync => 'Sicherung und Synchronisation';

  @override
  String get manageYourDataBackup => 'Datensicherung verwalten';

  @override
  String get importData => 'Daten importieren';

  @override
  String get importTripsFromOtherApps => 'Reisen aus anderen Apps importieren';

  @override
  String get exportData => 'Daten exportieren';

  @override
  String get exportYourTripData => 'Ihre Reisedaten exportieren';

  @override
  String get about => 'Über';

  @override
  String get appVersion => 'App-Version';

  @override
  String get rateApp => 'App bewerten';

  @override
  String get leaveAReviewOnTheAppStore =>
      'Eine Bewertung im App Store hinterlassen';

  @override
  String get helpAndSupport => 'Hilfe und Support';

  @override
  String get faqsAndContactInformation => 'FAQ und Kontaktinformationen';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get readOurPrivacyPolicy => 'Unsere Datenschutzrichtlinie lesen';

  @override
  String get termsOfService => 'Nutzungsbedingungen';

  @override
  String get readOurTermsAndConditions => 'Unsere AGB lesen';

  @override
  String get dangerZone => 'Gefahrenzone';

  @override
  String get clearAllData => 'Alle Daten löschen';

  @override
  String get removeAllTripsAndDocuments =>
      'Alle Reisen und Dokumente entfernen';

  @override
  String get clearAllDataConfirmation =>
      'Diese Aktion kann nicht rückgängig gemacht werden. Alle Ihre Reisen, Dokumente und Einstellungen werden dauerhaft gelöscht.';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get clearAll => 'Alles löschen';

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
  String get description => 'Beschreibung';

  @override
  String get amount => 'Betrag';

  @override
  String get date => 'Datum';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get retry => 'Wiederholen';

  @override
  String get add => 'Hinzufügen';

  @override
  String get update => 'Aktualisieren';

  @override
  String get close => 'Schließen';

  @override
  String get failedToLoad => 'Laden fehlgeschlagen';

  @override
  String get noDataYet => 'Noch keine Daten';

  @override
  String get startPlanning =>
      'Beginnen Sie mit der Planung Ihres nächsten Abenteuers!';

  @override
  String get createTrip => 'Reise erstellen';

  @override
  String get addDocument => 'Dokument hinzufügen';

  @override
  String get addExpense => 'Ausgabe hinzufügen';

  @override
  String get addActivity => 'Aktivität hinzufügen';

  @override
  String get addBooking => 'Buchung hinzufügen';

  @override
  String get totalExpenses => 'Gesamtausgaben';

  @override
  String get toDoItems => 'Aufgaben';

  @override
  String get expenseDetails => 'Ausgabendetails';

  @override
  String get expenseTitle => 'Ausgabentitel';

  @override
  String get category => 'Kategorie';

  @override
  String get paidBy => 'Bezahlt von';

  @override
  String get you => 'Sie';

  @override
  String get allDay => 'Ganztägig';

  @override
  String get startTime => 'Startzeit';

  @override
  String get endTime => 'Endzeit';

  @override
  String get activityTitle => 'Aktivitätstitel';

  @override
  String get activityType => 'Aktivitätstyp';

  @override
  String get bookingTitle => 'Buchungstitel';

  @override
  String get bookingType => 'Buchungstyp';

  @override
  String get status => 'Status';

  @override
  String get addFile => 'Datei hinzufügen';

  @override
  String get fileNotFound => 'Datei nicht gefunden';

  @override
  String get fileMovedOrDeleted =>
      'Die Datei wurde möglicherweise verschoben oder gelöscht';

  @override
  String get cannotDisplayImage => 'Bild kann nicht angezeigt werden';

  @override
  String get openExternally => 'Extern öffnen';

  @override
  String get failedToReadFile => 'Dateidaten konnten nicht gelesen werden';

  @override
  String get deleteExpense => 'Ausgabe löschen';

  @override
  String get deleteExpenseConfirmation =>
      'Sind Sie sicher, dass Sie diese Ausgabe löschen möchten?';

  @override
  String get expenseBreakdown => 'Ausgabenaufschlüsselung';

  @override
  String get breakdown => 'Aufschlüsselung';

  @override
  String get noExpensesYet => 'Noch keine Ausgaben';

  @override
  String get noActivitiesPlanned => 'Keine Aktivitäten geplant';

  @override
  String get splitDetails => 'Aufteilungsdetails';

  @override
  String get editExpense => 'Ausgabe bearbeiten';

  @override
  String get addNewExpense => 'Neue Ausgabe hinzufügen';

  @override
  String get editActivity => 'Aktivität bearbeiten';

  @override
  String get addNewActivity => 'Neue Aktivität hinzufügen';

  @override
  String get editBooking => 'Buchung bearbeiten';

  @override
  String get addNewBooking => 'Neue Buchung hinzufügen';

  @override
  String get updateExpense => 'Ausgabe aktualisieren';

  @override
  String get updateActivity => 'Aktivität aktualisieren';

  @override
  String get updateBooking => 'Buchung aktualisieren';

  @override
  String get transport => 'Transport';

  @override
  String get accommodation => 'Unterkunft';

  @override
  String get activities => 'Aktivitäten';

  @override
  String get shopping => 'Einkaufen';

  @override
  String get sightseeing => 'Sightseeing';

  @override
  String get meal => 'Mahlzeit';

  @override
  String get entertainment => 'Unterhaltung';

  @override
  String get other => 'Andere';

  @override
  String get noBookingsYet => 'Noch keine Buchungen';

  @override
  String get addFirstBooking => 'Erste Buchung hinzufügen';

  @override
  String get bookingDetails => 'Buchungsdetails';

  @override
  String get vendor => 'Anbieter';

  @override
  String get confirmationNumber => 'Bestätigungsnummer';

  @override
  String get attachments => 'Anhänge';

  @override
  String get failedToLoadTodos => 'Fehler beim Laden der Aufgaben';

  @override
  String get task => 'Aufgabe';

  @override
  String allWithCount(int count) {
    return 'Alle ($count)';
  }

  @override
  String get noToDoItems => 'Keine Aufgaben';

  @override
  String get stayOrganizedMessage =>
      'Bleiben Sie organisiert, indem Sie Aufgaben für Ihre Reiseplanung hinzufügen!';

  @override
  String get addFirstTask => 'Erste Aufgabe hinzufügen';

  @override
  String get taskDetails => 'Aufgabendetails';

  @override
  String get completed => 'Abgeschlossen';

  @override
  String get pending => 'Ausstehend';

  @override
  String get priority => 'Priorität';

  @override
  String get dueDate => 'Fälligkeitsdatum';

  @override
  String get editTask => 'Aufgabe bearbeiten';

  @override
  String get addNewTask => 'Neue Aufgabe hinzufügen';

  @override
  String get updateTask => 'Aufgabe aktualisieren';

  @override
  String get addTask => 'Aufgabe hinzufügen';

  @override
  String get deleteTask => 'Aufgabe löschen';

  @override
  String deleteTaskConfirmation(String title) {
    return 'Sind Sie sicher, dass Sie \"$title\" löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String get keepTrackMessage =>
      'Behalten Sie den Überblick über Ihre Flüge, Hotels und Aktivitäten!';

  @override
  String get previewNotAvailable =>
      'Vorschau für diesen Dateityp nicht verfügbar.\nTippen Sie auf \"Extern öffnen\", um mit einer anderen App anzuzeigen.';

  @override
  String get appVersionBeta => '1.0.0 (Beta)';

  @override
  String get defaultUserName => 'Max Mustermann';

  @override
  String get defaultUserEmail => 'max.mustermann@email.com';

  @override
  String get taskTitle => 'Aufgabentitel';

  @override
  String get descriptionOptional => 'Beschreibung (Optional)';

  @override
  String get setDueDateOptional => 'Fälligkeitsdatum setzen (Optional)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Fällig: $day/$month/$year';
  }

  @override
  String get urgent => 'Dringend';

  @override
  String get high => 'Hoch';

  @override
  String get medium => 'Mittel';

  @override
  String get low => 'Niedrig';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Fehler beim $action der Aufgabe: $error';
  }

  @override
  String get vendorCompanyOptional => 'Anbieter/Firma (Optional)';

  @override
  String get confirmationNumberOptional => 'Bestätigungsnummer (Optional)';

  @override
  String amountCurrency(String currency) {
    return 'Betrag ($currency)';
  }

  @override
  String get setBookingDateOptional => 'Buchungsdatum setzen (Optional)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Datum: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Anhänge (Optional)';

  @override
  String get maxFileSizeSupported =>
      'Max. Dateigröße: 5MB\nUnterstützte Formate: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Fehler beim $action der Buchung: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename erfolgreich angehängt';
  }

  @override
  String get fileSizeMustBeLess => 'Dateigröße muss weniger als 5MB sein';

  @override
  String failedToPickFile(String error) {
    return 'Fehler beim Datei auswählen: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Fehler beim Teilen der Datei: $error';
  }

  @override
  String get unknown => 'Unbekannt';

  @override
  String get editTrip => 'Reise bearbeiten';

  @override
  String get updateTrip => 'Reise aktualisieren';

  @override
  String get tripUpdatedSuccessfully => 'Reise erfolgreich aktualisiert';

  @override
  String get failedToUpdateTrip => 'Fehler beim Aktualisieren der Reise';

  @override
  String get deleteTrip => 'Reise löschen';

  @override
  String get deleteTripConfirmation =>
      'Sind Sie sicher, dass Sie diese Reise löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';

  @override
  String get tripDeletedSuccessfully => 'Reise erfolgreich gelöscht';

  @override
  String get failedToDeleteTrip => 'Fehler beim Löschen der Reise';

  @override
  String get tripCreatedSuccessfully => 'Reise erfolgreich erstellt!';

  @override
  String get failedToCreateTrip => 'Fehler beim Erstellen der Reise';

  @override
  String get selectStartDateFirst => 'Bitte wählen Sie zuerst das Startdatum';

  @override
  String get addAtLeastOneDestination =>
      'Bitte fügen Sie mindestens ein Reiseziel hinzu';

  @override
  String get selectBothStartAndEndDates =>
      'Bitte wählen Sie sowohl Start- als auch Enddatum';

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
  String get flight => 'Flug';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get bookingLimitReached =>
      'Buchungslimit erreicht. Sie können nur bis zu 15 Buchungen pro Reise hinzufügen.';

  @override
  String get documentLimitReached =>
      'Dokumentenlimit erreicht. Sie können nur bis zu 10 Dokumente insgesamt hinzufügen.';

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
