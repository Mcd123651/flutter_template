// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_template/res/color_schemes.dart';

/// AppTheme class: This class will manage the light and dark theme for the app.
class AppTheme extends ChangeNotifier {
  // Boolean flag to keep track if it's dark theme.
  bool _isDarkTheme = false;

  final ThemeData _lightTheme =
      ThemeData(useMaterial3: true, colorScheme: lightColorScheme);

  final ThemeData _darkTheme =
      ThemeData(useMaterial3: true, colorScheme: darkColorScheme);

  // Getter for the current theme
  ThemeData get currentTheme => _isDarkTheme ? _darkTheme : _lightTheme;

  // Getter to check if current theme is dark
  bool get isDarkTheme => _isDarkTheme;

  // Toggle the theme
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners(); // This will notify all the listening widgets to rebuild.
  }
}
