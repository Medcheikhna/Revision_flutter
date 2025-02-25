import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/generated/l10n.dart';
import 'package:provider/provider.dart';

import '../../view_model/languages_services.dart';

class Languages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).choose_language)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                languageService.setLocale(Locale('en'));
                GoRouter.of(context).go('/login');
              },
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                languageService.setLocale(Locale('ar'));
                GoRouter.of(context).go('/login'); // Redirect after selection
              },
              child: Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }
}
