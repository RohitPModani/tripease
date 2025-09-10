import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../l10n/app_localizations.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String _languageKey = 'selected_language';
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  // Single source of truth from generated localizations
  final List<Locale> supportedLocales = AppLocalizations.supportedLocales;

  LocalizationProvider() {
    _loadSavedLanguage();
  }

  /// Reloads the saved language from SharedPreferences
  Future<void> reloadLanguage() async {
    await _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_languageKey);
      if (saved != null && saved.isNotEmpty) {
        final parts = saved.split('_');
        _currentLocale = parts.length > 1 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
        notifyListeners();
        return;
      }
      // Fallback to device locale if supported, else keep default 'en'
      final device = WidgetsBinding.instance.platformDispatcher.locale;
      final deviceBase = Locale(device.languageCode);
      if (supportedLocales.contains(device) || supportedLocales.contains(deviceBase)) {
        _currentLocale = supportedLocales.contains(device) ? device : deviceBase;
        notifyListeners();
      }
    } catch (_) {
      // Ignore and keep default
    }
  }

  Future<void> setLocale(Locale locale) async {
    if (!supportedLocales.contains(locale)) return;
    
    _currentLocale = locale;
    // Persist selection
    final prefs = await SharedPreferences.getInstance();
    final code = locale.countryCode == null || locale.countryCode!.isEmpty
        ? locale.languageCode
        : '${locale.languageCode}_${locale.countryCode}';
    await prefs.setString(_languageKey, code);
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
      case 'pt':
        return 'Português (Portuguese)';
      case 'ru':
        return 'Русский (Russian)';
      case 'ar':
        return 'العربية (Arabic)';
      case 'hi':
        return 'हिन्दी (Hindi)';
      case 'nl':
        return 'Nederlands (Dutch)';
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
      case 'pt':
        return 'Português';
      case 'ru':
        return 'Русский';
      case 'ar':
        return 'العربية';
      case 'hi':
        return 'हिन्दी';
      case 'nl':
        return 'Nederlands';
      default:
        return 'English';
    }
  }
}
