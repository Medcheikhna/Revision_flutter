import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/presentation/widget/custom_drawer.dart';
import 'package:/flutter_gen/gen_l10n/app_localizations.dart';

import 'package:newtest/view_model/authentication.dart';
import 'package:provider/provider.dart';

import '../../model/auth.dart';
import '../../view_model/userviewmodel.dart';
import '../widget/widget_home_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();
    final authService = context.watch<AuthViewService>();
    final currentUser = authService.currentUser ??
        UserModel(username: "Guest", email: "guest@example.com");
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.userManagement)),
      drawer: CustomDrawer(userModel: currentUser),
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
                    title: Text(AppLocalizations.of(context)!.name +
                        '${user.username}'),
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
          context.go('/adduser', extra: userViewModel.users);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
