import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/app_routes.dart';
import 'package:newtest/view_model/user_view_model.dart';

import 'package:provider/provider.dart';

import '../../model/user_model.dart';

class WidgetHomePage {
  static void show(BuildContext context, User user) {
    showDialog(
      context: context,
      builder: (context) {
        final userViewModel = context.read<UserViewModel>();
        final localizations = AppLocalizations.of(context)!;
        return AlertDialog(
          title: Text(localizations.userManagement),
          content: Text(localizations.updateOrDelete),
          actions: [
            TextButton(
              onPressed: () {
                userViewModel.setSelectedUser(user);
                context.go(AppRoutes.updateUser);
              },
              child: Text(localizations.update),
            ),
            TextButton(
              onPressed: () async {
                EasyLoading.show(status: localizations.deleting);

                final success = await userViewModel.deleteUser(user.id!);
                print(success);
                EasyLoading.dismiss();

                if (success) {
                  EasyLoading.showSuccess(localizations.userDeletedSucceeded);
                } else {
                  EasyLoading.showError(localizations.failedDeleteUser);
                }

                Navigator.pop(context);
              },
              child: Text(localizations.delete),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(localizations.cancel),
            ),
          ],
        );
      },
    );
  }
}
