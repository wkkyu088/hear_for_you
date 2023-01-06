import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/modules/regular_module.dart';
import 'package:hear_for_you/modules/voice_test.dart';
import 'package:hear_for_you/screens/regular_screen.dart';
import 'package:hear_for_you/screens/setting_screen.dart';
import 'package:hear_for_you/screens/spalsh_screen.dart';

import 'package:hear_for_you/modules/voice_module.dart';
import 'package:hear_for_you/service/full_screen_alert/provider/alarm_provider.dart';
import 'package:hear_for_you/service/full_screen_alert/provider/alarm_state.dart';
import 'package:hear_for_you/service/full_screen_alert/service/alarm_polling_worker.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

import 'modules/voice_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  final AlarmState alarmState = AlarmState();
  AlarmPollingWorker().createPollingWorker(alarmState);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => VoiceModule()),
      ChangeNotifierProvider(create: (context) => RecordModule()),
      ChangeNotifierProvider(create: (context) => alarmState),
      ChangeNotifierProvider(create: (context) => AlarmProvider()),
      ChangeNotifierProvider(create: (context) => RecordModule()),
      ChangeNotifierProvider(create: (context) => VoiceModule()),
    ],
    child: const MyApp(),
  ));
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
      // 기기의 폰트 크기 무시
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'PretendardMedium',
      ),
      // home: name == "" ? const LoginScreen() : const BottomNavBar(),
      // home: const BottomNavBar(),
      home: const SplashScreen(),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  int selectedIndex;
  BottomNavBar({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedIndex = 1;
  final screens = [
    const VoiceModuleTest(),
    const RegularScreen(),
    const SettingScreen()
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    Widget bottomNavBar() {
      return BottomNavigationBar(
        backgroundColor: darkMode ? kBlack : kGrey1,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
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
      );
    }

    return Scaffold(
        body: ColorfulSafeArea(
      color: darkMode ? kBlack : kGrey1,
      bottom: true,
      child: Stack(
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
    ));
  }
}
