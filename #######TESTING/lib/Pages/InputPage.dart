import 'package:flutter/material.dart';
import '../Settings.dart' as settings;

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => InputPageState();
}

class InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 200,
        ),
        const Center(
            child: Text("값을 입력하는 스테이지입니다.\n입력된 값은 다른 창으로 넘어갑니다",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ))),
        Center(
            child: IconButton(
                icon: const Icon(Icons.abc_rounded),
                padding: const EdgeInsets.fromLTRB(0, 100, 0, 100),
                iconSize: 100,
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierDismissible: true, // 창 바깥쪽을 클릭하면 사라짐
                      builder: (BuildContext context) {
                        return const AlertPage();
                      });
                }))
      ]),
    );
  }
}

// 메인페이지에서 아이콘을 누르면 등장하는 페이지
class AlertPage extends StatefulWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  State<AlertPage> createState() => AlertPageState();
}

class AlertPageState extends State<AlertPage> {
  final myController = TextEditingController();

  @override // 객체가 삭제될 때 호출
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Container(
            width: 100,
            height: 100,
            padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
            // decoration: const BoxDecoration(
            //     border: Border(
            //         bottom: BorderSide(
            //   width: 2,
            // ))),
            child: TextField(
              controller: myController,
              decoration: InputDecoration(
                labelText: "값을 입력해주세요",
              ),
            )),
        actions: [
          TextButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          TextButton(
              child: const Text("확인"),
              onPressed: () {
                if (myController.text == '') {
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            content: Container(
                              padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
                              width: 100,
                              height: 100,
                              child: Text(
                                "값을 입력해주세요!!",
                              ),
                            ),
                            actions: [
                              TextButton(
                                  child: const Text("확인"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                            ]);
                      });
                } else {
                  settings.value = myController.text;
                  Navigator.of(context).pop(myController.text);
                }
              }),
        ]);
  }
}
