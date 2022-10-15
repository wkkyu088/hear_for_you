import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants.dart';

class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key, required this.num}) : super(key: key);
  final int num;

  @override
  State<NotificationSetting> createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    Widget spacer() {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 15),
        height: 1,
        color: darkMode ? Colors.grey[700] : kGrey2,
      );
    }

    Widget noti(n, detail) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                    onChanged: cases[widget.num]
                        ? (bool value) {
                            caseDetails[widget.num][n] = value;
                            setState(() {
                              caseDetails[widget.num][n] = value;
                            });
                          }
                        : null,
                  ),
                ),
              ),
            ],
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

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            darkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left_rounded,
            size: 25,
            color: darkMode ? kWhite : kBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          '${caseTitle[widget.num]} 알림',
          style: TextStyle(
            fontFamily: 'SCBold',
            fontSize: kL,
            color: darkMode ? kWhite : kBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 10),
                margin: const EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                  color: darkMode ? kGrey9 : kWhite,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: darkMode ? kBlack : kBlack.withOpacity(0.05),
                      spreadRadius: 3,
                      blurRadius: 15,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
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
                          onChanged: (bool value) {
                            cases[widget.num] = value;
                            setState(() {
                              cases[widget.num] = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                alignment: Alignment.centerLeft,
                child: Text(
                  '알림 방법',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: kGrey4, fontSize: kXS),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 10),
                decoration: BoxDecoration(
                  color: darkMode ? kGrey9 : kWhite,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: darkMode ? kBlack : kBlack.withOpacity(0.05),
                      spreadRadius: 3,
                      blurRadius: 15,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    noti(0, '휴대폰 진동으로 알림을 줍니다.'),
                    spacer(),
                    noti(1, '휴대폰 플래시로 알림을 줍니다.'),
                    spacer(),
                    noti(2, '휴대폰에 전체 화면으로 알림을 줍니다.'),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
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
