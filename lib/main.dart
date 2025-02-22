import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:newtest/Presentation/Secreen/add_user.dart';
import 'package:newtest/Presentation/Secreen/my_home_page.dart';
import 'package:newtest/Presentation/Secreen/update_user_page.dart';

import 'Presentation/Secreen/error_page.dart';
import 'package:provider/provider.dart';

import 'generated/l10n.dart';

import 'model/user_model.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'view_model/view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  // Open a box for the model
  await Hive.openBox<User>('users');

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            return MyHomePage();
          }),
      GoRoute(
        path: '/second',
        builder: (context, state) {
          return AddUserPage();
        },
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
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        title: "GoRouter App",
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        locale: Locale('en'),
        localizationsDelegates: <LocalizationsDelegate<Object>>[
          S.delegate,
          AppLocalizationDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
