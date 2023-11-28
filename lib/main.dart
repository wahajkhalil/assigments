import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterapp/Task/DatabaseTask.dart';
import 'package:flutterapp/Task/PackageTask.dart';
import 'package:showbutton/showbutton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Asigment(),
    );
  }
}
class Asigment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double buttonWidth = 200.0; // Set the desired width for the buttons

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PackageTask()),
                  );
                },
                child: Text('Package task'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: buttonWidth,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                child: Text('Realtime realtime'),
              ),
            ),
            // Add more buttons as needed
          ],
        ),
      ),
    );
  }
}
