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
  String get bookingType => 'Buchung';

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
  String get titleIsRequired => 'Titel ist erforderlich';

  @override
  String titleTooLong(int limit) {
    return 'Titel muss $limit Zeichen oder weniger haben';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'Beschreibung muss $limit Zeichen oder weniger haben';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Anbieter/Firma muss $limit Zeichen oder weniger haben';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'Bestätigungsnummer muss $limit Zeichen oder weniger haben';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Bezahlt von muss $limit Zeichen oder weniger haben';
  }

  @override
  String locationTooLong(int limit) {
    return 'Standort muss $limit Zeichen oder weniger haben';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'Beschreibung muss $limit Zeichen oder weniger haben';
  }

  @override
  String get amountIsRequired => 'Betrag ist erforderlich';

  @override
  String get enterValidAmount => 'Bitte gültigen Betrag eingeben';

  @override
  String get amountMustBePositive => 'Betrag muss positiv sein';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName ist erforderlich';
  }

  @override
  String get destinationIsRequired => 'Reiseziel ist erforderlich';

  @override
  String destinationTooLong(int limit) {
    return 'Reiseziel muss $limit Zeichen oder weniger haben';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (Optional)';
  }

  @override
  String maxCharacters(int maxLength) {
    return 'Maximal $maxLength Zeichen';
  }

  @override
  String get searchTripsPlaceholder => 'Reisen suchen...';

  @override
  String allWithTotal(int total) {
    return 'Alle ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'Bevorstehend ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Aktiv ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Abgeschlossen ($count)';
  }

  @override
  String get yourTripsTitle => 'Ihre Reisen';

  @override
  String activeTripsCount(int count) {
    return '$count Aktiv';
  }

  @override
  String get bookingsTabTitle => 'Buchungen';

  @override
  String get expensesTabTitle => 'Ausgaben';

  @override
  String get overviewTabTitle => 'Übersicht';

  @override
  String get todoTabTitle => 'Aufgaben';

  @override
  String get itineraryTabTitle => 'Reiseplan';

  @override
  String get failedToLoadTrip => 'Reise konnte nicht geladen werden';

  @override
  String get tripNotFound => 'Reise nicht gefunden';

  @override
  String get saveImage => 'Bild speichern';

  @override
  String get saveToPhotos => 'In Fotos speichern';

  @override
  String get saveToPhotosDescription => 'Direkt in Ihrer Fotogalerie speichern';

  @override
  String get saveToFiles => 'In Dateien speichern';

  @override
  String get saveToFilesDescription =>
      'Spezifischen Ordner zum Speichern wählen';

  @override
  String get imageSavedToPhotos => 'Bild in Fotos gespeichert';

  @override
  String get fileSavedSuccessfully => 'Datei erfolgreich gespeichert';

  @override
  String get open => 'Öffnen';

  @override
  String errorDownloadingFile(String error) {
    return 'Fehler beim Herunterladen der Datei: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Fehler beim Speichern in Fotos: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Fehler beim Speichern der Datei: $error';
  }

  @override
  String get selectDocument => 'Dokument auswählen';

  @override
  String get chooseFromGalleryTitle => 'Aus Galerie wählen';

  @override
  String get chooseFromGalleryDescription => 'Aus Fotobibliothek auswählen';

  @override
  String get chooseFileTitle => 'Datei wählen';

  @override
  String get chooseFileDescription => 'PDF oder andere Dateien auswählen';

  @override
  String get failedToCaptureImage => 'Bild konnte nicht aufgenommen werden';

  @override
  String get failedToSelectImage => 'Bild konnte nicht ausgewählt werden';

  @override
  String get failedToSelectFile => 'Datei konnte nicht ausgewählt werden';

  @override
  String get documentAddedSuccessfully => 'Dokument erfolgreich hinzugefügt';

  @override
  String get documentUpdatedSuccessfully => 'Dokument erfolgreich aktualisiert';

  @override
  String get failedToSaveDocument => 'Dokument konnte nicht gespeichert werden';

  @override
  String get documentTitle => 'Dokumenttitel *';

  @override
  String get documentCategory => 'Dokumentkategorie';

  @override
  String get changeDocument => 'Dokument ändern';

  @override
  String get documentsTitle => 'Dokumente';

  @override
  String get noDocumentsYet => 'Noch keine Dokumente';

  @override
  String get noDocumentsFound => 'Keine Dokumente gefunden';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String get documentDetails => 'Dokumentdetails';

  @override
  String get fileSize => 'Dateigröße';

  @override
  String get fileName => 'Dateiname';

  @override
  String get deleteDocument => 'Dokument löschen';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Sind Sie sicher, dass Sie \"$title\" löschen möchten? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Dokument \"$title\" erfolgreich gelöscht';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Dokument konnte nicht gelöscht werden: $error';
  }

  @override
  String get location => 'Standort';

  @override
  String get activityTitleLabel => 'Aktivitätstitel';

  @override
  String get activityTypeLabel => 'Aktivitätstyp';

  @override
  String get expenseTitleLabel => 'Ausgabentitel';

  @override
  String get destinations => 'Reiseziele';

  @override
  String get currency => 'Währung';

  @override
  String get tripInProgressStatus => 'Reise läuft';

  @override
  String get completedStatus => 'Abgeschlossen';

  @override
  String get tripDates => 'Reisedaten';

  @override
  String get expenseType => 'Ausgabe';

  @override
  String get expenseDetailsTitle => 'Ausgabendetails';

  @override
  String get activityDetailsTitle => 'Aktivitätsdetails';

  @override
  String get deleteActivity => 'Aktivität löschen';

  @override
  String get deleteBooking => 'Buchung löschen';

  @override
  String get january => 'Jan';

  @override
  String get february => 'Feb';

  @override
  String get march => 'Mär';

  @override
  String get april => 'Apr';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Jun';

  @override
  String get july => 'Jul';

  @override
  String get august => 'Aug';

  @override
  String get september => 'Sep';

  @override
  String get october => 'Okt';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Dez';

  @override
  String get food => 'Essen';

  @override
  String get confirmed => 'Bestätigt';

  @override
  String get cancelled => 'Storniert';

  @override
  String get passport => 'Reisepass';

  @override
  String get visa => 'Visum';

  @override
  String get ticket => 'Ticket';

  @override
  String get hotel => 'Hotel';

  @override
  String get insurance => 'Versicherung';

  @override
  String get editDocument => 'Dokument bearbeiten';

  @override
  String get updateDocument => 'Dokument aktualisieren';

  @override
  String get saveToGallery => 'In Galerie speichern';

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
  String get clearFilters => 'Filter löschen';

  @override
  String get travelDates => 'Reisedaten';

  @override
  String get selectDateRange => 'Datumsbereich auswählen';

  @override
  String get activityDetails => 'Aktivitätsdetails';

  @override
  String get quickActions => 'Schnellaktionen';

  @override
  String get addNewItemsToTrip => 'Neue Elemente zu Ihrer Reise hinzufügen';

  @override
  String get booking => 'Buchung';

  @override
  String get expense => 'Ausgabe';

  @override
  String get itinerary => 'Reiseplan';

  @override
  String get duration => 'Dauer';

  @override
  String get noExpensesFound => 'Keine Ausgaben gefunden';

  @override
  String get noExpensesFoundForCategory =>
      'Keine Ausgaben für diese Kategorie gefunden';

  @override
  String get noTasksFound => 'Keine Aufgaben gefunden';

  @override
  String get noBookingsFound => 'Keine Buchungen gefunden';

  @override
  String get noTripsFound => 'Keine Reisen gefunden';

  @override
  String get tryAdjustingFilters =>
      'Versuchen Sie, Ihre Suchbegriffe oder Filter anzupassen';

  @override
  String get searchTasks => 'Aufgaben suchen...';

  @override
  String get searchBookings => 'Buchungen suchen...';

  @override
  String get urgentPriority => 'Dringend';

  @override
  String get highPriority => 'Hoch';

  @override
  String get mediumPriority => 'Mittel';

  @override
  String get lowPriority => 'Niedrig';

  @override
  String get overdue => 'Überfällig';

  @override
  String get dueToday => 'Heute fällig';

  @override
  String get dueTomorrow => 'Morgen fällig';

  @override
  String get activeStatus => 'Aktiv';

  @override
  String get selectBackupFile => 'Backup-Datei auswählen';

  @override
  String get selectFile => 'Datei auswählen';

  @override
  String get importBackup => 'Backup importieren';

  @override
  String get importSuccessful => 'Import erfolgreich';

  @override
  String get importFailed => 'Import fehlgeschlagen';

  @override
  String get couldNotOpenAppStore => 'App Store konnte nicht geöffnet werden';

  @override
  String get couldNotOpenHelpSection =>
      'Hilfebereich konnte nicht geöffnet werden';

  @override
  String get couldNotOpenPrivacyPolicy =>
      'Datenschutzrichtlinie konnte nicht geöffnet werden';

  @override
  String get couldNotOpenTermsOfService =>
      'Nutzungsbedingungen konnten nicht geöffnet werden';

  @override
  String get confirmActionWarning =>
      'Diese Aktion kann nicht rückgängig gemacht werden!';

  @override
  String get finalConfirmationTitle => 'Endgültige Bestätigung';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Geben Sie $word in das Feld unten ein, um zu bestätigen:';
  }

  @override
  String get deletingAllData => 'Alle Daten werden gelöscht...';

  @override
  String get pleaseWait => 'Bitte warten Sie, dies kann einen Moment dauern.';

  @override
  String get dataClearedTitle => 'Daten Gelöscht';

  @override
  String get dataClearedMessage =>
      'Alle Ihre Daten wurden erfolgreich gelöscht. Die App wurde auf ihren ursprünglichen Zustand zurückgesetzt.';

  @override
  String get errorTitle => 'Fehler';

  @override
  String failedToClearAllData(String error) {
    return 'Fehler beim Löschen aller Daten: $error';
  }

  @override
  String get exportIntroTitle =>
      'Erstellen Sie eine sichere Sicherung aller Ihrer Voythrix-Daten:';

  @override
  String get exportEncryptionInfo =>
      'Ihre Daten werden verschlüsselt und in eine .tripe-Datei komprimiert.';

  @override
  String get backupPasswordTitle => 'Backup-Passwort (Optional)';

  @override
  String get backupPasswordHint => 'Passwort eingeben (optional)';

  @override
  String get confirmPasswordHint => 'Passwort bestätigen';

  @override
  String get passwordsMatch => 'Passwörter stimmen überein';

  @override
  String get passwordsDoNotMatch => 'Passwörter stimmen nicht überein';

  @override
  String get creatingBackup => 'Backup wird erstellt...';

  @override
  String get collectingAndEncrypting =>
      'Ihre Daten werden gesammelt und verschlüsselt...';

  @override
  String get backupCreatedTitle => 'Backup Erstellt';

  @override
  String get backupCreatedMessage => 'Ihr Backup wurde erfolgreich erstellt!';

  @override
  String get fileInfoLabel => 'Datei-Info:';

  @override
  String get fileInfoFormat => '• Format: Verschlüsselte .tripe-Datei';

  @override
  String get fileInfoSecurityPassword => '• Sicherheit: Passwort geschützt';

  @override
  String get fileInfoSecurityStandard =>
      '• Sicherheit: Standard-Verschlüsselung';

  @override
  String get fileInfoCompression => '• Komprimierung: GZip komprimiert';

  @override
  String get keepFileSafeNote =>
      'Bewahren Sie diese Datei sicher auf — Sie benötigen sie zur Wiederherstellung Ihrer Daten!';

  @override
  String get exportFailedTitle => 'Export Fehlgeschlagen';

  @override
  String failedToCreateBackup(String error) {
    return 'Fehler beim Erstellen des Backups: $error';
  }

  @override
  String get continueAction => 'Fortfahren';

  @override
  String get deleteEverything => 'Alles Löschen';

  @override
  String get createBackup => 'Backup Erstellen';

  @override
  String get ok => 'OK';
}
