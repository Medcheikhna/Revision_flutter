import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/widget_update_page.dart';

class UpdatePage extends StatelessWidget {
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.update)),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomFormWidget(),
        ),
      ),
    );
  }
}
