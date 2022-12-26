import 'dart:async';
import 'dart:io';
import 'notification.dart' as notification;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wav/wav.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../logs.dart';

class Processing {
  // 이 함수를 부르면 파일 자르기, 서버로 데이터 전송, 데이터 받아서 반환 등의 과정을 자동으로 처리하고 알람을 띄워줌
  static Future<String> getPrediction() async {
    try {
      var cuttedPath = await cutFile();
      var result = await uploadFile();
      // 알람 띄우는 부분
      notification.showNotification("소리 감지", "$result가 들립니다");
      return result;
    } catch (e) {
      print("Processing에서 에러 처리");
      // 처리 과정 중 에러가 발생했으면 여기서도 에러 반환
      rethrow;
      // throw e.toString();
    }
  }

  // 일정 데시벨 이상의 소리가 울렸을 때, 저장된 경로를 반환해주는 함수.
  // fileName에 아무 값도 넣지 않으면 초기 음원파일이 저장된 경로를 반환하고, 파일명이 들어온다면 해당 파일명을 넣어서 반환해준다.
  static Future<String> getPath({fileName = "audio.wav"}) async {
    var appDirectory = await getApplicationDocumentsDirectory();
    return "${appDirectory.path}/$fileName";
  }

  // 파일을 마지막 1초만 두고 자르고, 자른 파일의 경로를 반환해주는 함수
  static Future<String> cutFile() async {
    try {
      String path = await getPath();
      print("cutFile : 읽어올 경로는 $path입니다");

      // wav package를 이용하여 경로의 파일을 읽기
      var readedFile = await Wav.readFile(path);

      // 전체 길이 - samplesPerSecond부터 슬라이싱하면 마지막 1초간의 데이터만 남게 됨
      // 잘린 파일의 channel을 보니 두개이다! 왼쪽,오른쪽이라고 하는데 서버와 테스트해보니 채널이 두개여도 문제 없으므로 일단 두 채널 모두 처리
      for (int i = 0; i < readedFile.channels.length; i++) {
        readedFile.channels[i] = readedFile.channels[i].sublist(
            readedFile.channels[i].length - readedFile.samplesPerSecond,
            readedFile.channels[i].length);
      }

      // 잘린 데이터의 길이 재확인하기, 1초간의 데이터이면 samplesPerSecond와 같은 길이를 가져야 함.
      // 같지 않다면 Exception을 출력하도록 함
      if (readedFile.channels[0].length != readedFile.samplesPerSecond) {
        throw const FormatException("데이터를 제대로 자르지 못했습니다");
      }

      // 파일 저장하기
      path = await getPath(fileName: "cuttedFile.wav");
      print("cutFile : 저장할 경로는 $path입니다");
      readedFile.writeFile(path);

      return path;
    } catch (e) {
      rethrow;
    }
  }

  // 서버와 상호작용하고 결과를 반환해준다
  static Future<String> uploadFile() async {
    try {
      // 기록을 위한 로그파일 생성
      List<dynamic> singleLog = [];

      // dio 생성 (http request를 수행해줌)
      var dio = Dio();
      var target = await getPath(fileName: "cuttedFile.wav");
      print("uploadFile : 전송할 파일은 $target");

      // 접속할 주소 설정, 만약 외부 서버를 쓴다면 외부 서버의 ip를 입력해주면 됨!
      const address = "http://3.39.56.58:8000";

      // 파일 경로를 통해 전달할 데이터를 생성함
      // 현재는 파일과 유저명을 전달하는데, 유저명이 겹칠 수 있으므로 유저번호?를 사용해도 좋을 듯!
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(target),
        // 이거 유저네임을 어떻게 받아오는지?..
        'userName': setting.userName
      });

      print("uploadFile : 파일 폼데이터 만들기에 성공했습니다");

      // dio객체를 이용해서 서버와 상호작용하는 부분
      var response = await dio.post("$address/uploadFile", data: formData);
      print("uploadFile : 서버와 통신에 성공했습니다.");

      // 서버가 반환해준 결과를 result에 저장
      var result = response.data['prediction'];

      // 로그에 분석 결과와 분석 시간 삽입, 확인 여부는 일단 False로 하고 넣기
      singleLog.add(result);
      singleLog.add(DateTime.now());
      singleLog.add(false);

      logList.add(singleLog);
      //반환된 값이 null이라면 분석에 실패한 것이므로 exception을 반환
      if (result == "null") {
        throw SignalException;
      } else {
        return result.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> lowerDecibelCheck() async {
    int logLength = logList.length;

    try {
      // 가장 최근에 발생한 큰 소리의 시간을 가져오기
      DateTime timeLatest = logList[logLength - 1][1];
      // 이것보다 5회 이전에 발생한 큰 소리의 시간을 가져오기
      // 이 때 기록된 것이 5개 이하라면 여기서 오류가 날 수 있으므로 try-catch
      DateTime timePrevious = logList[logLength - 6][1];

      // 분 단위로 비교 가능하도록 int값으로 바꿔주는 함수 활용
      int minLatest = getMinuteValue(timeLatest);
      int minPrevious = getMinuteValue(timePrevious);

      // 둘을 뺐을 때 10이하면, 데시벨 이상의 소리가 10분 이내에 5번 발생한 것이므로 true를 반환해서 내리도록, 아니면 false 반환
      if (minLatest - minPrevious < 10) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // 에러가 났을 경우에는 기록된 것이 5개 이하인 경우일 것이므로 false 반환
      return false;
    }
  }

  static int getMinuteValue(DateTime time) {
    int forReturn = 0;
    forReturn += (int.parse(DateFormat("dd").format(DateTime.now())) * 60 * 24);
    forReturn += (int.parse(DateFormat("HH").format(DateTime.now())) * 60);
    forReturn += (int.parse(DateFormat("mm").format(DateTime.now())));
    return forReturn;
  }
}

class SoundPage extends StatefulWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  State<SoundPage> createState() => SoundPageState();
}

class SoundPageState extends State<SoundPage> {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_literals_to_create_immutables
    return Column(
      children: [
        const Text("테스트 페이지입니다.\n하단의 버튼을 누르면 서버와 데이터를 주고받습니다.",
            style: TextStyle(
              fontSize: 25,
            )),
        IconButton(
            icon: Icon(Icons.dark_mode),
            iconSize: 50,
            onPressed: () {
              showDialog(
                  context: context,
                  barrierDismissible: true, // 창 바깥쪽을 클릭하면 사라짐
                  builder: (BuildContext context) {
                    return const ModelPopup();
                  });
            })
      ],
    );
  }
}

class ModelPopup extends StatefulWidget {
  const ModelPopup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopupState();
}

class PopupState extends State<ModelPopup> {
  Widget object = loadingWidget();
  @override
  initState() {
    super.initState();
    Future<String> prediction = Processing.getPrediction();
    prediction.then((val) {
      setState(() {
        object = resultWidget(val);
      });
    }).catchError((error) {
      // SignalException은 무슨 소리인지 인지하지 못했을 경우임. 이때는 에러는 아니므로 다른 처리
      if (error.toString() == "SignalException") {
        setState(() {
          object = resultWidget("알 수 없는 소리입니다");
        });
      } else {
        setState(() {
          object = errorWidget(error.toString());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(content: object);
  }
}

// 로딩중일 때 띄울 위젯
Widget loadingWidget() {
  return const Center(child: Text("분석중입니다"));
}

// 분석이 완료되고 띄울 위젯
Widget resultWidget(String result) {
  return Column(children: [
    Text("분석 결과"),
    Text(result),
  ]);
}

// 분석 실패 혹은 에러 발생 시 띄울 위젯
Widget errorWidget(String result) {
  return Column(
    children: [
      Text("오류 발생"),
      Text(result),
    ],
  );
}
