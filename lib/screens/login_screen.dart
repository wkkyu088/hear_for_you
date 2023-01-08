import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/main.dart';
import 'package:hear_for_you/screens/tutorial_screen.dart';
import 'package:hear_for_you/service/full_screen_alert/view/alarm_observer.dart';
import 'package:hear_for_you/widgets/profile_modal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isOpen = false;
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    regularValue = false;
    name = name;
    profileValue = profileValue;
    regularValue = false;
    dB = 60;
    darkMode = false;
    selectedColor = 7;
    fontSizes = [false, true, false];
    fontSizeId = 1;
    cases = [true, true, true];
    caseDetails = [
      [true, true, true],
      [true, true, true],
      [true, true, true]
    ];

    super.initState();
  }

  static setProfile(String name, int profileValue) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('name', name);
    await pref.setInt('profileValue', profileValue);
    await pref.setBool('regularValue', false);
    await pref.setDouble('dB', 60);
    await pref.setBool('darkMode', false);
    await pref.setInt('selectedColor', 7);
    await pref.setInt('fontSizeId', 1);
    await pref.setBool('case1', true);
    await pref.setBool('case2', true);
    await pref.setBool('case3', true);
    await pref.setBool('case1detail1', true);
    await pref.setBool('case1detail2', true);
    await pref.setBool('case1detail3', true);
    await pref.setBool('case2detail1', true);
    await pref.setBool('case2detail2', true);
    await pref.setBool('case2detail3', true);
    await pref.setBool('case3detail1', true);
    await pref.setBool('case3detail2', true);
    await pref.setBool('case3detail3', true);

    name = name;
    profileValue = profileValue;
    regularValue = false;
    dB = 60;
    darkMode = false;
    selectedColor = 7;
    fontSizes = [false, true, false];
    fontSizeId = 1;
    cases = [true, true, true];
    caseDetails = [
      [true, true, true],
      [true, true, true],
      [true, true, true]
    ];
    kMain = colorChart[selectedColor];
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: darkMode ? kBlack : kGrey1,
      systemNavigationBarIconBrightness:
          darkMode ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: darkMode ? Brightness.dark : Brightness.light,
    ));

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.5,
                padding: EdgeInsets.only(
                    top: isOpen ? 50 : 150, bottom: isOpen ? 0 : 50),
                child: Image.asset('lib/assets/images/splash_image.png'),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: isOpen ? 0 : 50),
                  width: screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Text(
                          "이름",
                          style: TextStyle(fontSize: kM),
                        ),
                      ),
                      Focus(
                        onFocusChange: (focused) {
                          setState(() {
                            isOpen = focused ? true : false;
                          });
                        },
                        child: TextField(
                          controller: textController,
                          style: TextStyle(
                              fontSize: kS, color: darkMode ? kWhite : kBlack),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: darkMode ? kBlack : kGrey1,
                            hintText: "이름을 입력하세요",
                            hintStyle: TextStyle(fontSize: kL, color: kGrey4),
                            counterText: "",
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: darkMode ? kWhite : kBlack),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kGrey4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        child: Row(
                          children: [
                            Text(
                              "장애정도",
                              style: TextStyle(fontSize: kM),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.help_rounded,
                                color: colorChart[7],
                                size: 20,
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              constraints: const BoxConstraints(),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: kGrey4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                profileItems[profileValue],
                                style: TextStyle(
                                  fontSize: kL,
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                size: 22,
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
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: screenWidth,
              padding: EdgeInsets.only(
                  bottom: isOpen ? 15 : 30, left: 20, right: 20),
              child: TextButton(
                onPressed: () async {
                  if (textController.text != "") {
                    name = textController.text;
                    setProfile(name, profileValue);
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TutorialScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                style: TextButton.styleFrom(
                  primary: kWhite,
                  backgroundColor: colorChart[7],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  minimumSize: Size(screenWidth - 50, 60),
                ),
                child: Text(
                  "시작하기",
                  style: TextStyle(fontFamily: 'PretendardBold', fontSize: kXL),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
