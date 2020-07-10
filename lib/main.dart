import 'package:ean/screens/info_screen.dart';
import 'package:ean/screens/login_screen.dart';
import 'package:ean/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: kTitle,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/InfoScreen': (context) => InfoScreen(),
        });
  }
}
