import 'package:flutter/material.dart';
import 'package:flutterapp/Provider/TaskProvider.dart';
import 'package:flutterapp/SetState/TaskSetState.dart';
 import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemListProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Simple SetState'),
    ),
    body: Center(
      child: Column(
         children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskListScreen()),
              );            },
            child: Text('Press For SetState'),
          ),
          SizedBox(height: 16),

          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>
                    ProviderAssignment()
                   ),
              );
            },
            child: Text('Press For Provider'),
          ),
        ],
      ),
    ),
  );
}


}
