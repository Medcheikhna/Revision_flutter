import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../services/languages_services.dart';

class Languages extends StatelessWidget {
  const Languages({super.key});

  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.of(context).choose_language,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButton<Locale>(
            value: languageService.locale,
            items: [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
                onTap: () {
                  context.go('/homepage');
                  print("English: ");
                },
              ),
              DropdownMenuItem(
                value: Locale('fr'),
                child: Text('Français'),
                onTap: () {
                  context.go('/homepage');
                },
              ),
              DropdownMenuItem(
                value: Locale('ar'),
                child: Text('العربية'),
                onTap: () {
                  context.go('/homepage');
                },
              ),
            ],
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                languageService.setLocale(newLocale); // Updates UI instantly
              }
            },
          ),
        ],
      ),
    );
  }
}
