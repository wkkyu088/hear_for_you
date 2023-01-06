import 'package:flutter/material.dart';
import 'package:hear_for_you/screens/login_screen.dart';
import 'package:hear_for_you/widgets/custom_card.dart';
import 'package:hear_for_you/widgets/custom_dialog.dart';
import 'package:hear_for_you/widgets/setting_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

class DataSetting extends StatefulWidget {
  const DataSetting({Key? key}) : super(key: key);

  @override
  State<DataSetting> createState() => _DataSettingState();
}

class _DataSettingState extends State<DataSetting> {
  @override
  Widget build(BuildContext context) {
    // 설정 타이틀의 스타일
    TextStyle settingTitleStyle(color) {
      return TextStyle(
        fontFamily: 'PretendardBold',
        fontSize: kM,
        color: color,
      );
    }

    Icon chevronIcon =
        Icon(Icons.chevron_right_rounded, size: 22, color: kGrey5);

    // 각 설정 목록, 누르면 해당 페이지로 이동
    Widget settingItem(title, action, screen) {
      return TextButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => screen))
              .then((value) => setState(
                    () {},
                  ));
        },
        style: TextButton.styleFrom(
          primary: kGrey5,
        ),
        child: Row(
          children: [
            Text(title, style: settingTitleStyle(darkMode ? kWhite : kBlack)),
            const Spacer(),
            action,
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      appBar: settingAppbar('정보', context),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            customCard(
              '',
              Column(
                children: [
                  settingItem(
                    '이용 약관',
                    chevronIcon,
                    null,
                  ),
                  spacer(const EdgeInsets.only(bottom: 5)),
                  settingItem(
                    '개인정보 정책',
                    chevronIcon,
                    null,
                  ),
                  spacer(const EdgeInsets.only(bottom: 5)),
                  settingItem(
                    '만든 사람들',
                    chevronIcon,
                    null,
                  ),
                ],
              ),
              const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              nontitle: true,
            ),
            customCard(
              '',
              TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return twoButtonDialog(
                          context,
                          "잠시만요!",
                          "$name님의 모든 정보가 초기화됩니다.\n정말 삭제하시나요?",
                          "아니요",
                          "네, 삭제할래요",
                          () {
                            Navigator.of(context).pop();
                          },
                          () async {
                            // 모든 SharedPrefrences 초기화
                            final SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            pref.clear();

                            if (!mounted) return;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          isDelete: true,
                        );
                      });
                },
                style: TextButton.styleFrom(
                  primary: kGrey5,
                ),
                child: Row(
                  children: [
                    Text("내 정보 삭제", style: settingTitleStyle(Colors.red)),
                    const Spacer(),
                  ],
                ),
              ),
              const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              nontitle: true,
            ),
          ],
        ),
      ),
    );
  }
}
