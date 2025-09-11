// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'Voyages';

  @override
  String get documents => 'Documents';

  @override
  String get settings => 'Paramètres';

  @override
  String get quickStats => 'Statistiques Rapides';

  @override
  String get activeTrips => 'Voyages Actifs';

  @override
  String get pendingTasks => 'Tâches en Attente';

  @override
  String get totalBudget => 'Budget Total';

  @override
  String nextTripStartsIn(int days) {
    return 'Le prochain voyage commence dans $days jours';
  }

  @override
  String get yourTrips => 'Vos Voyages';

  @override
  String get searchTrips => 'Rechercher des voyages...';

  @override
  String get daysUntilStart => 'Jours Jusqu\'au Début';

  @override
  String get dateCreated => 'Date de Création';

  @override
  String get alphabetical => 'Alphabétique';

  @override
  String get budget => 'Budget';

  @override
  String get tasks => 'Tâches';

  @override
  String get tripInProgress => 'Voyage en Cours';

  @override
  String get startingToday => 'Commence Aujourd\'hui !';

  @override
  String daysToGo(int days) {
    return '$days jours restants';
  }

  @override
  String active(int count) {
    return '$count Actifs';
  }

  @override
  String get searchDocuments => 'Rechercher des documents...';

  @override
  String get personal => 'Personnel';

  @override
  String get tripRelated => 'Lié au Voyage';

  @override
  String get uploadDocument => 'Télécharger un Document';

  @override
  String get takePhoto => 'Prendre une Photo';

  @override
  String get captureDocumentWithCamera =>
      'Capturer le document avec l\'appareil photo';

  @override
  String get chooseFromGallery => 'Choisir dans la Galerie';

  @override
  String get selectFromPhotoLibrary => 'Sélectionner dans la photothèque';

  @override
  String get chooseFile => 'Choisir un Fichier';

  @override
  String get selectPdfOrOtherFiles =>
      'Sélectionner un PDF ou d\'autres fichiers';

  @override
  String expires(String date) {
    return 'Expire : $date';
  }

  @override
  String get view => 'Voir';

  @override
  String get share => 'Partager';

  @override
  String get download => 'Télécharger';

  @override
  String get delete => 'Supprimer';

  @override
  String get profile => 'Profil';

  @override
  String get preferences => 'Préférences';

  @override
  String get darkMode => 'Mode Sombre';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'Basculer entre thème clair et sombre';

  @override
  String get language => 'Langue';

  @override
  String get selectYourPreferredLanguage =>
      'Sélectionnez votre langue préférée';

  @override
  String get defaultCurrency => 'Devise par Défaut';

  @override
  String get currencyUsedForNewTrips =>
      'Devise utilisée pour les nouveaux voyages';

  @override
  String get dateFormat => 'Format de Date';

  @override
  String get howDatesAreDisplayed => 'Comment les dates sont affichées';

  @override
  String get temperatureUnit => 'Unité de Température';

  @override
  String get temperatureScalePreference =>
      'Préférence d\'échelle de température';

  @override
  String get appSettings => 'Paramètres de l\'App';

  @override
  String get backupAndSync => 'Sauvegarde et Synchronisation';

  @override
  String get manageYourDataBackup => 'Gérer votre sauvegarde de données';

  @override
  String get importData => 'Importer des Données';

  @override
  String get importTripsFromOtherApps =>
      'Importer des voyages d\'autres applications';

  @override
  String get exportData => 'Exporter des Données';

  @override
  String get exportYourTripData => 'Exporter vos données de voyage';

  @override
  String get about => 'À Propos';

  @override
  String get appVersion => 'Version de l\'App';

  @override
  String get rateApp => 'Évaluer l\'App';

  @override
  String get leaveAReviewOnTheAppStore => 'Laisser un avis sur l\'App Store';

  @override
  String get helpAndSupport => 'Aide et Support';

  @override
  String get faqsAndContactInformation => 'FAQ et informations de contact';

  @override
  String get privacyPolicy => 'Politique de Confidentialité';

  @override
  String get readOurPrivacyPolicy => 'Lire notre politique de confidentialité';

  @override
  String get termsOfService => 'Conditions de Service';

  @override
  String get readOurTermsAndConditions => 'Lire nos conditions générales';

  @override
  String get dangerZone => 'Zone de Danger';

  @override
  String get clearAllData => 'Effacer Toutes les Données';

  @override
  String get removeAllTripsAndDocuments =>
      'Supprimer tous les voyages et documents';

  @override
  String get clearAllDataConfirmation =>
      'Cette action ne peut pas être annulée. Tous vos voyages, documents et paramètres seront supprimés définitivement.';

  @override
  String get cancel => 'Annuler';

  @override
  String get clearAll => 'Tout Effacer';

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
  String get title => 'Titre';

  @override
  String get description => 'Description';

  @override
  String get amount => 'Montant';

  @override
  String get date => 'Date';

  @override
  String get edit => 'Modifier';

  @override
  String get retry => 'Réessayer';

  @override
  String get add => 'Ajouter';

  @override
  String get update => 'Mettre à jour';

  @override
  String get close => 'Fermer';

  @override
  String get failedToLoad => 'Échec du chargement';

  @override
  String get noDataYet => 'Pas encore de données';

  @override
  String get startPlanning =>
      'Commencez à planifier votre prochaine aventure !';

  @override
  String get createTrip => 'Créer un Voyage';

  @override
  String get addDocument => 'Ajouter un Document';

  @override
  String get addExpense => 'Ajouter une Dépense';

  @override
  String get addActivity => 'Ajouter une Activité';

  @override
  String get addBooking => 'Ajouter une Réservation';

  @override
  String get totalExpenses => 'Dépenses Totales';

  @override
  String get toDoItems => 'Tâches à Faire';

  @override
  String get expenseDetails => 'Détails de la Dépense';

  @override
  String get expenseTitle => 'Titre de la Dépense';

  @override
  String get category => 'Catégorie';

  @override
  String get paidBy => 'Payé par';

  @override
  String get you => 'Vous';

  @override
  String get allDay => 'Toute la journée';

  @override
  String get startTime => 'Heure de début';

  @override
  String get endTime => 'Heure de fin';

  @override
  String get activityTitle => 'Titre de l\'Activité';

  @override
  String get activityType => 'Type d\'Activité';

  @override
  String get bookingTitle => 'Titre de la Réservation';

  @override
  String get bookingType => 'Réservation';

  @override
  String get status => 'Statut';

  @override
  String get addFile => 'Ajouter un Fichier';

  @override
  String get fileNotFound => 'Fichier introuvable';

  @override
  String get fileMovedOrDeleted =>
      'Le fichier a peut-être été déplacé ou supprimé';

  @override
  String get cannotDisplayImage => 'Impossible d\'afficher l\'image';

  @override
  String get openExternally => 'Ouvrir Externement';

  @override
  String get failedToReadFile => 'Échec de la lecture des données du fichier';

  @override
  String get deleteExpense => 'Supprimer la Dépense';

  @override
  String get deleteExpenseConfirmation =>
      'Êtes-vous sûr de vouloir supprimer cette dépense ?';

  @override
  String get expenseBreakdown => 'Répartition des Dépenses';

  @override
  String get breakdown => 'Répartition';

  @override
  String get noExpensesYet => 'Pas encore de dépenses';

  @override
  String get noActivitiesPlanned => 'Aucune activité planifiée';

  @override
  String get splitDetails => 'Détails du Partage';

  @override
  String get editExpense => 'Modifier la Dépense';

  @override
  String get addNewExpense => 'Ajouter une Nouvelle Dépense';

  @override
  String get editActivity => 'Modifier l\'Activité';

  @override
  String get addNewActivity => 'Ajouter une Nouvelle Activité';

  @override
  String get editBooking => 'Modifier la Réservation';

  @override
  String get addNewBooking => 'Ajouter une Nouvelle Réservation';

  @override
  String get updateExpense => 'Mettre à jour la Dépense';

  @override
  String get updateActivity => 'Mettre à jour l\'Activité';

  @override
  String get updateBooking => 'Mettre à jour la Réservation';

  @override
  String get transport => 'Transport';

  @override
  String get accommodation => 'Hébergement';

  @override
  String get activities => 'Activités';

  @override
  String get shopping => 'Shopping';

  @override
  String get sightseeing => 'Tourisme';

  @override
  String get meal => 'Repas';

  @override
  String get entertainment => 'Divertissement';

  @override
  String get other => 'Autre';

  @override
  String get noBookingsYet => 'Pas encore de réservations';

  @override
  String get addFirstBooking => 'Ajouter la Première Réservation';

  @override
  String get bookingDetails => 'Détails de la Réservation';

  @override
  String get vendor => 'Fournisseur';

  @override
  String get confirmationNumber => 'Numéro de Confirmation';

  @override
  String get attachments => 'Pièces Jointes';

  @override
  String get failedToLoadTodos => 'Échec du chargement des tâches';

  @override
  String get task => 'Tâche';

  @override
  String allWithCount(int count) {
    return 'Toutes ($count)';
  }

  @override
  String get noToDoItems => 'Aucune tâche';

  @override
  String get stayOrganizedMessage =>
      'Restez organisé en ajoutant des tâches pour planifier votre voyage !';

  @override
  String get addFirstTask => 'Ajouter la première tâche';

  @override
  String get taskDetails => 'Détails de la tâche';

  @override
  String get completed => 'Terminé';

  @override
  String get pending => 'En attente';

  @override
  String get priority => 'Priorité';

  @override
  String get dueDate => 'Date d\'échéance';

  @override
  String get editTask => 'Modifier la tâche';

  @override
  String get addNewTask => 'Ajouter une nouvelle tâche';

  @override
  String get updateTask => 'Mettre à jour la tâche';

  @override
  String get addTask => 'Ajouter la tâche';

  @override
  String get deleteTask => 'Supprimer la tâche';

  @override
  String deleteTaskConfirmation(String title) {
    return 'Êtes-vous sûr de vouloir supprimer \"$title\" ? Cette action ne peut pas être annulée.';
  }

  @override
  String get keepTrackMessage =>
      'Gardez une trace de vos vols, hôtels et activités !';

  @override
  String get previewNotAvailable =>
      'Aperçu non disponible pour ce type de fichier.\nAppuyez sur \"Ouvrir à l\'extérieur\" pour voir avec une autre application.';

  @override
  String get appVersionBeta => '1.0.0 (Bêta)';

  @override
  String get defaultUserName => 'Jean Dupont';

  @override
  String get defaultUserEmail => 'jean.dupont@email.com';

  @override
  String get taskTitle => 'Titre de la tâche';

  @override
  String get descriptionOptional => 'Description (Optionnel)';

  @override
  String get setDueDateOptional => 'Définir la date d\'échéance (Optionnel)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Échéance : $day/$month/$year';
  }

  @override
  String get urgent => 'Urgent';

  @override
  String get high => 'Élevé';

  @override
  String get medium => 'Moyen';

  @override
  String get low => 'Faible';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Échec de $action la tâche : $error';
  }

  @override
  String get vendorCompanyOptional => 'Fournisseur/Entreprise (Optionnel)';

  @override
  String get confirmationNumberOptional => 'Numéro de confirmation (Optionnel)';

  @override
  String amountCurrency(String currency) {
    return 'Montant ($currency)';
  }

  @override
  String get setBookingDateOptional =>
      'Définir la date de réservation (Optionnel)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Date : $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Pièces jointes (Optionnel)';

  @override
  String get maxFileSizeSupported =>
      'Taille max du fichier : 5MB\nFormats supportés : PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Échec de $action la réservation : $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename joint avec succès';
  }

  @override
  String get fileSizeMustBeLess =>
      'La taille du fichier doit être inférieure à 5MB';

  @override
  String failedToPickFile(String error) {
    return 'Échec de sélection du fichier : $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Erreur lors du partage du fichier : $error';
  }

  @override
  String get unknown => 'Inconnu';

  @override
  String get editTrip => 'Modifier le Voyage';

  @override
  String get updateTrip => 'Mettre à jour le Voyage';

  @override
  String get tripUpdatedSuccessfully => 'Voyage mis à jour avec succès';

  @override
  String get failedToUpdateTrip => 'Échec de la mise à jour du voyage';

  @override
  String get deleteTrip => 'Supprimer le Voyage';

  @override
  String get deleteTripConfirmation =>
      'Êtes-vous sûr de vouloir supprimer ce voyage ? Cette action ne peut pas être annulée.';

  @override
  String get tripDeletedSuccessfully => 'Voyage supprimé avec succès';

  @override
  String get failedToDeleteTrip => 'Échec de la suppression du voyage';

  @override
  String get tripCreatedSuccessfully => 'Voyage créé avec succès !';

  @override
  String get failedToCreateTrip => 'Échec de la création du voyage';

  @override
  String get selectStartDateFirst =>
      'Veuillez d\'abord sélectionner la date de début';

  @override
  String get addAtLeastOneDestination =>
      'Veuillez ajouter au moins une destination';

  @override
  String get selectBothStartAndEndDates =>
      'Veuillez sélectionner les dates de début et de fin';

  @override
  String get titleIsRequired => 'Le titre est requis';

  @override
  String titleTooLong(int limit) {
    return 'Le titre doit contenir $limit caractères ou moins';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'La description doit contenir $limit caractères ou moins';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Fournisseur/Entreprise doit contenir $limit caractères ou moins';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'Le numéro de confirmation doit contenir $limit caractères ou moins';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Payé par doit contenir $limit caractères ou moins';
  }

  @override
  String locationTooLong(int limit) {
    return 'L\'emplacement doit contenir $limit caractères ou moins';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'La description doit contenir $limit caractères ou moins';
  }

  @override
  String get amountIsRequired => 'Le montant est requis';

  @override
  String get enterValidAmount => 'Veuillez entrer un montant valide';

  @override
  String get amountMustBePositive => 'Le montant doit être positif';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName est requis';
  }

  @override
  String get destinationIsRequired => 'La destination est requise';

  @override
  String destinationTooLong(int limit) {
    return 'La destination doit contenir $limit caractères ou moins';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (Optionnel)';
  }

  @override
  String maxCharacters(int maxLength) {
    return 'Maximum $maxLength caractères';
  }

  @override
  String get searchTripsPlaceholder => 'Rechercher des voyages...';

  @override
  String allWithTotal(int total) {
    return 'Tous ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'À venir ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Actifs ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Terminés ($count)';
  }

  @override
  String get yourTripsTitle => 'Vos Voyages';

  @override
  String activeTripsCount(int count) {
    return '$count Actifs';
  }

  @override
  String get bookingsTabTitle => 'Réservations';

  @override
  String get expensesTabTitle => 'Dépenses';

  @override
  String get overviewTabTitle => 'Aperçu';

  @override
  String get todoTabTitle => 'À Faire';

  @override
  String get itineraryTabTitle => 'Itinéraire';

  @override
  String get failedToLoadTrip => 'Échec du chargement du voyage';

  @override
  String get tripNotFound => 'Voyage non trouvé';

  @override
  String get saveImage => 'Enregistrer l\'Image';

  @override
  String get saveToPhotos => 'Enregistrer dans Photos';

  @override
  String get saveToPhotosDescription =>
      'Enregistrer directement dans votre galerie de photos';

  @override
  String get saveToFiles => 'Enregistrer dans Fichiers';

  @override
  String get saveToFilesDescription =>
      'Choisir un dossier spécifique pour enregistrer';

  @override
  String get imageSavedToPhotos => 'Image enregistrée dans Photos';

  @override
  String get fileSavedSuccessfully => 'Fichier enregistré avec succès';

  @override
  String get open => 'Ouvrir';

  @override
  String errorDownloadingFile(String error) {
    return 'Erreur lors du téléchargement du fichier : $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Erreur lors de l\'enregistrement dans Photos : $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Erreur lors de l\'enregistrement du fichier : $error';
  }

  @override
  String get selectDocument => 'Sélectionner un Document';

  @override
  String get chooseFromGalleryTitle => 'Choisir dans la Galerie';

  @override
  String get chooseFromGalleryDescription => 'Sélectionner dans la photothèque';

  @override
  String get chooseFileTitle => 'Choisir un Fichier';

  @override
  String get chooseFileDescription =>
      'Sélectionner un PDF ou d\'autres fichiers';

  @override
  String get failedToCaptureImage => 'Échec de la capture d\'image';

  @override
  String get failedToSelectImage => 'Échec de la sélection d\'image';

  @override
  String get failedToSelectFile => 'Échec de la sélection de fichier';

  @override
  String get documentAddedSuccessfully => 'Document ajouté avec succès';

  @override
  String get documentUpdatedSuccessfully => 'Document mis à jour avec succès';

  @override
  String get failedToSaveDocument => 'Échec de l\'enregistrement du document';

  @override
  String get documentTitle => 'Titre du Document *';

  @override
  String get documentCategory => 'Catégorie de Document';

  @override
  String get changeDocument => 'Changer de Document';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get noDocumentsYet => 'Aucun document encore';

  @override
  String get noDocumentsFound => 'Aucun document trouvé';

  @override
  String get clearSearch => 'Effacer la recherche';

  @override
  String get documentDetails => 'Détails du Document';

  @override
  String get fileSize => 'Taille du Fichier';

  @override
  String get fileName => 'Nom du Fichier';

  @override
  String get deleteDocument => 'Supprimer le Document';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Êtes-vous sûr de vouloir supprimer \"$title\" ? Cette action ne peut pas être annulée.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Document \"$title\" supprimé avec succès';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Échec de la suppression du document : $error';
  }

  @override
  String get location => 'Emplacement';

  @override
  String get activityTitleLabel => 'Titre de l\'Activité';

  @override
  String get activityTypeLabel => 'Type d\'Activité';

  @override
  String get expenseTitleLabel => 'Titre de la Dépense';

  @override
  String get destinations => 'Destinations';

  @override
  String get currency => 'Devise';

  @override
  String get tripInProgressStatus => 'Voyage en Cours';

  @override
  String get completedStatus => 'Terminé';

  @override
  String get tripDates => 'Dates du Voyage';

  @override
  String get expenseType => 'Dépense';

  @override
  String get expenseDetailsTitle => 'Détails de la Dépense';

  @override
  String get activityDetailsTitle => 'Détails de l\'Activité';

  @override
  String get deleteActivity => 'Supprimer l\'Activité';

  @override
  String get deleteBooking => 'Supprimer la Réservation';

  @override
  String get january => 'Jan';

  @override
  String get february => 'Fév';

  @override
  String get march => 'Mar';

  @override
  String get april => 'Avr';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Juin';

  @override
  String get july => 'Juil';

  @override
  String get august => 'Août';

  @override
  String get september => 'Sep';

  @override
  String get october => 'Oct';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Déc';

  @override
  String get food => 'Nourriture';

  @override
  String get confirmed => 'Confirmé';

  @override
  String get cancelled => 'Annulé';

  @override
  String get passport => 'Passeport';

  @override
  String get visa => 'Visa';

  @override
  String get ticket => 'Billet';

  @override
  String get hotel => 'Hôtel';

  @override
  String get insurance => 'Assurance';

  @override
  String get editDocument => 'Modifier le document';

  @override
  String get updateDocument => 'Mettre à jour le document';

  @override
  String get saveToGallery => 'Enregistrer dans la galerie';

  @override
  String get flight => 'Vol';

  @override
  String get restaurant => 'Restaurant';

  @override
  String get bookingLimitReached =>
      'Limite de réservations atteinte. Vous ne pouvez ajouter que 15 réservations par voyage.';

  @override
  String get documentLimitReached =>
      'Limite de documents atteinte. Vous ne pouvez ajouter que 10 documents au total.';

  @override
  String get clearFilters => 'Effacer les Filtres';

  @override
  String get travelDates => 'Dates de Voyage';

  @override
  String get selectDateRange => 'Sélectionner une plage de dates';

  @override
  String get activityDetails => 'Détails de l\'activité';

  @override
  String get quickActions => 'Actions Rapides';

  @override
  String get addNewItemsToTrip => 'Ajoutez de nouveaux éléments à votre voyage';

  @override
  String get booking => 'Réservation';

  @override
  String get expense => 'Dépense';

  @override
  String get itinerary => 'Itinéraire';

  @override
  String get duration => 'Durée';

  @override
  String get noExpensesFound => 'Aucune dépense trouvée';

  @override
  String get noExpensesFoundForCategory =>
      'Aucune dépense trouvée pour cette catégorie';

  @override
  String get noTasksFound => 'Aucune tâche trouvée';

  @override
  String get noBookingsFound => 'Aucune réservation trouvée';

  @override
  String get noTripsFound => 'Aucun voyage trouvé';

  @override
  String get tryAdjustingFilters =>
      'Essayez d\'ajuster vos termes de recherche ou filtres';

  @override
  String get searchTasks => 'Rechercher tâches...';

  @override
  String get searchBookings => 'Rechercher réservations...';

  @override
  String get urgentPriority => 'Urgent';

  @override
  String get highPriority => 'Élevé';

  @override
  String get mediumPriority => 'Moyen';

  @override
  String get lowPriority => 'Faible';

  @override
  String get overdue => 'En retard';

  @override
  String get dueToday => 'Dû aujourd\'hui';

  @override
  String get dueTomorrow => 'Dû demain';

  @override
  String get activeStatus => 'Actif';

  @override
  String get selectBackupFile => 'Sélectionner un Fichier de Sauvegarde';

  @override
  String get selectFile => 'Sélectionner un Fichier';

  @override
  String get importBackup => 'Importer la Sauvegarde';

  @override
  String get importSuccessful => 'Importation Réussie';

  @override
  String get importFailed => 'Échec de l\'Importation';

  @override
  String get couldNotOpenAppStore => 'Impossible d\'ouvrir l\'App Store';

  @override
  String get couldNotOpenHelpSection =>
      'Impossible d\'ouvrir la section d\'aide';

  @override
  String get couldNotOpenPrivacyPolicy =>
      'Impossible d\'ouvrir la politique de confidentialité';

  @override
  String get couldNotOpenTermsOfService =>
      'Impossible d\'ouvrir les conditions de service';

  @override
  String get confirmActionWarning => 'Cette action ne peut pas être annulée !';

  @override
  String get finalConfirmationTitle => 'Confirmation Finale';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Tapez $word dans la zone ci-dessous pour confirmer :';
  }

  @override
  String get deletingAllData => 'Suppression de toutes les données...';

  @override
  String get pleaseWait => 'Veuillez patienter, cela peut prendre un moment.';

  @override
  String get dataClearedTitle => 'Données Effacées';

  @override
  String get dataClearedMessage =>
      'Toutes vos données ont été supprimées avec succès. L\'application a été remise à son état initial.';

  @override
  String get errorTitle => 'Erreur';

  @override
  String failedToClearAllData(String error) {
    return 'Échec de l\'effacement de toutes les données : $error';
  }

  @override
  String get exportIntroTitle =>
      'Créer une sauvegarde sécurisée de toutes vos données Voythrix :';

  @override
  String get exportEncryptionInfo =>
      'Vos données seront cryptées et compressées dans un fichier .tripe.';

  @override
  String get backupPasswordTitle => 'Mot de Passe de Sauvegarde (Optionnel)';

  @override
  String get backupPasswordHint => 'Entrez le mot de passe (optionnel)';

  @override
  String get confirmPasswordHint => 'Confirmez le mot de passe';

  @override
  String get passwordsMatch => 'Les mots de passe correspondent';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get creatingBackup => 'Création de la sauvegarde...';

  @override
  String get collectingAndEncrypting =>
      'Collecte et cryptage de vos données...';

  @override
  String get backupCreatedTitle => 'Sauvegarde Créée';

  @override
  String get backupCreatedMessage =>
      'Votre sauvegarde a été créée avec succès !';

  @override
  String get fileInfoLabel => 'Informations du Fichier :';

  @override
  String get fileInfoFormat => '• Format : Fichier .tripe crypté';

  @override
  String get fileInfoSecurityPassword =>
      '• Sécurité : Protégé par mot de passe';

  @override
  String get fileInfoSecurityStandard => '• Sécurité : Cryptage standard';

  @override
  String get fileInfoCompression => '• Compression : Compression GZip';

  @override
  String get keepFileSafeNote =>
      'Gardez ce fichier en sécurité — vous en aurez besoin pour restaurer vos données !';

  @override
  String get exportFailedTitle => 'Échec de l\'Exportation';

  @override
  String failedToCreateBackup(String error) {
    return 'Échec de la création de la sauvegarde : $error';
  }

  @override
  String get continueAction => 'Continuer';

  @override
  String get deleteEverything => 'Tout Supprimer';

  @override
  String get createBackup => 'Créer une Sauvegarde';

  @override
  String get ok => 'OK';
}
