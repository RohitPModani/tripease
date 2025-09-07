// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Tripease';

  @override
  String get trips => 'Viajes';

  @override
  String get documents => 'Documentos';

  @override
  String get settings => 'Configuración';

  @override
  String get quickStats => 'Estadísticas Rápidas';

  @override
  String get activeTrips => 'Viajes Activos';

  @override
  String get pendingTasks => 'Tareas Pendientes';

  @override
  String get totalBudget => 'Presupuesto Total';

  @override
  String nextTripStartsIn(int days) {
    return 'El próximo viaje comienza en $days días';
  }

  @override
  String get yourTrips => 'Tus Viajes';

  @override
  String get searchTrips => 'Buscar viajes...';

  @override
  String get daysUntilStart => 'Días Hasta el Inicio';

  @override
  String get dateCreated => 'Fecha de Creación';

  @override
  String get alphabetical => 'Alfabético';

  @override
  String get budget => 'Presupuesto';

  @override
  String get tasks => 'Tareas';

  @override
  String get tripInProgress => 'Viaje en Progreso';

  @override
  String get startingToday => '¡Comienza Hoy!';

  @override
  String daysToGo(int days) {
    return '$days días restantes';
  }

  @override
  String active(int count) {
    return '$count Activos';
  }

  @override
  String get searchDocuments => 'Buscar documentos...';

  @override
  String get personal => 'Personal';

  @override
  String get tripRelated => 'Relacionado con Viajes';

  @override
  String get uploadDocument => 'Subir Documento';

  @override
  String get takePhoto => 'Tomar Foto';

  @override
  String get captureDocumentWithCamera => 'Capturar documento con cámara';

  @override
  String get chooseFromGallery => 'Elegir de la Galería';

  @override
  String get selectFromPhotoLibrary => 'Seleccionar de la biblioteca de fotos';

  @override
  String get chooseFile => 'Elegir Archivo';

  @override
  String get selectPdfOrOtherFiles => 'Seleccionar PDF u otros archivos';

  @override
  String expires(String date) {
    return 'Expira: $date';
  }

  @override
  String get view => 'Ver';

  @override
  String get share => 'Compartir';

  @override
  String get download => 'Descargar';

  @override
  String get delete => 'Eliminar';

  @override
  String get profile => 'Perfil';

  @override
  String get preferences => 'Preferencias';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'Cambiar entre tema claro y oscuro';

  @override
  String get language => 'Idioma';

  @override
  String get selectYourPreferredLanguage => 'Selecciona tu idioma preferido';

  @override
  String get defaultCurrency => 'Moneda Predeterminada';

  @override
  String get currencyUsedForNewTrips => 'Moneda utilizada para nuevos viajes';

  @override
  String get dateFormat => 'Formato de Fecha';

  @override
  String get howDatesAreDisplayed => 'Cómo se muestran las fechas';

  @override
  String get temperatureUnit => 'Unidad de Temperatura';

  @override
  String get temperatureScalePreference =>
      'Preferencia de escala de temperatura';

  @override
  String get appSettings => 'Configuración de la App';

  @override
  String get pushNotifications => 'Notificaciones Push';

  @override
  String get getRemindersAndUpdates =>
      'Recibir recordatorios y actualizaciones';

  @override
  String get locationServices => 'Servicios de Ubicación';

  @override
  String get allowLocationBasedFeatures =>
      'Permitir funciones basadas en ubicación';

  @override
  String get backupAndSync => 'Copia de Seguridad y Sincronización';

  @override
  String get manageYourDataBackup => 'Gestionar tu copia de seguridad de datos';

  @override
  String get importData => 'Importar Datos';

  @override
  String get importTripsFromOtherApps =>
      'Importar viajes de otras aplicaciones';

  @override
  String get exportData => 'Exportar Datos';

  @override
  String get exportYourTripData => 'Exportar tus datos de viaje';

  @override
  String get about => 'Acerca de';

  @override
  String get appVersion => 'Versión de la App';

  @override
  String get rateApp => 'Calificar App';

  @override
  String get leaveAReviewOnTheAppStore => 'Dejar una reseña en la App Store';

  @override
  String get helpAndSupport => 'Ayuda y Soporte';

  @override
  String get faqsAndContactInformation =>
      'Preguntas frecuentes e información de contacto';

  @override
  String get privacyPolicy => 'Política de Privacidad';

  @override
  String get readOurPrivacyPolicy => 'Leer nuestra política de privacidad';

  @override
  String get termsOfService => 'Términos de Servicio';

  @override
  String get readOurTermsAndConditions =>
      'Leer nuestros términos y condiciones';

  @override
  String get dangerZone => 'Zona de Peligro';

  @override
  String get clearAllData => 'Borrar Todos los Datos';

  @override
  String get removeAllTripsAndDocuments =>
      'Eliminar todos los viajes y documentos';

  @override
  String get clearAllDataConfirmation =>
      'Esta acción no se puede deshacer. Todos tus viajes, documentos y configuraciones serán eliminados permanentemente.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clearAll => 'Borrar Todo';

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
