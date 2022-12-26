// ignore_for_file: avoid_print
import 'package:hear_for_you/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'dart:async';

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
