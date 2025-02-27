import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/Presentation/Widget/customformfield.dart';
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
    WidgetsBinding.instance.addObserver(this);

    Future.microtask(() => Provider.of<AuthViewService>(context, listen: false)
        .checkAppStatus(context));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      Provider.of<AuthViewService>(context, listen: false).logout();
    }
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

                if (success) {
                  context.go("/homepage"); // Login success = homepage
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
