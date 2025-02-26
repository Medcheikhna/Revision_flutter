import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/services/services_sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/ApiFetcherGeneric.dart';
// Import SharedPrefs

class AuthViewService extends ChangeNotifier {
  final Fetcher _fetcher = Fetcher();
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  /// 🔍 Check First Launch & Authentication
  Future<void> checkAppStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
    String? storedToken = await SharedPrefs.getToken();

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Future.microtask(
          () => context.go('/languages')); // Navigate to Language Page
    } else if (storedToken != null) {
      _token = storedToken;
      notifyListeners();
      Future.microtask(() => context.go('/homepage')); // Navigate to Home Page
    }
  }

  Future<bool> authenticate(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _fetcher.login(username, password);

      if (response.token.isNotEmpty) {
        _token = response.token;

        // Store token securely
        await SharedPrefs.saveToken(_token!);

        _isLoading = false;
        notifyListeners();
        return true; // Login successful
      } else {
        _errorMessage = "Invalid credentials";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Error: ${e.toString()}";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // You can also create a method to log out and remove the token from SharedPreferences
  Future<void> logout() async {
    await SharedPrefs.removeToken();
    _token = null;
    notifyListeners();
  }
}
