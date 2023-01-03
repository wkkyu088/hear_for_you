import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hear_for_you/widgets/custom_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../constants.dart';

Widget permissionDialog(context, content, onPressed1, onPressed2) {
  return twoButtonDialog(
    context,
    "권한 설정 안내",
    content,
    "괜찮아요",
    "설정하러 가기",
    onPressed1,
    onPressed2,
  );
}

class PermissionCheckClass {
  static void AndroidAlertPermissionCheck(BuildContext context) async {
    var result = await Permission.notification.isGranted;

    print("안드로이드 알림 확인결과 : $result");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return permissionDialog(
            context,
            "알람 권한을 허용해주세요!\n큰 소리가 나면 알려드릴게요.",
            () {
              Navigator.pop(context);
            },
            () {
              openAppSettings();
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  static void AndroidMicPermissionCheck(BuildContext context) async {
    var result = await Permission.microphone.isGranted;

    print("안드로이드 마이크 확인결과 : $result");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return permissionDialog(
            context,
            "마이크 사용을 허용해주세요!\n주변 소리를 듣기 위해 필요해요.",
            () {
              Navigator.pop(context);
            },
            () {
              openAppSettings();
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  static void AndroidRecognitionPermissionCheck(BuildContext context) async {
    var result = await Permission.speech.isGranted;

    print("안드로이드 음성 녹음 확인결과 : $result");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return permissionDialog(
            context,
            "음성 녹음 사용을 허용해주세요!\n대화를 도와드리거나 주변 소리를 들을 수 있어요.",
            () {
              Navigator.pop(context);
            },
            () {
              openAppSettings();
              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  static void AndroidSystemAlertWindowPermissionCheck(
      BuildContext context) async {
    var result = await Permission.systemAlertWindow.isGranted;

    print("안드로이드 화면 알림 확인결과 : $result");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return permissionDialog(
            context,
            "전체 화면 알림을 위해\n다른 앱 위에 표시 사용을 허용해주세요!",
            () async {
              final SharedPreferences pref =
                  await SharedPreferences.getInstance();
              pref.setBool('case1detail3', false);
              pref.setBool('case2detail3', false);
              pref.setBool('case3detail3', false);

              caseDetails[0][2] = false;
              caseDetails[1][2] = false;
              caseDetails[2][2] = false;

              Navigator.pop(context);
            },
            () async {
              await Permission.systemAlertWindow.request();
              final SharedPreferences pref =
                  await SharedPreferences.getInstance();
              pref.setBool('case1detail3', true);
              pref.setBool('case2detail3', true);
              pref.setBool('case3detail3', true);

              caseDetails[0][2] = true;
              caseDetails[1][2] = true;
              caseDetails[2][2] = true;

              Navigator.pop(context);
            },
          );
        },
      );
    }
  }

  static void IOSAlertPermissionCheck(BuildContext context) async {
    var result = await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    print("IOS 알람 확인결과 : $result");

    if (!(result!)) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return permissionDialog(
              context,
              "알람 권한을 허용해주세요!\n큰 소리가 나면 알려드릴게요.",
              () {
                Navigator.pop(context);
              },
              () {
                openAppSettings();
                Navigator.pop(context);
              },
            );
          });
    }
  }

  static void IOSMicPermissionCheck(BuildContext context) async {
    var result = await Permission.microphone.isGranted;

    print("IOS 마이크 확인결과 : $result");
    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return permissionDialog(
              context,
              "마이크 사용을 허용해주세요!\n주변 소리를 듣기 위해 필요해요.",
              () {
                Navigator.pop(context);
              },
              () {
                openAppSettings();
                Navigator.pop(context);
              },
            );
          });
    }
  }

  static void IOSRecognitionPermissionCheck(BuildContext context) async {
    bool result = await SpeechToText().initialize();

    print("IOS 음성 녹음 확인결과 : $result");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return permissionDialog(
              context,
              "음성 녹음 사용을 허용해주세요!\n대화를 도와드리거나 주변 소리를 들을 수 있어요.",
              () {
                Navigator.pop(context);
              },
              () {
                openAppSettings();
                Navigator.pop(context);
              },
            );
          });
    }
  }

  static void IOSPhotoPermissionCheck(BuildContext context) async {
    var result = await Permission.photos.isGranted;

    print("사진첩 확인결과 : $result");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return permissionDialog(
              context,
              "사진첩 접근 권한을 허용해주세요!",
              () {
                Navigator.pop(context);
              },
              () {
                openAppSettings();
                Navigator.pop(context);
              },
            );
          });
    }
  }
}
