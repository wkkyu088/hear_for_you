import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

class DecibelSetting extends StatefulWidget {
  const DecibelSetting({Key? key}) : super(key: key);

  @override
  State<DecibelSetting> createState() => _DecibelSettingState();
}

class _DecibelSettingState extends State<DecibelSetting> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

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

    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            darkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 25,
            color: darkMode ? Colors.white : Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          '데시벨 설정',
          style: TextStyle(
            fontFamily: 'SCBold',
            fontSize: 20,
            color: darkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  '데시벨',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: darkMode ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.volume_mute_rounded,
                      size: 25,
                      color: darkMode ? Colors.white : Colors.black,
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
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'SCMedium',
                    fontSize: 16,
                    color: darkMode ? Colors.white : Colors.black,
                  ),
                  children: [
                    const TextSpan(text: '데시벨이 '),
                    TextSpan(
                      text: '$dB dB',
                      style: TextStyle(
                        fontFamily: 'SCBold',
                        fontSize: 16,
                        color: kMain,
                      ),
                    ),
                    const TextSpan(text: ' 이상이면 알림을 줍니다.'),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '부가 설명?',
                style: TextStyle(
                  fontSize: 14,
                  color: darkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
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
                                  ? Colors.grey.withOpacity(0.5)
                                  : colors[index].withOpacity(0.9),
                              child: Center(
                                child: Text(
                                  '${decibels[index]} dB',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'SCBold',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: screenWidth - 40 - 80,
                              height: 35,
                              color: dB > decibels[index]
                                  ? Colors.grey.withOpacity(0.1)
                                  : colors[index].withOpacity(0.1),
                              padding: const EdgeInsets.only(left: 10),
                              alignment: Alignment.centerLeft,
                              child: Text(
                                contents[index],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: darkMode ? Colors.white : Colors.black,
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
