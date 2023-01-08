import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/constants.dart';
import 'package:hear_for_you/main.dart';
import 'package:hear_for_you/widgets/custom_card.dart';
import 'package:hear_for_you/widgets/custom_dialog.dart';
import 'package:hear_for_you/widgets/setting_appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 화면 설정 페이지

class DisplaySetting extends StatefulWidget {
  const DisplaySetting({Key? key}) : super(key: key);

  @override
  State<DisplaySetting> createState() => _DisplaySettingState();
}

class _DisplaySettingState extends State<DisplaySetting> {
  // 현재 선택되어 있는 메인 색상 표시
  @override
  initState() {
    super.initState();
    for (int i = 0; i < checked.length; i++) {
      if (i == selectedColor) {
        checked[i] = true;
      } else {
        checked[i] = false;
      }
    }
  }

  static void setDarkMode(bool darkMode) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('darkMode', darkMode);
    print("darkMode changed! : $darkMode");
  }

  static void setSelectedColor(int selectedColor) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('selectedColor', selectedColor);
    print("selectedColor changed! : $selectedColor");
  }

  static void setFontSizeId(int fontSizeId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('fontSizeId', fontSizeId);
    print("fontSize changed! $fontSizeId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      // 1. 앱바
      appBar: settingAppbar('화면 설정', context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 2. 화면 스타일 설정 영역
              customCard(
                '화면 스타일',
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return twoButtonDialog(
                          context,
                          "화면 설정",
                          darkMode ? "다크모드를 해제합니다." : "다크모드를 설정합니다.",
                          "취소",
                          "확인",
                          () {
                            Navigator.pop(context);
                          },
                          () {
                            setState(() {
                              darkMode = !darkMode;
                              setDarkMode(darkMode);
                              SystemChrome.setSystemUIOverlayStyle(
                                  SystemUiOverlayStyle(
                                systemNavigationBarColor:
                                    darkMode ? kBlack : kGrey1,
                                systemNavigationBarDividerColor:
                                    Colors.transparent,
                                systemNavigationBarIconBrightness: darkMode
                                    ? Brightness.light
                                    : Brightness.dark,
                                statusBarColor: Colors.transparent,
                                statusBarIconBrightness: darkMode
                                    ? Brightness.light
                                    : Brightness.dark,
                                statusBarBrightness: darkMode
                                    ? Brightness.dark
                                    : Brightness.light,
                              ));
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavBar(selectedIndex: 1)));
                            });
                          },
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        '다크 모드',
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
                            value: darkMode,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 10),
              ),
              // 3. 글씨 크기 설정 영역
              customCard(
                '글씨 크기',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                            ToggleButtons(
                              isSelected: fontSizes,
                              color: kGrey5,
                              selectedColor: kWhite,
                              fillColor: kMain,
                              textStyle: const TextStyle(
                                  fontFamily: 'PretendardMedium'),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              constraints: const BoxConstraints(
                                  minWidth: 65, minHeight: 45),
                              borderColor: kGrey4,
                              selectedBorderColor: kMain,
                              borderRadius: BorderRadius.circular(10),
                              children: const [
                                Text(
                                  '작게',
                                  style: TextStyle(fontSize: 13),
                                ),
                                Text(
                                  '보통',
                                  style: TextStyle(fontSize: 17),
                                ),
                                Text(
                                  '크게',
                                  style: TextStyle(fontSize: 21),
                                )
                              ],
                              onPressed: (index) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return twoButtonDialog(
                                      context,
                                      "화면 설정",
                                      "폰트 사이즈를 변경합니다.",
                                      "취소",
                                      "확인",
                                      () {
                                        Navigator.pop(context);
                                      },
                                      () async {
                                        setState(() {
                                          for (int i = 0; i < 3; i++) {
                                            if (i == index) {
                                              fontSizes[i] = true;
                                              setFontSizeId(i);
                                            } else {
                                              fontSizes[i] = false;
                                            }
                                          }
                                        });
                                        final confirmed = await showDialog(
                                            context: context,
                                            builder: (context) {
                                              return oneButtonDialog(
                                                  context,
                                                  "폰트 크기 설정",
                                                  "폰트 크기 설정은\n앱을 완전히 껐다 켜면 적용됩니다.",
                                                  "확인", () {
                                                Navigator.pop(context, true);
                                              });
                                            });
                                        if (confirmed) {
                                          if (!mounted) return;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      BottomNavBar(
                                                          selectedIndex: 1)));
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      "⚠️ 앱을 껐다 켜면 적용됩니다.",
                      style: TextStyle(fontSize: 13, color: kMain),
                    ),
                  ],
                ),
                const EdgeInsets.only(top: 12, bottom: 12, left: 15, right: 10),
              ),
              // 4. 대표 색상 설정 영역
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
                height: 130,
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: colorChart.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return twoButtonDialog(
                              context,
                              "화면 설정",
                              "메인 색상을 변경합니다.",
                              "취소",
                              "확인",
                              () {
                                Navigator.pop(context);
                              },
                              () {
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
                                  setSelectedColor(selectedColor);
                                });
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BottomNavBar(selectedIndex: 1)));
                              },
                            );
                          },
                        );
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
