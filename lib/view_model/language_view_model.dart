import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class LanguageViewModel extends ChangeNotifier {
  static const String languageKey = "language_code";
  Locale _locale = Locale(ui.window.locale.languageCode);

  Locale get locale => _locale;

  /// Load saved locale or use device locale
  Future<void> loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString(languageKey);

    _locale = Locale(langCode!);

    notifyListeners();
  }

  /// Set a new locale and update UI
  Future<void> setLocale(Locale newLocale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, newLocale.languageCode);

    _locale = newLocale;
    notifyListeners();
  }
}
