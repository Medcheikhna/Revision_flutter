import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/view_model/user_view_model.dart';

import 'package:provider/provider.dart';

import '../../model/user_model.dart';

class WidgetHomePage {
  static void show(BuildContext context, User user) {
    print("==========ShowDialogue Page =====");

    showDialog(
      context: context,
      builder: (context) {
        final userViewModel = context.read<UserViewModel>();
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
              onPressed: () async {
                EasyLoading.show(
                    status: AppLocalizations.of(context)!.deleting);

                final success = await userViewModel.deleteUser(user.id!);
                print(success);
                EasyLoading.dismiss();

                if (success) {
                  EasyLoading.showSuccess(
                      AppLocalizations.of(context)!.userDeletedSucceeded);
                } else {
                  EasyLoading.showError(
                      AppLocalizations.of(context)!.failedDeleteUser);
                }

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
