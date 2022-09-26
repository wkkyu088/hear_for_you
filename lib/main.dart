import 'package:flutter/material.dart';
import 'package:hear_for_you/screens/regular_screen.dart';
import 'package:hear_for_you/screens/spalsh_screen.dart';

void main() {
  runApp(new MaterialApp(
      home: new SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context) => new RegularScreen()
      }));
}

/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hear For You',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: RegularScreen(),
    );
  }
}
*/