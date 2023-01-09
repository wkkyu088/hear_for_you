import 'dart:async';
import 'dart:io';
import 'package:hear_for_you/modules/regular_module.dart';
import 'package:hear_for_you/service/full_screen_alert/provider/alarm_state.dart';
import 'package:hear_for_you/widgets/custom_dialog.dart';
import 'package:hear_for_you/widgets/missed_alert.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../service/full_screen_alert/provider/alarm_provider.dart';
import '../service/full_screen_alert/service/alarm_scheduler.dart';
import '../service/full_screen_alert/view/alarm_screen.dart';
import '../service/functions.dart';
import 'package:flutter/material.dart';

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
    prediction.then((val) async {
      // --------------- cases[2] 전체 화면 알림 설정이 true이면 알림을 울리게 ---------------
      MissedAlertState.onScreen = false;
      if (cases[2]) {
        if (Platform.isAndroid) {
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
          setState(() {});
        } else {
          returnWidget = AlarmScreen(alarmName: val);
          setState(() {});
        }
      }
    }).catchError((error) async {
      // SignalException은 무슨 소리인지 인지하지 못했을 경우임. 이때는 에러는 아니므로 다른 처리
      MissedAlertState.onScreen = false;
      if (error.toString() == "SignalException") {
        if (cases[2]) {
          if (Platform.isAndroid) {
            DateTime now = DateTime.now();
            DateTime time = DateTime(
              now.year,
              now.month,
              now.day,
              now.hour,
              now.minute,
              now.second,
            );
            context
                .read<AlarmProvider>()
                .setAlarm(time, "${dB.round()} dB 이상의 소리");
            await AlarmScheduler.scheduleRepeatable(time);
            setState(() {});
          } else {
            returnWidget =
                AlarmScreen(alarmName: "${int.parse(dB.toString())} dB 이상의 소리");
            setState(() {});
          }
        }
      } else {
        print("analyzing : 에러가 발생했습니다 : $error");
        logToServer.add("analyzing : 에러가 발생했습니다 : $error");
        FunctionClass.sendLogToServer();
        defaultPress();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmState>(builder: (context, state, child) {
      print("state ${state.isFired}");
      if (state.isFired) {
        Navigator.pop(context);
      }
      return returnWidget;
    });
  }
}
