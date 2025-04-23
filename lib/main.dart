import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:newtest/presentation/screen/my_app.dart';

import 'package:newtest/view_model/auth_view_model.dart';
import 'package:newtest/view_model/user_view_model.dart';

import 'package:provider/provider.dart';
import 'package:newtest/model/user_model.dart';

import 'view_model/language_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('users');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => LanguageViewModel()),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}
