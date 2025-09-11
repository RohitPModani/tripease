// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'Voythrix';

  @override
  String get trips => '여행';

  @override
  String get documents => '문서';

  @override
  String get settings => '설정';

  @override
  String get quickStats => '빠른 통계';

  @override
  String get activeTrips => '활성 여행';

  @override
  String get pendingTasks => '대기 중인 작업';

  @override
  String get totalBudget => '총 예산';

  @override
  String nextTripStartsIn(int days) {
    return '다음 여행까지 $days일';
  }

  @override
  String get yourTrips => '당신의 여행';

  @override
  String get searchTrips => '여행 검색...';

  @override
  String get daysUntilStart => '시작까지 일수';

  @override
  String get dateCreated => '생성 날짜';

  @override
  String get alphabetical => '알파벳순';

  @override
  String get budget => '예산';

  @override
  String get tasks => '작업';

  @override
  String get tripInProgress => '여행 진행 중';

  @override
  String get startingToday => '오늘 시작!';

  @override
  String daysToGo(int days) {
    return '$days일 남음';
  }

  @override
  String active(int count) {
    return '$count개 활성';
  }

  @override
  String get searchDocuments => '문서 검색...';

  @override
  String get personal => '개인';

  @override
  String get tripRelated => '여행 관련';

  @override
  String get uploadDocument => '문서 업로드';

  @override
  String get takePhoto => '사진 촬영';

  @override
  String get captureDocumentWithCamera => '카메라로 문서 촬영';

  @override
  String get chooseFromGallery => '갤러리에서 선택';

  @override
  String get selectFromPhotoLibrary => '사진 라이브러리에서 선택';

  @override
  String get chooseFile => '파일 선택';

  @override
  String get selectPdfOrOtherFiles => 'PDF 또는 기타 파일 선택';

  @override
  String expires(String date) {
    return '만료: $date';
  }

  @override
  String get view => '보기';

  @override
  String get share => '공유';

  @override
  String get download => '다운로드';

  @override
  String get delete => '삭제';

  @override
  String get profile => '프로필';

  @override
  String get preferences => '환경설정';

  @override
  String get darkMode => '다크 모드';

  @override
  String get switchBetweenLightAndDarkTheme => '밝은 테마와 어두운 테마 전환';

  @override
  String get language => '언어';

  @override
  String get selectYourPreferredLanguage => '선호 언어 선택';

  @override
  String get defaultCurrency => '기본 통화';

  @override
  String get currencyUsedForNewTrips => '새 여행에 사용할 통화';

  @override
  String get dateFormat => '날짜 형식';

  @override
  String get howDatesAreDisplayed => '날짜 표시 방법';

  @override
  String get temperatureUnit => '온도 단위';

  @override
  String get temperatureScalePreference => '온도 스케일 설정';

  @override
  String get appSettings => '앱 설정';

  @override
  String get backupAndSync => '백업 및 동기화';

  @override
  String get manageYourDataBackup => '데이터 백업 관리';

  @override
  String get importData => '데이터 가져오기';

  @override
  String get importTripsFromOtherApps => '다른 앱에서 여행 가져오기';

  @override
  String get exportData => '데이터 내보내기';

  @override
  String get exportYourTripData => '여행 데이터 내보내기';

  @override
  String get about => '정보';

  @override
  String get appVersion => '앱 버전';

  @override
  String get rateApp => '앱 평가';

  @override
  String get leaveAReviewOnTheAppStore => '앱스토어에 리뷰 남기기';

  @override
  String get helpAndSupport => '도움말 및 지원';

  @override
  String get faqsAndContactInformation => 'FAQ 및 연락처 정보';

  @override
  String get privacyPolicy => '개인정보처리방침';

  @override
  String get readOurPrivacyPolicy => '개인정보처리방침 읽기';

  @override
  String get termsOfService => '서비스 약관';

  @override
  String get readOurTermsAndConditions => '이용약관 읽기';

  @override
  String get dangerZone => '위험 구역';

  @override
  String get clearAllData => '모든 데이터 삭제';

  @override
  String get removeAllTripsAndDocuments => '모든 여행 및 문서 제거';

  @override
  String get clearAllDataConfirmation =>
      '이 작업은 되돌릴 수 없습니다. 모든 여행, 문서 및 설정이 영구적으로 삭제됩니다.';

  @override
  String get cancel => '취소';

  @override
  String get clearAll => '모두 삭제';

  @override
  String get celsius => '섭씨';

  @override
  String get fahrenheit => '화씨';

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
  String get title => '제목';

  @override
  String get description => '설명';

  @override
  String get amount => '금액';

  @override
  String get date => '날짜';

  @override
  String get edit => '편집';

  @override
  String get retry => '다시 시도';

  @override
  String get add => '추가';

  @override
  String get update => '업데이트';

  @override
  String get close => '닫기';

  @override
  String get failedToLoad => '로드 실패';

  @override
  String get noDataYet => '아직 데이터가 없습니다';

  @override
  String get startPlanning => '다음 모험을 계획해보세요!';

  @override
  String get createTrip => '여행 만들기';

  @override
  String get addDocument => '문서 추가';

  @override
  String get addExpense => '지출 추가';

  @override
  String get addActivity => '활동 추가';

  @override
  String get addBooking => '예약 추가';

  @override
  String get totalExpenses => '총 지출';

  @override
  String get toDoItems => '할 일 목록';

  @override
  String get expenseDetails => '지출 세부사항';

  @override
  String get expenseTitle => '지출 제목';

  @override
  String get category => '카테고리';

  @override
  String get paidBy => '결제자';

  @override
  String get you => '당신';

  @override
  String get allDay => '하루 종일';

  @override
  String get startTime => '시작 시간';

  @override
  String get endTime => '종료 시간';

  @override
  String get activityTitle => '활동 제목';

  @override
  String get activityType => '활동 유형';

  @override
  String get bookingTitle => '예약 제목';

  @override
  String get bookingType => '예약 유형';

  @override
  String get status => '상태';

  @override
  String get addFile => '파일 추가';

  @override
  String get fileNotFound => '파일을 찾을 수 없습니다';

  @override
  String get fileMovedOrDeleted => '파일이 이동되었거나 삭제되었을 수 있습니다';

  @override
  String get cannotDisplayImage => '이미지를 표시할 수 없습니다';

  @override
  String get openExternally => '외부에서 열기';

  @override
  String get failedToReadFile => '파일 데이터 읽기 실패';

  @override
  String get deleteExpense => '지출 삭제';

  @override
  String get deleteExpenseConfirmation => '이 지출을 삭제하시겠습니까?';

  @override
  String get expenseBreakdown => '지출 분석';

  @override
  String get breakdown => '분석';

  @override
  String get noExpensesYet => '아직 지출이 없습니다';

  @override
  String get noActivitiesPlanned => '계획된 활동이 없습니다';

  @override
  String get splitDetails => '분할 세부사항';

  @override
  String get editExpense => '지출 편집';

  @override
  String get addNewExpense => '새 지출 추가';

  @override
  String get editActivity => '활동 편집';

  @override
  String get addNewActivity => '새 활동 추가';

  @override
  String get editBooking => '예약 편집';

  @override
  String get addNewBooking => '새 예약 추가';

  @override
  String get updateExpense => '지출 업데이트';

  @override
  String get updateActivity => '활동 업데이트';

  @override
  String get updateBooking => '예약 업데이트';

  @override
  String get transport => '교통';

  @override
  String get accommodation => '숙박';

  @override
  String get activities => '활동';

  @override
  String get shopping => '쇼핑';

  @override
  String get sightseeing => '관광';

  @override
  String get meal => '식사';

  @override
  String get entertainment => '엔터테인먼트';

  @override
  String get other => '기타';

  @override
  String get noBookingsYet => '아직 예약이 없습니다';

  @override
  String get addFirstBooking => '첫 예약 추가';

  @override
  String get bookingDetails => '예약 세부사항';

  @override
  String get vendor => '공급업체';

  @override
  String get confirmationNumber => '확인 번호';

  @override
  String get attachments => '첨부파일';

  @override
  String get failedToLoadTodos => '할 일 로드 실패';

  @override
  String get task => '작업';

  @override
  String allWithCount(int count) {
    return '모두 ($count)';
  }

  @override
  String get noToDoItems => '할 일이 없습니다';

  @override
  String get stayOrganizedMessage => '여행 계획을 위한 작업을 추가하여 정리정돈을 유지하세요!';

  @override
  String get addFirstTask => '첫 작업 추가';

  @override
  String get taskDetails => '작업 세부사항';

  @override
  String get completed => '완료';

  @override
  String get pending => '대기 중';

  @override
  String get priority => '우선순위';

  @override
  String get dueDate => '마감일';

  @override
  String get editTask => '작업 편집';

  @override
  String get addNewTask => '새 작업 추가';

  @override
  String get updateTask => '작업 업데이트';

  @override
  String get addTask => '작업 추가';

  @override
  String get deleteTask => '작업 삭제';

  @override
  String deleteTaskConfirmation(String title) {
    return '\"$title\"을(를) 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String get keepTrackMessage => '항공편, 호텔, 활동을 추적하세요!';

  @override
  String get previewNotAvailable =>
      '이 파일 유형에 대한 미리보기를 사용할 수 없습니다.\n\"외부에서 열기\"를 탭하여 다른 앱으로 보세요.';

  @override
  String get appVersionBeta => '1.0.0 (베타)';

  @override
  String get defaultUserName => '김철수';

  @override
  String get defaultUserEmail => 'kim.chulsoo@email.com';

  @override
  String get taskTitle => '작업 제목';

  @override
  String get descriptionOptional => '설명 (선택사항)';

  @override
  String get setDueDateOptional => '마감일 설정 (선택사항)';

  @override
  String dueWithDate(int day, int month, int year) {
    return '마감일: $year/$month/$day';
  }

  @override
  String get urgent => '긴급';

  @override
  String get high => '높음';

  @override
  String get medium => '보통';

  @override
  String get low => '낮음';

  @override
  String failedToAddUpdateTask(String action, String error) {
    return '작업 $action 실패: $error';
  }

  @override
  String get vendorCompanyOptional => '공급업체/회사 (선택사항)';

  @override
  String get confirmationNumberOptional => '확인 번호 (선택사항)';

  @override
  String amountCurrency(String currency) {
    return '금액 ($currency)';
  }

  @override
  String get setBookingDateOptional => '예약일 설정 (선택사항)';

  @override
  String dateWithDate(int day, int month, int year) {
    return '날짜: $year/$month/$day';
  }

  @override
  String get attachmentsOptional => '첨부파일 (선택사항)';

  @override
  String get maxFileSizeSupported =>
      '최대 파일 크기: 5MB\n지원 형식: PDF, DOC, DOCX, JPG, PNG, GIF';

  @override
  String failedToAddUpdateBooking(String action, String error) {
    return '예약 $action 실패: $error';
  }

  @override
  String fileAttachedSuccessfully(String filename) {
    return '$filename이(가) 성공적으로 첨부되었습니다';
  }

  @override
  String get fileSizeMustBeLess => '파일 크기는 5MB 미만이어야 합니다';

  @override
  String failedToPickFile(String error) {
    return '파일 선택 실패: $error';
  }

  @override
  String errorSharingFile(String error) {
    return '파일 공유 오류: $error';
  }

  @override
  String get unknown => '알 수 없음';

  @override
  String get editTrip => '여행 편집';

  @override
  String get updateTrip => '여행 업데이트';

  @override
  String get tripUpdatedSuccessfully => '여행이 성공적으로 업데이트되었습니다';

  @override
  String get failedToUpdateTrip => '여행 업데이트에 실패했습니다';

  @override
  String get deleteTrip => '여행 삭제';

  @override
  String get deleteTripConfirmation => '이 여행을 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';

  @override
  String get tripDeletedSuccessfully => '여행이 성공적으로 삭제되었습니다';

  @override
  String get failedToDeleteTrip => '여행 삭제에 실패했습니다';

  @override
  String get tripCreatedSuccessfully => '여행이 성공적으로 생성되었습니다!';

  @override
  String get failedToCreateTrip => '여행 생성에 실패했습니다';

  @override
  String get selectStartDateFirst => '먼저 시작일을 선택해주세요';

  @override
  String get addAtLeastOneDestination => '최소 하나의 목적지를 추가해주세요';

  @override
  String get selectBothStartAndEndDates => '시작일과 종료일을 모두 선택해주세요';

  @override
  String get titleIsRequired => '제목은 필수입니다';

  @override
  String titleTooLong(int limit) {
    return '제목은 $limit자 이내여야 합니다';
  }

  @override
  String descriptionTooLong(int limit) {
    return '설명은 $limit자 이내여야 합니다';
  }

  @override
  String vendorTooLong(int limit) {
    return '공급업체/회사는 $limit자 이내여야 합니다';
  }

  @override
  String confirmationNumberTooLong(int limit) {
    return '확인 번호는 $limit자 이내여야 합니다';
  }

  @override
  String paidByTooLong(int limit) {
    return '결제자는 $limit자 이내여야 합니다';
  }

  @override
  String locationTooLong(int limit) {
    return '위치는 $limit자 이내여야 합니다';
  }

  @override
  String itineraryDescriptionTooLong(int limit) {
    return '설명은 $limit자 이내여야 합니다';
  }

  @override
  String get amountIsRequired => '금액은 필수입니다';

  @override
  String get enterValidAmount => '유효한 금액을 입력하세요';

  @override
  String get amountMustBePositive => '금액은 양수여야 합니다';

  @override
  String fieldIsRequired(String fieldName) {
    return '$fieldName은(는) 필수입니다';
  }

  @override
  String get destinationIsRequired => '목적지는 필수입니다';

  @override
  String destinationTooLong(int limit) {
    return '목적지는 $limit자 이내여야 합니다';
  }

  @override
  String fieldOptional(String labelText) {
    return '$labelText (선택사항)';
  }

  @override
  String maxCharacters(int maxLength) {
    return '최대 $maxLength자';
  }

  @override
  String get searchTripsPlaceholder => '여행 검색...';

  @override
  String allWithTotal(int total) {
    return '전체 ($total)';
  }

  @override
  String upcomingWithCount(int count) {
    return '예정 ($count)';
  }

  @override
  String activeWithCount(int count) {
    return '활성 ($count)';
  }

  @override
  String completedWithCount(int count) {
    return '완료 ($count)';
  }

  @override
  String get yourTripsTitle => '당신의 여행';

  @override
  String activeTripsCount(int count) {
    return '$count개 활성';
  }

  @override
  String get bookingsTabTitle => '예약';

  @override
  String get expensesTabTitle => '지출';

  @override
  String get overviewTabTitle => '개요';

  @override
  String get todoTabTitle => '할 일';

  @override
  String get itineraryTabTitle => '여정';

  @override
  String get failedToLoadTrip => '여행 로드 실패';

  @override
  String get tripNotFound => '여행을 찾을 수 없습니다';

  @override
  String get saveImage => '이미지 저장';

  @override
  String get saveToPhotos => '사진에 저장';

  @override
  String get saveToPhotosDescription => '사진 갤러리에 직접 저장';

  @override
  String get saveToFiles => '파일에 저장';

  @override
  String get saveToFilesDescription => '저장할 특정 폴더 선택';

  @override
  String get imageSavedToPhotos => '이미지가 사진에 저장됨';

  @override
  String get fileSavedSuccessfully => '파일이 성공적으로 저장됨';

  @override
  String get open => '열기';

  @override
  String errorDownloadingFile(String error) {
    return '파일 다운로드 오류: $error';
  }

  @override
  String errorSavingToPhotos(String error) {
    return '사진 저장 오류: $error';
  }

  @override
  String errorSavingFile(String error) {
    return '파일 저장 오류: $error';
  }

  @override
  String get selectDocument => '문서 선택';

  @override
  String get chooseFromGalleryTitle => '갤러리에서 선택';

  @override
  String get chooseFromGalleryDescription => '사진 라이브러리에서 선택';

  @override
  String get chooseFileTitle => '파일 선택';

  @override
  String get chooseFileDescription => 'PDF 또는 기타 파일 선택';

  @override
  String get failedToCaptureImage => '이미지 촬영 실패';

  @override
  String get failedToSelectImage => '이미지 선택 실패';

  @override
  String get failedToSelectFile => '파일 선택 실패';

  @override
  String get documentAddedSuccessfully => '문서가 성공적으로 추가됨';

  @override
  String get documentUpdatedSuccessfully => '문서가 성공적으로 업데이트됨';

  @override
  String get failedToSaveDocument => '문서 저장 실패';

  @override
  String get documentTitle => '문서 제목 *';

  @override
  String get documentCategory => '문서 카테고리';

  @override
  String get changeDocument => '문서 변경';

  @override
  String get documentsTitle => '문서';

  @override
  String get noDocumentsYet => '아직 문서가 없습니다';

  @override
  String get noDocumentsFound => '문서를 찾을 수 없습니다';

  @override
  String get clearSearch => '검색 지우기';

  @override
  String get documentDetails => '문서 세부정보';

  @override
  String get fileSize => '파일 크기';

  @override
  String get fileName => '파일명';

  @override
  String get deleteDocument => '문서 삭제';

  @override
  String deleteDocumentConfirmation(String title) {
    return '\"$title\"을(를) 삭제하시겠습니까? 이 작업은 되돌릴 수 없습니다.';
  }

  @override
  String documentDeletedSuccessfully(String title) {
    return '문서 \"$title\"이(가) 성공적으로 삭제됨';
  }

  @override
  String failedToDeleteDocument(String error) {
    return '문서 삭제 실패: $error';
  }

  @override
  String get location => '위치';

  @override
  String get activityTitleLabel => '활동 제목';

  @override
  String get activityTypeLabel => '활동 유형';

  @override
  String get expenseTitleLabel => '지출 제목';

  @override
  String get destinations => '목적지';

  @override
  String get currency => '통화';

  @override
  String get tripInProgressStatus => '여행 진행 중';

  @override
  String get completedStatus => '완료됨';

  @override
  String get tripDates => '여행 날짜';

  @override
  String get expenseType => '지출';

  @override
  String get expenseDetailsTitle => '지출 세부사항';

  @override
  String get activityDetailsTitle => '활동 세부사항';

  @override
  String get deleteActivity => '활동 삭제';

  @override
  String get deleteBooking => '예약 삭제';

  @override
  String get january => '1월';

  @override
  String get february => '2월';

  @override
  String get march => '3월';

  @override
  String get april => '4월';

  @override
  String get may => '5월';

  @override
  String get june => '6월';

  @override
  String get july => '7월';

  @override
  String get august => '8월';

  @override
  String get september => '9월';

  @override
  String get october => '10월';

  @override
  String get november => '11월';

  @override
  String get december => '12월';

  @override
  String get food => '음식';

  @override
  String get confirmed => '확인됨';

  @override
  String get cancelled => '취소됨';

  @override
  String get passport => '여권';

  @override
  String get visa => '비자';

  @override
  String get ticket => '티켓';

  @override
  String get hotel => '호텔';

  @override
  String get insurance => '보험';

  @override
  String get editDocument => '문서 편집';

  @override
  String get updateDocument => '문서 업데이트';

  @override
  String get saveToGallery => '갤러리에 저장';

  @override
  String get flight => '항공편';

  @override
  String get restaurant => '레스토랑';

  @override
  String get bookingLimitReached =>
      '예약 한도에 도달했습니다. 여행당 최대 15개의 예약만 추가할 수 있습니다.';

  @override
  String get documentLimitReached => '문서 한도에 도달했습니다. 총 최대 10개의 문서만 추가할 수 있습니다.';

  @override
  String get clearFilters => '필터 지우기';

  @override
  String get travelDates => '여행 날짜';

  @override
  String get selectDateRange => '날짜 범위 선택';

  @override
  String get activityDetails => '활동 세부사항';

  @override
  String get quickActions => '빠른 작업';

  @override
  String get addNewItemsToTrip => '여행에 새 항목 추가';

  @override
  String get booking => '예약';

  @override
  String get expense => '지출';

  @override
  String get itinerary => '여정';

  @override
  String get duration => '기간';

  @override
  String get noExpensesFound => '지출을 찾을 수 없습니다';

  @override
  String get noExpensesFoundForCategory => '이 카테고리에서 지출을 찾을 수 없습니다';

  @override
  String get noTasksFound => '작업을 찾을 수 없습니다';

  @override
  String get noBookingsFound => '예약을 찾을 수 없습니다';

  @override
  String get noTripsFound => '여행을 찾을 수 없습니다';

  @override
  String get tryAdjustingFilters => '필터를 조정해 보세요';

  @override
  String get searchTasks => '작업 검색';

  @override
  String get searchBookings => '예약 검색';

  @override
  String get urgentPriority => '긴급';

  @override
  String get highPriority => '높음';

  @override
  String get mediumPriority => '보통';

  @override
  String get lowPriority => '낮음';

  @override
  String get overdue => '기한 초과';

  @override
  String get dueToday => '오늘 마감';

  @override
  String get dueTomorrow => '내일 마감';

  @override
  String get activeStatus => '활성 상태';

  @override
  String get selectBackupFile => '백업 파일 선택';

  @override
  String get selectFile => '파일 선택';

  @override
  String get importBackup => '백업 가져오기';

  @override
  String get importSuccessful => '가져오기 성공';

  @override
  String get importFailed => '가져오기 실패';

  @override
  String get couldNotOpenAppStore => '앱 스토어를 열 수 없습니다';

  @override
  String get couldNotOpenHelpSection => '도움말 섹션을 열 수 없습니다';

  @override
  String get couldNotOpenPrivacyPolicy => '개인정보처리방침을 열 수 없습니다';

  @override
  String get couldNotOpenTermsOfService => '서비스 약관을 열 수 없습니다';

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
  String get keepFileSafeNote => '이 파일을 안전하게 보관하세요 — 데이터 복원에 필요합니다!';

  @override
  String get exportFailedTitle => '내보내기 실패';

  @override
  String failedToCreateBackup(String error) {
    return '백업 생성 실패: $error';
  }

  @override
  String get continueAction => 'Continue';

  @override
  String get deleteEverything => '모두 삭제';

  @override
  String get createBackup => '백업 생성';

  @override
  String get ok => 'OK';
}
