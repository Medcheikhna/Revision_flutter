import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/app_routes.dart';
import 'package:provider/provider.dart';

import '../../view_model/auth_view_model.dart';
import '../widget/custom_login.dart';
// if you defined route constants

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkAppStatus());
  }

  void checkAppStatus() async {
    final authViewModel = context.read<AuthViewModel>();
    final isFirstLaunch = await authViewModel.checkAppStatus();
    if (!mounted) return; // Always check if widget is still mounted

    context.go(
      isFirstLaunch ? AppRoutes.languages : AppRoutes.login,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.watch<AuthViewModel>().isLoading;

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const LoginForm(),
            const SizedBox(height: 20),
            if (isLoading) const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
