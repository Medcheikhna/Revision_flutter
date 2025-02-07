import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  void increment() {
    _count++;
    notifyListeners(); // Notify listeners manually
  }
}

class Mychange_Notifier extends StatelessWidget {
  final CounterModel counterModel = CounterModel();

  Mychange_Notifier({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("ChangeNotifier Example")),
        body: Center(
          child: ListenableBuilder(
            listenable: counterModel,
            builder: (context, child) {
              return Text("Counter: ${counterModel.count}");
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => counterModel.increment(), // Update the state
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}



