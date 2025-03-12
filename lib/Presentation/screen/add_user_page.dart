import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/presentation/widget/widget_add_page.dart';

import 'package:newtest/model/user_model.dart';

import 'package:newtest/view_model/user_view_model.dart';

import 'package:provider/provider.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        context.go('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.addUser)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomFormWidget(
            formKey: _formKey,
            nameController: _nameController,
            emailController: _emailController,
            usernameController: _usernameController,
            phoneController: _phoneController,
            onSubmit: () {
              if (_formKey.currentState!.validate()) {
                final newUser = User(
                  username: _usernameController.text,
                  email: _emailController.text,
                  name: _nameController.text,
                  phone: _phoneController.text,
                );

                // Use UserViewModel to add user
                userViewModel.addUser(context, newUser).then((_) {
                  context.go('/home');
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
