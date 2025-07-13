import 'package:flutter/material.dart';

class LocaleManager with ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  void toggleLanguage() {
    _locale =
        _locale.languageCode == 'en' ? const Locale('zh') : const Locale('en');
    notifyListeners();
  }
}
