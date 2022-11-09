import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/widgets/custom_card.dart';
import 'package:hear_for_you/widgets/setting_appbar.dart';

import '../../constants.dart';

// 데시벨 설정 페이지

class DecibelSetting extends StatefulWidget {
  const DecibelSetting({Key? key}) : super(key: key);

  @override
  State<DecibelSetting> createState() => _DecibelSettingState();
}

class _DecibelSettingState extends State<DecibelSetting> {
  List decibels = [
    140,
    125,
    120,
    115,
    110,
    105,
    100,
    95,
    90,
    85,
    70,
    60,
    40,
  ];
  List contents = [
    '비행기 이착륙, 총소리',
    '사이렌 소리, 폭죽 소리',
    '록 콘서트, 나이트 클럽',
    '아기 울음소리, 제트 스키',
    '스노우 모빌 (운전자 기준)',
    '헬리콥터',
    '헤드폰, 이어폰, 전기톱 소리',
    '오토바이',
    '도로 주행 중인 트럭, 잔디 깎는 기계',
    '청력 안전 기준',
    '진공 청소기 소리',
    '일반 대화, 설거지 소리',
    '조용한 방'
  ];
  List colors = [
    Colors.red[400],
    Colors.deepOrange[400],
    Colors.orange[400],
    Colors.amber[400],
    Colors.yellow[600],
    const Color(0xFFF5E665),
    Colors.lime[400],
    Colors.lightGreen[400],
    Colors.lightGreen[600],
    Colors.green[400],
    Colors.teal[400],
    Colors.blue[400],
    Colors.indigo[400],
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      // 1. 앱바
      appBar: settingAppbar('데시벨 설정', context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. 데시벨 설정 영역
              customCard(
                '데시벨',
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.volume_mute_rounded,
                      size: 25,
                      color: darkMode ? kWhite : kBlack,
                    ),
                    SizedBox(
                      width: screenWidth - 140,
                      child: CupertinoSlider(
                        thumbColor: kMain,
                        activeColor: kMain,
                        min: 0.0,
                        max: 145.0,
                        divisions: 145,
                        value: dB,
                        onChanged: (value) {
                          value = value;
                          setState(() {
                            dB = value.roundToDouble();
                          });
                        },
                      ),
                    ),
                    Icon(
                      Icons.volume_up_rounded,
                      size: 25,
                      color: darkMode ? kWhite : kBlack,
                    ),
                  ],
                ),
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              // 3. 현재 설정된 데시벨 출력
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'SCMedium',
                    fontSize: kS,
                    color: darkMode ? kWhite : kBlack,
                  ),
                  children: [
                    const TextSpan(text: '데시벨이 '),
                    TextSpan(
                      text: '$dB dB',
                      style: TextStyle(
                        fontFamily: 'SCBold',
                        fontSize: kS,
                        color: kMain,
                      ),
                    ),
                    const TextSpan(text: ' 이상이면 알림을 줍니다.'),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              // 4. 데시벨 설정 관련 부가 설명
              Text(
                '부가 설명?',
                style: TextStyle(
                  fontSize: kXS,
                  color: darkMode ? kWhite : kBlack,
                ),
              ),
              const SizedBox(height: 20),
              // 5. 설정된 데시벨 범위 색상 표
              SizedBox(
                height: 500,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 13,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 35,
                              color: dB > decibels[index]
                                  ? kGrey5.withOpacity(0.5)
                                  : colors[index].withOpacity(0.9),
                              child: Center(
                                child: Text(
                                  '${decibels[index]} dB',
                                  style: TextStyle(
                                    fontSize: kL,
                                    color: kWhite,
                                    fontFamily: 'SCBold',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth - 36 - 80,
                              height: 35,
                              color: dB > decibels[index]
                                  ? kGrey5.withOpacity(0.1)
                                  : colors[index].withOpacity(0.1),
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                contents[index],
                                style: TextStyle(
                                  fontSize: kS,
                                  color: darkMode ? kWhite : kBlack,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 3),
                      ],
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
