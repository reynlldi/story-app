import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  static const String localeKey = 'locale';
  Locale _locale = const Locale('id');

  LocalizationProvider() {
    _loadLocale();
  }

  Locale get locale => _locale;

  void setLocale(Locale locale) async {
    _locale = locale;
    notifyListeners();
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(localeKey, locale.languageCode);
  }

  Future<void> _loadLocale() async {
    final preferences = await SharedPreferences.getInstance();
    final localeCode = preferences.getString(localeKey) ?? 'id';
    _locale = Locale(localeCode);
    notifyListeners();
  }
}
