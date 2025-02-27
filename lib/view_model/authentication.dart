import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/services/services_sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/ApiFetcherGeneric.dart';

class AuthViewService extends ChangeNotifier {
  final Fetcher _fetcher = Fetcher();
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;

  Future<void> checkAppStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await SharedPrefs.removeToken();
    _token = null;

    bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      await prefs.setBool('isFirstLaunch', false);
      Future.microtask(() => context.go('/languages'));
    } else {
      Future.microtask(() => context.go('/'));
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

        
        await SharedPrefs.saveToken(_token!);

        _isLoading = false;
        notifyListeners();
        return true;
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

 
  Future<void> logout() async {
    await SharedPrefs.removeToken();
    _token = null;
    notifyListeners();
  }
}
