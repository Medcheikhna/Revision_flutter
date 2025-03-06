import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newtest/model/user_model.dart';
import 'package:provider/provider.dart';

import 'package:/flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_model/userviewmodel.dart';
import '../widget/widget_update_page.dart';

class UpdatePage extends StatefulWidget {
  final User user;

  const UpdatePage({super.key, required this.user});

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
    phoneController = TextEditingController(text: widget.user.phone);
    emailController = TextEditingController(text: widget.user.email);
    nameController = TextEditingController(text: widget.user.name);
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();

    return WillPopScope(
      onWillPop: () async {
        context.go('/home'); // Navigate back on back press
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
            onSubmit: () {
              if (_formKey.currentState!.validate()) {
                final updatedUser = User(
                  id: widget.user.id,
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
