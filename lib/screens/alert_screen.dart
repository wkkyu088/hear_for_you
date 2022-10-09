import 'package:flutter/material.dart';
import 'package:hear_for_you/widgets/curved_painter.dart';
import 'dart:async';

import '../constants.dart';

class AlertScreen extends StatefulWidget {
  const AlertScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  late DateTime now;
  late Timer _timer;
  int min = 0;
  int sec = 0;

  @override
  initState() {
    super.initState();
    now = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        sec++;
        if (sec == 60) {
          sec = 0;
          min++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool mode = true; // 색상별 테스트용

    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Widget background(center, point, height) {
      return Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.transparent,
        child: CustomPaint(
          painter: CurvedPainter(
              center,
              point,
              height,
              mode
                  ? const Color(0xFFC80000).withOpacity(0.5)
                  : const Color(0xFFF8AE24).withOpacity(0.5)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[900] : Colors.grey[100],
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
                  width: screenWidth * 0.55,
                  child: Column(
                    children: [
                      Icon(
                        mode
                            ? Icons.notifications_active_rounded
                            : Icons.warning_rounded,
                        color: Colors.white,
                        size: 85,
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        '사이렌 감지',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontFamily: 'SCBold'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '${now.hour}시 ${now.minute}분 ${now.second}초에 사이렌 소리가 감지되었습니다.\n알림을 끄려면 확인 버튼을 눌러주세요.',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            height: 1.3,
                            fontFamily: 'SCLight'),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 60,
                left: screenWidth / 2 - 90,
                width: 180,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.black,
                    backgroundColor: mode
                        ? const Color(0xFFC80000)
                        : const Color(0xFFF8AE24),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                  ),
                  child: const Text(
                    '확인',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
