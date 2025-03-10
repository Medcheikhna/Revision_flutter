import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/helper/localizationhelper.dart';

import 'package:newtest/model/auth.dart';
import 'package:newtest/view_model/authentication.dart';
import 'package:newtest/view_model/languagesservices.dart';

import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final UserModel userModel;

  const CustomDrawer({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthViewService>(context, listen: false);
    final languageService =
        Provider.of<LanguageService>(context, listen: false);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildUserHeader(userModel),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(LocalizationsHelper.msgs.settings),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Settings page coming soon!")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: Text(LocalizationsHelper.msgs.changeTheme),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Theme change coming soon!")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(LocalizationsHelper.msgs.chooseLanguage),
            onTap: () {
              _showLanguageDialog(context, languageService);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(LocalizationsHelper.msgs.logout),
            onTap: () async {
              await authService.logout();
              context.go('/');
            },
          ),
        ],
      ),
    );
  }

  /// 🔹 User Header with Profile Info
  Widget _buildUserHeader(UserModel userModel) {
    return UserAccountsDrawerHeader(
      accountName: Text("User: ${userModel.username}"),
      accountEmail: Text("Email: ${userModel.email}"),
      currentAccountPicture: const CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person, size: 40, color: Colors.blue),
      ),
    );
  }

  /// 🔹 Show Language Change Dialog
  void _showLanguageDialog(
      BuildContext context, LanguageService languageService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocalizationsHelper.msgs.chooseLanguage),
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
