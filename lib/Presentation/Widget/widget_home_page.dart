import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../model/user_model.dart';
import '../../view_model/view_model.dart';

class UserDialog {
  static void show(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Manage User'),
        content: const Text('Update or Delete'),
        actions: [
          TextButton(
            onPressed: () {
              context.go("/update-user", extra: user);
            },
            child: const Text('Update'),
          ),
          TextButton(
            onPressed: () {
              context.read<UserViewModel>().deleteUser(user.id as int);
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
