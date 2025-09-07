// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tripease';

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
  String get pushNotifications => 'Notifications Push';

  @override
  String get getRemindersAndUpdates => 'Recevoir des rappels et mises à jour';

  @override
  String get locationServices => 'Services de Localisation';

  @override
  String get allowLocationBasedFeatures =>
      'Autoriser les fonctionnalités basées sur la localisation';

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
}
