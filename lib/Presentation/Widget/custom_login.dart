import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();
    return Form(
      key: authViewModel.formKey, 
      child: Column(
        children: [
          TextFormField(
            controller: authViewModel.usernameController,
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
            controller: authViewModel.passwordController,
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
            onPressed: () async {
              if (authViewModel.formKey.currentState!.validate()) {
                final success = await authViewModel.authenticate(
                  authViewModel.usernameController.text.trim(),
                  authViewModel.passwordController.text.trim(),
                );
                print("==============success============");
                print(success);
                if (success) {
                  authViewModel.usernameController.clear();
                  authViewModel.passwordController.clear();
                  context.go("/home");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text(authViewModel.errorMessage ?? "Login failed"),
                    ),
                  );
                }
              }
            },
            child: const Text("Login"),
          ),
        ],
      ),
    );
  }
}
