import 'package:flutter/material.dart';

class RegularScreen extends StatefulWidget {
  const RegularScreen({Key? key}) : super(key: key);
  @override
  State<RegularScreen> createState() => _RegularScreenState();
}

class _RegularScreenState extends State<RegularScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: Text('This is main page',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200))),
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
    );
  }
}
