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
  String get searchTripsPlaceholder => 'Search trips...';

  @override
  String allWithTotal(int total) {
    return 'All ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'Upcoming ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Active ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Completed ($count)';
  }

  @override
  String get yourTripsTitle => 'Your Trips';

  @override
  String activeTripsCount(int count) {
    return '$count Active';
  }

  @override
  String get bookingsTabTitle => 'Bookings';

  @override
  String get expensesTabTitle => 'Expenses';

  @override
  String get overviewTabTitle => 'Overview';

  @override
  String get todoTabTitle => 'To-Do';

  @override
  String get itineraryTabTitle => 'Itinerary';

  @override
  String get failedToLoadTrip => 'Failed to load trip';

  @override
  String get tripNotFound => 'Trip not found';

  @override
  String get saveImage => 'Save Image';

  @override
  String get saveToPhotos => 'Save to Photos';

  @override
  String get saveToPhotosDescription => 'Save directly to your photo gallery';

  @override
  String get saveToFiles => 'Save to Files';

  @override
  String get saveToFilesDescription => 'Choose a specific folder to save';

  @override
  String get imageSavedToPhotos => 'Image saved to Photos';

  @override
  String get fileSavedSuccessfully => 'File saved successfully';

  @override
  String get open => 'Open';

  @override
  String errorDownloadingFile(String error) {
    return 'Error downloading file: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Error saving to Photos: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Error saving file: $error';
  }

  @override
  String get selectDocument => 'Select Document';

  @override
  String get chooseFromGalleryTitle => 'Choose from Gallery';

  @override
  String get chooseFromGalleryDescription => 'Select from photo library';

  @override
  String get chooseFileTitle => 'Choose File';

  @override
  String get chooseFileDescription => 'Select PDF or other files';

  @override
  String get failedToCaptureImage => 'Failed to capture image';

  @override
  String get failedToSelectImage => 'Failed to select image';

  @override
  String get failedToSelectFile => 'Failed to select file';

  @override
  String get documentAddedSuccessfully => 'Document added successfully';

  @override
  String get documentUpdatedSuccessfully => 'Document updated successfully';

  @override
  String get failedToSaveDocument => 'Failed to save document';

  @override
  String get documentTitle => 'Document Title *';

  @override
  String get documentCategory => 'Document Category';

  @override
  String get changeDocument => 'Change Document';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get noDocumentsYet => 'No documents yet';

  @override
  String get noDocumentsFound => 'No documents found';

  @override
  String get clearSearch => 'Clear search';

  @override
  String get documentDetails => 'Document Details';

  @override
  String get fileSize => 'File Size';

  @override
  String get fileName => 'File Name';

  @override
  String get deleteDocument => 'Delete Document';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Are you sure you want to delete \"$title\"? This action cannot be undone.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Document \"$title\" deleted successfully';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Failed to delete document: $error';
  }

  @override
  String get location => 'Location';

  @override
  String get activityTitleLabel => 'Activity Title';

  @override
  String get activityTypeLabel => 'Activity Type';

  @override
  String get expenseTitleLabel => 'Expense Title';

  @override
  String get destinations => 'Destinations';

  @override
  String get currency => 'Currency';

  @override
  String get tripInProgressStatus => 'Trip in Progress';

  @override
  String get completedStatus => 'Completed';

  @override
  String get tripDates => 'Trip Dates';

  @override
  String get expenseType => 'Expense';

  @override
  String get expenseDetailsTitle => 'Expense Details';

  @override
  String get activityDetailsTitle => 'Activity Details';

  @override
  String get deleteActivity => 'Delete Activity';

  @override
  String get deleteBooking => 'Delete Booking';

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
  String get confirmActionWarning => 'This action cannot be undone!';

  @override
  String get finalConfirmationTitle => 'Final Confirmation';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Type $word in the box below to confirm:';
  }

  @override
  String get deletingAllData => 'Deleting all data...';

  @override
  String get pleaseWait => 'Please wait, this may take a moment.';

  @override
  String get dataClearedTitle => 'Data Cleared';

  @override
  String get dataClearedMessage =>
      'All your data has been successfully deleted. The app has been reset to its initial state.';

  @override
  String get errorTitle => 'Error';

  @override
  String failedToClearAllData(String error) {
    return 'Failed to clear all data: $error';
  }

  @override
  String get exportIntroTitle =>
      'Create a secure backup of all your Voythrix data:';

  @override
  String get exportEncryptionInfo =>
      'Your data will be encrypted and compressed into a .tripe file.';

  @override
  String get backupPasswordTitle => 'Backup Password (Optional)';

  @override
  String get backupPasswordHint => 'Enter password (optional)';

  @override
  String get confirmPasswordHint => 'Confirm password';

  @override
  String get passwordsMatch => 'Passwords match';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get creatingBackup => 'Creating backup...';

  @override
  String get collectingAndEncrypting =>
      'Collecting and encrypting your data...';

  @override
  String get backupCreatedTitle => 'Backup Created';

  @override
  String get backupCreatedMessage =>
      'Your backup has been created successfully!';

  @override
  String get fileInfoLabel => 'File Info:';

  @override
  String get fileInfoFormat => '• Format: Encrypted .tripe file';

  @override
  String get fileInfoSecurityPassword => '• Security: Password protected';

  @override
  String get fileInfoSecurityStandard => '• Security: Standard encryption';

  @override
  String get fileInfoCompression => '• Compression: GZip compressed';

  @override
  String get keepFileSafeNote =>
      'Keep this file safe — you\'ll need it to restore your data!';

  @override
  String get exportFailedTitle => 'Export Failed';

  @override
  String failedToCreateBackup(String error) {
    return 'Failed to create backup: $error';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get deleteEverything => 'Delete Everything';

  @override
  String get createBackup => 'Create Backup';

  @override
  String get ok => 'OK';
}
