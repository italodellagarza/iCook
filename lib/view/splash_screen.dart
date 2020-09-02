/// splash_screen.dart
/// classes SplashScreen e _SplashScreenState.
/// Responsável por mostrar a Splash Screen e redirecionar à página
/// raiz RootPage.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../control/authentication.dart';
import '../control/root_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    Future.delayed(Duration(seconds: 4)).then(
      (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => RootPage(
              auth: new Auth(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          width: 200,
          height: 200,
          child: Image.asset("imgs/splash.png"),
        ),
      ),
    );
  }
}
