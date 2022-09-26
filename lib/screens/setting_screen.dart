import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hear_for_you/widgets/profile.modal.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

TextStyle settingTitleStyle = const TextStyle(
    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black);
TextStyle settingTityleValueStyle = const TextStyle(
    fontSize: 25, fontWeight: FontWeight.bold, color: Colors.orange);

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    String name = '000';
    double dB = 70;
    double value = 20;
    bool regularValue = true;
    List<bool> cases = [true, false, false];

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                size: 30,
              ),
              onPressed: () {},
            ),
            centerTitle: true,
            elevation: 0,
            title: const Text(
              '설정',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('$name 님',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange)),
                    IconButton(
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .restorablePush(profileModalBuilder);
                        })
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
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
                        activeColor: Colors.orange,
                        value: regularValue,
                        onChanged: (bool value) {
                          setState(() {
                            regularValue = value;
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '상시모드 데시벨 설정',
                      style: settingTitleStyle,
                    ),
                    const Spacer(),
                    Text(
                      value.toString(),
                      style: settingTityleValueStyle,
                    ),
                    Text(
                      ' dB',
                      style: settingTitleStyle,
                    )
                  ],
                ),
                Container(
                  width: double.maxFinite,
                  child: CupertinoSlider(
                    thumbColor: Colors.orange,
                    activeColor: Colors.orange,
                    min: 0.0,
                    max: 100.0,
                    value: dB,
                    onChanged: (value) {
                      setState(() {
                        value = value.roundToDouble();
                      });
                    },
                  ),
                ),
                Text(
                  '상시모드 상황별 설정',
                  style: settingTitleStyle,
                ),
                Container(
                    padding: EdgeInsets.only(left: 25),
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 3,
                        itemBuilder: (context, i) {
                          return Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('상황', style: settingTitleStyle),
                                CupertinoSwitch(
                                    activeColor: Colors.orange,
                                    value: cases[i],
                                    onChanged: (bool value) {
                                      setState(() {
                                        cases[i] = value;
                                      });
                                    })
                              ],
                            ),
                            Container(
                              height: 80,
                            )
                          ]);
                        }))
              ],
            )));
  }
}
