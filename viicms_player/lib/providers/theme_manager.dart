import 'dart:ui';
import 'package:flutter/material.dart';

enum ThemeModeType { light, dark, system }

class ThemeManager with ChangeNotifier {
  ThemeModeType _themeMode = ThemeModeType.system;
  bool _isDarkMode = false;

  ThemeModeType get themeMode => _themeMode;
  bool get isDarkMode => _isDarkMode;

  ThemeManager() {
    _initTheme();
  }

  void _initTheme() {
    if (_themeMode == ThemeModeType.system) {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      _isDarkMode = brightness == Brightness.dark;
    }
    notifyListeners();
  }

  void toggleTheme(ThemeModeType mode) {
    _themeMode = mode;

    switch (mode) {
      case ThemeModeType.light:
        _isDarkMode = false;
        break;
      case ThemeModeType.dark:
        _isDarkMode = true;
        break;
      case ThemeModeType.system:
        final brightness = PlatformDispatcher.instance.platformBrightness;
        _isDarkMode = brightness == Brightness.dark;
        break;
    }
    notifyListeners();
  }
}
