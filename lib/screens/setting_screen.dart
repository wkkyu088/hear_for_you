import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/screens/settings/decibel_setting.dart';
import 'package:hear_for_you/screens/settings/display_setting.dart';
import 'package:hear_for_you/screens/settings/notification_setting.dart';
import 'package:hear_for_you/widgets/custom_card.dart';
import 'package:hear_for_you/widgets/profile_modal.dart';
import 'package:hear_for_you/constants.dart';
import 'package:hear_for_you/widgets/setting_appbar.dart';

// 설정 페이지

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    // 설정 타이틀의 스타일
    TextStyle settingTitleStyle = TextStyle(
      fontFamily: 'PretendardBold',
      fontSize: kM,
      color: darkMode ? kWhite : kBlack,
    );

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
            title,
            const Spacer(),
            action,
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      // 1. 앱바
      appBar: settingAppbar('설정', context, isLeading: false),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 18),
          margin: const EdgeInsets.only(bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. 개인 설정 영역
              customCard(
                '개인 설정',
                Column(
                  children: [
                    // 2-1. 사용자 이름
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontFamily: 'PretendardBold',
                            fontSize: kXL + 3,
                            color: kMain,
                          ),
                        ),
                        Text(
                          ' 님',
                          style: TextStyle(
                            fontFamily: 'PretendardBold',
                            fontSize: kXL,
                            color: darkMode ? kWhite : kBlack,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // 2-2. 사용자 장애 정도 설정
                    GestureDetector(
                      child: Container(
                        color: darkMode ? kGrey9 : kWhite,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              profileItems[profileValue],
                              style: TextStyle(
                                fontSize: kS,
                                color: darkMode ? kWhite : kBlack,
                              ),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 22,
                              color: darkMode ? kWhite : kBlack,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) =>
                                profileModalBuilder(context)).then(
                          (value) => setState(() {}),
                        );
                      },
                    ),
                  ],
                ),
                const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
              ),
              // 3. 상시모드 설정 영역
              customCard(
                '상시모드 설정',
                Column(
                  children: [
                    // 3-1. 상시모드 켜짐, 꺼짐 + 스위치
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 8),
                      child: Row(
                        children: [
                          Text(
                            '상시모드 ',
                            style: settingTitleStyle,
                          ),
                          regularValue
                              ? Text(
                                  '켜짐',
                                  style: TextStyle(
                                    fontFamily: 'PretendardBold',
                                    fontSize: kM,
                                    color: kMain,
                                  ),
                                )
                              : Text(
                                  '꺼짐',
                                  style: TextStyle(
                                    fontFamily: 'PretendardBold',
                                    fontSize: kM,
                                    color: kGrey5,
                                  ),
                                ),
                          const Spacer(),
                          Transform.scale(
                            scale: 0.9,
                            child: SizedBox(
                              height: 10,
                              child: CupertinoSwitch(
                                activeColor: kMain,
                                value: regularValue,
                                onChanged: (bool value) {
                                  regularValue = value;
                                  setState(() {
                                    regularValue = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    spacer(const EdgeInsets.only(bottom: 2)),
                    // 3-2. 데시벨 설정 페이지로 이동
                    settingItem(
                      Text(
                        '데시벨 설정',
                        style: settingTitleStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            dB.toString(),
                            style: TextStyle(fontSize: kM, color: kMain),
                          ),
                          Text(
                            ' dB',
                            style: TextStyle(
                              fontSize: kM,
                              color: darkMode ? kWhite : kBlack,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const DecibelSetting(),
                    ),
                  ],
                ),
                const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              ),
              // 4. 알림 설정 영역
              customCard(
                '알림 설정',
                Column(
                  children: [
                    // 4-1. case0, 긴급재난 알림 페이지로 이동 + 켬, 끔 표시
                    settingItem(
                      Text(caseTitle[0], style: settingTitleStyle),
                      Row(
                        children: [
                          Text(
                            cases[0] ? '켬' : '끔',
                            style: TextStyle(
                              fontSize: kM,
                              color: cases[0] ? kMain : kGrey5,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const NotificationSetting(num: 0),
                    ),
                    spacer(const EdgeInsets.only(bottom: 5)),
                    // 4-2. case1, 실외위험 알림 페이지로 이동 + 켬, 끔 표시
                    settingItem(
                      Text(caseTitle[1], style: settingTitleStyle),
                      Row(
                        children: [
                          Text(
                            cases[1] ? '켬' : '끔',
                            style: TextStyle(
                              fontSize: kM,
                              color: cases[1] ? kMain : kGrey5,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const NotificationSetting(num: 1),
                    ),
                    spacer(const EdgeInsets.only(bottom: 5)),
                    // 4-3. case2, 실내위험 알림 페이지로 이동 + 켬, 끔 표시
                    settingItem(
                      Text(caseTitle[2], style: settingTitleStyle),
                      Row(
                        children: [
                          Text(
                            cases[2] ? '켬' : '끔',
                            style: TextStyle(
                              fontSize: kM,
                              color: cases[2] ? kMain : kGrey5,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const NotificationSetting(num: 2),
                    ),
                  ],
                ),
                const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              ),
              // 5. 화면 설정 영역
              customCard(
                '기타 설정',
                // 5-1. 화면 설정 페이지로 이동
                settingItem(
                  Text(
                    '화면 설정',
                    style: settingTitleStyle,
                  ),
                  const Icon(Icons.chevron_right_rounded, size: 22),
                  const DisplaySetting(),
                ),
                const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
