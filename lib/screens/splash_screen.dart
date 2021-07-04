import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthspring/screens/intro_screen.dart';
import 'package:healthspring/screens/switch_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), openLogin);
    super.initState();
  }

  void openLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SwitchScreen(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
        child: Container(
          width: 300,
          child: Image.asset('assets/images/logo.png'),
        ),
      ),
    );
  }
}
