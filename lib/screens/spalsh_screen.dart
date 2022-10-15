import 'package:flutter/material.dart';
import 'dart:async';

import '../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: darkMode ? kBlack : kWhite,
        body: Center(
          child: SizedBox(
            width: screenWidth * 0.6,
            child: darkMode
                ? Image.asset('lib/assets/images/splash_image2.png')
                : Image.asset('lib/assets/images/splash_image.png'),
          ),
        ));
  }
}
