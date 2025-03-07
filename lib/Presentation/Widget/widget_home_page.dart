import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/helper/localizationhelper.dart';
import 'package:newtest/model/auth.dart';

import 'package:provider/provider.dart';

import '../../model/user_model.dart';

import '../../view_model/Userviewmodel.dart';

class UserDialog {
  UserModel? userModel;
  static void show(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(LocalizationsHelper.msgs.userManagement),
        content: Text(
          LocalizationsHelper.msgs.updateOrDelete,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.go("/updateuser_page", extra: user);
            },
            child: Text(
              LocalizationsHelper.msgs.update,
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
              LocalizationsHelper.msgs.delete,
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/');
            },
            child: Text(LocalizationsHelper.msgs.cancel),
          ),
        ],
      ),
    );
  }
}
