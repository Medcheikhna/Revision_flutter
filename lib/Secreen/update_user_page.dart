import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newtest/hive/ApiFetcherGeneric.dart';
import 'package:newtest/hive/user_model.dart';

class UpdatePage extends StatefulWidget {
  final User user; // Pass the current user to update

  const UpdatePage({super.key, required this.user});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final Fetcher fetcher = Fetcher();

  // Text controllers for the fields
  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController nameController;
  //late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(text: widget.user.phone);
    emailController = TextEditingController(text: widget.user.email);
    nameController = TextEditingController(text: widget.user.name);
  }

  Future<void> updateUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Prepare request data
        final data = {
          "telephone": phoneController.text,
          "email": emailController.text,
          "name": nameController.text,
        };

        // Send update request
        final response = await fetcher.put(
          'https://jsonplaceholder.typicode.com/users/${widget.user.id}',
          data,
        );

        // Check if the response is successful (status code 200)
        if (response != null) {
          final updatedUser = User(
            id: widget.user.id,
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
          );
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User updated successfully')),
          );

          // Navigate back to home page
          context.go('/', extra: updatedUser);
        } else {
          // Handle the case where the response is null or unsuccessful
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Failed to update user: No response data')),
          );
        }
      } catch (e) {
        // Handle any exceptions
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update user: $e')),
        );
      }
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
        appBar: AppBar(title: const Text('Update User')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: updateUser,
                  child: const Text('Update'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
