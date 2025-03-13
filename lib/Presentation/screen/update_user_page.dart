import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/user_view_model.dart';
import '../widget/widget_update_page.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController phoneController;
  late TextEditingController emailController;
  late TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserViewModel>().selectedUser!;
    phoneController = TextEditingController(text: user.phone);
    emailController = TextEditingController(text: user.email);
    nameController = TextEditingController(text: user.username);
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
    final user = userViewModel.selectedUser!;

    return WillPopScope(
      onWillPop: () async {
        context.go('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.update)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomFormWidget(
            formKey: _formKey,
            phoneController: phoneController,
            emailController: emailController,
            nameController: nameController,
            onSubmit: () async {
              if (_formKey.currentState!.validate()) {
                final updatedUser = User(
                  id: user.id,
                  username: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
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
          ),
        ),
      ),
    );
  }
}
