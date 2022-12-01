import 'package:flutter/material.dart';
import 'dart:async';

import '../constants.dart';

// 스플래시 페이지

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // 4초 동안 지속된 후 홈스크린으로 이동
  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, navigationPage);
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
