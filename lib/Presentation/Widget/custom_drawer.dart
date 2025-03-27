import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:newtest/view_model/auth_view_model.dart';

import 'package:newtest/view_model/language_view_model.dart';

import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Consumer<AuthViewModel>(
            builder: (context, authViewModel, child) {
              return _buildUserHeader(authViewModel);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Settings page coming soon!")),
              );
            },
          ),
          Consumer<LanguageViewModel>(
            builder: (context, themChange, child) {
              return ListTile(
                leading: const Icon(Icons.brightness_6),
                title: Text(AppLocalizations.of(context)!.changeTheme),
                onTap: () {
                  themChange.toggleTheme();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Theme change coming soon!")),
                  );
                },
              );
            },
          ),
          Consumer<LanguageViewModel>(
            builder: (context, languageViewModel, child) {
              return ListTile(
                leading: const Icon(Icons.language),
                title: Text(AppLocalizations.of(context)!.chooseLanguage),
                onTap: () {
                  _showLanguageDialog(context, languageViewModel);
                },
              );
            },
          ),
          const Divider(),
          Consumer<AuthViewModel>(
            builder: (context, authViewModel, child) {
              return ListTile(
                leading: const Icon(Icons.logout),
                title: Text(AppLocalizations.of(context)!.logout),
                onTap: () async {
                  await authViewModel.logout();
                  if (context.mounted) {
                    context.go('/');
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 User Header with Profile Info
  Widget _buildUserHeader(AuthViewModel authViewModel) {
    final user = authViewModel.currentAuth;
    return UserAccountsDrawerHeader(
      accountName: Text(user != null ? "User: ${user.username}" : "Guest"),
      accountEmail:
          Text(user != null ? "Email: ${user.email}" : "No email available"),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 40, color: Colors.blue),
      ),
    );
  }

  /// 🔹 Show Language Change Dialog
  void _showLanguageDialog(
      BuildContext context, LanguageViewModel languageViewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.chooseLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () {
                languageViewModel.setLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("العربية"),
              onTap: () {
                languageViewModel.setLocale(const Locale('ar'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
