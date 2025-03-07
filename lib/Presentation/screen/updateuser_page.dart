import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/helper/localizationhelper.dart';

import 'package:newtest/model/user_model.dart';
import 'package:provider/provider.dart';

import '../../view_model/userviewmodel.dart';
import '../widget/widget_update_page.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({
    super.key,
  });

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
    nameController = TextEditingController(text: user.name);
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
        appBar: AppBar(title: Text(LocalizationsHelper.msgs.update)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomFormWidget(
            formKey: _formKey,
            phoneController: phoneController,
            emailController: emailController,
            nameController: nameController,
            onSubmit: () {
              if (_formKey.currentState!.validate()) {
                final updatedUser = User(
                  id: user.id,
                  name: nameController.text,
                  email: emailController.text,
                  phone: phoneController.text,
                );

                userViewModel.updateUser(context, updatedUser);
              }
            },
          ),
        ),
      ),
    );
  }
}
