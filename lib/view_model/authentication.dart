import 'package:flutter/material.dart';
import 'package:newtest/services/services_sharedpreference.dart';

import '../services/ApiFetcherGeneric.dart';
// Import SharedPrefs

class AuthViewModel extends ChangeNotifier {
  final Fetcher _fetcher = Fetcher();
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  Future<bool> authenticate(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    print("==============================");
    try {
      final response = await _fetcher.login(username, password);
      print("================================");
      print("Response from login: $response");
      _token = response['token'];

      // Store token in SharedPreferences
      await SharedPrefs.saveToken(_token!);
      print(_token); // Store token for authentication
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // You can create a method to check if the user is logged in on app startup
  Future<void> checkToken() async {
    String? storedToken = await SharedPrefs.getToken();
    if (storedToken != null) {
      _token = storedToken;
      notifyListeners();
    }
  }

  // You can also create a method to log out and remove the token from SharedPreferences
  Future<void> logout() async {
    await SharedPrefs.removeToken();
    _token = null;
    notifyListeners();
  }
}
