import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newtest/model/auth.dart';
import 'package:newtest/services/fetcher.dart';
// Add this import
import 'package:newtest/services/services_sharedpreference.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthViewService extends ChangeNotifier {
  final Fetcher _fetcher = Fetcher();
  bool _isLoading = false;
  String? _errorMessage;
  String? _token;
  UserModel? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get token => _token;
  UserModel? get currentUser => _currentUser;
  bool? isFirstLaunch;
  Future<void> checkAppStatus(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch == true) {
      await prefs.setBool('isFirstLaunch', false);

      Future.microtask(() {
        context.go('/languages');
      });
      notifyListeners();
    } else if (isFirstLaunch == false) {
      Future.microtask(() {
        context.go('/');
      });
      notifyListeners();
    }
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
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = "Identifiants incorrects";
      }
    } catch (e) {
      print("Erreur lors de l'authentification: $e");
      _errorMessage = "Impossible de se connecter. Vérifiez votre connexion.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return false;
  }

  Future<void> logout() async {
    await SharedPrefs.removeToken();
    _token = null;
    _currentUser = null;
    notifyListeners();
  }
}
