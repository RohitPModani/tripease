import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  bool _isDarkMode = false;
  
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;
  
  ThemeProvider() {
    _loadThemePreference();
  }
  
  /// Reloads the theme preference from SharedPreferences
  Future<void> reloadTheme() async {
    await _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt('theme_mode') ?? 1; // 0 = system, 1 = light, 2 = dark
      
      switch (themeModeIndex) {
        case 0:
          _themeMode = ThemeMode.system;
          _isDarkMode = false;
          break;
        case 1:
          _themeMode = ThemeMode.light;
          _isDarkMode = false;
          break;
        case 2:
          _themeMode = ThemeMode.dark;
          _isDarkMode = true;
          break;
      }
      
      notifyListeners();
    } catch (e) {
      // If SharedPreferences fails, default to light theme
      _themeMode = ThemeMode.light;
      _isDarkMode = false;
    }
  }
  
  Future<void> _saveThemePreference(int themeModeIndex) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('theme_mode', themeModeIndex);
    } catch (e) {
      // Handle the error silently for now
      debugPrint('Failed to save theme preference: $e');
    }
  }
  
  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    _isDarkMode = mode == ThemeMode.dark;
    
    int themeModeIndex = 0;
    switch (mode) {
      case ThemeMode.system:
        themeModeIndex = 0;
        break;
      case ThemeMode.light:
        themeModeIndex = 1;
        break;
      case ThemeMode.dark:
        themeModeIndex = 2;
        break;
    }
    
    await _saveThemePreference(themeModeIndex);
    notifyListeners();
  }
  
  Future<void> toggleDarkMode() async {
    if (_themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      await setThemeMode(ThemeMode.dark);
    }
  }
  
  // Helper method to check if dark mode is currently active
  bool isCurrentlyDark(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }
}