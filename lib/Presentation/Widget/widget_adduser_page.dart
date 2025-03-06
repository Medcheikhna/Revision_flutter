import 'package:flutter/material.dart';
import 'package:/flutter_gen/gen_l10n/app_localizations.dart';

class CustomFormWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController phoneController;
  final VoidCallback onSubmit;

  const CustomFormWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.usernameController,
    required this.phoneController,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          // Name Field
          TextFormField(
            controller: nameController,
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
            controller: emailController,
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
            controller: usernameController,
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
            controller: phoneController,
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
            onPressed: onSubmit,
            child: Text(AppLocalizations.of(context)!.addUser),
          ),
        ],
      ),
    );
  }
}
