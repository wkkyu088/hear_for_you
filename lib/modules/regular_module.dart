// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:async';

import 'package:hear_for_you/constants.dart';
import 'package:hear_for_you/service/Functions.dart';

// Regular Mode
String _path = '';
var recorderController;
var _recordTimer;
var _decibelTimer;

var _context;

// 상시모드 켜기
void initRegularMode() async {
  print('--------------------- init regular mode');
  // var dir = await getExternalStorageDirectory();
  var dir = await getApplicationDocumentsDirectory();
  _path = "${dir!.path}/audio.aac";
  recorderController = RecorderController()
    ..androidEncoder = AndroidEncoder.aac
    ..androidOutputFormat = AndroidOutputFormat.mpeg4
    ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC;
  if (regularValue) {
    start();
  }
}

// 상시모드 끄기 - 데시벨체커
void disposeRegularMode() async {
  print('--------------------- dispose regular mode');

  await recorderController?.dispose();
  await _recordTimer?.cancel();
  await _decibelTimer?.cancel();
}

void start() async {
  await recorderController.record(_path);

  checkDecibel();
  repeatRecorder();
}

// 특정 데시벨 감지 후 저장
// /storage/emulated/0/Android/data/com.example.hear_for_you/files/audio.wav
void save() async {
  var path = await recorderController.stop();
  print('--------------------- saved to $path');
}

// 1초마다 데시벨 구하기
Future<double?> _getDecibel() async =>
    await AudioWaveformsInterface.instance.getDecibel();

void checkDecibel() {
  _decibelTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      var decibel = await _getDecibel();
      print('--------------------- decibel : $decibel');
      if (decibel == null) {
        throw "Failed to get sound level";
      }
      if (decibel >= dB) {
        // 여기에 모델 코드 작성하기
        save();
        FunctionClass.showPopup(_context);
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

  _recordTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
    print(DateTime.now().second);
    await recorderController.record(_path);
  });
}
