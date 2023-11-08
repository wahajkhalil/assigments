import 'dart:io';

import 'package:flutter/material.dart';
 import 'package:flutterapp/Provider/ProviderCart.dart';
import 'package:flutterapp/Screens/MenuPage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartProvider()),
        // Add other providers as needed
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return

           MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(

            colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
            useMaterial3: false,
          ),
          home: HomePage( ),
        )

     ;
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
      body: Stack(
        fit: StackFit.expand, // Makes the Stack take the full screen space
        children: [
          // Image that fits the screen
          Image.asset(
            'assets/images/images.png', // Replace with your image path
            fit: BoxFit.scaleDown ,
          ),
          // Overlapping button at the bottom
          Positioned(
            left: 15,
            right: 15,
            bottom: 15,
            child: Container(
               child:
                 ElevatedButton(
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
              ),
           ],

      ),
    );
  }
}

