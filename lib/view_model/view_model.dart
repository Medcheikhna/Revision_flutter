import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../model/user_model.dart';
import '../../services/ApiFetcherGeneric.dart';

class UserViewModel extends ChangeNotifier {
  final Fetcher fetcher = Fetcher();
  final ScrollController scrollController = ScrollController();

  List<User> users = [];
  bool isLoading = false;
  bool hasMoreData = true;
  final int itemsPerPage = 8;

  UserViewModel() {
    fetchUsersFromHive();
    scrollController.addListener(_onScroll);
  }

  Future<void> fetchUsersFromHive() async {
    final userBox = Hive.box<User>('users');

    // Clear the cache before fetching new data
    await userBox.clear();

    users.clear(); // Also clear the in-memory list
    notifyListeners();

    // Fetch fresh data from the backend
    await fetchUsers();
  }

  Future<void> fetchUsers() async {
    if (isLoading) return;

    notifyListeners();

    try {
      final data = await fetcher.get();
      // print(data);

      if (data.isNotEmpty) {
        final userBox = Hive.box<User>('users');
        await userBox.clear();
        users.addAll(data);
        notifyListeners();
      } else {
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      bool success = await fetcher.delete(id);
      if (success) {
        users.removeWhere((user) => user.id == id);
        notifyListeners();
        EasyLoading.showSuccess('User deleted successfully!');
      } else {
        EasyLoading.showError('Failed to delete user.');
      }
    } catch (e) {
      EasyLoading.showError('Error deleting user: $e');
    }
  }

  void _onScroll() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        hasMoreData) {
      fetchUsers();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  //==============adduserr=====================

  Future<void> addUser(BuildContext context, User user) async {
    try {
      EasyLoading.show(status: 'Adding user...');

      final newUser = await fetcher.post(user);
      EasyLoading.dismiss();
      EasyLoading.showSuccess('User added successfully!');

      final userBox = Hive.box<User>('users');
      userBox.add(newUser);
      users.add(newUser);
      notifyListeners();

      context.go('/');
        } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error adding user: $e');
    }
  }

  //=============================update user ==============================

  Future<void> updateUser(BuildContext context, User updatedUser) async {
    try {
      EasyLoading.show(status: 'Updating user...');

      final response = await fetcher.put(updatedUser.id!, updatedUser);
      if (response != null) {
        final userBox = Hive.box<User>('users');

        // Find & update user in local storage
        final index = users.indexWhere((user) => user.id == updatedUser.id);
        if (index != -1) {
          users[index] = updatedUser;
          userBox.putAt(index, updatedUser);
          notifyListeners();
        }

        EasyLoading.dismiss();
        EasyLoading.showSuccess('User updated successfully!');
        context.go('/'); // Navigate back
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Failed to update user.');
      }
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Error updating user: $e');
    }
  }
}
