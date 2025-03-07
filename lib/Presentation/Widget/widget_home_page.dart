import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/helper/localizationhelper.dart';

import 'package:provider/provider.dart';

import '../../model/user_model.dart';

import '../../view_model/Userviewmodel.dart';

class UserDialog {
  static void show(BuildContext context, User user) {
    final userViewModel = context.read<UserViewModel>();
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
              userViewModel.setSelectedUser(user);
              context.go("/updateuser");
            },
            child: Text(
              LocalizationsHelper.msgs.update,
            ),
          ),
          TextButton(
            onPressed: () {
              userViewModel.deleteUser(context, user.id!);
              print("================");
              context.go('/home');
              print("================");
            },
            child: Text(
              LocalizationsHelper.msgs.delete,
            ),
          ),
          TextButton(
            onPressed: () {
              context.go('/home');
            },
            child: Text(LocalizationsHelper.msgs.cancel),
          ),
        ],
      ),
    );
  }
}
