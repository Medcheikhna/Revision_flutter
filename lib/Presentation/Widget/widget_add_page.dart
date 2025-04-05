// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/model/user_model.dart';

import 'package:newtest/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class WidgetAddPage extends StatelessWidget {
  const WidgetAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();

    return Form(
      key: userViewModel.formKey,
      child: Column(
        children: [
          // Name Field
          TextFormField(
            controller: userViewModel.nameController,
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
            controller: userViewModel.emailController,
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

          // Username Field
          TextFormField(
            controller: userViewModel.usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a username';
              }
              if (value.length < 2) {
                return 'This username must be at least 2 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Phone Number Field
          TextFormField(
            controller: userViewModel.phoneController,
            decoration: const InputDecoration(labelText: 'Your phone number'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              if (value.length < 8) {
                return 'Phone number must be at least 8 digits';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Add User Button
          ElevatedButton(
            onPressed: () async {
              if (userViewModel.formKey.currentState!.validate()) {
                final newUser = User(
                  username: userViewModel.usernameController.text,
                  email: userViewModel.emailController.text,
                  name: userViewModel.nameController.text,
                  phone: userViewModel.phoneController.text,
                );
                EasyLoading.show(status: AppLocalizations.of(context)!.adding);

                // Use UserViewModel to add user
                await userViewModel.addUser(newUser).then((_) {
                  // Handle success or error after the addUser operation
                  if (userViewModel.successMessage != null) {
                    EasyLoading.dismiss();
                    EasyLoading.showSuccess(
                        AppLocalizations.of(context)!.userAddedSuccessfully);
                    context.go('/home'); // Navigate after success
                  } else if (userViewModel.errorMessage != null) {
                    EasyLoading.dismiss();
                    EasyLoading.showError(
                        '${AppLocalizations.of(context)!.errorAddingUser} ${userViewModel.errorMessage!}');
                  }
                });
              }
            },
            child: Text(AppLocalizations.of(context)!.addUser),
          ),
        ],
      ),
    );
  }
}
