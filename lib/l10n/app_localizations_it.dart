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

  @override
  String get title => 'Titolo';

  @override
  String get description => 'Descrizione';

  @override
  String get amount => 'Importo';

  @override
  String get date => 'Data';

  @override
  String get edit => 'Modifica';

  @override
  String get retry => 'Riprova';

  @override
  String get add => 'Aggiungi';

  @override
  String get update => 'Aggiorna';

  @override
  String get close => 'Chiudi';

  @override
  String get failedToLoad => 'Caricamento fallito';

  @override
  String get noDataYet => 'Nessun dato ancora';

  @override
  String get startPlanning => 'Inizia a pianificare la tua prossima avventura!';

  @override
  String get createTrip => 'Crea Viaggio';

  @override
  String get addDocument => 'Aggiungi Documento';

  @override
  String get addExpense => 'Aggiungi Spesa';

  @override
  String get addActivity => 'Aggiungi Attività';

  @override
  String get addBooking => 'Aggiungi Prenotazione';

  @override
  String get totalExpenses => 'Spese Totali';

  @override
  String get toDoItems => 'Elementi da Fare';

  @override
  String get expenseDetails => 'Dettagli Spesa';

  @override
  String get expenseTitle => 'Titolo Spesa';

  @override
  String get category => 'Categoria';

  @override
  String get paidBy => 'Pagato da';

  @override
  String get you => 'Tu';

  @override
  String get allDay => 'Tutto il giorno';

  @override
  String get startTime => 'Ora di inizio';

  @override
  String get endTime => 'Ora di fine';

  @override
  String get activityTitle => 'Titolo Attività';

  @override
  String get activityType => 'Tipo di Attività';

  @override
  String get bookingTitle => 'Titolo Prenotazione';

  @override
  String get bookingType => 'Tipo di Prenotazione';

  @override
  String get status => 'Stato';

  @override
  String get addFile => 'Aggiungi File';

  @override
  String get fileNotFound => 'File non trovato';

  @override
  String get fileMovedOrDeleted =>
      'Il file potrebbe essere stato spostato o eliminato';

  @override
  String get cannotDisplayImage => 'Impossibile visualizzare l\'immagine';

  @override
  String get openExternally => 'Apri Esternamente';

  @override
  String get failedToReadFile => 'Impossibile leggere i dati del file';

  @override
  String get deleteExpense => 'Elimina Spesa';

  @override
  String get deleteExpenseConfirmation =>
      'Sei sicuro di voler eliminare questa spesa?';

  @override
  String get expenseBreakdown => 'Ripartizione Spese';

  @override
  String get breakdown => 'Ripartizione';

  @override
  String get noExpensesYet => 'Nessuna spesa ancora';

  @override
  String get noActivitiesPlanned => 'Nessuna attività pianificata';

  @override
  String get splitDetails => 'Dettagli Divisione';

  @override
  String get editExpense => 'Modifica Spesa';

  @override
  String get addNewExpense => 'Aggiungi Nuova Spesa';

  @override
  String get editActivity => 'Modifica Attività';

  @override
  String get addNewActivity => 'Aggiungi Nuova Attività';

  @override
  String get editBooking => 'Modifica Prenotazione';

  @override
  String get addNewBooking => 'Aggiungi Nuova Prenotazione';

  @override
  String get updateExpense => 'Aggiorna Spesa';

  @override
  String get updateActivity => 'Aggiorna Attività';

  @override
  String get updateBooking => 'Aggiorna Prenotazione';

  @override
  String get transport => 'Trasporto';

  @override
  String get accommodation => 'Alloggio';

  @override
  String get activities => 'Attività';

  @override
  String get shopping => 'Shopping';

  @override
  String get sightseeing => 'Turismo';

  @override
  String get meal => 'Pasto';

  @override
  String get entertainment => 'Intrattenimento';

  @override
  String get other => 'Altro';

  @override
  String get noBookingsYet => 'Nessuna prenotazione ancora';

  @override
  String get addFirstBooking => 'Aggiungi Prima Prenotazione';

  @override
  String get bookingDetails => 'Dettagli Prenotazione';

  @override
  String get vendor => 'Fornitore';

  @override
  String get confirmationNumber => 'Numero di Conferma';

  @override
  String get attachments => 'Allegati';

  @override
  String get failedToLoadTodos => 'Errore nel caricamento delle attività';

  @override
  String get task => 'Attività';

  @override
  String allWithCount(int count) {
    return 'Tutte ($count)';
  }

  @override
  String get noToDoItems => 'Nessuna attività';

  @override
  String get stayOrganizedMessage =>
      'Rimani organizzato aggiungendo attività per pianificare il tuo viaggio!';

  @override
  String get addFirstTask => 'Aggiungi prima attività';

  @override
  String get taskDetails => 'Dettagli attività';

  @override
  String get completed => 'Completato';

  @override
  String get pending => 'In attesa';

  @override
  String get priority => 'Priorità';

  @override
  String get dueDate => 'Scadenza';

  @override
  String get editTask => 'Modifica attività';

  @override
  String get addNewTask => 'Aggiungi nuova attività';

  @override
  String get updateTask => 'Aggiorna attività';

  @override
  String get addTask => 'Aggiungi attività';

  @override
  String get deleteTask => 'Elimina attività';

  @override
  String deleteTaskConfirmation(String title) {
    return 'Sei sicuro di voler eliminare \"$title\"? Questa azione non può essere annullata.';
  }

  @override
  String get keepTrackMessage =>
      'Tieni traccia dei tuoi voli, hotel e attività!';

  @override
  String get previewNotAvailable =>
      'Anteprima non disponibile per questo tipo di file.\nTocca \"Apri Esternamente\" per visualizzare con un\'altra app.';

  @override
  String get appVersionBeta => '1.0.0 (Beta)';

  @override
  String get defaultUserName => 'Mario Rossi';

  @override
  String get defaultUserEmail => 'mario.rossi@email.com';

  @override
  String get taskTitle => 'Titolo Attività';

  @override
  String get descriptionOptional => 'Descrizione (opzionale)';

  @override
  String get setDueDateOptional => 'Imposta scadenza (opzionale)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Scadenza: $day/$month/$year';
  }

  @override
  String get urgent => 'Urgente';

  @override
  String get high => 'Alta';

  @override
  String get medium => 'Media';

  @override
  String get low => 'Bassa';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Impossibile $action attività: $error';
  }

  @override
  String get vendorCompanyOptional => 'Fornitore/Azienda (opzionale)';

  @override
  String get confirmationNumberOptional => 'Numero di Conferma (opzionale)';

  @override
  String amountCurrency(String currency) {
    return 'Importo ($currency)';
  }

  @override
  String get setBookingDateOptional => 'Imposta data prenotazione (opzionale)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Data: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Allegati (opzionale)';

  @override
  String get maxFileSizeSupported =>
      'Dimensione massima file: 5MB\nFormati supportati: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Impossibile $action prenotazione: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename allegato con successo';
  }

  @override
  String get fileSizeMustBeLess =>
      'La dimensione del file deve essere inferiore a 5MB';

  @override
  String failedToPickFile(String error) {
    return 'Impossibile selezionare file: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Errore nella condivisione del file: $error';
  }

  @override
  String get unknown => 'Sconosciuto';

  @override
  String get biometricAuthentication => 'Autenticazione Biometrica';

  @override
  String get biometricAuthenticationDescription =>
      'Usa l\'impronta digitale o il riconoscimento facciale per proteggere la tua app';

  @override
  String get editTrip => 'Modifica Viaggio';

  @override
  String get updateTrip => 'Aggiorna Viaggio';

  @override
  String get tripUpdatedSuccessfully => 'Viaggio aggiornato con successo';

  @override
  String get failedToUpdateTrip => 'Impossibile aggiornare il viaggio';

  @override
  String get deleteTrip => 'Elimina Viaggio';

  @override
  String get deleteTripConfirmation =>
      'Sei sicuro di voler eliminare questo viaggio? Questa azione non può essere annullata.';

  @override
  String get tripDeletedSuccessfully => 'Viaggio eliminato con successo';

  @override
  String get failedToDeleteTrip => 'Impossibile eliminare il viaggio';

  @override
  String get tripCreatedSuccessfully => 'Viaggio creato con successo!';

  @override
  String get failedToCreateTrip => 'Impossibile creare il viaggio';

  @override
  String get selectStartDateFirst => 'Seleziona prima la data di inizio';

  @override
  String get addAtLeastOneDestination => 'Aggiungi almeno una destinazione';

  @override
  String get selectBothStartAndEndDates =>
      'Seleziona sia la data di inizio che quella di fine';
}
