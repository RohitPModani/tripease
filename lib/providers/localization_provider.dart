import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  final List<Locale> supportedLocales = const [
    Locale('en'), // English
    Locale('zh'), // Mandarin Chinese
    Locale('ja'), // Japanese
    Locale('ko'), // Korean
    Locale('es'), // Spanish
    Locale('fr'), // French
    Locale('de'), // German
    Locale('it'), // Italian
  ];

  LocalizationProvider() {
    _loadSavedLanguage();
  }

  void _loadSavedLanguage() {
    // For now, just use default language
    // TODO: Implement persistent storage for language setting
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    
    _currentLocale = locale;
    // TODO: Save to persistent storage
    notifyListeners();
  }

  String getLanguageDisplayName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'zh':
        return '中文 (Mandarin)';
      case 'ja':
        return '日本語 (Japanese)';
      case 'ko':
        return '한국어 (Korean)';
      case 'es':
        return 'Español (Spanish)';
      case 'fr':
        return 'Français (French)';
      case 'de':
        return 'Deutsch (German)';
      case 'it':
        return 'Italiano (Italian)';
      default:
        return 'English';
    }
  }

  String getLanguageNativeName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'zh':
        return '中文';
      case 'ja':
        return '日本語';
      case 'ko':
        return '한국어';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      case 'de':
        return 'Deutsch';
      case 'it':
        return 'Italiano';
      default:
        return 'English';
    }
  }
}