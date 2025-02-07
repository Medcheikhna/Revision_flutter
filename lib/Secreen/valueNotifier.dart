import 'package:flutter/material.dart';

// class Counter {
//   ValueNotifier<int> count = ValueNotifier<int>(0);

//   void increment() {
//     count.value++;
//   }
// }

// ignore: must_be_immutable
class CounterWidget extends StatelessWidget {
  ValueNotifier<int> count = ValueNotifier<int>(0);

  CounterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: ValueListenableBuilder<int>(
          valueListenable: count,
          builder: (context, value, child) {
            return Text(
              '$value',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => count.value++,
        child: Icon(Icons.add),
      ),
    );
  }
}
