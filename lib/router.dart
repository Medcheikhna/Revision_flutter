import 'package:newtest/app_routes.dart';
import 'package:newtest/presentation/screen/add_user_page.dart';
import 'package:newtest/presentation/screen/error_page.dart';
import 'package:newtest/presentation/screen/home_page.dart';
import 'package:newtest/presentation/screen/languages_page.dart';
import 'package:newtest/presentation/screen/login_page.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/presentation/screen/update_user_page.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginPage()),
    GoRoute(path: AppRoutes.languages, builder: (_, __) => const Languages()),
    GoRoute(path: AppRoutes.home, builder: (_, __) => const MyHomePage()),
    GoRoute(path: AppRoutes.addUser, builder: (_, __) => const AddUserPage()),
    GoRoute(path: AppRoutes.updateUser, builder: (_, __) => const UpdatePage()),
  ],
  errorBuilder: (_, state) => const ErrorPage(),
);
