import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthspring/screens/login_screen.dart';
import 'package:healthspring/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {'/login': (context) => LoginScreen()},
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
      ),
    );
  }
}
