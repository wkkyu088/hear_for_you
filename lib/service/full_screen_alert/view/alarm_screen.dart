import 'dart:async';

import 'package:flutter/material.dart';
import '../provider/alarm_state.dart';
import '../view/curved_painter.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({Key? key}) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    bool mode = true; // 색상별 테스트용

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 배경 웨이브
    Widget background(center, point, height) {
      return Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.transparent,
        child: CustomPaint(
          painter: CurvedPainter(center, point, height,
              mode ? kAlert1.withOpacity(0.5) : kAlert2.withOpacity(0.5)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      body: Column(
        children: [
          Stack(
            children: [
              background(const Offset(0, 0), 0.45, 0.5),
              background(const Offset(0, 10), 0.65, 0.55),
              background(const Offset(0, 20), 0.55, 0.6),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: screenHeight * 0.1),
                  width: screenWidth * 0.58,
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
                        '사이렌 감지',
                        style: TextStyle(
                            color: kWhite,
                            fontSize: 38,
                            fontFamily: 'PretendardBold'),
                      ),
                      const SizedBox(height: 10),
                      // 알림 발생 시간
                      Text(
                        '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
                        style: TextStyle(color: kWhite, fontSize: kXL),
                      ),
                      const SizedBox(height: 30),
                      // 알림 발생 시각과 부가 설명
                      Text(
                        '${now.hour}시 ${now.minute}분 ${now.second}초에 사이렌 소리가 감지되었습니다.\n알림을 끄려면 확인 버튼을 눌러주세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: kWhite,
                            fontSize: kM,
                            height: 1.3,
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
                    _dismissAlarm();
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
        ],
      ),
    );
  }
}