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
  void initState() {
    super.initState();
    checked[selectedColor] = true;
  }

  @override
  Widget build(BuildContext context) {
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
          '화면 설정',
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
                      style: TextStyle(color: kGrey4, fontSize: kXS),
                    ),
                  ),
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
                          '다크 모드',
                          style: TextStyle(
                            fontSize: kS,
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
                      style: TextStyle(color: kGrey4, fontSize: kXS),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 12, left: 15, right: 10),
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
                          '글씨 크기',
                          style: TextStyle(
                            fontSize: kM,
                            color: darkMode ? kWhite : kBlack,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Text(
                              '$fontSize pt',
                              style: TextStyle(
                                fontSize: kS,
                                color: darkMode ? kWhite : kBlack,
                              ),
                            ),
                            const SizedBox(width: 10),
                            ToggleButtons(
                              isSelected: const [false, false],
                              color: kGrey5,
                              textStyle: TextStyle(fontSize: kM),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              constraints: const BoxConstraints(
                                  minWidth: 40, minHeight: 30),
                              borderColor: kGrey5,
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
                  Container(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '대표 색상',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: kGrey4, fontSize: kXS),
                    ),
                  ),
                  Container(
                    height: 140,
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
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: colorChart.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                                kMain = colorChart[index];
                                for (int i = 0; i < checked.length; i++) {
                                  if (i == index) {
                                    checked[i] = true;
                                  } else {
                                    checked[i] = false;
                                  }
                                }
                              });
                            },
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: checked[index]
                                        ? Border.all(color: kBlack, width: 2)
                                        : const Border(),
                                    color: colorChart[index],
                                  ),
                                ),
                                checked[index]
                                    ? Center(
                                        child: Icon(
                                          Icons.check_rounded,
                                          color: kBlack,
                                          size: 25,
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          );
                        }),
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
