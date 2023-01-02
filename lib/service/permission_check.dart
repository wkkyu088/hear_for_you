import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PermissionCheckClass {
  static void AndroidAlertPermissionCheck(BuildContext context) async {
    var result = await Permission.notification.isGranted;

    print("안드로이드 알림 확인결과 : ${result}");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child:
                      Center(child: Text("알람 권한을 허용해주세요!\n\n큰 소리가 나면 알려드릴게요"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                      Navigator.pop(context);
                    },
                    child: Text('설정하러 가기')),
              ],
            );
          });
    }
  }

  static void AndroidMicPermissionCheck(BuildContext context) async {
    var result = await Permission.microphone.isGranted;

    print("안드로이드 마이크 확인결과 : ${result}");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child: Center(
                      child: Text("마이크 사용을 허용해주세요!\n주변 소리를 듣기 위해 필요해요"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                      Navigator.pop(context);
                    },
                    child: Text('설정하러 가기')),
              ],
            );
          });
    }
  }

  static void AndroidRecognitionPermissionCheck(BuildContext context) async {
    var result = await Permission.speech.isGranted;

    print("안드로이드 음성 녹음 확인결과 : ${result}");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child: const Center(
                      child: Text(
                          "음성 녹음 사용을 허용해주세요!\n대화를 도와드리거나 주변 소리를 들을 수 있어요"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () {
                      openAppSettings();
                      Navigator.pop(context);
                    },
                    child: Text('설정하러가기')),
              ],
            );
          });
    }
  }

  static void AndroidSystemAlertWindowPermissionCheck(
      BuildContext context) async {
    var result = await Permission.systemAlertWindow.isGranted;

    print("안드로이드 화면 알림 확인결과 : ${result}");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child: const Center(child: Text("다른 앱 위에 표시 사용을 허용해주세요!"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () async {
                      await Permission.systemAlertWindow.request();
                      Navigator.pop(context);
                    },
                    child: Text('설정하러가기')),
              ],
            );
          });
    }
  }

  static void IOSAlertPermissionCheck(BuildContext context) async {
    var result = await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    print("IOS 알람 확인결과 : ${result}");

    if (!(result!)) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child:
                      Center(child: Text("알람 권한을 허용해주세요!\n\n큰 소리가 나면 알려드릴게요"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                      Navigator.pop(context);
                    },
                    child: Text('설정하러 가기')),
              ],
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
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child: Center(
                      child: Text("마이크 사용 권한을 허용해주세요!\n주변 소리를 듣기 위해 필요해요"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                      Navigator.pop(context);
                    },
                    child: Text('설정하러 가기')),
              ],
            );
          });
    }
  }

  static void IOSRecognitionPermissionCheck(BuildContext context) async {
    bool result = await SpeechToText().initialize();

    print("IOS 음성 녹음 확인결과 : ${result}");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child: Center(
                      child:
                          Text("음성 녹음을 허용해주세요!\n\n다른 사람의 말을 글자로 바꿔드릴 수 있어요!"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                      Navigator.pop(context);
                    },
                    child: Text('설정하러 가기')),
              ],
            );
          });
    }
  }

  static void IOSPhotoPermissionCheck(BuildContext context) async {
    var result = await Permission.photos.isGranted;

    print("사진첩 확인결과 : ${result}");

    if (!result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child: Center(child: Text("사진첩 접근 권한을 허용해주세요!"))),
              actions: [
                TextButton(
                    onPressed: (() {
                      Navigator.pop(context);
                    }),
                    child: Text("괜찮아요!")),
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                      Navigator.pop(context);
                    },
                    child: Text('설정하러 가기')),
              ],
            );
          });
    }
  }
}
