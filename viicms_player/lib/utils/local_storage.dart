import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  LocalStorage._();

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String? getString(String key) => _prefs?.getString(key);

  static Future<bool> setString(String key, String value) {
    assert(
      _prefs != null,
      'LocalStorage not initialized! Call LocalStorage.init() first',
    );
    return _prefs!.setString(key, value);
  }

  static Future<bool> remove(String key) {
    assert(
      _prefs != null,
      'LocalStorage not initialized! Call LocalStorage.init() first',
    );
    return _prefs!.remove(key);
  }

  // Other Method...
}
