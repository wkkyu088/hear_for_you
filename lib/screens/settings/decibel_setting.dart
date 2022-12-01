import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  List data = [
    [140, '비행기 이착륙, 폭죽 소리', Colors.red[400]],
    [120, '록 콘서트, 전동 드릴', Colors.deepOrange[400]],
    [115, '아기 울음소리', Colors.orange[400]],
    [110, '앰뷸런스 소리, 헬리콥터', Colors.yellow[600]],
    [110, '전차가 지나가는 다리 밑', Colors.lime[400]],
    [100, '자동차 경적, 전기톱 소리', Colors.lightGreen[400]],
    [90, '지하철, 자동차 소음, 공장 소음', Colors.lightGreen[600]],
    [80, '철도변, 진공청소기', Colors.green[400]],
    [70, '매미 소리, 도로변 소음', Colors.teal[400]],
    [60, '빗소리, 세탁기, 전화벨', Colors.blue[400]],
    [40, '조용한 방, 일반적인 대화', Colors.indigo[400]],
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
                        divisions: 29,
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
                    fontFamily: 'PretendardMedium',
                    fontSize: kS,
                    color: darkMode ? kWhite : kBlack,
                  ),
                  children: [
                    const TextSpan(text: '데시벨이 '),
                    TextSpan(
                      text: '$dB dB',
                      style: TextStyle(
                        fontFamily: 'PretendardBold',
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
                  itemCount: 11,
                  itemBuilder: ((context, index) {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 80,
                              height: 40,
                              color: dB > data[index][0]
                                  ? kGrey5.withOpacity(0.5)
                                  : data[index][2].withOpacity(0.9),
                              child: Center(
                                child: Text(
                                  '${data[index][0]} dB',
                                  style: TextStyle(
                                    fontSize: kL,
                                    color: kWhite,
                                    fontFamily: 'PretendardBold',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth - 36 - 80,
                              height: 40,
                              color: dB > data[index][0]
                                  ? kGrey5.withOpacity(0.1)
                                  : data[index][2].withOpacity(0.1),
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                data[index][1],
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
