import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import '../../view_model/language_view_model.dart';

class Languages extends StatelessWidget {
  const Languages({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.chooseLanguage)),
      body: Center(
        child: Consumer<LanguageViewModel>(
            builder: (context, languageService, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await languageService.setLocale(Locale('en'));
                  context.go('/');
                },
                child: Text('English'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await languageService.setLocale(Locale('ar'));
                  context.go('/');
                },
                child: Text('العربية'),
              ),
            ],
          );
        }),
      ),
    );
  }
}
