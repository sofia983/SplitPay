import 'package:shared_preferences/shared_preferences.dart';

class LocalPreferences {
  static const String _keyDarkMode = 'is_dark_mode';
  static const String _keyPreferredCurrency = 'preferred_currency';

  Future<void> setDarkMode(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, isDark);
  }

  Future<bool> getDarkMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ?? false;
  }

  Future<void> setPreferredCurrency(String currency) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyPreferredCurrency, currency);
  }

  Future<String> getPreferredCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyPreferredCurrency) ?? 'COP';
  }
}