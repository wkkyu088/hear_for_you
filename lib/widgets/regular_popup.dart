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
  void Function()? defaultPress() {
    Navigator.pop(context);
    context.read<RecordModule>().record();
    return null;
  }

  Color color = Colors.black;
  late Widget returnWidget = oneButtonDialog(
      context, title, object, message, defaultPress,
      color: color);
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
          returnWidget = AlarmScreen(alarmName: val);
          setState(() {});
      }
    }).catchError((error) {
      // SignalException은 무슨 소리인지 인지하지 못했을 경우임. 이때는 에러는 아니므로 다른 처리
      if (error.toString() == "SignalException") {
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
            context.read<AlarmProvider>().setAlarm(time, "큰 소리");
            await AlarmScheduler.scheduleRepeatable(time);
          });
        } else {
          returnWidget = const AlarmScreen(alarmName: "큰 소리");
          setState(() {});
        }
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
