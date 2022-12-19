import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:hear_for_you/main.dart';
// import 'package:hear_for_you/modules/local_notification.dart';
import 'package:hear_for_you/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
=======
    print("################### START ###################");
    print(name);
    print(profileValue);
    print(regularValue);
    print(dB);
    print(darkMode);
    print(selectedColor);
    print(fontSizes);
    print(cases);
    print(caseDetails);
    print("######################################");
    // LocalNotification.initialize();
    setState(() {});
>>>>>>> Stashed changes
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
