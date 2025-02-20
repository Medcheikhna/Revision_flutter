import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:newtest/Presentation/Secreen/add_user.dart';
import 'package:newtest/Presentation/Secreen/my_home_page.dart';
import 'package:newtest/Presentation/Secreen/update_user_page.dart';

import 'Presentation/Secreen/error_page.dart';
import 'package:provider/provider.dart';

import 'services/Applocalization.dart';
import 'model/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'view_model/view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  // Open a box for the model
  await Hive.openBox<User>('users');

  runApp(AlertDialogApp());
}

class AlertDialogApp extends StatefulWidget {
  const AlertDialogApp({super.key});

  static _AlertDialogAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AlertDialogAppState>();
  @override
  State<AlertDialogApp> createState() => _AlertDialogAppState();
}

class _AlertDialogAppState extends State<AlertDialogApp> {
  Locale _locale = const Locale('en');

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  //final _appRouter = AppRouter();
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          builder: (context, state) {
            // final conter = state.extra as Counter;
            // print("object:===================$conter ");
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
      ],
      child: MaterialApp.router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
        title: "GoRouter App",
        theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        locale: _locale,
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
      ),
    );
  }
}
