import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/constants.dart';

class DisplaySetting extends StatefulWidget {
  const DisplaySetting({Key? key}) : super(key: key);

  @override
  State<DisplaySetting> createState() => _DisplaySettingState();
}

class _DisplaySettingState extends State<DisplaySetting> {
  @override
  Widget build(BuildContext context) {
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
          '화면 설정',
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
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '화면 스타일',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    ),
                  ),
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
                          '다크 모드',
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
                              value: darkMode,
                              onChanged: (bool value) {
                                darkMode = value;
                                setState(() {
                                  darkMode = value;
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
                      '글씨',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey[400], fontSize: 13),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 12, left: 15, right: 10),
                    margin: const EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      color: darkMode ? Colors.grey[850] : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        Text(
                          '글씨 크기',
                          style: TextStyle(
                            fontSize: 17,
                            color: darkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '$fontSize pt',
                              style: TextStyle(
                                fontSize: 16,
                                color: darkMode ? Colors.white : Colors.black,
                              ),
                            ),
                            const SizedBox(width: 10),
                            ToggleButtons(
                              isSelected: const [false, false],
                              color: Colors.grey,
                              textStyle: const TextStyle(fontSize: 17),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              constraints: const BoxConstraints(
                                  minWidth: 40, minHeight: 30),
                              borderColor: Colors.grey,
                              borderRadius: BorderRadius.circular(30),
                              children: const [Text('-'), Text('+')],
                              onPressed: (index) {
                                setState(() {
                                  if (index == 0) {
                                    fontSize -= 1;
                                  } else {
                                    fontSize += 1;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
