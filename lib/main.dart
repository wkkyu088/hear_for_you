import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/screens/regular_screen.dart';
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
    bool isDarkMode = false;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
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
      home: RegularScreen(),
    );
  }
}
