import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/screens/voice_screen.dart';
import 'package:hear_for_you/screens/regular_screen.dart';
import 'package:hear_for_you/screens/setting_screen.dart';
import 'package:hear_for_you/screens/spalsh_screen.dart';

import 'constants.dart';

// void main() {
//   runApp(new MaterialApp(
//       home: new SplashScreen(),
//       routes: <String, WidgetBuilder>{
//         '/HomeScreen': (BuildContext context) => new RegularScreen()
//       }));
// }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: darkMode ? kBlack : kGrey1,
      systemNavigationBarIconBrightness:
          darkMode ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: darkMode
          ? Platform.isIOS
              ? Brightness.dark
              : Brightness.light
          : Platform.isIOS
              ? Brightness.light
              : Brightness.dark,
    ));

    return MaterialApp(
      title: 'Hear For You',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'SCMedium',
      ),
      home: const BottomNavBar(),
      // home: SplashScreen(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 1;
  final screens = [
    const VoiceScreen(title: '음성모드'),
    const RegularScreen(),
    const SettingScreen()
  ];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    Widget bottomNavBar() {
      return SizedBox(
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          // showSelectedLabels: false,
          // showUnselectedLabels: false,
          currentIndex: selectedIndex,
          selectedItemColor: kMain,
          unselectedItemColor: darkMode ? kWhite : kGrey8,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.keyboard_voice_rounded,
                size: 26,
                color: selectedIndex == 0
                    ? kMain
                    : darkMode
                        ? kWhite
                        : kGrey8,
              ),
              label: '음성모드',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 26,
                color: selectedIndex == 1
                    ? kMain
                    : darkMode
                        ? kWhite
                        : kGrey8,
              ),
              label: '상시모드',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings_rounded,
                size: 26,
                color: selectedIndex == 2
                    ? kMain
                    : darkMode
                        ? kWhite
                        : kGrey8,
              ),
              label: '설정',
            ),
          ],
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          screens[selectedIndex],
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: keyboardHeight == 0 ? bottomNavBar() : Container(height: 0),
          ),
        ],
      ),
    );
  }
}
