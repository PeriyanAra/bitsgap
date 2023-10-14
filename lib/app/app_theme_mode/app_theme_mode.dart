import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppThemeMode with ChangeNotifier, DiagnosticableTreeMixin {
  AppThemeMode([ThemeMode? themeMode]) : _themeMode = themeMode ?? ThemeMode.light;

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void updateThemeMode(ThemeMode themeMode) {
    if (themeMode != _themeMode) {
      _themeMode = themeMode;
      notifyListeners();
    }
  }
}
