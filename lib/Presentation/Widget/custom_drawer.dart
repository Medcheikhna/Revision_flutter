import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/app_routes.dart';
import 'package:newtest/model/auth.dart';
import 'package:newtest/view_model/auth_view_model.dart';
import 'package:newtest/view_model/language_view_model.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();
    final languageViewModel = context.read<LanguageViewModel>();
    final themeNotifier = context.watch<LanguageViewModel>(); 
    final localizations = AppLocalizations.of(context)!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildUserHeader(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(localizations.settings),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Settings page coming soon!")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(localizations.changeTheme),
            onTap: () async {
              await themeNotifier.toggleTheme();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Theme change coming soon!")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(localizations.chooseLanguage),
            onTap: () {
              _showLanguageDialog(context, languageViewModel);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(localizations.logout),
            onTap: () async {
              await authViewModel.logout();
              if (context.mounted) context.go(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    final auth = Auth();
    return UserAccountsDrawerHeader(
      accountName: Text(auth.username.isNotEmpty ? "User: ${auth.username}" : "Guest"),
      accountEmail: Text(auth.email.isNotEmpty ? "Email: ${auth.email}" : "No email available"),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 40, color: Colors.blue),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context, LanguageViewModel languageViewModel) {
    final localizations = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(localizations.chooseLanguage),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text("English"),
              onTap: () async {
                await languageViewModel.setLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text("العربية"),
              onTap: () async {
                await languageViewModel.setLocale(const Locale('ar'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
