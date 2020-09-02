/// main.dart
/// classe MyApp.
/// Responsável por inicializar o aplicativo e encaminhar para a Splash Screen.

import 'package:flutter/material.dart';
import 'package:ICook/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return SplashScreen();
        },
      ),
    );
  }
}
