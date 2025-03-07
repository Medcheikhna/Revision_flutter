import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newtest/l10n/l10n.dart';
import 'package:newtest/presentation/screen/login_page.dart';
import 'package:provider/provider.dart';
import 'package:newtest/model/user_model.dart';
import 'helper/navigation_helper.dart';
import 'presentation/screen/adduser_page.dart';
import 'presentation/screen/error_page.dart';
import 'presentation/screen/languages_page.dart';
import 'presentation/screen/home_page.dart';
import 'presentation/screen/updateuser_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'view_model/authentication.dart';
import 'view_model/languagesservices.dart';
import 'view_model/userviewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');

  final languageService = LanguageService();
  await languageService.loadLocale();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => languageService),
        ChangeNotifierProvider(
          create: (context) => AuthViewService(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      navigatorKey: appNavigatorKey,
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/languages',
          builder: (context, state) => const Languages(),
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) => const MyHomePage(),
        ),
        GoRoute(
          path: '/adduser',
          builder: (context, state) => const AddUserPage(),
        ),
        GoRoute(
          path: '/updateuser',
          builder: (context, state) => const UpdatePage(),
        ),
      ],
      errorBuilder: (context, state) {
        print("Error occurred: ${state.error}");
        return const ErrorPage();
      },
    );

    return Consumer<LanguageService>(
      builder: (context, languageService, child) {
        return MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          title: "User Manage App",
          theme: ThemeData.light(),
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          locale: languageService.locale,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: L10n.all,
        );
      },
    );
  }
}
