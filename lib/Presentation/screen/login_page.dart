import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/presentation/widget/custom_formfield.dart';
import 'package:provider/provider.dart';
import '../../view_model/authentication.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final authViewModel = Provider.of<AuthViewService>(context, listen: false);
    authViewModel.checkAppStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LoginForm(
              usernameController: _usernameController,
              passwordController: _passwordController,
              onSubmit: () async {
                final success = await authViewModel.authenticate(
                  _usernameController.text.trim(),
                  _passwordController.text.trim(),
                );
                print("==============success============");
                print(success);
                if (success) {
                  context.go("/home");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text(authViewModel.errorMessage ?? "Login failed"),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            authViewModel.isLoading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}


/// provider for count 
/// 
/// 
/// 
/// 
