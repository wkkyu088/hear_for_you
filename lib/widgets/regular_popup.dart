import 'dart:async';
import 'dart:io';
import 'package:hear_for_you/modules/regular_module.dart';
import 'package:hear_for_you/widgets/custom_dialog.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../service/flash_light.dart';
import '../service/full_screen_alert/provider/alarm_provider.dart';
import '../service/full_screen_alert/service/alarm_scheduler.dart';
import '../service/full_screen_alert/view/alarm_screen.dart';
import '../service/functions.dart';
import '../constants.dart' as settings;
import 'package:flutter/material.dart';

import '../service/notification.dart';

class ModelPopup extends StatefulWidget {
  const ModelPopup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopupState();
}

class PopupState extends State<ModelPopup> {
  String object = "분석중입니다";
  String title = "소리 감지";
  String message = "닫기";
  void Function()? onPressed() {
    Navigator.pop(context);
    context.read<RecordModule>().record();
    return null;
  }

  Color color = Colors.black;
  late Widget returnWidget =
      oneButtonDialog(context, title, object, message, onPressed, color: color);
  @override
  initState() {
    super.initState();
    Future<String> prediction = FunctionClass.getPrediction();
    prediction.then((val) {
      if (Platform.isAndroid) {
        setState(() async {
          DateTime now = DateTime.now();
          DateTime time = DateTime(
            now.year,
            now.month,
            now.day,
            now.hour,
            now.minute,
            now.second,
          );
          context.read<AlarmProvider>().setAlarm(time, val);
          await AlarmScheduler.scheduleRepeatable(time);
        });
      } else {
        setState(() {
          returnWidget = AlarmScreen(alarmName: val);
          // object = "분석 결과: $val";
          color = Colors.green;
        });
      }
    }).catchError((error) {
      // SignalException은 무슨 소리인지 인지하지 못했을 경우임. 이때는 에러는 아니므로 다른 처리
      if (error.toString() == "SignalException") {
        if (Platform.isAndroid) {
          returnWidget = const AlarmScreen(alarmName: "큰 소리");
          FlashLight.startFlashLight(0);
        } else {
          setState(() {
            title = "분석 실패";
            object = "알 수 없는 소리입니다";
            color = Colors.red;
            // returnWidget = oneButtonDialog(context, title, object, "확인", () {},
            //     color: color);
            // Timer(const Duration(seconds: 2), () {
            //   Navigator.pop(context);
            //   // 여기
            // });
            returnWidget = const AlarmScreen(alarmName: "큰 소리");
          });
        }
      } else if (error.toString() == "FileSystemException") {
        setState(() {
          title = "파일 에러";
          object = "audio.wav 파일이 없습니다";
          color = Colors.red;
          returnWidget = oneButtonDialog(context, title, object, "확인", () {},
              color: color);
          Timer(const Duration(seconds: 2), () {
            Navigator.pop(context);
            // 여기
            context.read<RecordModule>().record();
            });
          });
      } else {
        print("analyzing : 에러가 발생했습니다 : $error");
        logToServer.add("analyzing : 에러가 발생했습니다 : $error");
        FunctionClass.sendLogToServer();
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return returnWidget;
  }
}
