import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:css_colors/css_colors.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class MyLocale extends StatelessWidget {
  final VoidCallback toggleLanguage;

  MyLocale({required this.toggleLanguage});

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
        child: Text(AppLocalizations.of(context)!.helloworld),
      ),
    );
  }
}
