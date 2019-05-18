import 'package:flutter/material.dart';
import 'pages/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iBarragem',
      home: LandingPage(),
      // darkTheme: ThemeData(
      //   primaryColorDark: Colors.grey,
      //   brightness: Brightness.dark,
      // ),
    );
  }
}