import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:newtest/hive/ApiFetcherGeneric.dart';
import 'package:newtest/hive/user_model.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final Fetcher fetcher = Fetcher();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> addUser(User user) async {
    try {
      // Show loading indicator
      EasyLoading.show(status: 'Adding user...');

      // Simulate a network call
      final response = await fetcher.post(user.toJson());

      // Check if the response is not null
      if (response != null) {
        // Hide loading indicator
        EasyLoading.dismiss(animation: true);

        // Show success message
        EasyLoading.showSuccess('User added successfully!');

        // Notify the home page about the new user
        final newUser = User.fromJson(response);
        // Navigate back to the home page
        final userBox = Hive.box<User>('users');
        userBox.add(newUser);
        print("================================================");
        print(newUser);
        print("================================================");
        context.go('/');
      } else {
        // Hide loading indicator
        EasyLoading.dismiss();

        // Show error message if the response is null
        EasyLoading.showError('Failed to add user: No response from server');
      }
    } catch (e) {
      // Hide loading indicator
      EasyLoading.dismiss();

      // Show error message
      EasyLoading.showError('Error adding user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/'); // Navigate back to the home page on back button press
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Add User')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Password Field
                TextFormField(
                  controller: _userNameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    if (value.length < 2) {
                      return 'this username must be at least';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Confirm Password Field
                TextFormField(
                  controller: _phoneController,
                  decoration:
                      const InputDecoration(labelText: 'your phone number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your Phone Number';
                    }
                    if (value.length < 8) {
                      return 'Number phone cannot be less than 8 numbers';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Add User Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newUser = User(
                        username: _nameController.text,
                        email: _emailController.text,
                        name: _nameController.text,
                        phone: _phoneController.text,
                        // address: null, // Let the server handle address input,
                        // role: null, // Let the server determine user role,
                        // status: null, // Let the server determine user status,

                        // id: null, // Let the server generate the ID
                      );

                      addUser(newUser).then((_) {
                        context.go('/'); // Navigate back to home
                      });
                    }
                  },
                  child: const Text('Add User'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
