import 'package:flutter/material.dart';
import 'navigation_helper.dart';
import 'package:/flutter_gen/gen_l10n/app_localizations.dart';

class LocalizationsHelper {
  static AppLocalizations get msgs {
    final context = appNavigatorKey.currentContext;
    if (context == null) {
      throw Exception(
          "AppNavigator context is null — localization not available!");
    }
    return AppLocalizations.of(context)!;
  }

  static List<Locale> get locales => AppLocalizations.supportedLocales;
}
