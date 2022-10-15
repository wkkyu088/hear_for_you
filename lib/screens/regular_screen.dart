import 'package:flutter/material.dart';
import 'package:hear_for_you/constants.dart';
import 'package:hear_for_you/screens/alert_screen.dart';
import 'package:hear_for_you/widgets/wave_form.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../constants.dart';

class RegularScreen extends StatefulWidget {
  const RegularScreen({Key? key}) : super(key: key);
  @override
  State<RegularScreen> createState() => _RegularScreenState();
}

class _RegularScreenState extends State<RegularScreen>
    with SingleTickerProviderStateMixin {
  List<bool> op = [true, true, true, true, true];
  bool open = true;
  late AnimationController controller;
  late Animation<double> animation =
      Tween(begin: 0.0, end: 100.0).animate(controller);

  @override
  void initState() {
    super.initState();
    setState(() {});
    controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    animation.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      body: Stack(
        children: [
          Column(
            children: [
              // background(const Offset(0, 20), 0.55, 0.72,
              //     const Color(0xFFF5ECE5).withOpacity(0.7)),
              // background(const Offset(0, 10), 0.6, 0.65,
              //     const Color(0xFFF5E3D7).withOpacity(0.7)),
              // background(const Offset(0, 0), 0.45, 0.58,
              //     const Color(0xFFF5DBCC).withOpacity(0.7)),
              // Center(
              //   child: Container(
              //     margin: EdgeInsets.only(top: screenHeight * 0.3),
              //     child: Column(
              //       children: [
              //         GestureDetector(
              //           child: SizedBox(
              //             height: 60,
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 waveForm(heights[0]),
              //                 waveForm(heights[1]),
              //                 waveForm(heights[2]),
              //                 waveForm(heights[3]),
              //                 waveForm(heights[4]),
              //               ],
              //             ),
              //           ),
              //           onTap: () {
              //             // setState(() {
              //             //   for (int i = 0; i < heights.length; i++) {
              //             //     if (op[i] == true) {
              //             //       heights[i] += 5;
              //             //     } else {
              //             //       heights[i] -= 5;
              //             //     }
              //             //     if (heights[i] == 55) {
              //             //       op[i] = false;
              //             //     } else if (heights[i] == 5) {
              //             //       op[i] = true;
              //             //     }
              //             //   }
              //             // });
              //           },
              //         ),
              //         const SizedBox(height: 15),
              //         Text(
              //           regularValue ? '소리를 듣고 있습니다...' : '상시모드가 꺼져있습니다.',
              //           style: TextStyle(
              //             color: Colors.grey[700],
              //             fontSize: kXS,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Container(
                padding: EdgeInsets.only(top: statusBarHeight),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.help_rounded,
                          size: 24,
                          color: darkMode ? kWhite : kBlack,
                        ),
                        padding: const EdgeInsets.all(10),
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
                            Text(
                              '상시모드 ',
                              style: TextStyle(
                                fontSize: kXL,
                                fontFamily: 'SCBold',
                                color: darkMode ? kWhite : kBlack,
                              ),
                            ),
                            Text(
                              regularValue ? '켜짐' : '꺼짐',
                              style: TextStyle(
                                fontSize: kXL,
                                fontFamily: 'SCBold',
                                color: regularValue ? kMain : kGrey5,
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.help_rounded,
                          size: 25,
                          color: Colors.transparent,
                        ),
                        padding: const EdgeInsets.all(15),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    width: screenWidth * 0.7,
                    height: screenWidth * 0.7,
                    margin: const EdgeInsets.only(top: 80),
                    child: SfRadialGauge(
                      axes: <RadialAxis>[
                        RadialAxis(
                          minimum: 0,
                          maximum: 100,
                          showLabels: false,
                          showTicks: false,
                          startAngle: 270,
                          endAngle: 270,
                          axisLineStyle: AxisLineStyle(
                            thickness: 0.08,
                            color: darkMode ? kGrey9 : kGrey2.withOpacity(0.6),
                            thicknessUnit: GaugeSizeUnit.factor,
                          ),
                          pointers: <GaugePointer>[
                            RangePointer(
                              value: regularValue ? animation.value : 0,
                              width: 0.08,
                              sizeUnit: GaugeSizeUnit.factor,
                              gradient: SweepGradient(
                                colors: <Color>[kMain, kMain.withOpacity(0.5)],
                                stops: const <double>[0.35, 0.85],
                              ),
                              cornerStyle: CornerStyle.bothCurve,
                              enableAnimation: true,
                              animationDuration: 100,
                              animationType: AnimationType.linear,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.55,
                    height: screenWidth * 0.55,
                    margin: const EdgeInsets.only(top: 80),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [kMain, kMain.withOpacity(0.5)]),
                    ),
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: MediaQuery.of(context).size,
                          painter: WaveForm(1, 1),
                        ),
                        regularValue
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: screenWidth * 0.55 * 0.4 * 0.5),
                                child: CustomPaint(
                                  size: MediaQuery.of(context).size,
                                  painter: WaveForm(0.6, 0.6),
                                ),
                              )
                            : const SizedBox(),
                        regularValue
                            ? Container(
                                margin: EdgeInsets.only(
                                    top: screenWidth * 0.55 * 0.8 * 0.5),
                                child: CustomPaint(
                                  size: MediaQuery.of(context).size,
                                  painter: WaveForm(0.2, 0.2),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: darkMode ? kGrey4 : kGrey8,
                        shape: BoxShape.circle,
                      ),
                    )
                ],
              ),
              const SizedBox(height: 15),
              Text(
                regularValue ? '소리를 듣고 있습니다...' : '상시모드가 꺼져있습니다.',
                style:
                    TextStyle(fontSize: kS, color: darkMode ? kGrey4 : kGrey8),
              ),
              const Spacer(),
            ],
          ),
          open
              ? Positioned(
                  left: 15,
                  right: 15,
                  bottom: 90,
                  child: Container(
                    width: screenWidth,
                    height: 120,
                    padding: const EdgeInsets.only(
                        top: 5, bottom: 12, left: 15, right: 15),
                    decoration: BoxDecoration(
                      color: darkMode
                          ? kGrey8.withOpacity(0.8)
                          : kWhite.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: darkMode ? kBlack : kBlack.withOpacity(0.1),
                          spreadRadius: 3,
                          blurRadius: 15,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '미확인 알림',
                              style: TextStyle(fontSize: kXS, color: kGrey5),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.close_rounded,
                                size: 20,
                                color: kGrey5,
                              ),
                              onPressed: () {
                                setState(() {
                                  open = !open;
                                });
                              },
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'SCBold',
                                fontSize: kS,
                                color: darkMode ? kWhite : kBlack,
                              ),
                              children: [
                                TextSpan(
                                    text: '사이렌 소리 ',
                                    style: TextStyle(fontSize: kL)),
                                const TextSpan(text: '(17시 20분)'),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '확인하셨나요?',
                              style: TextStyle(
                                  fontSize: kM,
                                  color: darkMode ? kWhite : kBlack),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                '네',
                                style: TextStyle(fontSize: kS, color: kMain),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 12),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                '아니오',
                                style: TextStyle(fontSize: kS, color: kGrey5),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
