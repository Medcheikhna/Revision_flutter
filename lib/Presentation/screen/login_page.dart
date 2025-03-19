import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/presentation/widget/custom_login.dart';

import 'package:newtest/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    checkAppStatus();
  }

  void checkAppStatus() async {
    final authViewModel = context.read<AuthViewModel>();
    bool isFirstLaunch = await authViewModel.checkAppStatus();
    if (isFirstLaunch) {
      context.go('/languages');
    } else {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LoginForm(),
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
