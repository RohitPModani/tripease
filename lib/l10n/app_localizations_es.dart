// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

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
  String get addDocument => 'Agregar Documento';

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
  String get bookingType => 'Reserva';

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

  @override
  String get editTrip => 'Editar Viaje';

  @override
  String get updateTrip => 'Actualizar Viaje';

  @override
  String get tripUpdatedSuccessfully => 'Viaje actualizado exitosamente';

  @override
  String get failedToUpdateTrip => 'Error al actualizar el viaje';

  @override
  String get deleteTrip => 'Eliminar Viaje';

  @override
  String get deleteTripConfirmation =>
      '¿Estás seguro de que quieres eliminar este viaje? Esta acción no se puede deshacer.';

  @override
  String get tripDeletedSuccessfully => 'Viaje eliminado exitosamente';

  @override
  String get failedToDeleteTrip => 'Error al eliminar el viaje';

  @override
  String get tripCreatedSuccessfully => '¡Viaje creado exitosamente!';

  @override
  String get failedToCreateTrip => 'Error al crear el viaje';

  @override
  String get selectStartDateFirst =>
      'Por favor selecciona primero la fecha de inicio';

  @override
  String get addAtLeastOneDestination => 'Por favor agrega al menos un destino';

  @override
  String get selectBothStartAndEndDates =>
      'Por favor selecciona tanto la fecha de inicio como la de fin';

  @override
  String get titleIsRequired => 'El título es obligatorio';

  @override
  String titleTooLong(int limit) {
    return 'El título debe tener $limit caracteres o menos';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'La descripción debe tener $limit caracteres o menos';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Proveedor/Empresa debe tener $limit caracteres o menos';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'El número de confirmación debe tener $limit caracteres o menos';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Pagado por debe tener $limit caracteres o menos';
  }

  @override
  String locationTooLong(int limit) {
    return 'La ubicación debe tener $limit caracteres o menos';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'La descripción debe tener $limit caracteres o menos';
  }

  @override
  String get amountIsRequired => 'El monto es obligatorio';

  @override
  String get enterValidAmount => 'Por favor ingrese un monto válido';

  @override
  String get amountMustBePositive => 'El monto debe ser positivo';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName es obligatorio';
  }

  @override
  String get destinationIsRequired => 'El destino es obligatorio';

  @override
  String destinationTooLong(int limit) {
    return 'El destino debe tener $limit caracteres o menos';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (Opcional)';
  }

  @override
  String maxCharacters(int maxLength) {
    return '$maxLength máx';
  }

  @override
  String get searchTripsPlaceholder => 'Buscar viajes...';

  @override
  String allWithTotal(int total) {
    return 'Todas ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'Próximas ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Activas ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Completadas ($count)';
  }

  @override
  String get yourTripsTitle => 'Tus Viajes';

  @override
  String activeTripsCount(int count) {
    return '$count Activos';
  }

  @override
  String get bookingsTabTitle => 'Reservas';

  @override
  String get expensesTabTitle => 'Gastos';

  @override
  String get overviewTabTitle => 'Resumen';

  @override
  String get todoTabTitle => 'Tareas';

  @override
  String get itineraryTabTitle => 'Itinerario';

  @override
  String get failedToLoadTrip => 'Error al cargar el viaje';

  @override
  String get tripNotFound => 'Viaje no encontrado';

  @override
  String get saveImage => 'Guardar Imagen';

  @override
  String get saveToPhotos => 'Guardar en Fotos';

  @override
  String get saveToPhotosDescription =>
      'Guardar directamente en tu galería de fotos';

  @override
  String get saveToFiles => 'Guardar en Archivos';

  @override
  String get saveToFilesDescription =>
      'Elegir una carpeta específica para guardar';

  @override
  String get imageSavedToPhotos => 'Imagen guardada en Fotos';

  @override
  String get fileSavedSuccessfully => 'Archivo guardado exitosamente';

  @override
  String get open => 'Abrir';

  @override
  String errorDownloadingFile(String error) {
    return 'Error al descargar archivo: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Error al guardar en Fotos: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Error al guardar archivo: $error';
  }

  @override
  String get selectDocument => 'Seleccionar Documento';

  @override
  String get chooseFromGalleryTitle => 'Elegir de la Galería';

  @override
  String get chooseFromGalleryDescription =>
      'Seleccionar de la biblioteca de fotos';

  @override
  String get chooseFileTitle => 'Elegir Archivo';

  @override
  String get chooseFileDescription => 'Seleccionar PDF u otros archivos';

  @override
  String get failedToCaptureImage => 'Error al capturar imagen';

  @override
  String get failedToSelectImage => 'Error al seleccionar imagen';

  @override
  String get failedToSelectFile => 'Error al seleccionar archivo';

  @override
  String get documentAddedSuccessfully => 'Documento agregado exitosamente';

  @override
  String get documentUpdatedSuccessfully =>
      'Documento actualizado exitosamente';

  @override
  String get failedToSaveDocument => 'Error al guardar documento';

  @override
  String get documentTitle => 'Título del Documento *';

  @override
  String get documentCategory => 'Categoría de Documento';

  @override
  String get changeDocument => 'Cambiar Documento';

  @override
  String get documentsTitle => 'Documentos';

  @override
  String get noDocumentsYet => 'Aún no hay documentos';

  @override
  String get noDocumentsFound => 'No se encontraron documentos';

  @override
  String get clearSearch => 'Limpiar búsqueda';

  @override
  String get documentDetails => 'Detalles del Documento';

  @override
  String get fileSize => 'Tamaño del Archivo';

  @override
  String get fileName => 'Nombre del Archivo';

  @override
  String get deleteDocument => 'Eliminar Documento';

  @override
  String deleteDocumentConfirmation(String title) {
    return '¿Estás seguro de que quieres eliminar \"$title\"? Esta acción no se puede deshacer.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Documento \"$title\" eliminado exitosamente';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Error al eliminar documento: $error';
  }

  @override
  String get location => 'Ubicación';

  @override
  String get activityTitleLabel => 'Título de la Actividad';

  @override
  String get activityTypeLabel => 'Tipo de Actividad';

  @override
  String get expenseTitleLabel => 'Título del Gasto';

  @override
  String get destinations => 'Destinos';

  @override
  String get currency => 'Moneda';

  @override
  String get tripInProgressStatus => 'Viaje en Progreso';

  @override
  String get completedStatus => 'Completado';

  @override
  String get tripDates => 'Fechas del Viaje';

  @override
  String get expenseType => 'Gasto';

  @override
  String get expenseDetailsTitle => 'Detalles del Gasto';

  @override
  String get activityDetailsTitle => 'Detalles de la Actividad';

  @override
  String get deleteActivity => 'Eliminar Actividad';

  @override
  String get deleteBooking => 'Eliminar Reserva';

  @override
  String get january => 'Ene';

  @override
  String get february => 'Feb';

  @override
  String get march => 'Mar';

  @override
  String get april => 'Abr';

  @override
  String get may => 'May';

  @override
  String get june => 'Jun';

  @override
  String get july => 'Jul';

  @override
  String get august => 'Ago';

  @override
  String get september => 'Sep';

  @override
  String get october => 'Oct';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Dic';

  @override
  String get food => 'Comida';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get passport => 'Pasaporte';

  @override
  String get visa => 'Visa';

  @override
  String get ticket => 'Boleto';

  @override
  String get hotel => 'Hotel';

  @override
  String get insurance => 'Seguro';

  @override
  String get editDocument => 'Editar Documento';

  @override
  String get updateDocument => 'Actualizar Documento';

  @override
  String get saveToGallery => 'Guardar en Galería';

  @override
  String get flight => 'Vuelo';

  @override
  String get restaurant => 'Restaurante';

  @override
  String get bookingLimitReached =>
      'Límite de reservas alcanzado. Solo puedes agregar hasta 15 reservas por viaje.';

  @override
  String get documentLimitReached =>
      'Límite de documentos alcanzado. Solo puedes agregar hasta 10 documentos en total.';

  @override
  String get clearFilters => 'Limpiar Filtros';

  @override
  String get travelDates => 'Fechas de Viaje';

  @override
  String get selectDateRange => 'Seleccionar rango de fechas';

  @override
  String get activityDetails => 'Activity Details';

  @override
  String get quickActions => 'Acciones Rápidas';

  @override
  String get addNewItemsToTrip => 'Agrega nuevos elementos a tu viaje';

  @override
  String get booking => 'Reserva';

  @override
  String get expense => 'Gasto';

  @override
  String get itinerary => 'Itinerario';

  @override
  String get duration => 'Duración';

  @override
  String get noExpensesFound => 'No se encontraron gastos';

  @override
  String get noExpensesFoundForCategory =>
      'No se encontraron gastos para esta categoría';

  @override
  String get noTasksFound => 'No se encontraron tareas';

  @override
  String get noBookingsFound => 'No se encontraron reservas';

  @override
  String get noTripsFound => 'No se encontraron viajes';

  @override
  String get tryAdjustingFilters =>
      'Intenta ajustar tus términos de búsqueda o filtros';

  @override
  String get searchTasks => 'Buscar tareas...';

  @override
  String get searchBookings => 'Buscar reservas...';

  @override
  String get urgentPriority => 'Urgente';

  @override
  String get highPriority => 'Alta';

  @override
  String get mediumPriority => 'Media';

  @override
  String get lowPriority => 'Baja';

  @override
  String get overdue => 'Vencido';

  @override
  String get dueToday => 'Vence hoy';

  @override
  String get dueTomorrow => 'Vence mañana';

  @override
  String get activeStatus => 'Activo';

  @override
  String get selectBackupFile => 'Seleccionar Archivo de Respaldo';

  @override
  String get selectFile => 'Seleccionar Archivo';

  @override
  String get importBackup => 'Importar Respaldo';

  @override
  String get importSuccessful => 'Importación Exitosa';

  @override
  String get importFailed => 'Importación Fallida';

  @override
  String get couldNotOpenAppStore =>
      'No se pudo abrir la tienda de aplicaciones';

  @override
  String get couldNotOpenHelpSection => 'No se pudo abrir la sección de ayuda';

  @override
  String get couldNotOpenPrivacyPolicy =>
      'No se pudo abrir la política de privacidad';

  @override
  String get couldNotOpenTermsOfService =>
      'No se pudo abrir los términos de servicio';

  @override
  String get confirmActionWarning => '¡Esta acción no se puede deshacer!';

  @override
  String get finalConfirmationTitle => 'Confirmación Final';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Escribe $word en el cuadro de abajo para confirmar:';
  }

  @override
  String get deletingAllData => 'Eliminando todos los datos...';

  @override
  String get pleaseWait => 'Por favor espera, esto puede tomar un momento.';

  @override
  String get dataClearedTitle => 'Datos Eliminados';

  @override
  String get dataClearedMessage =>
      'Todos tus datos han sido eliminados exitosamente. La aplicación se ha restablecido a su estado inicial.';

  @override
  String get errorTitle => 'Error';

  @override
  String failedToClearAllData(String error) {
    return 'Error al eliminar todos los datos: $error';
  }

  @override
  String get exportIntroTitle =>
      'Crear una copia de seguridad segura de todos tus datos de Voythrix:';

  @override
  String get exportEncryptionInfo =>
      'Tus datos serán cifrados y comprimidos en un archivo .tripe.';

  @override
  String get backupPasswordTitle =>
      'Contraseña de Copia de Seguridad (Opcional)';

  @override
  String get backupPasswordHint => 'Introduce contraseña (opcional)';

  @override
  String get confirmPasswordHint => 'Confirmar contraseña';

  @override
  String get passwordsMatch => 'Las contraseñas coinciden';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get creatingBackup => 'Creando copia de seguridad...';

  @override
  String get collectingAndEncrypting => 'Recopilando y cifrando tus datos...';

  @override
  String get backupCreatedTitle => 'Copia de Seguridad Creada';

  @override
  String get backupCreatedMessage =>
      '¡Tu copia de seguridad ha sido creada exitosamente!';

  @override
  String get fileInfoLabel => 'Información del Archivo:';

  @override
  String get fileInfoFormat => '• Formato: Archivo .tripe cifrado';

  @override
  String get fileInfoSecurityPassword =>
      '• Seguridad: Protegido con contraseña';

  @override
  String get fileInfoSecurityStandard => '• Seguridad: Cifrado estándar';

  @override
  String get fileInfoCompression => '• Compresión: Compresión GZip';

  @override
  String get keepFileSafeNote =>
      'Guarda este archivo de forma segura: ¡lo necesitarás para restaurar tus datos!';

  @override
  String get exportFailedTitle => 'Error de Exportación';

  @override
  String failedToCreateBackup(String error) {
    return 'Error al crear la copia de seguridad: $error';
  }

  @override
  String get continueAction => 'Continuar';

  @override
  String get deleteEverything => 'Eliminar Todo';

  @override
  String get createBackup => 'Crear Copia de Seguridad';

  @override
  String get ok => 'Aceptar';
}
