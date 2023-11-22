 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/Task/DatabaseExample.dart';
 import 'package:flutterapp/Task/DioExample.dart';
import 'package:flutterapp/Task/HttpExample.dart';
import 'package:flutterapp/Task/PreferenceScreen.dart';
 import 'package:flutterapp/Task/socket_manager.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void onPressedButton2() {
    // Action for Button 2
    print('Button 2 pressed');
  }

  void onPressedButton3() {
    // Action for Button 3
    print('Button 3 pressed');
  }

  void onPressedButton4() {
    // Action for Button 4
    print('Button 4 pressed');
  }

  void onPressedButton5() {
    // Action for Button 5
    print('Button 5 pressed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Button Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HttpExample()),
                );
              },
              child: Text('Http task 1 and Cashe 7 Task'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DioExampleScreen()),
                );
              },
              child: Text('Dio Task'
                  ' 2'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TaskListScreen
                    ()),
                );

              },
              child: Text('Database Assigmnet'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SocketScreen()),
                );
              },
               child: Text('SocketScreen 4'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PreferenceScreen()),
                );
              },
              child: Text('shared_preferences theme Task 5'),
            ),
          ],
        ),
      ),
    );
  }

}
