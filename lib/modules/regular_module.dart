// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:async';

import 'package:hear_for_you/constants.dart';

import '../service/functions.dart';

// Regular Mode
String _path = '';
var recorderController;
var _recordTimer;
var _decibelTimer;

void setContext(BuildContext context) {
  _context = context;
}

var _context;

// 상시모드 켜기
void initRegularMode(bool rv) async {
  print(
      '------------------------------------------------------------------------------------ init regular mode');
  // var dir = await getExternalStorageDirectory();
  var dir = await getApplicationDocumentsDirectory();
  _path = "${dir.path}/audio.aac";
  recorderController = RecorderController()
    ..androidEncoder = AndroidEncoder.aac
    ..androidOutputFormat = AndroidOutputFormat.mpeg4
    ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC;

  // sharedPreference에서 regularValue=True인 경우
  if (rv) {
    checkDecibel();
    repeatRecorder(false);
  }
}

// 상시모드 끄기 - 데시벨체커
void disposeRegularMode() async {
  print(
      '------------------------------------------------------------------------------------ dispose regular mode');

  await recorderController?.dispose();
  await _recordTimer?.cancel();
  await _decibelTimer?.cancel();
}

// 특정 데시벨 감지 후 저장
// /storage/emulated/0/Android/data/com.example.hear_for_you/files/audio.wav
void save() async {
  var path = await recorderController.stop();
  print(
      '------------------------------------------------------------------------------------ saved to $path');
  repeatRecorder(true);
}

// 1초마다 데시벨 구하기
Future<double?> _getDecibel() async =>
    await AudioWaveformsInterface.instance.getDecibel();

void checkDecibel() {
  _decibelTimer = Timer.periodic(
    const Duration(seconds: 1),
    (timer) async {
      var decibel = await _getDecibel();
      print(
          '------------------------------------------------------------------------------------ decibel : $decibel');
      try {
        if (decibel! >= dB) {
          /////////////////////////////////////////////////////////////////// dB이상 소리 감지 후 행동
          save();
          FunctionClass.showPopup(_context);
          print(
              '------------------------------------------------------------------------------------ get classification');
        }
      } catch (e) {
        throw "Failed to get sound level";
      }
    },
  );
}

// n분마다 녹음 초기화 + 재시작
void repeatRecorder(bool restart) {
  // 재시작
  if (restart) {
    _recordTimer?.cancel();
    print(
        '------------------------------------------------------------------------------------ restart recordTimer');
  }
  print(
      '------------------------------------------------------------------------------------ 5초 뒤 녹음이 시작됩니다 : ${DateTime.now().second}');
  _recordTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
    print(
        '------------------------------------------------------------------------------------ recordTimer: ${DateTime.now().second}');
    await recorderController.record(_path);
  });
}
