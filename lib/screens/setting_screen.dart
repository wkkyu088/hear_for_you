import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/screens/settings/decibel_setting.dart';
import 'package:hear_for_you/screens/settings/display_setting.dart';
import 'package:hear_for_you/screens/settings/notification_setting.dart';
import 'package:hear_for_you/widgets/profile_modal.dart';
import 'package:hear_for_you/constants.dart';

// CupertinoSwitch(
//   activeColor: kMain,
//   value: cases[0],
//   onChanged: (bool value) {
//     setState(() {
//       cases[0] = value;
//     });
//   },
// ),

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String name = '오희정';
  final items = [
    "중증 청각장애 (2~3급)",
    "경증 청각장애 (4~6급)",
    "청각중복장애 (시각 등)",
    "직접 설정",
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    TextStyle settingTitleStyle = TextStyle(
      fontFamily: 'SCBold',
      fontSize: 18,
      color: darkMode ? Colors.white : Colors.black,
    );

    Widget spacer(margin) {
      return Container(
        margin: margin,
        height: 1,
        color: darkMode ? Colors.grey[800] : Colors.grey[200],
      );
    }

    Widget customCard(title, child, padding) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.grey[400], fontSize: 13),
            ),
          ),
          Container(
            padding: padding,
            margin: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              color: darkMode ? Colors.grey[850] : Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: child,
          ),
        ],
      );
    }

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
          primary: Colors.grey,
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
      backgroundColor: darkMode ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle:
              darkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: Icon(
              Icons.close_rounded,
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
            '설정',
            style: TextStyle(
              fontFamily: 'SCBold',
              fontSize: 22,
              color: darkMode ? Colors.white : Colors.black,
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customCard(
                '개인 설정',
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'SCBold', fontSize: 25, color: kMain),
                        ),
                        Text(
                          ' 님',
                          style: TextStyle(
                            fontFamily: 'SCBold',
                            fontSize: 22,
                            color: darkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                        child: Container(
                          color: darkMode ? Colors.grey[850] : Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                items[profileValue],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: darkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 22,
                                color: darkMode ? Colors.white : Colors.black,
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      profileModalBuilder(context))
                              .then((value) => setState(() {}));
                        }),
                  ],
                ),
                const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              ),
              customCard(
                '상시모드 설정',
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 8),
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
                                      fontFamily: 'SCBold',
                                      fontSize: 18,
                                      color: kMain),
                                )
                              : const Text(
                                  '꺼짐',
                                  style: TextStyle(
                                      fontFamily: 'SCBold',
                                      fontSize: 18,
                                      color: Colors.grey),
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
                    spacer(const EdgeInsets.only(bottom: 5)),
                    settingItem(
                      Text(
                        '데시벨 설정',
                        style: settingTitleStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            dB.toString(),
                            style: TextStyle(fontSize: 18, color: kMain),
                          ),
                          Text(
                            ' dB',
                            style: TextStyle(
                              fontSize: 18,
                              color: darkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const DecibelSetting(),
                    ),
                  ],
                ),
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              customCard(
                '알림 설정',
                Column(
                  children: [
                    settingItem(
                      Text(caseTitle[0], style: settingTitleStyle),
                      Row(
                        children: [
                          Text(
                            cases[0] ? '켬' : '끔',
                            style: TextStyle(
                              fontSize: 18,
                              color: cases[0] ? kMain : Colors.grey,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const NotificationSetting(num: 0),
                    ),
                    spacer(const EdgeInsets.only(bottom: 5)),
                    settingItem(
                      Text(caseTitle[1], style: settingTitleStyle),
                      Row(
                        children: [
                          Text(
                            cases[1] ? '켬' : '끔',
                            style: TextStyle(
                              fontSize: 18,
                              color: cases[1] ? kMain : Colors.grey,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const NotificationSetting(num: 1),
                    ),
                    spacer(const EdgeInsets.only(bottom: 5)),
                    settingItem(
                      Text(caseTitle[2], style: settingTitleStyle),
                      Row(
                        children: [
                          Text(
                            cases[2] ? '켬' : '끔',
                            style: TextStyle(
                              fontSize: 18,
                              color: cases[2] ? kMain : Colors.grey,
                            ),
                          ),
                          const Icon(Icons.chevron_right_rounded, size: 22)
                        ],
                      ),
                      const NotificationSetting(num: 2),
                    ),
                  ],
                ),
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
              customCard(
                '기타 설정',
                settingItem(
                  Text(
                    '화면 설정',
                    style: settingTitleStyle,
                  ),
                  const Icon(Icons.chevron_right_rounded, size: 22),
                  const DisplaySetting(),
                ),
                const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
