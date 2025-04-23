import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/app_routes.dart';
import 'package:newtest/presentation/widget/language_button.dart';

import 'package:provider/provider.dart';

import '../../view_model/language_view_model.dart';

class Languages extends StatelessWidget {
  const Languages({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.chooseLanguage),
        centerTitle: true,
        elevation: 2,
      ),
      body: Center(
        child: Consumer<LanguageViewModel>(
          builder: (context, languageService, child) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.language, size: 80, color: theme.primaryColor),
                  const SizedBox(height: 24),
                  Text(
                    localizations.chooseLanguage,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  LanguageButton(
                    text: 'English',
                    icon: Icons.language,
                    onTap: () async {
                      await languageService.setLocale(const Locale('en'));
                      context.go(AppRoutes.login);
                    },
                  ),
                  const SizedBox(height: 16),
                  LanguageButton(
                    text: 'العربية',
                    icon: Icons.language,
                    onTap: () async {
                      await languageService.setLocale(const Locale('ar'));
                      context.go(AppRoutes.login);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
