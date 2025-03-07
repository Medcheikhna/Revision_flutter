import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newtest/helper/localizationhelper.dart';

import 'package:provider/provider.dart';

import '../../view_model/languagesservices.dart';

class Languages extends StatelessWidget {
  const Languages({super.key});
  @override
  Widget build(BuildContext context) {
    final languageService = Provider.of<LanguageService>(context);

    return Scaffold(
      appBar: AppBar(title: Text(LocalizationsHelper.msgs.chooseLanguage)),
      body: Center(
        child: Column(
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
              onPressed: () {
                languageService.setLocale(Locale('ar'));
                context.go('/');
              },
              child: Text('العربية'),
            ),
          ],
        ),
      ),
    );
  }
}
