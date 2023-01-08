import 'package:flutter/material.dart';
import 'package:hear_for_you/main.dart';
import 'package:hear_for_you/screens/login_screen.dart';
import 'package:hear_for_you/service/full_screen_alert/view/alarm_observer.dart';
import 'package:hear_for_you/service/notification.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';
import '../constants.dart';
import '../modules/regular_module.dart';

// 스플래시 페이지

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static getProfile() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      initNotification();
      name = pref.getString('name')!;
      profileValue = pref.getInt('profileValue')!;
      regularValue = pref.getBool('regularValue')!;
      dB = pref.getDouble('dB')!;
      darkMode = pref.getBool('darkMode')!;
      selectedColor = pref.getInt('selectedColor')!;
      fontSizeId = pref.getInt('fontSizeId')!;
      for (var i = 0; i < 3; i++) {
        if (i == fontSizeId) {
          fontSizes[i] = true;
        } else {
          fontSizes[i] = false;
        }
      }
      cases = [
        pref.getBool('case1')!,
        pref.getBool('case2')!,
        pref.getBool('case3')!
      ];
      caseDetails = [
        [
          pref.getBool('case1detail1')!,
          pref.getBool('case1detail2')!,
          pref.getBool('case1detail3')!
        ],
        [
          pref.getBool('case2detail1')!,
          pref.getBool('case2detail2')!,
          pref.getBool('case2detail3')!
        ],
        [
          pref.getBool('case3detail1')!,
          pref.getBool('case3detail2')!,
          pref.getBool('case3detail3')!
        ],
      ];
      logList = pref.getStringList('logList')!;
    } catch (e) {
      print(e);
    }
  }

  // 4초 동안 지속된 후 홈스크린으로 이동
  startTime() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    name == ''
        ? {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()))
          }
        : Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AlarmObserver(child: BottomNavBar(selectedIndex: 1)),
            ),
          );
  }

  void initSplash() async {
    await getProfile();

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
    print("logs : ${logList}");
    print("######################################");
    debugPrint("debugging : $regularValue");
  }

  @override
  void initState() {
    super.initState();
    startTime();
    initSplash();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: darkMode ? kBlack : kGrey1,
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
