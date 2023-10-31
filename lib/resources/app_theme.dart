// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_template/resources/color_schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// AppTheme class: Manages the theme (light/dark) for the app.
class AppTheme extends ChangeNotifier {
  bool _isDarkTheme;

  AppTheme(this._isDarkTheme);

  // Themes
  final ThemeData _lightTheme =
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);
  final ThemeData _darkTheme =
      ThemeData(useMaterial3: true, colorScheme: darkColorScheme);

  /// Get the current theme based on the theme state.
  ThemeData get currentTheme => _isDarkTheme ? _darkTheme : _lightTheme;

  /// Check if the current theme is set to dark.
  bool get isDarkTheme => _isDarkTheme;

  /// Toggle between light and dark themes.
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveThemePreference();
    notifyListeners(); // Notify listeners to rebuild widgets.
  }

  /// Save the current theme preference to shared preferences.
  Future<void> _saveThemePreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', _isDarkTheme);
  }
}
