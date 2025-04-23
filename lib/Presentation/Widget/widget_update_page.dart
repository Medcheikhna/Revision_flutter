import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/app_routes.dart';
import 'package:newtest/model/user_model.dart';
import 'package:newtest/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class WidgetUpdatePage extends StatelessWidget {
  const WidgetUpdatePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();
    final localizations = AppLocalizations.of(context)!;
    return Form(
      key: userViewModel.formKey,
      child: ListView(
        children: [
          TextFormField(
            controller: userViewModel.phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
            validator: (value) => value!.isEmpty ? 'Phone is required' : null,
          ),
          TextFormField(
            controller: userViewModel.emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) => value!.isEmpty ? 'Email is required' : null,
          ),
          TextFormField(
            controller: userViewModel.nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) => value!.isEmpty ? 'Name is required' : null,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              if (userViewModel.formKey.currentState!.validate()) {
                final updatedUser = User(
                  id: userViewModel.selectedUser!.id,
                  username: userViewModel.nameController.text,
                  email: userViewModel.emailController.text,
                  phone: userViewModel.phoneController.text,
                );

                bool success = await userViewModel.updateUser(updatedUser);

                if (success) {
                  EasyLoading.showSuccess(
                      localizations.userUpdateSuccess);
                  context.go(AppRoutes.home);
                } else {
                  EasyLoading.showError(
                     localizations.failedUpdateUser);
                }
              }
            },
            child: Text(localizations.update),
          ),
        ],
      ),
    );
  }
}
