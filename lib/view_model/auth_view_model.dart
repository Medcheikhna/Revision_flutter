import 'package:flutter/material.dart';

import 'package:newtest/model/auth.dart';
import 'package:newtest/services/fetcher.dart';
// Add this import
import 'package:newtest/services/services_sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewModel extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final Fetcher _fetcher = Fetcher();
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;
  Auth? _currentAuth;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;
  Auth? get currentAuth => _currentAuth;
  bool? isFirstLaunch;
  Future<bool> checkAppStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch == true) {
      await prefs.setBool('isFirstLaunch', false);
    }

    notifyListeners();
    return isFirstLaunch!;
  }

  Future<bool> authenticate(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    print("=======================================");
    try {
      final response = await _fetcher.login(username, password);
      print(response);
      print("===========================");
      if (response.token!.isNotEmpty) {
        _token = response.token;
        await SharedPrefs.saveToken(_token!);
        _currentAuth = response;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Identifiants incorrects";
      }
    } catch (e) {
      print("Authentication error: $e");
      _errorMessage = "Unable to connect. Check your connection ";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<void> logout() async {
    await SharedPrefs.removeToken();
    _token = null;
    _currentAuth = null;
    notifyListeners();
  }
}
