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
}
