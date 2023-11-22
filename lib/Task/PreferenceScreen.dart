import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceScreen extends StatefulWidget {
  @override
  _PreferenceScreenState createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  final TextEditingController _themeController = TextEditingController();
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeController.text = _prefs.getString('theme') ?? 'DefaultTheme';
    });
  }

  _savePreferences() {
    _prefs.setString('theme', _themeController.text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Preferences saved'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Preference Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _themeController,
              decoration: InputDecoration(labelText: 'Enter Theme'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _savePreferences();
              },
              child: Text('Save Preferences'),
            ),
          ],
        ),
      ),
    );
  }
}