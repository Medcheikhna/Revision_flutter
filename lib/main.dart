import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newtest/presentation/screen/login_page.dart';
import 'package:provider/provider.dart';
import 'package:newtest/model/user_model.dart';
import 'package:newtest/generated/l10n.dart';

import 'presentation/screen/adduser_page.dart';
import 'presentation/screen/error_page.dart';
import 'presentation/screen/languages_page.dart';
import 'presentation/screen/home_page.dart';
import 'presentation/screen/updateuser_page.dart';

import 'view_model/authentication.dart';
import 'view_model/languages_services.dart';
import 'view_model/view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(
          create: (context) => LanguageService(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            final authService = AuthViewService();
            authService.checkAppStatus();
            return authService;
          },
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewService>(context);

    final GoRouter router = GoRouter(
      refreshListenable: authViewModel,
      initialLocation: '/',
      redirect: (context, state) {
        if (authViewModel.isFirstLaunch == null) {
          return null;
        } else if (authViewModel.isFirstLaunch == true) {
          return '/languages_page';
        } else {
          return null;
        }
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/languages_page',
          builder: (context, state) => const Languages(),
        ),
        GoRoute(
          path: '/home_page',
          builder: (context, state) => const MyHomePage(),
        ),
        GoRoute(
          path: '/adduser_page',
          builder: (context, state) => const AddUserPage(),
        ),
        GoRoute(
          path: '/updateuser_page',
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
