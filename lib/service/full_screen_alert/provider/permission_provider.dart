// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PermissionProvider extends ChangeNotifier {
//   PermissionProvider(this._preferences);

//   @visibleForTesting
//   static const String systemAlertWindowGranted = "systemAlertWindowGranted";
//   static const String notificationGranted = "notificationGranted";
//   static const String speechGranted = "speechGranted";

//   final SharedPreferences _preferences;

//   bool isGrantedAll() {
//     bool isSystemAlertWindowGranted =
//         _preferences.getBool(systemAlertWindowGranted) ?? false;
//     bool isNotificationGranted =
//         _preferences.getBool(notificationGranted) ?? false;
//     bool isSpeechGranted = _preferences.getBool(speechGranted) ?? false;

//     if (isSystemAlertWindowGranted &&
//         isNotificationGranted &&
//         isSpeechGranted) {
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future<bool> requestSystemAlertWindow() async {
//     print("다른 앱 위 권한 설정 하러옴");
//     if (await Permission.systemAlertWindow.status != PermissionStatus.granted) {
//       await Permission.systemAlertWindow.request();
//     }

//     if (await Permission.systemAlertWindow.status == PermissionStatus.granted) {
//       await _preferences.setBool(systemAlertWindowGranted, true);
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }

//   Future<bool> requestNotification() async {
//     print("알림 권한 설정 하러옴");

//     if (await Permission.notification.status != PermissionStatus.granted) {
//       await Permission.notification.request();
//       print("????");
//     }

//     if (await Permission.notification.status == PermissionStatus.granted) {
//       print("!!!!");
//       await _preferences.setBool(notificationGranted, true);
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }

//   Future<bool> requestSpeech() async {
//     print("음성 녹음 권한 설정 하러옴");
//     if (await Permission.speech.status != PermissionStatus.granted) {
//       await Permission.speech.request();
//       print("????");
//     }

//     if (await Permission.speech.status == PermissionStatus.granted) {
//       await _preferences.setBool(speechGranted, true);
//       notifyListeners();
//       return true;
//     }
//     return false;
//   }
// }
