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
        color: darkMode ? Colors.grey[700] : Colors.grey[200],
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
                  fontSize: 17,
                  color: darkMode ? Colors.white : Colors.black,
                ),
              ),
              const Spacer(),
              Transform.scale(
                scale: 0.9,
                child: SizedBox(
                  height: 10,
                  child: CupertinoSwitch(
                    activeColor: cases[widget.num] ? kMain : Colors.grey,
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
                fontSize: 14,
                color: darkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Container(
            height: 120,
            color: darkMode ? Colors.grey[700] : Colors.grey[200],
            child: const Center(child: Text('예시 사진/그림')),
          ),
        ],
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
          '${caseTitle[widget.num]} 알림',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 10),
                margin: const EdgeInsets.only(bottom: 25),
                decoration: BoxDecoration(
                  color: darkMode ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Text(
                      cases[widget.num] ? '알림 끄기' : '알림 켜기',
                      style: TextStyle(
                        fontSize: 17,
                        color: darkMode ? Colors.white : Colors.black,
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
                  style: TextStyle(color: Colors.grey[400], fontSize: 13),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    top: 15, bottom: 15, left: 15, right: 10),
                decoration: BoxDecoration(
                  color: darkMode ? Colors.grey[850] : Colors.white,
                  borderRadius: BorderRadius.circular(15),
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
                    fontSize: 14,
                    height: 1.5,
                    color: darkMode ? Colors.white : Colors.black,
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
