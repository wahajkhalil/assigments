import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterapp/cameraopen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:camera/camera.dart'; // Import the camera package

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras(); // Initialize cameras
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _currentLocale = Locale("en");

  void _toggleLanguage() {
    setState(() {
      _currentLocale = _currentLocale.languageCode == "en"
          ? Locale("es")
          : Locale("en");
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: _currentLocale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale("en"), Locale("es")],
      home: MyHomePage(toggleLanguage: _toggleLanguage),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final VoidCallback toggleLanguage;

  MyHomePage({required this.toggleLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.helloworld),
        actions: [
          Switch(
            value: Localizations.localeOf(context).languageCode == "es",
            onChanged: (value) {
              toggleLanguage();
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
            inactiveThumbColor: Colors.redAccent,
            inactiveTrackColor: Colors.orangeAccent,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showLocationDialog(context);
              },
              child: Text('Show Location'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                  availableCameras().then((value) => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));

              },
              child: Text('Open Camera'),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    } catch (e) {
      print(e);
      return 'Error getting location';
    }
  }

  Future<void> _showLocationDialog(BuildContext context) async {
    String locationMessage = await _getCurrentLocation();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Current Location'),
          content: Text(locationMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}


