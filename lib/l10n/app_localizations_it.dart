// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

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
  String get bookingType => 'Prenotazione';

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

  @override
  String get titleIsRequired => 'Il titolo è obbligatorio';

  @override
  String titleTooLong(int limit) {
    return 'Il titolo deve essere di $limit caratteri o meno';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'La descrizione deve essere di $limit caratteri o meno';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Fornitore/Azienda deve essere di $limit caratteri o meno';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'Il numero di conferma deve essere di $limit caratteri o meno';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Pagato da deve essere di $limit caratteri o meno';
  }

  @override
  String locationTooLong(int limit) {
    return 'La posizione deve essere di $limit caratteri o meno';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'La descrizione deve essere di $limit caratteri o meno';
  }

  @override
  String get amountIsRequired => 'L\'importo è obbligatorio';

  @override
  String get enterValidAmount => 'Inserisci un importo valido';

  @override
  String get amountMustBePositive => 'L\'importo deve essere positivo';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName è obbligatorio';
  }

  @override
  String get destinationIsRequired => 'La destinazione è obbligatoria';

  @override
  String destinationTooLong(int limit) {
    return 'La destinazione deve essere di $limit caratteri o meno';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (Opzionale)';
  }

  @override
  String maxCharacters(int maxLength) {
    return 'Massimo $maxLength caratteri';
  }

  @override
  String get searchTripsPlaceholder => 'Cerca viaggi...';

  @override
  String allWithTotal(int total) {
    return 'Tutti ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'Prossimi ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Attivi ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Completati ($count)';
  }

  @override
  String get yourTripsTitle => 'I Tuoi Viaggi';

  @override
  String activeTripsCount(int count) {
    return '$count Attivi';
  }

  @override
  String get bookingsTabTitle => 'Prenotazioni';

  @override
  String get expensesTabTitle => 'Spese';

  @override
  String get overviewTabTitle => 'Panoramica';

  @override
  String get todoTabTitle => 'Da Fare';

  @override
  String get itineraryTabTitle => 'Itinerario';

  @override
  String get failedToLoadTrip => 'Impossibile caricare il viaggio';

  @override
  String get tripNotFound => 'Viaggio non trovato';

  @override
  String get saveImage => 'Salva Immagine';

  @override
  String get saveToPhotos => 'Salva nelle Foto';

  @override
  String get saveToPhotosDescription =>
      'Salva direttamente nella tua galleria foto';

  @override
  String get saveToFiles => 'Salva nei File';

  @override
  String get saveToFilesDescription =>
      'Scegli una cartella specifica per salvare';

  @override
  String get imageSavedToPhotos => 'Immagine salvata nelle Foto';

  @override
  String get fileSavedSuccessfully => 'File salvato con successo';

  @override
  String get open => 'Apri';

  @override
  String errorDownloadingFile(String error) {
    return 'Errore nel download del file: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Errore nel salvare nelle Foto: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Errore nel salvare il file: $error';
  }

  @override
  String get selectDocument => 'Seleziona Documento';

  @override
  String get chooseFromGalleryTitle => 'Scegli dalla Galleria';

  @override
  String get chooseFromGalleryDescription => 'Seleziona dalla libreria foto';

  @override
  String get chooseFileTitle => 'Scegli File';

  @override
  String get chooseFileDescription => 'Seleziona PDF o altri file';

  @override
  String get failedToCaptureImage => 'Impossibile catturare l\'immagine';

  @override
  String get failedToSelectImage => 'Impossibile selezionare l\'immagine';

  @override
  String get failedToSelectFile => 'Impossibile selezionare il file';

  @override
  String get documentAddedSuccessfully => 'Documento aggiunto con successo';

  @override
  String get documentUpdatedSuccessfully => 'Documento aggiornato con successo';

  @override
  String get failedToSaveDocument => 'Impossibile salvare il documento';

  @override
  String get documentTitle => 'Titolo Documento *';

  @override
  String get documentCategory => 'Categoria Documento';

  @override
  String get changeDocument => 'Cambia Documento';

  @override
  String get documentsTitle => 'Documenti';

  @override
  String get noDocumentsYet => 'Nessun documento ancora';

  @override
  String get noDocumentsFound => 'Nessun documento trovato';

  @override
  String get clearSearch => 'Cancella ricerca';

  @override
  String get documentDetails => 'Dettagli Documento';

  @override
  String get fileSize => 'Dimensione File';

  @override
  String get fileName => 'Nome File';

  @override
  String get deleteDocument => 'Elimina Documento';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Sei sicuro di voler eliminare \"$title\"? Questa azione non può essere annullata.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Documento \"$title\" eliminato con successo';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Impossibile eliminare il documento: $error';
  }

  @override
  String get location => 'Posizione';

  @override
  String get activityTitleLabel => 'Titolo Attività';

  @override
  String get activityTypeLabel => 'Tipo di Attività';

  @override
  String get expenseTitleLabel => 'Titolo Spesa';

  @override
  String get destinations => 'Destinazioni';

  @override
  String get currency => 'Valuta';

  @override
  String get tripInProgressStatus => 'Viaggio in Corso';

  @override
  String get completedStatus => 'Completato';

  @override
  String get tripDates => 'Date del Viaggio';

  @override
  String get expenseType => 'Spesa';

  @override
  String get expenseDetailsTitle => 'Dettagli Spesa';

  @override
  String get activityDetailsTitle => 'Dettagli Attività';

  @override
  String get deleteActivity => 'Elimina Attività';

  @override
  String get deleteBooking => 'Elimina Prenotazione';

  @override
  String get january => 'Gen';

  @override
  String get february => 'Feb';

  @override
  String get march => 'Mar';

  @override
  String get april => 'Apr';

  @override
  String get may => 'Mag';

  @override
  String get june => 'Giu';

  @override
  String get july => 'Lug';

  @override
  String get august => 'Ago';

  @override
  String get september => 'Set';

  @override
  String get october => 'Ott';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Dic';

  @override
  String get food => 'Cibo';

  @override
  String get confirmed => 'Confermato';

  @override
  String get cancelled => 'Cancellato';

  @override
  String get passport => 'Passaporto';

  @override
  String get visa => 'Visto';

  @override
  String get ticket => 'Biglietto';

  @override
  String get hotel => 'Hotel';

  @override
  String get insurance => 'Assicurazione';

  @override
  String get editDocument => 'Modifica Documento';

  @override
  String get updateDocument => 'Aggiorna Documento';

  @override
  String get saveToGallery => 'Salva nella Galleria';

  @override
  String get flight => 'Volo';

  @override
  String get restaurant => 'Ristorante';

  @override
  String get bookingLimitReached =>
      'Limite prenotazioni raggiunto. Puoi aggiungere solo 15 prenotazioni per viaggio.';

  @override
  String get documentLimitReached =>
      'Limite documenti raggiunto. Puoi aggiungere solo 10 documenti in totale.';

  @override
  String get clearFilters => 'Cancella Filtri';

  @override
  String get travelDates => 'Date di Viaggio';

  @override
  String get selectDateRange => 'Seleziona intervallo di date';

  @override
  String get activityDetails => 'Dettagli Attività';

  @override
  String get quickActions => 'Azioni Rapide';

  @override
  String get addNewItemsToTrip => 'Aggiungi nuovi elementi al tuo viaggio';

  @override
  String get booking => 'Prenotazione';

  @override
  String get expense => 'Spesa';

  @override
  String get itinerary => 'Itinerario';

  @override
  String get duration => 'Durata';

  @override
  String get noExpensesFound => 'Nessuna spesa trovata';

  @override
  String get noExpensesFoundForCategory =>
      'Nessuna spesa trovata per questa categoria';

  @override
  String get noTasksFound => 'Nessuna attività trovata';

  @override
  String get noBookingsFound => 'Nessuna prenotazione trovata';

  @override
  String get noTripsFound => 'Nessun viaggio trovato';

  @override
  String get tryAdjustingFilters =>
      'Prova ad aggiustare i termini di ricerca o i filtri';

  @override
  String get searchTasks => 'Cerca attività...';

  @override
  String get searchBookings => 'Cerca prenotazioni...';

  @override
  String get urgentPriority => 'Urgente';

  @override
  String get highPriority => 'Alta';

  @override
  String get mediumPriority => 'Media';

  @override
  String get lowPriority => 'Bassa';

  @override
  String get overdue => 'Scaduto';

  @override
  String get dueToday => 'Scade oggi';

  @override
  String get dueTomorrow => 'Scade domani';

  @override
  String get activeStatus => 'Attivo';

  @override
  String get selectBackupFile => 'Seleziona File di Backup';

  @override
  String get selectFile => 'Seleziona File';

  @override
  String get importBackup => 'Importa Backup';

  @override
  String get importSuccessful => 'Importazione Riuscita';

  @override
  String get importFailed => 'Importazione Fallita';

  @override
  String get couldNotOpenAppStore => 'Impossibile aprire l\'App Store';

  @override
  String get couldNotOpenHelpSection => 'Impossibile aprire la sezione aiuto';

  @override
  String get couldNotOpenPrivacyPolicy =>
      'Impossibile aprire l\'informativa sulla privacy';

  @override
  String get couldNotOpenTermsOfService =>
      'Impossibile aprire i termini di servizio';

  @override
  String get confirmActionWarning => 'Questa azione non può essere annullata!';

  @override
  String get finalConfirmationTitle => 'Conferma Finale';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Digita $word nella casella qui sotto per confermare:';
  }

  @override
  String get deletingAllData => 'Eliminazione di tutti i dati...';

  @override
  String get pleaseWait =>
      'Attendere prego, questo potrebbe richiedere un momento.';

  @override
  String get dataClearedTitle => 'Dati Cancellati';

  @override
  String get dataClearedMessage =>
      'Tutti i tuoi dati sono stati eliminati con successo. L\'app è stata ripristinata al suo stato iniziale.';

  @override
  String get errorTitle => 'Errore';

  @override
  String failedToClearAllData(String error) {
    return 'Impossibile cancellare tutti i dati: $error';
  }

  @override
  String get exportIntroTitle =>
      'Crea un backup sicuro di tutti i tuoi dati Voythrix:';

  @override
  String get exportEncryptionInfo =>
      'I tuoi dati saranno crittografati e compressi in un file .tripe.';

  @override
  String get backupPasswordTitle => 'Password di Backup (Opzionale)';

  @override
  String get backupPasswordHint => 'Inserisci password (opzionale)';

  @override
  String get confirmPasswordHint => 'Conferma password';

  @override
  String get passwordsMatch => 'Le password corrispondono';

  @override
  String get passwordsDoNotMatch => 'Le password non corrispondono';

  @override
  String get creatingBackup => 'Creazione backup...';

  @override
  String get collectingAndEncrypting =>
      'Raccolta e crittografia dei tuoi dati...';

  @override
  String get backupCreatedTitle => 'Backup Creato';

  @override
  String get backupCreatedMessage =>
      'Il tuo backup è stato creato con successo!';

  @override
  String get fileInfoLabel => 'Informazioni File:';

  @override
  String get fileInfoFormat => '• Formato: File .tripe crittografato';

  @override
  String get fileInfoSecurityPassword => '• Sicurezza: Protetto da password';

  @override
  String get fileInfoSecurityStandard => '• Sicurezza: Crittografia standard';

  @override
  String get fileInfoCompression => '• Compressione: Compressione GZip';

  @override
  String get keepFileSafeNote =>
      'Tieni questo file al sicuro — ne avrai bisogno per ripristinare i tuoi dati!';

  @override
  String get exportFailedTitle => 'Esportazione Fallita';

  @override
  String failedToCreateBackup(String error) {
    return 'Impossibile creare il backup: $error';
  }

  @override
  String get continueAction => 'Continua';

  @override
  String get deleteEverything => 'Elimina Tutto';

  @override
  String get createBackup => 'Crea Backup';

  @override
  String get ok => 'OK';
}
