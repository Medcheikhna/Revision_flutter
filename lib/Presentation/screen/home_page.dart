import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_model/user_view_model.dart';
import '../widget/custom_drawer.dart';
import '../widget/widget_home_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = context.watch<UserViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.userManagement,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 4,
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: userViewModel.users.isEmpty && userViewModel.isLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              )
            : ListView.builder(
                controller: userViewModel.scrollController,
                itemCount: userViewModel.users.length +
                    (userViewModel.isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < userViewModel.users.length) {
                    final user = userViewModel.users[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        leading: CircleAvatar(
                          child: Text(user.username![0].toUpperCase(),
                              style: const TextStyle(color: Colors.white)),
                        ),
                        title: Text(
                          "${AppLocalizations.of(context)!.name} ${user.username}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        subtitle: Text(
                          "${AppLocalizations.of(context)!.email} ${user.email}",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward,
                          size: 18,
                        ),
                        onTap: () => UserDialog.show(context, user),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CircularProgressIndicator(color: Colors.orange),
                      ),
                    );
                  }
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add_user'),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
