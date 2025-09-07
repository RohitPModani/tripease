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
}
