// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Tripease';

  @override
  String get trips => 'Viaggi';

  @override
  String get documents => 'Documenti';

  @override
  String get settings => 'Impostazioni';

  @override
  String get quickStats => 'Statistiche Rapide';

  @override
  String get activeTrips => 'Viaggi Attivi';

  @override
  String get pendingTasks => 'Attività in Sospeso';

  @override
  String get totalBudget => 'Budget Totale';

  @override
  String nextTripStartsIn(int days) {
    return 'Il prossimo viaggio inizia tra $days giorni';
  }

  @override
  String get yourTrips => 'I Tuoi Viaggi';

  @override
  String get searchTrips => 'Cerca viaggi...';

  @override
  String get daysUntilStart => 'Giorni all\'Inizio';

  @override
  String get dateCreated => 'Data di Creazione';

  @override
  String get alphabetical => 'Alfabetico';

  @override
  String get budget => 'Budget';

  @override
  String get tasks => 'Attività';

  @override
  String get tripInProgress => 'Viaggio in Corso';

  @override
  String get startingToday => 'Inizia Oggi!';

  @override
  String daysToGo(int days) {
    return '$days giorni rimanenti';
  }

  @override
  String active(int count) {
    return '$count Attivi';
  }

  @override
  String get searchDocuments => 'Cerca documenti...';

  @override
  String get personal => 'Personale';

  @override
  String get tripRelated => 'Correlato al Viaggio';

  @override
  String get uploadDocument => 'Carica Documento';

  @override
  String get takePhoto => 'Scatta Foto';

  @override
  String get captureDocumentWithCamera => 'Cattura documento con fotocamera';

  @override
  String get chooseFromGallery => 'Scegli dalla Galleria';

  @override
  String get selectFromPhotoLibrary => 'Seleziona dalla libreria foto';

  @override
  String get chooseFile => 'Scegli File';

  @override
  String get selectPdfOrOtherFiles => 'Seleziona PDF o altri file';

  @override
  String expires(String date) {
    return 'Scade: $date';
  }

  @override
  String get view => 'Visualizza';

  @override
  String get share => 'Condividi';

  @override
  String get download => 'Scarica';

  @override
  String get delete => 'Elimina';

  @override
  String get profile => 'Profilo';

  @override
  String get preferences => 'Preferenze';

  @override
  String get darkMode => 'Modalità Scura';

  @override
  String get switchBetweenLightAndDarkTheme => 'Passa tra tema chiaro e scuro';

  @override
  String get language => 'Lingua';

  @override
  String get selectYourPreferredLanguage => 'Seleziona la tua lingua preferita';

  @override
  String get defaultCurrency => 'Valuta Predefinita';

  @override
  String get currencyUsedForNewTrips => 'Valuta utilizzata per i nuovi viaggi';

  @override
  String get dateFormat => 'Formato Data';

  @override
  String get howDatesAreDisplayed => 'Come vengono visualizzate le date';

  @override
  String get temperatureUnit => 'Unità di Temperatura';

  @override
  String get temperatureScalePreference => 'Preferenza scala temperatura';

  @override
  String get appSettings => 'Impostazioni App';

  @override
  String get pushNotifications => 'Notifiche Push';

  @override
  String get getRemindersAndUpdates => 'Ricevi promemoria e aggiornamenti';

  @override
  String get locationServices => 'Servizi di Localizzazione';

  @override
  String get allowLocationBasedFeatures =>
      'Consenti funzioni basate sulla posizione';

  @override
  String get backupAndSync => 'Backup e Sincronizzazione';

  @override
  String get manageYourDataBackup => 'Gestisci il backup dei tuoi dati';

  @override
  String get importData => 'Importa Dati';

  @override
  String get importTripsFromOtherApps => 'Importa viaggi da altre app';

  @override
  String get exportData => 'Esporta Dati';

  @override
  String get exportYourTripData => 'Esporta i tuoi dati di viaggio';

  @override
  String get about => 'Informazioni';

  @override
  String get appVersion => 'Versione App';

  @override
  String get rateApp => 'Valuta App';

  @override
  String get leaveAReviewOnTheAppStore =>
      'Lascia una recensione sull\'App Store';

  @override
  String get helpAndSupport => 'Aiuto e Supporto';

  @override
  String get faqsAndContactInformation => 'FAQ e informazioni di contatto';

  @override
  String get privacyPolicy => 'Informativa sulla Privacy';

  @override
  String get readOurPrivacyPolicy =>
      'Leggi la nostra informativa sulla privacy';

  @override
  String get termsOfService => 'Termini di Servizio';

  @override
  String get readOurTermsAndConditions => 'Leggi i nostri termini e condizioni';

  @override
  String get dangerZone => 'Zona di Pericolo';

  @override
  String get clearAllData => 'Cancella Tutti i Dati';

  @override
  String get removeAllTripsAndDocuments => 'Rimuovi tutti i viaggi e documenti';

  @override
  String get clearAllDataConfirmation =>
      'Questa azione non può essere annullata. Tutti i tuoi viaggi, documenti e impostazioni saranno eliminati permanentemente.';

  @override
  String get cancel => 'Annulla';

  @override
  String get clearAll => 'Cancella Tutto';

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
