// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Tripease';

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
  String get pushNotifications => 'Push-Benachrichtigungen';

  @override
  String get getRemindersAndUpdates => 'Erinnerungen und Updates erhalten';

  @override
  String get locationServices => 'Standortdienste';

  @override
  String get allowLocationBasedFeatures =>
      'Standortbasierte Funktionen erlauben';

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
  String get biometricAuthentication => 'Biometrische Authentifizierung';

  @override
  String get biometricAuthenticationDescription =>
      'Verwenden Sie Fingerabdruck oder Gesichtserkennung, um Ihre App zu sichern';

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
}
