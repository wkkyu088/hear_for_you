import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:hear_for_you/service/full_screen_alert/service/alarm_scheduler.dart';
import 'package:hear_for_you/widgets/missed_alert.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../service/flash_light.dart';
import '../service/full_screen_alert/provider/alarm_provider.dart';
import '../service/notification.dart';
import '../service/permission_check.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

import 'package:hear_for_you/modules/regular_module.dart' as rm;
// 상시모드 페이지

class RegularScreen extends StatefulWidget {
  const RegularScreen({Key? key}) : super(key: key);
  @override
  State<RegularScreen> createState() => RegularScreenState();
}

class RegularScreenState extends State<RegularScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation =
      Tween(begin: 0.0, end: 100.0).animate(controller);
  static bool needPopup = false;

  // 애니메이션 시작
  // ++ 12월 27일 알람설정 확인하는 부분도 추가 ++
  @override
  void initState() {
    super.initState();
    // 현재 안드로이드면
    if (Platform.isAndroid) {
      PermissionCheckClass.AndroidAlertPermissionCheck(context);
    } else {
      // ios라면
      PermissionCheckClass.IOSAlertPermissionCheck(context);
    }
    rm.setContext(context);
    controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    animation.addListener(() {
      setState(() {});
    });
  }

  // 애니메이션 종료
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      body: Stack(
        children: [
          Column(
            children: [
              // 1. 상시모드 상태 표시줄
              Padding(
                padding: EdgeInsets.only(
                    top: 5 + statusBarHeight, bottom: 5, left: 5, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 1-1. 도움말 버튼 (현재 임시로 알림 화면 연결)
                    IconButton(
                      icon: Icon(
                        Icons.help_rounded,
                        size: 24,
                        color: darkMode ? kWhite : kBlack,
                      ),
                      padding: const EdgeInsets.all(10),
                      onPressed: () async {
                        // 전체화면 알림
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const AlertScreen()));
                        DateTime now = DateTime.now();
                        DateTime time = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          now.hour,
                          now.minute,
                          now.second,
                        );
                        context.read<AlarmProvider>().setAlarm(time);
                        await AlarmScheduler.scheduleRepeatable(time);

                        // 안드로이드 notification + 플래시
                        showNotification("알림 제목", "알림이 왔습니다.");
                        FlashLight.startFlashLight(0);

                        // 커스텀 모달
                        // showDialog(
                        //     context: context,
                        //     builder: (BuildContext context) {
                        //       return customDialog("제목", "내용");
                        //     });

                        // 튜토리얼 페이지
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const TutorialScreen()));
                      },
                    ),
                    // 1-2. 상시모드 상태
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
                              fontFamily: 'PretendardBold',
                              color: darkMode ? kWhite : kBlack,
                            ),
                          ),
                          Text(
                            regularValue ? '켜짐' : '꺼짐',
                            style: TextStyle(
                              fontSize: kXL,
                              fontFamily: 'PretendardBold',
                              color: regularValue ? kMain : kGrey5,
                            ),
                          )
                        ],
                      ),
                    ),
                    // 1-3. 대칭 맞추기용 아이콘
                    IconButton(
                      icon: const Icon(
                        Icons.help_rounded,
                        size: 24,
                        color: Colors.transparent,
                      ),
                      padding: const EdgeInsets.all(15),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              // 2. 원형 회전 애니메이션
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  // 2-1. 애니메이션 외부 (실제 돌아가는 부분)
                  Container(
                    width: screenWidth * 0.7,
                    height: screenWidth * 0.7,
                    margin: const EdgeInsets.only(top: 60),
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
                  // 2-2. 애니메이션 내부 (웨이브폼이 그려져있는 이미지)
                  Container(
                    width: screenWidth * 0.55,
                    height: screenWidth * 0.55,
                    margin: const EdgeInsets.only(top: 60),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [kMain, kMain.withOpacity(0.5)]),
                    ),
                    // 2-2-1. 웨이브폼 (상시모드 상태에 따라 모양 달라짐)
                    // child: Stack(
                    //   children: [
                    //     CustomPaint(
                    //       size: MediaQuery.of(context).size,
                    //       painter: WaveForm(1, 1),
                    //     ),
                    //     regularValue
                    //         ? Container(
                    //             margin: EdgeInsets.only(
                    //                 top: screenWidth * 0.55 * 0.4 * 0.5),
                    //             child: CustomPaint(
                    //               size: MediaQuery.of(context).size,
                    //               painter: WaveForm(0.6, 0.6),
                    //             ),
                    //           )
                    //         : const SizedBox(),
                    //     regularValue
                    //         ? Container(
                    //             margin: EdgeInsets.only(
                    //                 top: screenWidth * 0.55 * 0.8 * 0.5),
                    //             child: CustomPaint(
                    //               size: MediaQuery.of(context).size,
                    //               painter: WaveForm(0.2, 0.2),
                    //             ),
                    //           )
                    //         : const SizedBox(),
                    //   ],
                    // ),
                    child: regularValue
                        ? AudioWaveforms(
                            waveStyle: WaveStyle(
                              waveColor: darkMode ? kBlack : kGrey1,
                              spacing: 10,
                              extendWaveform: true,
                              showMiddleLine: false,
                              scaleFactor: 10,
                            ),
                            size: Size(screenWidth * 0.55, screenWidth * 0.55),
                            recorderController: rm.recorderController,
                          )
                        : Container(),
                  )
                ],
              ),
              const SizedBox(height: 60),
              // 3. 소리를 듣고 있습니다. (큰 의미 없음, 보조 표식)
              regularValue
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Container(
                            color: darkMode ? kBlack : kGrey1,
                            child: LoadingAnimationWidget.waveDots(
                              color:
                                  darkMode ? kWhite : const Color(0xFF434343),
                              size: 30.0,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '소리를 듣고 있습니다',
                            style: TextStyle(
                              color:
                                  darkMode ? kWhite : const Color(0xFF434343),
                              fontSize: kXS,
                            ),
                          ),
                        ])
                  : const Text('상시모드가 꺼져있습니다.'),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         for (int i = 0; i < 5; i++)
              //           Container(
              //             width: 6,
              //             height: 6,
              //             margin: const EdgeInsets.all(3),
              //             decoration: BoxDecoration(
              //               color: darkMode ? kGrey4 : kGrey8,
              //               shape: BoxShape.circle,
              //             ),
              //           )
              //       ],
              //     ),
              //     const SizedBox(height: 15),
              //     Text(
              //       regularValue ? '소리를 듣고 있습니다...' : '상시모드가 꺼져있습니다.',
              //       style:
              //           TextStyle(fontSize: kS, color: darkMode ? kGrey4 : kGrey8),
              //     ),
              //     const Spacer(),
            ],
          ),
          // 4. 미확인 알림 팝업 자리
          missedAlertOpen
              ? MissedAlert(
                  title: '사이렌 소리',
                  time: DateTime(2022, 9, 7, 17, 30),
                )
              : Container(),
        ],
      ),
    );
  }
}
