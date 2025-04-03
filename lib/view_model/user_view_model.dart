import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../model/user_model.dart';
import '../services/fetcher.dart';

class UserViewModel extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final fetcher = Fetcher();

  List<User> users = [];
  bool isLoading = false;
  String? successMessage;
  String? errorMessage;
  User? _selectedUser;
  String searchQuery = "";
  bool isSearching = false;
  User? get selectedUser => _selectedUser;
  UserViewModel() {
    fetchUsers();
    searchController.addListener(_onSearchChanged);
  }
  void _onSearchChanged() {
    searchQuery = searchController.text.toLowerCase();
    notifyListeners();
  }

  List<User> get filteredUsers {
    if (searchQuery.isEmpty) return users;
    return users
        .where((user) =>
            user.username!.toLowerCase().contains(searchQuery) ||
            user.email!.toLowerCase().contains(searchQuery))
        .toList();
  }
 
  Future<void> fetchUsers() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      final data = await fetcher.get();
      print('Fetched users from API: $data');

      final userBox = Hive.box<User>('users');

      if (data.isNotEmpty) {
        for (var user in data) {
          await userBox.put(user.id, user);
        }

        users = userBox.values.toList();

        notifyListeners();
      } else {
        print("No data received from backend");
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteUser(int id) async {
    try {
      bool success = await fetcher.delete(id);
      if (success) {
        users.removeWhere((user) => user.id == id);
        notifyListeners();
      }
      return success;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //==============adduserr=====================

  Future<bool> addUser(User user) async {
    isLoading = true;
    notifyListeners();

    try {
      final newUser = await fetcher.post(user);

      final userBox = Hive.box<User>('users');

      if (newUser.id != null) {
        userBox.put(newUser.id, newUser);
      }

      users = userBox.values.toList();

      successMessage = "User added successfully";
      print(successMessage);
      return true;
    } catch (e) {
      errorMessage = "Error adding user: $e";
      print(errorMessage);
      notifyListeners();
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //=============================update user ==============================

  void setSelectedUser(User user) {
    _selectedUser = user;
    phoneController = TextEditingController(text: _selectedUser!.phone);
    emailController = TextEditingController(text: _selectedUser!.email);
    nameController = TextEditingController(text: _selectedUser!.username);
    notifyListeners();
  }

  Future<bool> updateUser(User updatedUser) async {
    try {
      EasyLoading.show(status: 'Updating...');

      final response = await fetcher.put(updatedUser.id!, updatedUser);
      if (response != null) {
        final userBox = Hive.box<User>('users');

        final existingUser = userBox.get(updatedUser.id);
        if (existingUser != null) {
          await userBox.put(updatedUser.id, updatedUser);
          final index = users.indexWhere((user) => user.id == updatedUser.id);
          if (index != -1) {
            users[index] = updatedUser;
          }
          EasyLoading.dismiss();
          notifyListeners();
          return true;
        } else {
          EasyLoading.dismiss();
          print("User not found in Hive!");
          return false;
        }
      } else {
        EasyLoading.dismiss();
        return false;
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Error updating user: $e");
      return false;
    }
  }

  void toggleSearch() {
    isSearching = !isSearching;
    if (!isSearching) {
      searchController.clear();
      searchQuery = "";
    }
    notifyListeners();
  }
}
