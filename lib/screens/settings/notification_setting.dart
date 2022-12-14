import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/service/permission_check.dart';
import 'package:hear_for_you/widgets/custom_card.dart';
import 'package:hear_for_you/widgets/setting_appbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';

// 알림 설정 페이지

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key, required this.num}) : super(key: key);
  final int num;

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  static void setCases(int n, bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('case${n + 1}', value);
    print("case${n + 1} changed! : $value");
  }

  static void setCaseDetails(int n, int m, bool value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('case${n + 1}detail${m + 1}', value);
    print("case${n + 1}Detail${m + 1} changed! : $value");
  }

  // 알림 방법 세가지 + 스위치 + 설명
  Widget noti(n, detail) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: cases[widget.num]
              ? () async {
                  if (n == 2) {
                    if (caseDetails[widget.num][n] == false) {
                      var result = await Permission.systemAlertWindow.isGranted;
                      if (result) {
                        setState(() {
                          caseDetails[widget.num][n] =
                              !caseDetails[widget.num][n];
                          setCaseDetails(
                              widget.num, n, caseDetails[widget.num][n]);
                        });
                      } else {
                        if (Platform.isAndroid) {
                          PermissionCheckClass
                              .AndroidSystemAlertWindowPermissionCheck(context);
                        }
                      }
                    } else {
                      setState(() {
                        caseDetails[widget.num][n] =
                            !caseDetails[widget.num][n];
                        setCaseDetails(
                            widget.num, n, caseDetails[widget.num][n]);
                      });
                    }
                  } else {
                    setState(() {
                      caseDetails[widget.num][n] = !caseDetails[widget.num][n];
                      setCaseDetails(widget.num, n, caseDetails[widget.num][n]);
                    });
                  }
                }
              : null,
          child: Row(
            children: [
              Text(
                detailTitle[n],
                style: TextStyle(
                  fontSize: kM,
                  color: darkMode ? kWhite : kBlack,
                ),
              ),
              const Spacer(),
              Transform.scale(
                scale: 0.9,
                child: SizedBox(
                  height: 10,
                  child: CupertinoSwitch(
                    activeColor: cases[widget.num] ? kMain : kGrey5,
                    value: caseDetails[widget.num][n],
                    onChanged: (value) {},
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            detail,
            style: TextStyle(
              fontSize: kXS,
              color: darkMode ? kWhite : kBlack,
            ),
          ),
        ),
        Container(
          height: 120,
          color: darkMode ? Colors.grey[700] : kGrey2,
          child: const Center(child: Text('예시 사진/그림')),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      // 1. 앱바
      appBar: settingAppbar('${caseTitle[widget.num]} 알림', context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 2. 알림 끄기, 켜기 설정 영역
              customCard(
                '',
                InkWell(
                  onTap: () async {
                    setState(() {
                      cases[widget.num] = !cases[widget.num];
                      setCases(widget.num, cases[widget.num]);
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        cases[widget.num] ? '알림 끄기' : '알림 켜기',
                        style: TextStyle(
                          fontSize: kM,
                          color: darkMode ? kWhite : kBlack,
                        ),
                      ),
                      const Spacer(),
                      Transform.scale(
                        scale: 0.9,
                        child: SizedBox(
                          height: 10,
                          child: CupertinoSwitch(
                            activeColor: kMain,
                            value: cases[widget.num],
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 10),
                nontitle: true,
              ),
              // 3. 알림 방법 설정 영역
              customCard(
                '알림 방법',
                Column(
                  children: [
                    noti(0, '휴대폰 진동으로 알림을 줍니다.'),
                    spacer(const EdgeInsets.symmetric(vertical: 15)),
                    noti(1, '휴대폰 플래시로 알림을 줍니다.'),
                    Platform.isAndroid
                        ? spacer(const EdgeInsets.symmetric(vertical: 15))
                        : Container(),
                    Platform.isAndroid
                        ? noti(2, '휴대폰에 전체 화면으로 알림을 줍니다.')
                        : Container(),
                  ],
                ),
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 10),
              ),
              // 4. 알림 분류 부가 설명
              Container(
                padding: const EdgeInsets.only(
                    top: 10, bottom: 20, left: 10, right: 10),
                child: Text(
                  caseContents[widget.num],
                  style: TextStyle(
                    fontSize: kXS,
                    height: 1.5,
                    color: darkMode ? kWhite : kBlack,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
