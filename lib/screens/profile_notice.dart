import 'package:flutter/material.dart';
import 'package:hear_for_you/widgets/setting_appbar.dart';

import '../constants.dart';

class ProfileNotice extends StatelessWidget {
  const ProfileNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Text text(t) {
      return Text(t,
          style: TextStyle(fontSize: kS, height: 1.3, color: kBlack));
    }

    return Scaffold(
        backgroundColor: kGrey1,
        appBar: settingAppbar("장애정도 설정 안내", context),
        body: RawScrollbar(
          child: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  text("사용자별 들리는 정도에 맞추어 서비스를 제공하기 위해 장애정도 설정 기능을 제공합니다."),
                  text("\n각 장애 정도에 대한 설명입니다.\n(출처: 보건복지부 2019년 장애정도 판정기준)"),
                  const SizedBox(height: 10),
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: kGrey2,
                    ),
                    child: text("중증 청각장애 (1~3급)"),
                  ),
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: kGrey2),
                    ),
                    child: text(
                        "1.두 귀의 청력 손실이 각각 90데시벨(dB) 이상인 사람\n2.두 귀의 청력 손실이 각각 80데시벨(dB) 이상인 사람"),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: kGrey2,
                    ),
                    child: text("경증 청각장애 (4~6급)"),
                  ),
                  Container(
                    width: screenWidth,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: kGrey2),
                    ),
                    child: text(
                        "1.두 귀의 청력 손실이 각각 70데시벨(dB) 이상인 사람\n2.두 귀에 들리는 보통 말소리의 최대의 명료도가 50퍼센트 이하인 사람\n3.두 귀의 청력 손실이 각각 60데시벨(dB) 이상인 사람\n4.한 귀의 청력손실이 80데시벨(dB) 이상, 다른 귀의 청력 손실이 40데시벨(dB)이상인 사람"),
                  ),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'PretendardMedium',
                        fontSize: kS,
                        color: kBlack,
                      ),
                      children: [
                        const TextSpan(text: '\n중증 청각장애의 경우 초기 데시벨 기준이 '),
                        TextSpan(
                          text: '60 dB',
                          style: TextStyle(
                            fontFamily: 'PretendardBold',
                            fontSize: kS,
                            color: colorChart[7],
                          ),
                        ),
                        const TextSpan(text: '로 설정되고, 경증 청각장애의 경우 '),
                        TextSpan(
                          text: '80 dB',
                          style: TextStyle(
                            fontFamily: 'PretendardBold',
                            fontSize: kS,
                            color: colorChart[7],
                          ),
                        ),
                        const TextSpan(text: '로 설정됩니다.'),
                      ],
                    ),
                  ),
                  text("\n해당 설정은 모두 앱 내의 설정 탭에서 변경 가능합니다."),
                  text(
                      "\n설정 관련하여 도움이 필요하시거나 다른 문의 사항이 있으시다면 peoples221120@gmail.com을 통해 이메일을 보내주시기 바랍니다."),
                ],
              ),
            ),
          ),
        ));
  }
}
