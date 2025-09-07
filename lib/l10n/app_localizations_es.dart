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

  @override
  String get title => 'Título';

  @override
  String get description => 'Descripción';

  @override
  String get amount => 'Cantidad';

  @override
  String get date => 'Fecha';

  @override
  String get edit => 'Editar';

  @override
  String get retry => 'Reintentar';

  @override
  String get add => 'Agregar';

  @override
  String get update => 'Actualizar';

  @override
  String get close => 'Cerrar';

  @override
  String get failedToLoad => 'Error al cargar';

  @override
  String get noDataYet => 'Aún no hay datos';

  @override
  String get startPlanning => '¡Comienza a planificar tu próxima aventura!';

  @override
  String get createTrip => 'Crear Viaje';

  @override
  String get addExpense => 'Agregar Gasto';

  @override
  String get addActivity => 'Agregar Actividad';

  @override
  String get addBooking => 'Agregar Reserva';

  @override
  String get totalExpenses => 'Gastos Totales';

  @override
  String get toDoItems => 'Tareas Pendientes';

  @override
  String get expenseDetails => 'Detalles del Gasto';

  @override
  String get expenseTitle => 'Título del Gasto';

  @override
  String get category => 'Categoría';

  @override
  String get paidBy => 'Pagado por';

  @override
  String get you => 'Tú';

  @override
  String get allDay => 'Todo el día';

  @override
  String get startTime => 'Hora de inicio';

  @override
  String get endTime => 'Hora de fin';

  @override
  String get activityTitle => 'Título de la Actividad';

  @override
  String get activityType => 'Tipo de Actividad';

  @override
  String get bookingTitle => 'Título de la Reserva';

  @override
  String get bookingType => 'Tipo de Reserva';

  @override
  String get status => 'Estado';

  @override
  String get addFile => 'Agregar Archivo';

  @override
  String get fileNotFound => 'Archivo no encontrado';

  @override
  String get fileMovedOrDeleted =>
      'El archivo puede haber sido movido o eliminado';

  @override
  String get cannotDisplayImage => 'No se puede mostrar la imagen';

  @override
  String get openExternally => 'Abrir Externamente';

  @override
  String get failedToReadFile => 'Error al leer los datos del archivo';

  @override
  String get deleteExpense => 'Eliminar Gasto';

  @override
  String get deleteExpenseConfirmation =>
      '¿Estás seguro de que quieres eliminar este gasto?';

  @override
  String get expenseBreakdown => 'Desglose de Gastos';

  @override
  String get breakdown => 'Desglose';

  @override
  String get noExpensesYet => 'Aún no hay gastos';

  @override
  String get noActivitiesPlanned => 'No hay actividades planificadas';

  @override
  String get splitDetails => 'Detalles de División';

  @override
  String get editExpense => 'Editar Gasto';

  @override
  String get addNewExpense => 'Agregar Nuevo Gasto';

  @override
  String get editActivity => 'Editar Actividad';

  @override
  String get addNewActivity => 'Agregar Nueva Actividad';

  @override
  String get editBooking => 'Editar Reserva';

  @override
  String get addNewBooking => 'Agregar Nueva Reserva';

  @override
  String get updateExpense => 'Actualizar Gasto';

  @override
  String get updateActivity => 'Actualizar Actividad';

  @override
  String get updateBooking => 'Actualizar Reserva';

  @override
  String get transport => 'Transporte';

  @override
  String get accommodation => 'Alojamiento';

  @override
  String get activities => 'Actividades';

  @override
  String get shopping => 'Compras';

  @override
  String get sightseeing => 'Turismo';

  @override
  String get meal => 'Comida';

  @override
  String get entertainment => 'Entretenimiento';

  @override
  String get other => 'Otro';

  @override
  String get noBookingsYet => 'Aún no hay reservas';

  @override
  String get addFirstBooking => 'Agregar Primera Reserva';

  @override
  String get bookingDetails => 'Detalles de la Reserva';

  @override
  String get vendor => 'Proveedor';

  @override
  String get confirmationNumber => 'Número de Confirmación';

  @override
  String get attachments => 'Adjuntos';

  @override
  String get failedToLoadTodos => 'Error al cargar las tareas';

  @override
  String get task => 'Tarea';

  @override
  String allWithCount(int count) {
    return 'Todas ($count)';
  }

  @override
  String get noToDoItems => 'Sin tareas pendientes';

  @override
  String get stayOrganizedMessage =>
      '¡Mantente organizado agregando tareas para planificar tu viaje!';

  @override
  String get addFirstTask => 'Agregar primera tarea';

  @override
  String get taskDetails => 'Detalles de la tarea';

  @override
  String get completed => 'Completado';

  @override
  String get pending => 'Pendiente';

  @override
  String get priority => 'Prioridad';

  @override
  String get dueDate => 'Fecha de vencimiento';

  @override
  String get editTask => 'Editar tarea';

  @override
  String get addNewTask => 'Agregar nueva tarea';

  @override
  String get updateTask => 'Actualizar tarea';

  @override
  String get addTask => 'Agregar tarea';

  @override
  String get deleteTask => 'Eliminar tarea';

  @override
  String deleteTaskConfirmation(String title) {
    return '¿Estás seguro de que quieres eliminar \"$title\"? Esta acción no se puede deshacer.';
  }

  @override
  String get keepTrackMessage =>
      '¡Mantén un registro de tus vuelos, hoteles y actividades!';

  @override
  String get previewNotAvailable =>
      'Vista previa no disponible para este tipo de archivo.\nToca \"Abrir externamente\" para ver con otra aplicación.';

  @override
  String get appVersionBeta => '1.0.0 (Beta)';

  @override
  String get defaultUserName => 'Juan Pérez';

  @override
  String get defaultUserEmail => 'juan.perez@email.com';

  @override
  String get taskTitle => 'Título de la tarea';

  @override
  String get descriptionOptional => 'Descripción (Opcional)';

  @override
  String get setDueDateOptional => 'Establecer fecha límite (Opcional)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Vencimiento: $day/$month/$year';
  }

  @override
  String get urgent => 'Urgente';

  @override
  String get high => 'Alta';

  @override
  String get medium => 'Media';

  @override
  String get low => 'Baja';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Error al $action tarea: $error';
  }

  @override
  String get vendorCompanyOptional => 'Proveedor/Empresa (Opcional)';

  @override
  String get confirmationNumberOptional => 'Número de confirmación (Opcional)';

  @override
  String amountCurrency(String currency) {
    return 'Cantidad ($currency)';
  }

  @override
  String get setBookingDateOptional => 'Establecer fecha de reserva (Opcional)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Fecha: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Adjuntos (Opcional)';

  @override
  String get maxFileSizeSupported =>
      'Tamaño máximo de archivo: 5MB\nFormatos soportados: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Error al $action reserva: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename adjuntado exitosamente';
  }

  @override
  String get fileSizeMustBeLess => 'El tamaño del archivo debe ser menor a 5MB';

  @override
  String failedToPickFile(String error) {
    return 'Error al seleccionar archivo: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Error al compartir archivo: $error';
  }

  @override
  String get unknown => 'Desconocido';
}
