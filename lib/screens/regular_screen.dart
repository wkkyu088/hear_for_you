import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hear_for_you/constants.dart';
import 'package:hear_for_you/screens/setting_screen.dart';
import 'package:hear_for_you/screens/voice_screen.dart';

class RegularScreen extends StatefulWidget {
  const RegularScreen({Key? key}) : super(key: key);
  @override
  State<RegularScreen> createState() => _RegularScreenState();
}

class _RegularScreenState extends State<RegularScreen> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    Widget waveForm(height) {
      return Container(
        width: 10,
        height: height,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black,
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const VoiceScreen(title: "voice")));
        },
        backgroundColor: Colors.black,
        elevation: 10.0,
        child: const Icon(
          Icons.mic_rounded,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: width,
            height: 450,
            color: kMain.withOpacity(0.1),
          ),
          Container(
            width: width,
            height: 550,
            color: kMain.withOpacity(0.1),
          ),
          Container(
            width: width,
            height: 650,
            color: kMain.withOpacity(0.1),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 200),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      waveForm(25),
                      waveForm(35),
                      waveForm(50),
                      waveForm(25),
                      waveForm(35),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '소리를 듣고 있습니다...',
                    style: TextStyle(
                      color: Color.fromARGB(255, 67, 67, 67),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
          backgroundColor: kMain.withOpacity(0.3),
          leading: IconButton(
            icon: const Icon(
              Icons.help_rounded,
              size: 30,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings_rounded,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingScreen()));
              },
            ),
          ],
          centerTitle: true,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '상시모드 ',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'SCBold',
                ),
              ),
              Text(
                '켜짐',
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'SCBold',
                  color: kMain,
                ),
              )
            ],
          )),
    );
  }
}
