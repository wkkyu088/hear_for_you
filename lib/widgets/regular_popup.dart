import 'dart:async';
import 'package:hear_for_you/widgets/custom_dialog.dart';

import '../service/functions.dart';
import '../constants.dart' as settings;
import 'package:flutter/material.dart';

class SoundPage extends StatefulWidget {
  const SoundPage({Key? key}) : super(key: key);

  @override
  State<SoundPage> createState() => SoundPageState();
}

class SoundPageState extends State<SoundPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("테스트 페이지입니다.\n하단의 버튼을 누르면 서버와 데이터2를 주고받습니다.",
            style: TextStyle(
              fontSize: 25,
            )),
        IconButton(
            icon: const Icon(Icons.dark_mode),
            iconSize: 50,
            onPressed: () {
              FunctionClass.showPopup(context);
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
  String object = "분석중입니다.";
  Color color = Colors.black;
  @override
  initState() {
    super.initState();
    Future<String> prediction = FunctionClass.getPrediction();
    prediction.then((val) {
      setState(() {
        object = "분석 결과: $val";
        color = Colors.green;
      });
    }).catchError((error) {
      // SignalException은 무슨 소리인지 인지하지 못했을 경우임. 이때는 에러는 아니므로 다른 처리
      if (error.toString() == "SignalException") {
        setState(() {
          object = "알 수 없는 소리입니다";
          color = Colors.red;
          Timer.periodic(const Duration(seconds: 2), (timer) {
            Navigator.pop(context);
          });
        });
      } else if (error.toString() == "FileSystemException") {
        setState(() {
          object = "audio.aac 파일이 없습니다";
          color = Colors.red;
          Timer.periodic(const Duration(seconds: 2), (timer) {
            Navigator.pop(context);
          });
        });
      } else {
        setState(() {
          object =
              "Error : ${error.toString().split(" ")[0]}\n\nErrorCode : ${error.toString()}";
          color = Colors.red;
          Timer.periodic(const Duration(seconds: 2), (timer) {
            Navigator.pop(context);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return oneButtonDialog(context, "분석 결과", object, "확인", () {}, color: color);
    // return AlertDialog(
    //     content: SizedBox(width: 200, height: 100, child: object));
  }
}

// 로딩중일 때 띄울 위젯
Widget loadingWidget() {
  return Center(
      child: Container(
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: settings.colorChart[settings.selectedColor],
              border: Border.all(color: Colors.black, width: 1)),
          child: const Center(
              child: Text("분석중입니다",
                  style: TextStyle(color: Colors.white, fontSize: 15)))));
}

// 분석이 완료되고 띄울 위젯
Widget resultWidget(String result) {
  return Column(children: [
    Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: settings.colorChart[settings.selectedColor],
            border: Border.all(color: Colors.black, width: 1)),
        child: const Center(
            child: Text("분석 결과",
                style: TextStyle(color: Colors.white, fontSize: 15)))),
    Text(result),
  ]);
}

// 분석 실패 혹은 에러 발생 시 띄울 위젯
Widget errorWidget(String result) {
  return Column(
    children: [
      Container(
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: settings.colorChart[settings.selectedColor],
              border: Border.all(color: Colors.black, width: 1)),
          child: const Center(
              child: Text("오류 발생",
                  style: TextStyle(color: Colors.white, fontSize: 15)))),
      Text(result),
    ],
  );
}
