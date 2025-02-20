import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../model/user_model.dart';
import '../../view_model/view_model.dart';

class UserDialog {
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
              context.go("/update-user", extra: user);
            },
            child: Text(
              S.of(context).update,
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<UserViewModel>().deleteUser(context, user.id!);
              Navigator.of(context).pop();
            },
            child: Text(
              S.of(context).delete,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(S.of(context).cancel),
          ),
        ],
      ),
    );
  }
}
