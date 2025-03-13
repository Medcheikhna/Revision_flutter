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
    final authViewModel = context.watch<AuthViewModel>();
    final languageService =
        Provider.of<LanguageViewModel>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildUserHeader(authViewModel),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(AppLocalizations.of(context)!.settings),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Settings page coming soon!")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(AppLocalizations.of(context)!.changeTheme),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Theme change coming soon!")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(AppLocalizations.of(context)!.chooseLanguage),
            onTap: () {
              _showLanguageDialog(context, languageService);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(AppLocalizations.of(context)!.logout),
            onTap: () async {
              await authViewModel.logout();
              context.go('/');
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 User Header with Profile Info
  Widget _buildUserHeader(AuthViewModel authViewModel) {
    return UserAccountsDrawerHeader(
      accountName: Text("User: ${authViewModel.currentAuth!.username}"),
      accountEmail: Text("Email: ${authViewModel.currentAuth!.email}"),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 40, color: Colors.blue),
      ),
    );
  }

  /// 🔹 Show Language Change Dialog
  void _showLanguageDialog(
      BuildContext context, LanguageViewModel languageService) {
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
                languageService.setLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("العربية"),
              onTap: () {
                languageService.setLocale(const Locale('ar'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
