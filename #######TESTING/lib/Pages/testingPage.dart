import 'package:flutter/material.dart';
import '../AI.dart' as ai;

class PopupTestPage extends StatefulWidget {
  const PopupTestPage({Key? key}) : super(key: key);

  @override
  State<PopupTestPage> createState() => PopupTestPageState();
}

class PopupTestPageState extends State<PopupTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Center(
          child: Container(
              height: 200,
              width: 300,
              padding: const EdgeInsets.all(0.0),
              decoration: const BoxDecoration(
                  color: Colors.lightBlue,
                  border: Border(
                    top: BorderSide(width: 1),
                    left: BorderSide(width: 1),
                    right: BorderSide(width: 1),
                    bottom: BorderSide(width: 1),
                  )),
              child: const Center(
                  child: Text("테스트용 페이지입니다.\n버튼을 누르시면 팝업 및 알람이 등장합니다")))),
      IconButton(
          icon: const Icon(Icons.surround_sound_rounded),
          iconSize: 50,
          onPressed: (() => showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                    content: Container(
                        width: 150,
                        height: 150,
                        color: Colors.red,
                        padding: const EdgeInsets.all(15),
                        child: const Center(child: ai.ModelPopup())));
              }))),
      Container(
        child: Text("이 아래는 사운드 테스트용 버튼입니다!"),
        padding: EdgeInsets.all(16.0),
      ),
      IconButton(
        icon: Icon(Icons.add_home_outlined),
        iconSize: 50,
        onPressed: (() => showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              return AlertDialog(
                  content: Container(
                width: 150,
                height: 150,
                color: Colors.blue,
              ));
            })),
      )
    ]));
  }
}
