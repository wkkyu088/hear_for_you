import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hear_for_you/main.dart';
import 'package:hear_for_you/service/full_screen_alert/provider/alarm_state.dart';
import 'package:hear_for_you/service/full_screen_alert/view/curved_painter.dart';
import 'package:hear_for_you/widgets/missed_alert.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../modules/regular_module.dart';
import '../../Functions.dart';
import 'alarm_observer.dart';

class AlarmScreen extends StatefulWidget {
  final String alarmName;
  const AlarmScreen({Key? key, required this.alarmName}) : super(key: key);

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> with WidgetsBindingObserver {
  late DateTime now;
  late Timer _timer;
  int min = 0;
  int sec = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        sec++;
        if (sec == 60) {
          sec = 0;
          min++;
        }
        // 알람을 자동으로 끌 시간
        if (min == 0 && sec == 10) {
          MissedAlertState.onScreen = true;
          _dismissAlarm();
        }
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        _dismissAlarm();
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer.cancel();
    super.dispose();
  }

  void _dismissAlarm() async {
    final alarmState = context.read<AlarmState>();
    alarmState.dismiss();
    await context.read<RecordModule>().record();
  }

  @override
  Widget build(BuildContext context) {
    bool mode = true; // 색상별 테스트용

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double navigationBarHeight = MediaQuery.of(context).padding.bottom;

    // 배경 웨이브
    Widget background(center, point, height) {
      return Container(
        width: screenWidth,
        height: screenHeight - statusBarHeight - navigationBarHeight,
        color: Colors.transparent,
        child: CustomPaint(
          painter: CurvedPainter(
            center,
            point,
            height,
            point == 0.45
                ? (mode ? kAlert1 : kAlert2)
                : (mode ? kAlert1.withOpacity(0.5) : kAlert2.withOpacity(0.5)),
          ),
        ),
      );
    }

    return Scaffold(
        backgroundColor: mode ? kAlert1 : kAlert2,
        body: SafeArea(
          child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                      height: screenHeight, color: darkMode ? kBlack : kGrey1),
                  background(const Offset(0, 0), 0.45, 0.5),
                  background(const Offset(0, 10), 0.65, 0.55),
                  background(const Offset(0, 20), 0.55, 0.6),
                ],
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.1),
                  width: screenWidth * 0.8,
                  child: Column(
                    children: [
                      // 알림 종류 아이콘
                      Icon(
                        mode
                            ? Icons.notifications_active_rounded
                            : Icons.warning_rounded,
                        color: kWhite,
                        size: 85,
                      ),
                      const SizedBox(height: 30),
                      // 알림 이름
                      Text(
                        '${widget.alarmName} 감지',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 38,
                            fontFamily: 'PretendardBold'),
                      ),
                      const SizedBox(height: 10),
                      // 알림 발생 시간
                      Text(
                        '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
                        style: TextStyle(color: kWhite, fontSize: kL),
                      ),
                      const SizedBox(height: 30),
                      // 알림 발생 시각과 부가 설명
                      Text(
                        '${now.hour}시 ${now.minute}분 ${now.second}초에 ${widget.alarmName}가 감지되었습니다.\n알림을 끄려면 확인 버튼을 눌러주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kWhite,
                            fontSize: kM,
                            height: 1.4,
                            fontFamily: 'PretendardLight'),
                      ),
                    ],
                  ),
                ),
              ),
              // 확인 버튼
              Positioned(
                bottom: 60,
                left: screenWidth / 2 - 90,
                width: 180,
                child: TextButton(
                  onPressed: () {
                    // 확인버튼을 누른 알람은 로그에 등장하지 않도록 조치
                    if (Platform.isIOS) {
                      print("확인버튼 눌림");
                      FunctionClass.changeLogState(logList.length - 1);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AlarmObserver(
                              child: BottomNavBar(selectedIndex: 1)),
                        ),
                      );
                      MissedAlertState.onScreen = true;
                      _dismissAlarm();
                    } else {
                      FunctionClass.changeLogState(logList.length - 1);
                      MissedAlertState.onScreen = true;
                      _dismissAlarm();
                    }
                  },
                  style: TextButton.styleFrom(
                    primary: kBlack,
                    backgroundColor: mode ? kAlert1 : kAlert2,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: Text(
                    '확인',
                    style: TextStyle(
                      color: kWhite,
                      fontSize: kXL + 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
