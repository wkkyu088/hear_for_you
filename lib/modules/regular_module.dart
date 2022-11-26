// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:noise_meter/noise_meter.dart';

import '../constants.dart';

class RegularScreenTest extends StatefulWidget {
  const RegularScreenTest({super.key});

  @override
  State<StatefulWidget> createState() => RegularScreenTestState();
}

class RegularScreenTestState extends State<RegularScreenTest> {
  int currentDecibel = 0;

  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;
  late Timer _timer;
  late final RecorderController recorderController;

  String? _path;
  late Directory appDirectory;

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    _path = "${appDirectory.path}/audio.wav";
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (!regularValue) {
        regularValue = true;
      }
      if (noiseReading.maxDecibel.toInt() > dB) {
        print(noiseReading.toString());

        save();
      }
    });
  }

  void onError(Object error) {
    print(error.toString());
    regularValue = false;
  }

  void start() async {
    print('starting');
    // 녹음 및 소음 측정 시작
    try {
      regularValue = true;
      await recorderController.record(_path);
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
      _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
        print(DateTime.now());
      });
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  // save & timer reset
  void save() async {
    var path = await recorderController.stop();
    regularValue = false;
    _noiseSubscription!.cancel();
    _timer.cancel();
    setState(() {});
    print('save done $path');
  }

  // init & dispose
  @override
  void initState() {
    super.initState();
    _getDir();
    regularValue = false;
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC;
    _noiseMeter = NoiseMeter(onError);
  }

  @override
  void dispose() {
    recorderController.dispose();
    _noiseSubscription?.cancel();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: start,
              child: Text('Start'),
            ),
            TextButton(
              onPressed: save,
              child: Text('Save'),
            ),
          ],
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
          child: AudioWaveforms(
            waveStyle: const WaveStyle(
              waveColor: Colors.white,
              spacing: 8.0,
              extendWaveform: true,
              showMiddleLine: false,
            ),
            size: Size(MediaQuery.of(context).size.width, 200.0),
            recorderController: recorderController,
          ),
        ),
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
