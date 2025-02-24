import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'Presentation/Secreen/add_user.dart';
import 'Presentation/Secreen/error_page.dart';
import 'Presentation/Secreen/languages.dart';
import 'Presentation/Secreen/my_home_page.dart';
import 'Presentation/Secreen/update_user_page.dart';
import 'generated/l10n.dart';
import 'model/user_model.dart';
import 'services/languages_services.dart';
import 'view_model/view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');

  /// Initialize LanguageService and load the locale
  LanguageService languageService = LanguageService();
  await languageService.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => LanguageService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => Languages(),
      ),
      GoRoute(
        path: '/homepage',
        builder: (context, state) => MyHomePage(),
      ),
      GoRoute(
        path: '/adduser',
        builder: (context, state) => AddUserPage(),
      ),
      GoRoute(
        path: '/update-user',
        builder: (context, state) {
          final user = state.extra as User;
          return UpdatePage(user: user);
        },
      ),
    ],
    errorBuilder: (context, state) {
      print("Error occurred: ${state.error}");
      return const ErrorPage();
    },
  );

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return MaterialApp.router(
          routerDelegate: _router.routerDelegate,
          routeInformationParser: _router.routeInformationParser,
          routeInformationProvider: _router.routeInformationProvider,
          title: "GoRouter App",
          theme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          locale: languageService.locale, // Dynamically updates locale
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
        );
      },
    );
  }
}
