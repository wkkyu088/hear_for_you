// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:hear_for_you/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hear For You',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        fontFamily: 'PretendardMedium',
      ),
      home: const RegularScreenTest(),
    );
  }
}

// Regular Mode
String path = '';
var recorderController;
var recordTimer;
var decibelTimer;

// 상시모드 켜기
void initRegularMode() async {
  print('--------------------- init regular mode');
  var dir = await getExternalStorageDirectory();
  path = "${dir!.path}/audio.wav";

  recorderController = RecorderController()
    ..androidEncoder = AndroidEncoder.aac
    ..androidOutputFormat = AndroidOutputFormat.mpeg4
    ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC;
  checkDecibel();
  repeatRecorder();
}

// 상시모드 끄기 - 데시벨체커
void disposeRegularMode() {
  print('--------------------- dispose regular mode');

  recorderController?.dispose();
  recordTimer?.cancel();
  decibelTimer?.cancel();
}

// 특정 데시벨 감지 후 저장
void save() async {
  var path = await recorderController.stop();
  print('--------------------- saved to $path');
}

// 1초마다 데시벨 구하기
Future<double?> _getDecibel() async =>
    await AudioWaveformsInterface.instance.getDecibel();

void checkDecibel() {
  decibelTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      var decibel = await _getDecibel();
      if (decibel == null) {
        throw "Failed to get sound level";
      }
      if (decibel > dB) {
        save();

        // 여기에 모델 코드 작성하기
        print('get classification');
      }
    },
  );
}

// n분마다 녹음 초기화 + 재시작
void repeatRecorder() {
  // // 재시작
  // if (regularValue) {
  //   recordTimer?.cancel();
  //   recorderController.stop();
  // } else {}

  recordTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    print(DateTime.now());
    save();
    await recorderController.record(path);
  });
}

class RegularScreenTest extends StatefulWidget {
  const RegularScreenTest({super.key});

  @override
  State<StatefulWidget> createState() => RegularScreenTestState();
}

class RegularScreenTestState extends State<RegularScreenTest> {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: (() {
            regularValue ? disposeRegularMode() : initRegularMode();
          }),
          child: Text(
            '상시보드 : $regularValue',
            style: TextStyle(fontSize: 30),
          ),
        ),
        Container(
            width: screenWidth * 0.55,
            height: screenWidth * 0.55,
            margin: const EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kMain, kMain.withOpacity(0.5)]),
            ),
            child: regularValue
                ? AudioWaveforms(
                    waveStyle: const WaveStyle(
                      waveColor: Colors.white,
                      spacing: 8.0,
                      extendWaveform: true,
                      showMiddleLine: false,
                    ),
                    size: Size(MediaQuery.of(context).size.width, 200.0),
                    recorderController: recorderController,
                  )
                : Container()),
        const SizedBox(height: 60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: darkMode ? kGrey4 : kGrey8,
                  shape: BoxShape.circle,
                ),
              )
          ],
        ),
        const SizedBox(height: 15),
        Text(
          regularValue ? '소리를 듣고 있습니다...' : '상시모드가 꺼져있습니다.',
          style: TextStyle(fontSize: kS, color: darkMode ? kGrey4 : kGrey8),
        ),
      ],
    ));
  }
}
