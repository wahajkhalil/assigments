import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterapp/MenuPage.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: false,
      ),
      home: HomePage( ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pizza hut Home Page',

          style: TextStyle(
          fontSize: 25,
          fontFamily: "mainfontBold",
          color: Colors.white,
        ),

        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.brown, // Set the background color to red
        ) ,

         child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
         Container(
             height: 600, // Set the height of the container
             child:Image.asset('assets/images/homepageicon.jpg')

            ),

            SizedBox(height: 20),

        Container(
          width: 200, // Set the desired width

          child: ElevatedButton(
            onPressed: () {

              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MenuPage()));
              // Add the action you want the button to perform
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(16.0),
              ),
            ),
            child: Text(
              'Go To Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: "mainfontBold",
              ),
            ),
          ),
        ),

          ],
        ),
      ),
    );
  }
}
