import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class LanguageViewModel extends ChangeNotifier {
  static const String languageKey = "language_code";
  Locale _locale = Locale(ui.window.locale.languageCode);

  Locale get locale => _locale;
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;
  LanguageViewModel() {
    loadTheme();
    loadLocale();
  }

  /// Load saved locale or use device locale
  Future<void> loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? langCode = prefs.getString(languageKey);

    // Provide a default value if langCode is null
    _locale = Locale(langCode ?? ui.window.locale.languageCode);

    notifyListeners();
  }

  /// Set a new locale and update UI
  Future<void> setLocale(Locale newLocale) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(languageKey, newLocale.languageCode);

    _locale = newLocale;
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    // Get the stored value, defaulting to false (light mode) if not found
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    // Toggle the theme mode
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);

    notifyListeners();
  }
}
