import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/model/auth.dart';

import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../model/user_model.dart';

import '../../view_model/view_model.dart';

class UserDialog {
  UserModel? userModel;
  static void show(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.of(context).user_management),
        content: Text(
          S.of(context).update_or_delete,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go("/updateuser_page", extra: user);
            },
            child: Text(
              S.of(context).update,
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<UserViewModel>().deleteUser(context, user.id!);
              context.go('/');
            },
            child: Text(
              S.of(context).delete,
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: Text(S.of(context).cancel),
          ),
        ],
      ),
    );
  }
}
