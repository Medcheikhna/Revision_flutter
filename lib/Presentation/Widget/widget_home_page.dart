import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/model/auth.dart';
import 'package:/flutter_gen/gen_l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import '../../model/user_model.dart';

import '../../view_model/Userviewmodel.dart';

class UserDialog {
  UserModel? userModel;
  static void show(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.userManagement),
        content: Text(
          AppLocalizations.of(context)!.updateOrDelete,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go("/updateuser_page", extra: user);
            },
            child: Text(
              AppLocalizations.of(context)!.update,
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<UserViewModel>().deleteUser(context, user.id!);
              print("================");
              context.go('/home_page');
              print("================");
            },
            child: Text(
              AppLocalizations.of(context)!.delete,
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
        ],
      ),
    );
  }
}
