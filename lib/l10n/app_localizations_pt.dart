// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => 'Viagens';

  @override
  String get documents => 'Documentos';

  @override
  String get settings => 'Configurações';

  @override
  String get quickStats => 'Estatísticas Rápidas';

  @override
  String get activeTrips => 'Viagens Ativas';

  @override
  String get pendingTasks => 'Tarefas Pendentes';

  @override
  String get totalBudget => 'Orçamento Total';

  @override
  String nextTripStartsIn(int days) {
    return 'Próxima viagem começa em $days dias';
  }

  @override
  String get yourTrips => 'Suas Viagens';

  @override
  String get searchTrips => 'Buscar viagens...';

  @override
  String get daysUntilStart => 'Dias Até o Início';

  @override
  String get dateCreated => 'Data de Criação';

  @override
  String get alphabetical => 'Alfabética';

  @override
  String get budget => 'Orçamento';

  @override
  String get tasks => 'Tarefas';

  @override
  String get tripInProgress => 'Viagem em Andamento';

  @override
  String get startingToday => 'Começando Hoje!';

  @override
  String daysToGo(int days) {
    return '$days dias restantes';
  }

  @override
  String active(int count) {
    return '$count Ativo';
  }

  @override
  String get searchDocuments => 'Buscar documentos...';

  @override
  String get personal => 'Pessoal';

  @override
  String get tripRelated => 'Relacionado à Viagem';

  @override
  String get uploadDocument => 'Enviar Documento';

  @override
  String get takePhoto => 'Tirar Foto';

  @override
  String get captureDocumentWithCamera => 'Capturar documento com a câmera';

  @override
  String get chooseFromGallery => 'Escolher da Galeria';

  @override
  String get selectFromPhotoLibrary => 'Selecionar da biblioteca de fotos';

  @override
  String get chooseFile => 'Escolher Arquivo';

  @override
  String get selectPdfOrOtherFiles => 'Selecionar PDF ou outros arquivos';

  @override
  String expires(String date) {
    return 'Expira: $date';
  }

  @override
  String get view => 'Ver';

  @override
  String get share => 'Compartilhar';

  @override
  String get download => 'Baixar';

  @override
  String get delete => 'Excluir';

  @override
  String get profile => 'Perfil';

  @override
  String get preferences => 'Preferências';

  @override
  String get darkMode => 'Modo Escuro';

  @override
  String get switchBetweenLightAndDarkTheme =>
      'Alternar entre tema claro e escuro';

  @override
  String get language => 'Idioma';

  @override
  String get selectYourPreferredLanguage => 'Selecione seu idioma preferido';

  @override
  String get defaultCurrency => 'Moeda Padrão';

  @override
  String get currencyUsedForNewTrips => 'Moeda usada para novas viagens';

  @override
  String get dateFormat => 'Formato de Data';

  @override
  String get howDatesAreDisplayed => 'Como as datas são exibidas';

  @override
  String get temperatureUnit => 'Unidade de Temperatura';

  @override
  String get temperatureScalePreference =>
      'Preferência de escala de temperatura';

  @override
  String get appSettings => 'Configurações do App';

  @override
  String get backupAndSync => 'Backup e Sincronização';

  @override
  String get manageYourDataBackup => 'Gerenciar backup dos seus dados';

  @override
  String get importData => 'Importar Dados';

  @override
  String get importTripsFromOtherApps => 'Importar viagens de outros apps';

  @override
  String get exportData => 'Exportar Dados';

  @override
  String get exportYourTripData => 'Exportar seus dados de viagem';

  @override
  String get about => 'Sobre';

  @override
  String get appVersion => 'Versão do App';

  @override
  String get rateApp => 'Avaliar App';

  @override
  String get leaveAReviewOnTheAppStore => 'Deixar uma avaliação na App Store';

  @override
  String get helpAndSupport => 'Ajuda e Suporte';

  @override
  String get faqsAndContactInformation => 'FAQs e informações de contato';

  @override
  String get privacyPolicy => 'Política de Privacidade';

  @override
  String get readOurPrivacyPolicy => 'Ler nossa política de privacidade';

  @override
  String get termsOfService => 'Termos de Serviço';

  @override
  String get readOurTermsAndConditions => 'Ler nossos termos e condições';

  @override
  String get dangerZone => 'Zona de Perigo';

  @override
  String get clearAllData => 'Limpar Todos os Dados';

  @override
  String get removeAllTripsAndDocuments =>
      'Remover todas as viagens e documentos';

  @override
  String get clearAllDataConfirmation =>
      'Esta ação não pode ser desfeita. Todas as suas viagens, documentos e configurações serão excluídas permanentemente.';

  @override
  String get cancel => 'Cancelar';

  @override
  String get clearAll => 'Limpar Tudo';

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
  String get description => 'Descrição';

  @override
  String get amount => 'Valor';

  @override
  String get date => 'Data';

  @override
  String get edit => 'Editar';

  @override
  String get retry => 'Tentar novamente';

  @override
  String get add => 'Adicionar';

  @override
  String get update => 'Atualizar';

  @override
  String get close => 'Fechar';

  @override
  String get failedToLoad => 'Falha ao carregar';

  @override
  String get noDataYet => 'Ainda não há dados';

  @override
  String get startPlanning => 'Comece a planejar sua próxima aventura!';

  @override
  String get createTrip => 'Criar Viagem';

  @override
  String get addDocument => 'Adicionar Documento';

  @override
  String get addExpense => 'Adicionar Despesa';

  @override
  String get addActivity => 'Adicionar Atividade';

  @override
  String get addBooking => 'Adicionar Reserva';

  @override
  String get totalExpenses => 'Despesas Totais';

  @override
  String get toDoItems => 'Itens a Fazer';

  @override
  String get expenseDetails => 'Detalhes da Despesa';

  @override
  String get expenseTitle => 'Título da Despesa';

  @override
  String get category => 'Categoria';

  @override
  String get paidBy => 'Pago por';

  @override
  String get you => 'Você';

  @override
  String get allDay => 'Dia todo';

  @override
  String get startTime => 'Hora de início';

  @override
  String get endTime => 'Hora de término';

  @override
  String get activityTitle => 'Título da Atividade';

  @override
  String get activityType => 'Tipo de Atividade';

  @override
  String get bookingTitle => 'Título da Reserva';

  @override
  String get bookingType => 'Tipo de Reserva';

  @override
  String get status => 'Status';

  @override
  String get addFile => 'Adicionar Arquivo';

  @override
  String get fileNotFound => 'Arquivo não encontrado';

  @override
  String get fileMovedOrDeleted => 'O arquivo pode ter sido movido ou excluído';

  @override
  String get cannotDisplayImage => 'Não é possível exibir a imagem';

  @override
  String get openExternally => 'Abrir Externamente';

  @override
  String get failedToReadFile => 'Falha ao ler dados do arquivo';

  @override
  String get deleteExpense => 'Excluir Despesa';

  @override
  String get deleteExpenseConfirmation =>
      'Tem certeza de que deseja excluir esta despesa?';

  @override
  String get expenseBreakdown => 'Detalhamento de Despesas';

  @override
  String get breakdown => 'Detalhamento';

  @override
  String get noExpensesYet => 'Ainda não há despesas';

  @override
  String get noActivitiesPlanned => 'Nenhuma atividade planejada';

  @override
  String get splitDetails => 'Detalhes da Divisão';

  @override
  String get editExpense => 'Editar Despesa';

  @override
  String get addNewExpense => 'Adicionar Nova Despesa';

  @override
  String get editActivity => 'Editar Atividade';

  @override
  String get addNewActivity => 'Adicionar Nova Atividade';

  @override
  String get editBooking => 'Editar Reserva';

  @override
  String get addNewBooking => 'Adicionar Nova Reserva';

  @override
  String get updateExpense => 'Atualizar Despesa';

  @override
  String get updateActivity => 'Atualizar Atividade';

  @override
  String get updateBooking => 'Atualizar Reserva';

  @override
  String get transport => 'Transporte';

  @override
  String get accommodation => 'Acomodação';

  @override
  String get activities => 'Atividades';

  @override
  String get shopping => 'Compras';

  @override
  String get sightseeing => 'Turismo';

  @override
  String get meal => 'Refeição';

  @override
  String get entertainment => 'Entretenimento';

  @override
  String get other => 'Outro';

  @override
  String get noBookingsYet => 'Ainda não há reservas';

  @override
  String get addFirstBooking => 'Adicionar Primeira Reserva';

  @override
  String get bookingDetails => 'Detalhes da Reserva';

  @override
  String get vendor => 'Fornecedor';

  @override
  String get confirmationNumber => 'Número de Confirmação';

  @override
  String get attachments => 'Anexos';

  @override
  String get failedToLoadTodos => 'Falha ao carregar tarefas';

  @override
  String get task => 'Tarefa';

  @override
  String allWithCount(int count) {
    return 'Todas ($count)';
  }

  @override
  String get noToDoItems => 'Nenhum item a fazer';

  @override
  String get stayOrganizedMessage =>
      'Mantenha-se organizado adicionando tarefas para o planejamento da sua viagem!';

  @override
  String get addFirstTask => 'Adicionar Primeira Tarefa';

  @override
  String get taskDetails => 'Detalhes da Tarefa';

  @override
  String get completed => 'Concluído';

  @override
  String get pending => 'Pendente';

  @override
  String get priority => 'Prioridade';

  @override
  String get dueDate => 'Data de vencimento';

  @override
  String get editTask => 'Editar Tarefa';

  @override
  String get addNewTask => 'Adicionar Nova Tarefa';

  @override
  String get updateTask => 'Atualizar Tarefa';

  @override
  String get addTask => 'Adicionar Tarefa';

  @override
  String get deleteTask => 'Excluir Tarefa';

  @override
  String deleteTaskConfirmation(String title) {
    return 'Tem certeza de que deseja excluir \"$title\"? Esta ação não pode ser desfeita.';
  }

  @override
  String get keepTrackMessage => 'Acompanhe seus voos, hotéis e atividades!';

  @override
  String get previewNotAvailable =>
      'Visualização não disponível para este tipo de arquivo.\nToque em \"Abrir Externamente\" para visualizar com outro app.';

  @override
  String get appVersionBeta => '1.0.0 (Beta)';

  @override
  String get defaultUserName => 'João Silva';

  @override
  String get defaultUserEmail => 'joao.silva@email.com';

  @override
  String get taskTitle => 'Título da Tarefa';

  @override
  String get descriptionOptional => 'Descrição (Opcional)';

  @override
  String get setDueDateOptional => 'Definir Data de Vencimento (Opcional)';

  @override
  String dueWithDate(int day, int month, int year) {
    return 'Vencimento: $day/$month/$year';
  }

  @override
  String get urgent => 'Urgente';

  @override
  String get high => 'Alta';

  @override
  String get medium => 'Média';

  @override
  String get low => 'Baixa';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return 'Falha ao $action tarefa: $error';
  }

  @override
  String get vendorCompanyOptional => 'Fornecedor/Empresa (Opcional)';

  @override
  String get confirmationNumberOptional => 'Número de Confirmação (Opcional)';

  @override
  String amountCurrency(String currency) {
    return 'Valor ($currency)';
  }

  @override
  String get setBookingDateOptional => 'Definir Data da Reserva (Opcional)';

  @override
  String dateWithDate(int day, int month, int year) {
    return 'Data: $day/$month/$year';
  }

  @override
  String get attachmentsOptional => 'Anexos (Opcional)';

  @override
  String get maxFileSizeSupported =>
      'Tamanho máximo do arquivo: 5MB\nFormatos suportados: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return 'Falha ao $action reserva: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename anexado com sucesso';
  }

  @override
  String get fileSizeMustBeLess =>
      'O tamanho do arquivo deve ser menor que 5MB';

  @override
  String failedToPickFile(String error) {
    return 'Falha ao selecionar arquivo: $error';
  }

  @override
  String errorSharingFile(String error) {
    return 'Erro ao compartilhar arquivo: $error';
  }

  @override
  String get unknown => 'Desconhecido';

  @override
  String get editTrip => 'Editar Viagem';

  @override
  String get updateTrip => 'Atualizar Viagem';

  @override
  String get tripUpdatedSuccessfully => 'Viagem atualizada com sucesso';

  @override
  String get failedToUpdateTrip => 'Falha ao atualizar viagem';

  @override
  String get deleteTrip => 'Excluir Viagem';

  @override
  String get deleteTripConfirmation =>
      'Tem certeza de que deseja excluir esta viagem? Esta ação não pode ser desfeita.';

  @override
  String get tripDeletedSuccessfully => 'Viagem excluída com sucesso';

  @override
  String get failedToDeleteTrip => 'Falha ao excluir viagem';

  @override
  String get tripCreatedSuccessfully => 'Viagem criada com sucesso!';

  @override
  String get failedToCreateTrip => 'Falha ao criar viagem';

  @override
  String get selectStartDateFirst =>
      'Por favor, selecione primeiro a data de início';

  @override
  String get addAtLeastOneDestination =>
      'Por favor, adicione pelo menos um destino';

  @override
  String get selectBothStartAndEndDates =>
      'Por favor, selecione tanto a data de início quanto a de término';

  @override
  String get titleIsRequired => 'O título é obrigatório';

  @override
  String titleTooLong(int limit) {
    return 'O título deve ter $limit caracteres ou menos';
  }

  @override
  String descriptionTooLong(int limit) {
    return 'A descrição deve ter $limit caracteres ou menos';
  }

  @override
  String vendorTooLong(int limit) {
    return 'Fornecedor/Empresa deve ter $limit caracteres ou menos';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return 'O número de confirmação deve ter $limit caracteres ou menos';
  }

  @override
  String paidByTooLong(int limit) {
    return 'Pago por deve ter $limit caracteres ou menos';
  }

  @override
  String locationTooLong(int limit) {
    return 'A localização deve ter $limit caracteres ou menos';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return 'A descrição deve ter $limit caracteres ou menos';
  }

  @override
  String get amountIsRequired => 'O valor é obrigatório';

  @override
  String get enterValidAmount => 'Por favor, insira um valor válido';

  @override
  String get amountMustBePositive => 'O valor deve ser positivo';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName é obrigatório';
  }

  @override
  String get destinationIsRequired => 'O destino é obrigatório';

  @override
  String destinationTooLong(int limit) {
    return 'O destino deve ter $limit caracteres ou menos';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (Opcional)';
  }

  @override
  String maxCharacters(int maxLength) {
    return '$maxLength max';
  }

  @override
  String get searchTripsPlaceholder => 'Buscar viagens...';

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
    return 'Ativas ($count)';
  }

  @override
  String completedWithCount(int count) {
    return 'Concluídas ($count)';
  }

  @override
  String get yourTripsTitle => 'Suas Viagens';

  @override
  String activeTripsCount(int count) {
    return '$count Ativas';
  }

  @override
  String get bookingsTabTitle => 'Reservas';

  @override
  String get expensesTabTitle => 'Despesas';

  @override
  String get overviewTabTitle => 'Visão Geral';

  @override
  String get todoTabTitle => 'A Fazer';

  @override
  String get itineraryTabTitle => 'Itinerário';

  @override
  String get failedToLoadTrip => 'Falha ao carregar viagem';

  @override
  String get tripNotFound => 'Viagem não encontrada';

  @override
  String get saveImage => 'Salvar Imagem';

  @override
  String get saveToPhotos => 'Salvar nas Fotos';

  @override
  String get saveToPhotosDescription =>
      'Salvar diretamente na galeria de fotos';

  @override
  String get saveToFiles => 'Salvar nos Arquivos';

  @override
  String get saveToFilesDescription =>
      'Escolher uma pasta específica para salvar';

  @override
  String get imageSavedToPhotos => 'Imagem salva nas Fotos';

  @override
  String get fileSavedSuccessfully => 'Arquivo salvo com sucesso';

  @override
  String get open => 'Abrir';

  @override
  String errorDownloadingFile(String error) {
    return 'Erro ao baixar arquivo: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return 'Erro ao salvar nas Fotos: $error';
  }

  @override
  String errorSavingFile(String error) {
    return 'Erro ao salvar arquivo: $error';
  }

  @override
  String get selectDocument => 'Selecionar Documento';

  @override
  String get chooseFromGalleryTitle => 'Escolher da Galeria';

  @override
  String get chooseFromGalleryDescription =>
      'Selecionar da biblioteca de fotos';

  @override
  String get chooseFileTitle => 'Escolher Arquivo';

  @override
  String get chooseFileDescription => 'Selecionar PDF ou outros arquivos';

  @override
  String get failedToCaptureImage => 'Falha ao capturar imagem';

  @override
  String get failedToSelectImage => 'Falha ao selecionar imagem';

  @override
  String get failedToSelectFile => 'Falha ao selecionar arquivo';

  @override
  String get documentAddedSuccessfully => 'Documento adicionado com sucesso';

  @override
  String get documentUpdatedSuccessfully => 'Documento atualizado com sucesso';

  @override
  String get failedToSaveDocument => 'Falha ao salvar documento';

  @override
  String get documentTitle => 'Título do Documento *';

  @override
  String get documentCategory => 'Categoria do Documento';

  @override
  String get changeDocument => 'Alterar Documento';

  @override
  String get documentsTitle => 'Documentos';

  @override
  String get noDocumentsYet => 'Ainda sem documentos';

  @override
  String get noDocumentsFound => 'Nenhum documento encontrado';

  @override
  String get clearSearch => 'Limpar pesquisa';

  @override
  String get documentDetails => 'Detalhes do documento';

  @override
  String get fileSize => 'Tamanho do arquivo';

  @override
  String get fileName => 'Nome do arquivo';

  @override
  String get deleteDocument => 'Excluir Documento';

  @override
  String deleteDocumentConfirmation(String title) {
    return 'Tem certeza de que deseja excluir \"$title\"? Esta ação não pode ser desfeita.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return 'Documento \"$title\" excluído com sucesso';
  }

  @override
  String failedToDeleteDocument(String error) {
    return 'Falha ao excluir documento: $error';
  }

  @override
  String get location => 'Localização';

  @override
  String get activityTitleLabel => 'Título da Atividade';

  @override
  String get activityTypeLabel => 'Tipo de Atividade';

  @override
  String get expenseTitleLabel => 'Título da Despesa';

  @override
  String get destinations => 'Destinos';

  @override
  String get currency => 'Moeda';

  @override
  String get tripInProgressStatus => 'Viagem em Andamento';

  @override
  String get completedStatus => 'Concluído';

  @override
  String get tripDates => 'Datas da viagem';

  @override
  String get expenseType => 'Despesa';

  @override
  String get expenseDetailsTitle => 'Detalhes da Despesa';

  @override
  String get activityDetailsTitle => 'Detalhes da Atividade';

  @override
  String get deleteActivity => 'Excluir Atividade';

  @override
  String get deleteBooking => 'Excluir Reserva';

  @override
  String get january => 'Jan';

  @override
  String get february => 'Fev';

  @override
  String get march => 'Mar';

  @override
  String get april => 'Abr';

  @override
  String get may => 'Mai';

  @override
  String get june => 'Jun';

  @override
  String get july => 'Jul';

  @override
  String get august => 'Ago';

  @override
  String get september => 'Set';

  @override
  String get october => 'Out';

  @override
  String get november => 'Nov';

  @override
  String get december => 'Dez';

  @override
  String get food => 'Comida';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get cancelled => 'Cancelado';

  @override
  String get passport => 'Passaporte';

  @override
  String get visa => 'Visto';

  @override
  String get ticket => 'Bilhete';

  @override
  String get hotel => 'Hotel';

  @override
  String get insurance => 'Seguro';

  @override
  String get editDocument => 'Editar Documento';

  @override
  String get updateDocument => 'Atualizar Documento';

  @override
  String get saveToGallery => 'Salvar na Galeria';

  @override
  String get flight => 'Voo';

  @override
  String get restaurant => 'Restaurante';

  @override
  String get bookingLimitReached =>
      'Limite de reservas atingido. Você pode adicionar apenas 15 reservas por viagem.';

  @override
  String get documentLimitReached =>
      'Limite de documentos atingido. Você pode adicionar apenas 10 documentos no total.';

  @override
  String get clearFilters => 'Limpar filtros';

  @override
  String get travelDates => 'Datas da Viagem';

  @override
  String get selectDateRange => 'Selecionar Intervalo de Datas';

  @override
  String get activityDetails => 'Detalhes da Atividade';

  @override
  String get quickActions => 'Ações rápidas';

  @override
  String get addNewItemsToTrip => 'Adicionar novos itens à viagem';

  @override
  String get booking => 'Reserva';

  @override
  String get expense => 'Despesa';

  @override
  String get itinerary => 'Itinerário';

  @override
  String get duration => 'Duração';

  @override
  String get noExpensesFound => 'Nenhuma despesa encontrada';

  @override
  String get noExpensesFoundForCategory =>
      'Nenhuma despesa encontrada para esta categoria';

  @override
  String get noTasksFound => 'Nenhuma tarefa encontrada';

  @override
  String get noBookingsFound => 'Nenhuma reserva encontrada';

  @override
  String get noTripsFound => 'Nenhuma viagem encontrada';

  @override
  String get tryAdjustingFilters => 'Tente ajustar os filtros';

  @override
  String get searchTasks => 'Buscar tarefas';

  @override
  String get searchBookings => 'Buscar reservas';

  @override
  String get urgentPriority => 'Urgente';

  @override
  String get highPriority => 'Alto';

  @override
  String get mediumPriority => 'Médio';

  @override
  String get lowPriority => 'Baixo';

  @override
  String get overdue => 'Atrasado';

  @override
  String get dueToday => 'Vence hoje';

  @override
  String get dueTomorrow => 'Vence amanhã';

  @override
  String get activeStatus => 'Status ativo';

  @override
  String get selectBackupFile => 'Selecionar Arquivo de Backup';

  @override
  String get selectFile => 'Selecionar Arquivo';

  @override
  String get importBackup => 'Importar Backup';

  @override
  String get importSuccessful => 'Importação Bem-sucedida';

  @override
  String get importFailed => 'Falha na Importação';

  @override
  String get couldNotOpenAppStore => 'Não foi possível abrir a App Store';

  @override
  String get couldNotOpenHelpSection =>
      'Não foi possível abrir a seção de ajuda';

  @override
  String get couldNotOpenPrivacyPolicy =>
      'Não foi possível abrir a política de privacidade';

  @override
  String get couldNotOpenTermsOfService =>
      'Não foi possível abrir os termos de serviço';

  @override
  String get confirmActionWarning => 'Esta ação não pode ser desfeita!';

  @override
  String get finalConfirmationTitle => 'Confirmação Final';

  @override
  String finalConfirmationPrompt(String word) {
    return 'Digite $word na caixa abaixo para confirmar:';
  }

  @override
  String get deletingAllData => 'Excluindo todos os dados...';

  @override
  String get pleaseWait => 'Aguarde, isso pode levar um momento.';

  @override
  String get dataClearedTitle => 'Dados Limpos';

  @override
  String get dataClearedMessage =>
      'Todos os seus dados foram excluídos com sucesso. O aplicativo foi redefinido para seu estado inicial.';

  @override
  String get errorTitle => 'Erro';

  @override
  String failedToClearAllData(String error) {
    return 'Falha ao limpar todos os dados: $error';
  }

  @override
  String get exportIntroTitle =>
      'Crie um backup seguro de todos os seus dados do Voythrix:';

  @override
  String get exportEncryptionInfo =>
      'Seus dados serão criptografados e compactados em um arquivo .tripe.';

  @override
  String get backupPasswordTitle => 'Senha de Backup (Opcional)';

  @override
  String get backupPasswordHint => 'Digite a senha (opcional)';

  @override
  String get confirmPasswordHint => 'Confirme a senha';

  @override
  String get passwordsMatch => 'As senhas coincidem';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get creatingBackup => 'Criando backup...';

  @override
  String get collectingAndEncrypting =>
      'Coletando e criptografando seus dados...';

  @override
  String get backupCreatedTitle => 'Backup Criado';

  @override
  String get backupCreatedMessage => 'Seu backup foi criado com sucesso!';

  @override
  String get fileInfoLabel => 'Informações do Arquivo:';

  @override
  String get fileInfoFormat => '• Formato: Arquivo .tripe criptografado';

  @override
  String get fileInfoSecurityPassword => '• Segurança: Protegido por senha';

  @override
  String get fileInfoSecurityStandard => '• Segurança: Criptografia padrão';

  @override
  String get fileInfoCompression => '• Compressão: Compactado GZip';

  @override
  String get keepFileSafeNote =>
      'Mantenha este arquivo seguro — você precisará dele para restaurar seus dados!';

  @override
  String get exportFailedTitle => 'Falha na Exportação';

  @override
  String failedToCreateBackup(String error) {
    return 'Falha ao criar backup: $error';
  }

  @override
  String get continueAction => 'Continuar';

  @override
  String get deleteEverything => 'Excluir Tudo';

  @override
  String get createBackup => 'Criar Backup';

  @override
  String get ok => 'OK';
}
