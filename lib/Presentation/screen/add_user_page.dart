import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:newtest/presentation/widget/widget_add_page.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.addUser)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomFormWidget(),
        ),
      ),
    );
  }
}
