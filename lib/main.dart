import 'dart:async';
import 'dart:io';

import 'package:css_colors/css_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterapp/Helper.dart';
import 'package:flutterapp/Task/DatabaseTask.dart';
import 'package:flutterapp/Task/PackageTask.dart';
import 'package:flutterapp/Task/httptask.dart';
import 'package:showbutton/showbutton.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    _getToken();
    return MaterialApp(
      home: Asigment(),
    );
  }
}
Future<void> _getToken() async {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? token = await _firebaseMessaging.getToken();
  print("Device Token: $token");
}

class Asigment extends StatelessWidget {

  final NotificationService _notificationService = NotificationService();
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }


  @override
  Widget build(BuildContext context) {
    double buttonWidth = 200.0; // Set the desired width for the buttons
    _notificationService.initialize(); // Initialize notifications

    return Scaffold(
      appBar: AppBar(
        backgroundColor:CSSColors.cadetBlue,
         title: Text('Flutter Assigment 5'),
      ),
      body: Container(
        color: CSSColors.blanchedAlmond,
        child: Center(
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
                ))
                 , SizedBox(height: 20),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    makePhoneCall("45466465");
                  },
                  child: Text('Launch Url'),
                ),
              ),   SizedBox(height: 20),
              SizedBox(
                width: buttonWidth,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePageHttp()),
                    );                  },
                  child: Text('Http'),
                ),
              ),
              // Add more buttons as needed
            ],
          ),
        ),
      ),
    );
  }

  void openGoogleWebsite() async {



   }




  void makePhoneCall(String phoneNumber) async {
    final String url = 'tel:$phoneNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
