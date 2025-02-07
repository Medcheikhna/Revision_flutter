import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newtest/const/Url.dart';
import 'package:newtest/hive/Applocalization.dart';
import '../hive/ApiFetcherGeneric.dart';
import '../hive/user_model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Fetcher fetcher = Fetcher();
  final ScrollController scrollController = ScrollController();

  List<User> users = [];

  final int itemsPerPage = 8;
  bool isLoading = false;
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    fetchUsersFromHive();

    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasMoreData) {
        fetchUsers();
      }
    });
  }

  Future<void> fetchUsersFromHive() async {
    final userBox = Hive.box<User>('users');
    setState(() {
      users = userBox.values.toList(); // Get users from Hive
    });
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      final data = await fetcher.get(BaseApi);
      // print(data);
      final List<User> newUsers =
          List.from(data).map<User>((e) => User.fromJson(e)).toList();

      if (newUsers.isEmpty) {
        setState(() {
          hasMoreData = false; // No more data to fetch
        });
      } else {
        setState(() {
          users.addAll(newUsers); // Append new users to the existing list
        });
      }
    } catch (e) {
      print('Error fetching users: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteUser(var id) async {
    EasyLoading.show();
    try {
      await fetcher.delete('$BaseApi/$id/');
      setState(() {
        users.removeWhere((user) => user.id == id);
      });
      EasyLoading.dismiss();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  void showUserDialog(BuildContext context, User user) {
    final localizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations!.translate('manage_user')),
        content: Text(localizations.translate('update_or_delete')),
        actions: [
          TextButton(
            onPressed: () async {
              EasyLoading.show(status: localizations.translate('updating'));
              await Future.delayed(
                  const Duration(seconds: 2)); // Simulating update
              EasyLoading.dismiss();

              context.go("/update-user", extra: user);
            },
            child: Text(localizations.translate('update')),
          ),
          TextButton(
            onPressed: () async {
              EasyLoading.show(status: localizations.translate('deleting'));
              await deleteUser(user.id);
              EasyLoading.dismiss();
              Navigator.of(context).pop();
            },
            child: Text(localizations.translate('delete')),
          ),
          TextButton(
            onPressed: () {
              EasyLoading.showInfo(
                  localizations.translate('operation_canceled'));
              Navigator.of(context).pop();
            },
            child: Text(localizations.translate('cancel')),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final updatedUser = GoRouterState.of(context).extra as User?;

    if (updatedUser != null) {
      final index = users.indexWhere((user) => user.id == updatedUser.id);
      if (index != -1) {
        setState(() {
          users[index] = updatedUser;
        });
      }
    }
    final screenWidth = MediaQuery.of(context).size.width;

    final bool isSmallScreen = screenWidth < 600;
    final int crossAxisCount = isSmallScreen ? 1 : (screenWidth ~/ 200);

    return Scaffold(
      appBar: AppBar(title: const Text('User Management')),
      body: users.isEmpty && isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            )
          : LayoutBuilder(
              builder: (context, constraints) {
                if (isSmallScreen) {
                  // Use ListView for smaller screens
                  return ListView.builder(
                    controller: scrollController,
                    itemCount: users.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < users.length) {
                        final user = users[index];
                        return ListTile(
                          title: Text("Name: ${user.username}"),
                          subtitle: Text("${user.email}"),
                          onTap: () => showUserDialog(context, user),
                        );
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          ),
                        );
                      }
                    },
                  );
                } else {
                  // Use GridView for larger screens
                  return GridView.builder(
                    controller: scrollController,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 2,
                    ),
                    itemCount: users.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index < users.length) {
                        final user = users[index];
                        return Card(
                          margin: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () => showUserDialog(context, user),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text("Name:${user.name}",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text("Email:${user.email}")),
                                ],
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.amber,
                            ),
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/second', extra: users);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
