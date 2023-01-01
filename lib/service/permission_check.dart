import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PermissionCheckClass {
  static Future<bool> IOSrequestAlertPermission(BuildContext context) async {
    var result = await FlutterLocalNotificationsPlugin()
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    print("알림 확인결과 : ${result}");

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
      return false;
    }
    return true;
  }

  static Future<bool> IOSrequestMicPermission(BuildContext context) async {
    var result = await Permission.microphone.isDenied;

    print("마이크 확인결과(denied) : $result");
    if (result) {
      // 허용이 안된 경우
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                  width: 200,
                  height: 100,
                  child: Center(child: Text("마이크 사용 권한을 허용해주세요!"))),
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
      return false;
    }
    return true;
  }

  static Future<bool> IOSrequestRecognitionPermission(
      BuildContext context) async {
    bool result = await SpeechToText().initialize();

    print("음성인식 확인결과 : ${result}");

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
      return false;
    }
    return true;
  }

  static Future<bool> IOSrequestPhotoPermission(BuildContext context) async {
    var result = await Permission.photos.request();

    print("사진첩 확인결과 : ${result.isGranted}");

    if (!result.isGranted) {
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
      return false;
    }
    return true;
  }
}
