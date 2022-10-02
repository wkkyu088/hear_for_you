import 'package:flutter/material.dart';
import 'package:hear_for_you/constants.dart';
import 'package:hear_for_you/screens/alert_screen.dart';
import 'package:hear_for_you/screens/setting_screen.dart';
import 'package:hear_for_you/screens/voice_screen.dart';
import 'package:hear_for_you/widgets/curved_painter.dart';

import '../constants.dart';

class RegularScreen extends StatefulWidget {
  const RegularScreen({Key? key}) : super(key: key);
  @override
  State<RegularScreen> createState() => _RegularScreenState();
}

class _RegularScreenState extends State<RegularScreen> {
  List<bool> op = [true, true, true, true, true];

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<double> heights =
        regularValue ? [25, 35, 50, 25, 35] : [10, 10, 10, 10, 10];
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    Widget waveForm(height) {
      return Container(
        width: 10,
        height: height,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
      );
    }

    Widget background(center, point, height) {
      return Container(
        width: screenWidth,
        height: screenHeight,
        color: Colors.transparent,
        child: CustomPaint(
          painter:
              CurvedPainter(center, point, height, kMain.withOpacity(0.08)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Container(
        margin: const EdgeInsets.all(5),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VoiceScreen(title: "voice")));
          },
          backgroundColor: Colors.black,
          elevation: 10.0,
          child: const Icon(
            Icons.mic_rounded,
            size: 26,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          background(const Offset(0, 0), 0.45, 0.58),
          background(const Offset(0, 10), 0.6, 0.65),
          background(const Offset(0, 20), 0.55, 0.72),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: screenHeight * 0.3),
              child: Column(
                children: [
                  GestureDetector(
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          waveForm(heights[0]),
                          waveForm(heights[1]),
                          waveForm(heights[2]),
                          waveForm(heights[3]),
                          waveForm(heights[4]),
                        ],
                      ),
                    ),
                    onTap: () {
                      // setState(() {
                      //   for (int i = 0; i < heights.length; i++) {
                      //     if (op[i] == true) {
                      //       heights[i] += 5;
                      //     } else {
                      //       heights[i] -= 5;
                      //     }
                      //     if (heights[i] == 55) {
                      //       op[i] = false;
                      //     } else if (heights[i] == 5) {
                      //       op[i] = true;
                      //     }
                      //   }
                      // });
                    },
                  ),
                  const SizedBox(height: 15),
                  Text(
                    regularValue ? '소리를 듣고 있습니다...' : '상시모드가 꺼져있습니다.',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 67, 67, 67),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: statusBarHeight),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.help_rounded,
                    size: 25,
                  ),
                  padding: const EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const AlertScreen(title: "alert")));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        '상시모드 ',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'SCBold',
                        ),
                      ),
                      Text(
                        regularValue ? '켜짐' : '꺼짐',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: 'SCBold',
                          color: regularValue ? kMain : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.settings_rounded,
                    size: 25,
                  ),
                  padding: const EdgeInsets.all(15),
                  onPressed: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SettingScreen()))
                        .then((value) {
                      setState(() {});
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
