import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  Stream<int> countStream() {
    // Simulating a stream of integer values

    return Stream.periodic(Duration(seconds: 1), (count) => count);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: countStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Text('Count: ${snapshot.data}');
        }
      },
    );
  }
}
