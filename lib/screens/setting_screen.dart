import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/widgets/profile_modal.dart';
import 'package:hear_for_you/constants.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String name = '오희정';
  double dB = 70;
  List<bool> cases = [true, false, false];
  List<String> caseTitle = ['긴급 재난', '실외 위험', '실내 위험'];
  List<List<bool>> details = [
    [true, false, true],
    [false, true, true],
    [false, false, true]
  ];
  List<String> detailTitle = ['진동 알림', '플래시 알림', '전체화면 알림'];
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

    TextStyle settingTitleStyle = const TextStyle(
        fontFamily: 'SCBold', fontSize: 20, color: Colors.black);
    TextStyle settingDetailStyle =
        const TextStyle(fontSize: 16, color: Colors.black);
    TextStyle settingTityleValueStyle =
        TextStyle(fontFamily: 'SCBold', fontSize: 20, color: kMain);

    Widget spacer() {
      // return const SizedBox(height: 10);
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        height: 1,
        color: Colors.grey[100],
      );
    }

    Widget buttonItem(s, listValue) {
      return Container(
        width: screenWidth / 3 - 25,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Text(s, style: const TextStyle(fontSize: 14)),
      );
    }

    Widget customToggleButton(selectList, children) {
      return ToggleButtons(
          isSelected: selectList,
          onPressed: (int index) {
            setState(() {
              selectList[index] = !selectList[index];
            });
          },
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          constraints: const BoxConstraints(),
          selectedColor: Colors.white,
          color: Colors.grey,
          fillColor: kMain,
          borderColor: Colors.grey,
          selectedBorderColor: kMain,
          borderRadius: BorderRadius.circular(20),
          children: [
            buttonItem(children[0], selectList[0]),
            buttonItem(children[1], selectList[1]),
            buttonItem(children[2], selectList[2]),
          ]);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 0,
          title: const Text(
            '설정',
            style: TextStyle(
              fontFamily: 'SCBold',
              fontSize: 22,
            ),
          )),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'SCBold', fontSize: 28, color: kMain),
                  ),
                  const Text(
                    ' 님',
                    style: TextStyle(
                        fontFamily: 'SCBold',
                        fontSize: 26,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).restorablePush(profileModalBuilder);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      items[profileValue],
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: 25,
                    ),
                  ],
                ),
              ),
              spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '상시모드 ',
                    style: settingTitleStyle,
                  ),
                  regularValue
                      ? Text(
                          '켜짐',
                          style: settingTityleValueStyle,
                        )
                      : Text(
                          '꺼짐',
                          style: settingTityleValueStyle,
                        ),
                  const Spacer(),
                  CupertinoSwitch(
                      activeColor: kMain,
                      value: regularValue,
                      onChanged: (bool value) {
                        regularValue = value;
                        setState(() {
                          regularValue = value;
                        });
                      })
                ],
              ),
              spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '상시모드 데시벨 설정',
                    style: settingTitleStyle,
                  ),
                  const Spacer(),
                  Text(
                    dB.toString(),
                    style: settingTityleValueStyle,
                  ),
                  Text(
                    ' dB',
                    style: settingTitleStyle,
                  )
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.maxFinite,
                child: CupertinoSlider(
                  thumbColor: kMain,
                  activeColor: kMain,
                  min: 0.0,
                  max: 100.0,
                  divisions: 20,
                  value: dB,
                  onChanged: (value) {
                    value = value;
                    setState(() {
                      dB = value.roundToDouble();
                    });
                  },
                ),
              ),
              spacer(),
              Text(
                '상시모드 상황별 설정',
                style: settingTitleStyle,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(left: 5),
                height: MediaQuery.of(context).size.height * 0.5,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: 3,
                  itemBuilder: (context, i) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(caseTitle[i], style: settingTitleStyle),
                            CupertinoSwitch(
                              activeColor: kMain,
                              value: cases[i],
                              onChanged: (bool value) {
                                setState(() {
                                  cases[i] = value;
                                });
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        customToggleButton(details[i], detailTitle),
                        i == 3 ? const SizedBox() : const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
