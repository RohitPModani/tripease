// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'Поездки';

  @override
  String get documents => 'Документы';

  @override
  String get settings => 'Настройки';

  @override
  String get quickStats => 'Быстрая статистика';

  @override
  String get activeTrips => 'Активные поездки';

  @override
  String get pendingTasks => 'Ожидающие задачи';

  @override
  String get totalBudget => 'Общий бюджет';

  @override
  String nextTripStartsIn(int days) {
    return 'Следующая поездка начнется через $days дней';
  }

  @override
  String get yourTrips => 'Ваши поездки';

  @override
  String get searchTrips => 'Поиск поездок...';

  @override
  String get daysUntilStart => 'Дни до начала';

  @override
  String get dateCreated => 'Дата создания';

  @override
  String get alphabetical => 'По алфавиту';

  @override
  String get budget => 'Бюджет';

  @override
  String get tasks => 'Задачи';

  @override
  String get tripInProgress => 'Поездка в процессе';

  @override
  String get startingToday => 'Начинается сегодня!';

  @override
  String daysToGo(int days) {
    return '$days дней осталось';
  }

  @override
  String active(int count) {
    return '$count активных';
  }

  @override
  String get searchDocuments => 'Поиск документов...';

  @override
  String get personal => 'Личные';

  @override
  String get tripRelated => 'Связанные с поездкой';

  @override
  String get uploadDocument => 'Загрузить документ';

  @override
  String get takePhoto => 'Сделать фото';

  @override
  String get captureDocumentWithCamera => 'Сфотографировать документ камерой';

  @override
  String get chooseFromGallery => 'Выбрать из галереи';

  @override
  String get selectFromPhotoLibrary => 'Выбрать из библиотеки фотографий';

  @override
  String get chooseFile => 'Выбрать файл';

  @override
  String get selectPdfOrOtherFiles => 'Выбрать PDF или другие файлы';

  @override
  String expires(String date) {
    return 'Истекает: $date';
  }

  @override
  String get view => 'Посмотреть';

  @override
  String get share => 'Поделиться';

  @override
  String get download => 'Скачать';

  @override
  String get delete => 'Удалить';

  @override
  String get profile => 'Профиль';

  @override
  String get preferences => 'Настройки';

  @override
  String get darkMode => 'Тёмный режим';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'Переключение между светлой и тёмной темой';

  @override
  String get language => 'Язык';

  @override
  String get selectYourPreferredLanguage => 'Выберите предпочитаемый язык';

  @override
  String get defaultCurrency => 'Валюта по умолчанию';

  @override
  String get currencyUsedForNewTrips => 'Валюта для новых поездок';

  @override
  String get dateFormat => 'Формат даты';

  @override
  String get howDatesAreDisplayed => 'Как отображаются даты';

  @override
  String get temperatureUnit => 'Единица температуры';

  @override
  String get temperatureScalePreference => 'Предпочтение шкалы температуры';

  @override
  String get appSettings => 'Настройки приложения';

  @override
  String get backupAndSync => 'Резервное копирование и синхронизация';

  @override
  String get manageYourDataBackup => 'Управление резервным копированием данных';

  @override
  String get importData => 'Импорт данных';

  @override
  String get importTripsFromOtherApps => 'Импорт поездок из других приложений';

  @override
  String get exportData => 'Экспорт данных';

  @override
  String get exportYourTripData => 'Экспорт данных поездки';

  @override
  String get about => 'О программе';

  @override
  String get appVersion => 'Версия приложения';

  @override
  String get rateApp => 'Оценить приложение';

  @override
  String get leaveAReviewOnTheAppStore => 'Оставить отзыв в App Store';

  @override
  String get helpAndSupport => 'Помощь и поддержка';

  @override
  String get faqsAndContactInformation =>
      'Часто задаваемые вопросы и контактная информация';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get readOurPrivacyPolicy =>
      'Ознакомиться с политикой конфиденциальности';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get readOurTermsAndConditions =>
      'Ознакомиться с условиями использования';

  @override
  String get dangerZone => 'Опасная зона';

  @override
  String get clearAllData => 'Очистить все данные';

  @override
  String get removeAllTripsAndDocuments => 'Удалить все поездки и документы';

  @override
  String get clearAllDataConfirmation =>
      'Это действие нельзя отменить. Все ваши поездки, документы и настройки будут навсегда удалены.';

  @override
  String get cancel => 'Отменить';

  @override
  String get clearAll => 'Очистить все';

  @override
  String get celsius => 'Цельсий';

  @override
  String get fahrenheit => 'Фаренгейт';

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
  String get title => 'Заголовок';

  @override
  String get description => 'Описание';

  @override
  String get amount => 'Сумма';

  @override
  String get date => 'Дата';

  @override
  String get edit => 'Редактировать';

  @override
  String get retry => 'Повторить';

  @override
  String get add => 'Добавить';

  @override
  String get update => 'Обновить';

  @override
  String get close => 'Закрыть';

  @override
  String get failedToLoad => 'Ошибка загрузки';

  @override
  String get noDataYet => 'Данных пока нет';

  @override
  String get startPlanning => 'Начните планировать своё следующее приключение!';

  @override
  String get createTrip => 'Создать поездку';

  @override
  String get addDocument => 'Добавить документ';

  @override
  String get addExpense => 'Добавить расход';

  @override
  String get addActivity => 'Добавить активность';

  @override
  String get addBooking => 'Добавить бронирование';

  @override
  String get totalExpenses => 'Общие расходы';

  @override
  String get toDoItems => 'Список дел';

  @override
  String get expenseDetails => 'Детали расхода';

  @override
  String get expenseTitle => 'Название расхода';

  @override
  String get category => 'Категория';

  @override
  String get paidBy => 'Оплачено';

  @override
  String get you => 'Вы';

  @override
  String get allDay => 'Весь день';

  @override
  String get startTime => 'Время начала';

  @override
  String get endTime => 'Время окончания';

  @override
  String get activityTitle => 'Название мероприятия';

  @override
  String get activityType => 'Тип мероприятия';

  @override
  String get bookingTitle => 'Название бронирования';

  @override
  String get bookingType => 'Тип бронирования';

  @override
  String get status => 'Статус';

  @override
  String get addFile => 'Добавить файл';

  @override
  String get fileNotFound => 'Файл не найден';

  @override
  String get fileMovedOrDeleted => 'Возможно, файл был перемещен или удален';

  @override
  String get cannotDisplayImage => 'Не удается отобразить изображение';

  @override
  String get openExternally => 'Открыть внешне';

  @override
  String get failedToReadFile => 'Не удалось прочитать данные файла';

  @override
  String get deleteExpense => 'Удалить расход';

  @override
  String get deleteExpenseConfirmation =>
      'Вы уверены, что хотите удалить этот расход?';

  @override
  String get expenseBreakdown => 'Разбивка расходов';

  @override
  String get breakdown => 'Разбивка';

  @override
  String get noExpensesYet => 'Расходов пока нет';

  @override
  String get noActivitiesPlanned => 'Мероприятия не запланированы';

  @override
  String get splitDetails => 'Детали разделения';

  @override
  String get editExpense => 'Редактировать расход';

  @override
  String get addNewExpense => 'Добавить новый расход';

  @override
  String get editActivity => 'Редактировать мероприятие';

  @override
  String get addNewActivity => 'Добавить новое мероприятие';

  @override
  String get editBooking => 'Редактировать бронирование';

  @override
  String get addNewBooking => 'Добавить новое бронирование';

  @override
  String get updateExpense => 'Обновить расход';

  @override
  String get updateActivity => 'Обновить мероприятие';

  @override
  String get updateBooking => 'Обновить бронирование';

  @override
  String get transport => 'Транспорт';

  @override
  String get accommodation => 'Размещение';

  @override
  String get activities => 'Мероприятия';

  @override
  String get shopping => 'Покупки';

  @override
  String get sightseeing => 'Осмотр достопримечательностей';

  @override
  String get meal => 'Еда';

  @override
  String get entertainment => 'Развлечения';

  @override
  String get other => 'Другое';

  @override
  String get noBookingsYet => 'Пока нет бронирований';

  @override
  String get addFirstBooking => 'Добавить первое бронирование';

  @override
  String get bookingDetails => 'Детали бронирования';

  @override
  String get vendor => 'Поставщик';

  @override
  String get confirmationNumber => 'Номер подтверждения';

  @override
  String get attachments => 'Вложения';

  @override
  String get failedToLoadTodos => 'Не удалось загрузить задачи';

  @override
  String get task => 'Задача';

  @override
  String allWithCount(int count) {
    return 'Все ($count)';
  }

  @override
  String get noToDoItems => 'Задач нет';

  @override
  String get stayOrganizedMessage =>
      'Оставайтесь организованными, добавляя задачи для планирования поездки!';

  @override
  String get addFirstTask => 'Добавить первую задачу';

  @override
  String get taskDetails => 'Детали задачи';

  @override
  String get completed => 'Завершено';

  @override
  String get pending => 'В ожидании';

  @override
  String get priority => 'Приоритет';

  @override
  String get dueDate => 'Срок выполнения';

  @override
  String get editTask => 'Редактировать задачу';

  @override
  String get addNewTask => 'Добавить новую задачу';

  @override
  String get updateTask => 'Обновить задачу';

  @override
  String get addTask => 'Добавить задачу';

  @override
  String get deleteTask => 'Удалить задачу';

  @override
  String deleteTaskConfirmation(String title) {
    return 'Вы уверены, что хотите удалить \"$title\"? Это действие нельзя отменить.';
  }

  @override
  String get keepTrackMessage =>
      'Отслеживайте свои рейсы, отели и мероприятия!';

  @override
  String get previewNotAvailable =>
      'Предварительный просмотр недоступен для этого типа файла.\nНажмите \"Открыть внешне\" для просмотра в другом приложении.';

  @override
  String get appVersionBeta => '1.0.0 (Бета)';

  @override
  String get defaultUserName => 'Иван Иванов';

  @override
  String get defaultUserEmail => 'john.doe@email.com';

  @override
  String get taskTitle => 'Название задачи';

  @override
  String get descriptionOptional => 'Описание (необязательно)';

  @override
  String get setDueDateOptional => 'Установить срок выполнения (необязательно)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Срок: $day/$month/$year';
  }

  @override
  String get urgent => 'Срочно';

  @override
  String get high => 'Высокий';

  @override
  String get medium => 'Средний';

  @override
  String get low => 'Низкий';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Не удалось $action задачу: $error';
  }

  @override
  String get vendorCompanyOptional => 'Поставщик/Компания (необязательно)';

  @override
  String get confirmationNumberOptional =>
      'Номер подтверждения (необязательно)';

  @override
  String amountCurrency(String currency) {
    return 'Сумма ($currency)';
  }

  @override
  String get setBookingDateOptional =>
      'Установить дату бронирования (необязательно)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Дата: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Вложения (необязательно)';

  @override
  String get maxFileSizeSupported =>
      'Макс. размер файла: 5 МБ\nПоддерживаемые форматы: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Не удалось $action бронирование: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename успешно прикреплен';
  }

  @override
  String get fileSizeMustBeLess => 'Размер файла должен быть менее 5 МБ';

  @override
  String failedToPickFile(String error) {
    return 'Не удалось выбрать файл: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Ошибка обмена файлом: $error';
  }

  @override
  String get unknown => 'Неизвестно';

  @override
  String get editTrip => 'Редактировать поездку';

  @override
  String get updateTrip => 'Обновить поездку';

  @override
  String get tripUpdatedSuccessfully => 'Поездка успешно обновлена';

  @override
  String get failedToUpdateTrip => 'Не удалось обновить поездку';

  @override
  String get deleteTrip => 'Удалить поездку';

  @override
  String get deleteTripConfirmation =>
      'Вы уверены, что хотите удалить эту поездку? Это действие нельзя отменить.';

  @override
  String get tripDeletedSuccessfully => 'Поездка успешно удалена';

  @override
  String get failedToDeleteTrip => 'Не удалось удалить поездку';

  @override
  String get tripCreatedSuccessfully => 'Поездка успешно создана!';

  @override
  String get failedToCreateTrip => 'Не удалось создать поездку';

  @override
  String get selectStartDateFirst => 'Сначала выберите дату начала';

  @override
  String get addAtLeastOneDestination =>
      'Пожалуйста, добавьте хотя бы одно направление';

  @override
  String get selectBothStartAndEndDates => 'Выберите дату начала и окончания';

  @override
  String get titleIsRequired => 'Название обязательно';

  @override
  String titleTooLong(int limit) {
    return 'Название должно содержать не более $limit символов';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'Описание должно содержать не более $limit символов';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Поставщик/Компания должен содержать не более $limit символов';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'Номер подтверждения должен содержать не более $limit символов';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Плательщик должен содержать не более $limit символов';
  }

  @override
  String locationTooLong(int limit) {
    return 'Местоположение должно содержать не более $limit символов';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'Описание должно содержать не более $limit символов';
  }

  @override
  String get amountIsRequired => 'Сумма обязательна';

  @override
  String get enterValidAmount => 'Введите правильную сумму';

  @override
  String get amountMustBePositive => 'Сумма должна быть положительной';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName обязательно';
  }

  @override
  String get destinationIsRequired => 'Направление обязательно';

  @override
  String destinationTooLong(int limit) {
    return 'Направление должно содержать не более $limit символов';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (необязательно)';
  }

  @override
  String maxCharacters(int maxLength) {
    return '$maxLength макс.';
  }

  @override
  String get searchTripsPlaceholder => 'Поиск поездок...';

  @override
  String allWithTotal(int total) {
    return 'Все ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return 'Предстоящие ($count)';
  }

  @override
  String activeWithCount(int count) {
    return 'Активные ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Завершённые ($count)';
  }

  @override
  String get yourTripsTitle => 'Ваши поездки';

  @override
  String activeTripsCount(int count) {
    return '$count активных';
  }

  @override
  String get bookingsTabTitle => 'Бронирования';

  @override
  String get expensesTabTitle => 'Расходы';

  @override
  String get overviewTabTitle => 'Обзор';

  @override
  String get todoTabTitle => 'Дела';

  @override
  String get itineraryTabTitle => 'Маршрут';

  @override
  String get failedToLoadTrip => 'Ошибка загрузки поездки';

  @override
  String get tripNotFound => 'Поездка не найдена';

  @override
  String get saveImage => 'Сохранить изображение';

  @override
  String get saveToPhotos => 'Сохранить в фото';

  @override
  String get saveToPhotosDescription => 'Сохранить прямо в фотогалерею';

  @override
  String get saveToFiles => 'Сохранить в файлы';

  @override
  String get saveToFilesDescription =>
      'Выберите конкретную папку для сохранения';

  @override
  String get imageSavedToPhotos => 'Изображение сохранено в фото';

  @override
  String get fileSavedSuccessfully => 'Файл успешно сохранен';

  @override
  String get open => 'Открыть';

  @override
  String errorDownloadingFile(String error) {
    return 'Ошибка загрузки файла: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Ошибка сохранения в фото: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Ошибка сохранения файла: $error';
  }

  @override
  String get selectDocument => 'Выбрать документ';

  @override
  String get chooseFromGalleryTitle => 'Выбрать из галереи';

  @override
  String get chooseFromGalleryDescription => 'Выбрать из фотобиблиотеки';

  @override
  String get chooseFileTitle => 'Выбрать файл';

  @override
  String get chooseFileDescription => 'Выбрать PDF или другие файлы';

  @override
  String get failedToCaptureImage => 'Не удалось сделать снимок';

  @override
  String get failedToSelectImage => 'Не удалось выбрать изображение';

  @override
  String get failedToSelectFile => 'Не удалось выбрать файл';

  @override
  String get documentAddedSuccessfully => 'Документ успешно добавлен';

  @override
  String get documentUpdatedSuccessfully => 'Документ успешно обновлен';

  @override
  String get failedToSaveDocument => 'Не удалось сохранить документ';

  @override
  String get documentTitle => 'Название документа *';

  @override
  String get documentCategory => 'Категория документа';

  @override
  String get changeDocument => 'Изменить документ';

  @override
  String get documentsTitle => 'Документы';

  @override
  String get noDocumentsYet => 'Документов пока нет';

  @override
  String get noDocumentsFound => 'Документы не найдены';

  @override
  String get clearSearch => 'Очистить поиск';

  @override
  String get documentDetails => 'Детали документа';

  @override
  String get fileSize => 'Размер файла';

  @override
  String get fileName => 'Имя файла';

  @override
  String get deleteDocument => 'Удалить документ';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Вы уверены, что хотите удалить \"$title\"? Это действие нельзя отменить.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Документ \"$title\" успешно удален';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Не удалось удалить документ: $error';
  }

  @override
  String get location => 'Местоположение';

  @override
  String get activityTitleLabel => 'Название мероприятия';

  @override
  String get activityTypeLabel => 'Тип мероприятия';

  @override
  String get expenseTitleLabel => 'Название расхода';

  @override
  String get destinations => 'Направления';

  @override
  String get currency => 'Валюта';

  @override
  String get tripInProgressStatus => 'Поездка в процессе';

  @override
  String get completedStatus => 'Завершено';

  @override
  String get tripDates => 'Даты поездки';

  @override
  String get expenseType => 'Расход';

  @override
  String get expenseDetailsTitle => 'Детали расхода';

  @override
  String get activityDetailsTitle => 'Детали мероприятия';

  @override
  String get deleteActivity => 'Удалить мероприятие';

  @override
  String get deleteBooking => 'Удалить бронирование';

  @override
  String get january => 'Январь';

  @override
  String get february => 'Февраль';

  @override
  String get march => 'Март';

  @override
  String get april => 'Апрель';

  @override
  String get may => 'Май';

  @override
  String get june => 'Июнь';

  @override
  String get july => 'Июль';

  @override
  String get august => 'Август';

  @override
  String get september => 'Сентябрь';

  @override
  String get october => 'Октябрь';

  @override
  String get november => 'Ноябрь';

  @override
  String get december => 'Декабрь';

  @override
  String get food => 'Еда';

  @override
  String get confirmed => 'Подтверждено';

  @override
  String get cancelled => 'Отменено';

  @override
  String get passport => 'Паспорт';

  @override
  String get visa => 'Виза';

  @override
  String get ticket => 'Билет';

  @override
  String get hotel => 'Отель';

  @override
  String get insurance => 'Страхование';

  @override
  String get editDocument => 'Редактировать документ';

  @override
  String get updateDocument => 'Обновить документ';

  @override
  String get saveToGallery => 'Сохранить в галерею';

  @override
  String get flight => 'Рейс';

  @override
  String get restaurant => 'Ресторан';

  @override
  String get bookingLimitReached =>
      'Достигнут лимит бронирований. Вы можете добавить только 15 бронирований на поездку.';

  @override
  String get documentLimitReached =>
      'Достигнут лимит документов. Вы можете добавить только 10 документов всего.';

  @override
  String get clearFilters => 'Очистить фильтры';

  @override
  String get travelDates => 'Даты поездки';

  @override
  String get selectDateRange => 'Выбрать диапазон дат';

  @override
  String get activityDetails => 'Детали мероприятия';

  @override
  String get quickActions => 'Быстрые действия';

  @override
  String get addNewItemsToTrip => 'Добавить новые элементы в поездку';

  @override
  String get booking => 'Бронирование';

  @override
  String get expense => 'Расход';

  @override
  String get itinerary => 'Маршрут';

  @override
  String get duration => 'Продолжительность';

  @override
  String get noExpensesFound => 'Расходы не найдены';

  @override
  String get noExpensesFoundForCategory =>
      'Расходы для этой категории не найдены';

  @override
  String get noTasksFound => 'Задачи не найдены';

  @override
  String get noBookingsFound => 'Бронирования не найдены';

  @override
  String get noTripsFound => 'Поездки не найдены';

  @override
  String get tryAdjustingFilters => 'Попробуйте настроить фильтры';

  @override
  String get searchTasks => 'Поиск задач';

  @override
  String get searchBookings => 'Поиск бронирований';

  @override
  String get urgentPriority => 'Срочно';

  @override
  String get highPriority => 'Высокий';

  @override
  String get mediumPriority => 'Средний';

  @override
  String get lowPriority => 'Низкий';

  @override
  String get overdue => 'Просрочено';

  @override
  String get dueToday => 'Срок сегодня';

  @override
  String get dueTomorrow => 'Срок завтра';

  @override
  String get activeStatus => 'Активный статус';

  @override
  String get selectBackupFile => 'Выбрать файл резервной копии';

  @override
  String get selectFile => 'Выбрать файл';

  @override
  String get importBackup => 'Импорт резервной копии';

  @override
  String get importSuccessful => 'Импорт успешен';

  @override
  String get importFailed => 'Импорт не удался';

  @override
  String get couldNotOpenAppStore => 'Не удалось открыть магазин приложений';

  @override
  String get couldNotOpenHelpSection => 'Не удалось открыть раздел справки';

  @override
  String get couldNotOpenPrivacyPolicy =>
      'Не удалось открыть политику конфиденциальности';

  @override
  String get couldNotOpenTermsOfService =>
      'Не удалось открыть условия обслуживания';

  @override
  String get confirmActionWarning => 'Это действие нельзя отменить!';

  @override
  String get finalConfirmationTitle => 'Окончательное подтверждение';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Напишите $word в поле ниже для подтверждения:';
  }

  @override
  String get deletingAllData => 'Удаление всех данных...';

  @override
  String get pleaseWait =>
      'Пожалуйста, подождите, это может занять некоторое время.';

  @override
  String get dataClearedTitle => 'Данные очищены';

  @override
  String get dataClearedMessage =>
      'Все ваши данные были успешно удалены. Приложение было сброшено до первоначального состояния.';

  @override
  String get errorTitle => 'Ошибка';

  @override
  String failedToClearAllData(String error) {
    return 'Ошибка при очистке всех данных: $error';
  }

  @override
  String get exportIntroTitle =>
      'Создайте безопасную резервную копию всех ваших данных Voythrix:';

  @override
  String get exportEncryptionInfo =>
      'Ваши данные будут зашифрованы и сжаты в файл .tripe.';

  @override
  String get backupPasswordTitle => 'Пароль резервной копии (опционально)';

  @override
  String get backupPasswordHint => 'Введите пароль (опционально)';

  @override
  String get confirmPasswordHint => 'Подтвердите пароль';

  @override
  String get passwordsMatch => 'Пароли совпадают';

  @override
  String get passwordsDoNotMatch => 'Пароли не совпадают';

  @override
  String get creatingBackup => 'Создание резервной копии...';

  @override
  String get collectingAndEncrypting => 'Сбор и шифрование ваших данных...';

  @override
  String get backupCreatedTitle => 'Резервная копия создана';

  @override
  String get backupCreatedMessage =>
      'Ваша резервная копия была создана успешно!';

  @override
  String get fileInfoLabel => 'Информация о файле:';

  @override
  String get fileInfoFormat => '• Формат: Зашифрованный файл .tripe';

  @override
  String get fileInfoSecurityPassword => '• Безопасность: Защищен паролем';

  @override
  String get fileInfoSecurityStandard =>
      '• Безопасность: Стандартное шифрование';

  @override
  String get fileInfoCompression => '• Сжатие: Сжато GZip';

  @override
  String get keepFileSafeNote =>
      'Оберегайте этот файл — он понадобится вам для восстановления ваших данных!';

  @override
  String get exportFailedTitle => 'Ошибка экспорта';

  @override
  String failedToCreateBackup(String error) {
    return 'Ошибка при создании резервной копии: $error';
  }

  @override
  String get continueAction => 'Продолжить';

  @override
  String get deleteEverything => 'Удалить всё';

  @override
  String get createBackup => 'Создать резервную копию';

  @override
  String get ok => 'ОК';
}
