import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:newtest/helper/localizationhelper.dart';

import 'package:newtest/presentation/widget/widget_adduser_page.dart';

import 'package:newtest/model/user_model.dart';

import 'package:provider/provider.dart';

import '../../view_model/Userviewmodel.dart';

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
    final userViewModel =
        context.watch<UserViewModel>(); 

    return WillPopScope(
      onWillPop: () async {
        context.go('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(LocalizationsHelper.msgs.addUser)),
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
