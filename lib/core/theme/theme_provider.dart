import 'package:flutter/material.dart';
import 'package:hear_music/core/theme/dark_mode.dart';
import 'package:hear_music/core/theme/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hear_music/core/services/shared_prefrences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  bool _prefsServiceLoading = true; // <-- Add this line
  SharedPreferencesService? _prefsService;

  bool get isDarkMode => _isDarkMode;
  bool get prefsServiceLoading => _prefsServiceLoading; // <-- Add this getter

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _prefsService = SharedPreferencesService(prefs);
    _isDarkMode = _prefsService!.getIsDarkMode();
    _prefsServiceLoading = false; // <-- Set loading to false after loading
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    if (_prefsService == null) {
      final prefs = await SharedPreferences.getInstance();
      _prefsService = SharedPreferencesService(prefs);
    }
    await _prefsService!.setIsDarkMode(_isDarkMode);
  }

  ThemeData get themeData => _isDarkMode ? ThemeData.dark() : ThemeData.light();
}