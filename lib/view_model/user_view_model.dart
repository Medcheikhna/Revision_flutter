import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:hive_flutter/hive_flutter.dart';

import '../../model/user_model.dart';
import '../services/fetcher.dart';

class UserViewModel extends ChangeNotifier {
  final Fetcher fetcher = Fetcher();
  final ScrollController scrollController = ScrollController();

  List<User> users = [];
  bool isLoading = false;
  String? successMessage;
  String? errorMessage;
  User? _selectedUser;
  User? get selectedUser => _selectedUser;
  UserViewModel() {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    try {
      // Fetch users from the backend
      final data = await fetcher.get();
      print('Fetched users from API: $data');

      final userBox = Hive.box<User>('users');

      if (data.isNotEmpty) {
        for (var user in data) {
          await userBox.put(user.id, user);
        }

        users = userBox.values.toList();

        // Notify listeners to update the UI
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
      // Perform API call to add user
      final newUser = await fetcher.post(user);

      final userBox = Hive.box<User>('users');
      print("hello in function ================================");
      // Ensure the user has a valid ID before adding
      if (newUser.id != null) {
        userBox.put(newUser.id, newUser); // Store the user using ID as key
      } else {
        userBox.add(newUser); // If no ID, add normally (not recommended)
      }

      users = userBox.values.toList(); // Refresh local list
      successMessage = "User added successfully";
      print(successMessage); // Localized message
      notifyListeners();
      return true; // Indicate success
    } catch (e) {
      errorMessage = "Error adding user: $e"; // Localized error message
      print(errorMessage);
      notifyListeners();
      return false; // Indicate error
    } finally {
      isLoading = false;
      notifyListeners(); // Update loading state
    }
  }

  //=============================update user ==============================

  void setSelectedUser(User user) {
    _selectedUser = user;
    notifyListeners();
  }

  Future<bool> updateUser(User updatedUser) async {
    try {
      EasyLoading.show(status: 'Updating...');

      final response = await fetcher.put(updatedUser.id!, updatedUser);
      if (response != null) {
        final userBox = Hive.box<User>('users');

        // Check if the user exists in Hive using user.id as the key
        final existingUser = userBox.get(updatedUser.id);
        if (existingUser != null) {
          // User found, update the user in Hive and memory
          await userBox.put(updatedUser.id, updatedUser); // Update Hive data
          final index = users.indexWhere((user) => user.id == updatedUser.id);
          if (index != -1) {
            users[index] = updatedUser; // Update in-memory list
          }
          EasyLoading.dismiss();
          notifyListeners();
          return true; // Success
        } else {
          EasyLoading.dismiss();
          print("User not found in Hive!");
          return false; // Error - user not found
        }
      } else {
        EasyLoading.dismiss();
        return false; // Failed to update on server
      }
    } catch (e) {
      EasyLoading.dismiss();
      print("Error updating user: $e");
      return false; // Error
    }
  }
}
