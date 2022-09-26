import 'package:flutter/material.dart';
import 'package:hear_for_you/screens/regular_screen.dart';

void main() {
  runApp(const MyApp());
}

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
