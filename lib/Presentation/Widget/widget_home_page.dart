import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/view_model/user_view_model.dart';

import 'package:provider/provider.dart';

import '../../model/user_model.dart';



class UserDialog {
  static void show(BuildContext context, User user) {
    print("==========ShowDialogue Page =====");

    showDialog(
      context: context,
      builder: (context) {
        final userViewModel =
            Provider.of<UserViewModel>(context, listen: false);
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.userManagement),
          content: Text(AppLocalizations.of(context)!.updateOrDelete),
          actions: [
            TextButton(
              onPressed: () {
                userViewModel.setSelectedUser(user);
                context.go("/update_user");
              },
              child: Text(AppLocalizations.of(context)!.update),
            ),
            TextButton(
              onPressed: () {
                userViewModel.deleteUser(context, user.id!);
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.delete),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.cancel),
            ),
          ],
        );
      },
    );
  }
}
