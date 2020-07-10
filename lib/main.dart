import 'package:ean/screens/info_screen.dart';
import 'package:ean/screens/login_screen.dart';
import 'package:ean/utils/constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: kTitle,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Raleway',
        ),
        initialRoute: kRouteLoginScreen,
        routes: {
          kRouteLoginScreen: (context) => LoginScreen(),
          kRouteInfoScreen: (context) => InfoScreen(),
        });
  }
}
