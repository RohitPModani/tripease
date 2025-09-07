// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '트립이즈';

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
  String get pushNotifications => '푸시 알림';

  @override
  String get getRemindersAndUpdates => '알림 및 업데이트 받기';

  @override
  String get locationServices => '위치 서비스';

  @override
  String get allowLocationBasedFeatures => '위치 기반 기능 허용';

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
  String get biometricAuthentication => '생체 인증';

  @override
  String get biometricAuthenticationDescription => '지문이나 얼굴 인식을 사용하여 앱을 보호하세요';
}
