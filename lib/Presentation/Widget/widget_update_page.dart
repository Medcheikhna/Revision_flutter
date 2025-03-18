import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/model/user_model.dart';
import 'package:newtest/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class CustomFormWidget extends StatelessWidget {
  const CustomFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.read<UserViewModel>();

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
                      AppLocalizations.of(context)!.userUpdateSuccess);
                  context.go('/home');
                } else {
                  EasyLoading.showError(
                      AppLocalizations.of(context)!.failedUpdateUser);
                }
              }
            },
            child: Text(AppLocalizations.of(context)!.update),
          ),
        ],
      ),
    );
  }
}
