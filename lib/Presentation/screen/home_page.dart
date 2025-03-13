import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:newtest/presentation/widget/custom_drawer.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_model/user_view_model.dart';
import '../widget/widget_home_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
   
    
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.userManagement)),
      drawer: CustomDrawer(),
      body: userViewModel.users.isEmpty && userViewModel.isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.amber))
          : ListView.builder(
              controller: userViewModel.scrollController,
              itemCount: userViewModel.users.length +
                  (userViewModel.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < userViewModel.users.length) {
                  final user = userViewModel.users[index];
                  return ListTile(
                    title: Text(
                        "${AppLocalizations.of(context)!.name}${user.username}"),
                    subtitle: Text(
                        "${AppLocalizations.of(context)!.email} ${user.email}"),
                    onTap: () => UserDialog.show(context, user),
                  );
                } else {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(color: Colors.amber),
                    ),
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add_user');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
