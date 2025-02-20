import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:newtest/Presentation/Widget/widjet_add_user.dart';

import 'package:newtest/model/user_model.dart';
import 'package:newtest/services/ApiFetcherGeneric.dart';
import 'package:provider/provider.dart';

import '../../generated/l10n.dart';
import '../../view_model/view_model.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final Fetcher fetcher = Fetcher();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
    return WillPopScope(
      onWillPop: () async {
        context.go('/');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(S.of(context).add_user)),
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

                userViewModel.addUser(context, newUser).then((_) {
                  context.go('/');
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
