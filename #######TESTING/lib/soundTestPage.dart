import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_audio_cutter/audio_cutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path/path.dart' as path;
import 'package:mfcc/mfcc.dart';
import 'package:wav/wav.dart';
import 'AI.dart';

class SoundPage extends StatefulWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  State<SoundPage> createState() => SoundPageState();
}

class SoundPageState extends State<SoundPage> {
  List<String> state = ["사운드 파일 불러오기"];
  int process = 0;
  // 자른 파일의 경로
  String? cuttedFile;

  // path_provider가 제공해주는 경로를 받기 위한 변수들
  late Directory appDirectory;
  late String _path;

  @override
  initState() {
    super.initState();
    setPath();
  }

  void setPath() async {
    appDirectory = await getApplicationDocumentsDirectory();
    _path = "${appDirectory.path}/audio.wav";
  }

  void changePath(String fileName) async {
    _path = "${appDirectory.path}/$fileName";
  }

  Future<String> cutFile(filePath) async {
    try {
      print("읽고자 하는 파일의 경로는 $_path입니다.");

      // wav로 읽어보자
      var readedFile = await Wav.readFile(_path);
      print("포맷 : ${readedFile.format}");
      print("샘플시간 : ${readedFile.samplesPerSecond}");

      // 전체 길이 - samplesPerSecond 하면 1초간의 데이터만 나옴
      // 일단 채널은 두개로 놔두자.. 왼쪽, 오른쪽이라고 함
      for (int i = 0; i < readedFile.channels.length; i++) {
        readedFile.channels[i] = readedFile.channels[i].sublist(
            readedFile.channels[i].length - readedFile.samplesPerSecond,
            readedFile.channels[i].length);
      }

      // 잘린 데이터의 길이 재확인하기

      print("readedFile의 채널 길이 : ${readedFile.channels[0].length}");

      // cutFile 수행 완료
      changePath("cuttedFile.wav");
      readedFile.writeFile(_path);

      getMFCC();

      return "파일 읽기 및 자르기 성공. $_path에 파일이 저장되었습니다.";

      // // 읽은 파일의 길이 등을 파악하기
      // for (var chan in readedFile.channels) {
      //   for (int i = 0; i < chan.length; i++) {
      //     chan[i];
      //   }
      // }

      // return "파일이 잘렸습니다, 파일의 원래 길이는 ${ends / 1000}초였습니다.\n잘린 파일의 내용은 $cuttedFile입니다.";
    } catch (e) {
      return "오류 발생 : $e";
    }
  }

  Future<List<String>> getMFCC() async {
    List<String> forReturn = [];

    var sampleRate = 22050;
    var windowLength = 1024;
    var windowStride = 512;
    var fftSize = 1024;
    var numFilters = 50;
    var numCoefs = 50;

    var readedFile = await Wav.readFile(_path);

    var result = await MFCC.mfccFeats(readedFile.channels[0], sampleRate,
        windowLength, windowStride, fftSize, numFilters, numCoefs);

    bool flag = true;
    int length = result[0].length;

    for (int i = 1; i < result.length; i++) {
      if (length != result[i].length) {
        flag = false;
        break;
      }
    }

    // MFCC의 평균을 구하는 부분
    List<double> meanedMFCC = [];

    double tmp;
    for (int i = 0; i < length; i++) {
      tmp = 0;
      for (int j = 0; j < numCoefs; j++) {
        tmp += result[j][i];
      }
      meanedMFCC.add(tmp / length);
    }

    forReturn.add("MFCC의 길이 : ${result.length}");
    forReturn.add("MFCC[0]의 길이 : ${result[0].length}");
    forReturn.add("모든 MFCC[n]의 길이가 같은가? : $flag");
    forReturn.add("meanedMFCC의 길이 : ${meanedMFCC.length}");
    forReturn.add("${meanedMFCC.sublist(0, 10)}");

    return forReturn;
  }
  //   List<num> readedFile =
  //   var mfcc_proc = MFCC.mfccFeats(sampleRate, fftSize, numFilters, numCoefs,
  //       energy: false);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        children: [
          for (int i = 0; i < state.length; i++) ...[
            Container(child: Text(state[i]), padding: const EdgeInsets.all(4.0))
          ],
          Row(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 15, 0),
                child: const Text("audio.wav를 잘라\ncutFile.wav로 저장하기",
                    style: TextStyle(
                      fontSize: 15,
                    ))),
            IconButton(
                icon: const Icon(Icons.accessibility),
                iconSize: 50,
                color: Colors.black,
                onPressed: () async {
                  var filePath = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return InputPopup();
                      });
                  if (filePath == "") {
                  } else {
                    // 함수 실행 결과로 나온 메세지를 받아서 페이지에 추가하기 위함
                    String returnState = await cutFile(filePath);
                    setState(() {
                      state.add(returnState);
                    });
                  }
                })
          ]),
          Row(children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: const Text("MFCC를 구하고\n전치행렬의 산술평균을 반환",
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ),
            IconButton(
                icon: const Icon(Icons.ac_unit),
                iconSize: 50,
                color: Colors.black,
                onPressed: () async {
                  // 함수 실행 결과로 나온 메세지를 받아서 페이지에 추가하기 위함
                  List<String> returnState = await getMFCC();
                  setState(() {
                    for (int i = 0; i < returnState.length; i++) {
                      state.add(returnState[i]);
                    }
                  });
                })
          ]),
          Row(children: [
            Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 80, 0),
                child: const Text("모델 불러오기",
                    style: TextStyle(
                      fontSize: 15,
                    ))),
            IconButton(
                icon: const Icon(Icons.add_circle),
                iconSize: 50,
                onPressed: () async {
                  String val = await ModelClass.makeModel();
                  setState(() {
                    state.add(val);
                  });
                })
          ]),
        ],
      ),
    ]);
  }
}

class InputPopup extends StatelessWidget {
  InputPopup({Key? key}) : super(key: key);

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SizedBox(
            width: 300,
            height: 300,
            child: Center(
                child: Column(
              children: [
                const Text("자를 파일의 경로를 입력하세요"),
                TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: "자르고자 하는 파일의 경로를 입력해주세요",
                    ))
              ],
            ))),
        actions: [
          TextButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.pop(context, "assets/sounds/file.wav");
              }),
          TextButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.pop(context, textController.text);
              })
        ]);
  }
}
