import 'package:flutter/material.dart';
import 'package:hear_music/core/theme/dark_mode.dart';
import 'package:hear_music/core/theme/light_mode.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme; // Default theme is light

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkTheme;

  set themeData(ThemeData theme) {
    _themeData = theme;
    // Notify listeners when the theme changes
    notifyListeners();
  }

  // Method to toggle between light and dark themes
  // This method is called when the user taps the theme toggle button
  // in the app bar or any other UI element
  // It switches the theme and notifies listeners to rebuild the UI
  void toggleTheme() {
    if (_themeData == lightTheme) {
      _themeData = darkTheme;
    } else {
      _themeData = lightTheme;
    }
    notifyListeners();
  }
}