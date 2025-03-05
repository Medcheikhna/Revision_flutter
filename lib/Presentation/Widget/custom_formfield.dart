import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.onSubmit,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Assigning the GlobalKey to Form
      child: Column(
        children: [
          TextFormField(
            controller: widget.usernameController, 
            decoration: const InputDecoration(labelText: "Username"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              } else if (value.length < 3) {
                return 'Username must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: widget.passwordController,
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: false,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit();
              }
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
