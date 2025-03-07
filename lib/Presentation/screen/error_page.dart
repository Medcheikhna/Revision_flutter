import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newtest/helper/localizationhelper.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocalizationsHelper.msgs.error,
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 100,
            ),
            const SizedBox(height: 20),
            Text(
              LocalizationsHelper.msgs.something_wrong,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home page
                context.go('/');
              },
              child: Text(
                LocalizationsHelper.msgs.goBack,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
