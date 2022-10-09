import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/widgets/chat_modal.dart';

import '../constants.dart';

class VoiceScreen extends StatefulWidget {
  const VoiceScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<VoiceScreen> createState() => _VoiceScreenState();
}

class _VoiceScreenState extends State<VoiceScreen> {
  late bool isEmpty;
  late bool isInput;

  @override
  initState() {
    super.initState();
    isEmpty = true;
    isInput = false;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    final List chat1 = ['이것은 음성모드입니다.', '대화를 인식하여 텍스트로 보여줍니다.'];
    final List chat2 = ['이것은 사용자의 발화입니다.', '키보드로 입력하여 전달합니다.'];
    final List chat3 = ['종료 버튼을 눌러 대화를 종료하거나 진행한 대화를 저장 또는 공유할 수 있습니다.'];

    Widget bubble(str, user) {
      return Container(
        padding: const EdgeInsets.all(15),
        constraints: BoxConstraints(maxWidth: screenWidth * 0.65),
        decoration: BoxDecoration(
          color: user
              ? kMain
              : darkMode
                  ? Colors.grey[800]
                  : Colors.grey[200],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomRight: user ? Radius.zero : const Radius.circular(20),
            bottomLeft: user ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Text(
          str,
          style: TextStyle(
              color: user
                  ? Colors.white
                  : darkMode
                      ? Colors.white
                      : Colors.grey,
              fontSize: 16),
        ),
      );
    }

    Widget waveForm(height) {
      return Container(
        width: 6,
        height: height,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: darkMode ? Colors.white : const Color(0xFF434343),
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkMode ? Colors.grey[900] : Colors.grey[100],
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            const SizedBox(height: 10),
            isEmpty
                ? const Flexible(
                    child: Center(
                      child: Text(
                        '음성모드 화면입니다.\n하단의 버튼을 눌러 대화를 시작하세요.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.grey, fontSize: 16, height: 2),
                      ),
                    ),
                  )
                : Positioned(
                    top: 20,
                    width: screenWidth,
                    height: isInput
                        ? screenHeight - (keyboardHeight + 125)
                        : screenHeight - 50,
                    child: ListView(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat1[0], false),
                              const SizedBox(height: 8),
                              bubble(chat1[1], false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              bubble(chat2[0], true),
                              const SizedBox(height: 8),
                              bubble(chat2[1], true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat3[0], false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat1[0], false),
                              const SizedBox(height: 8),
                              bubble(chat1[1], false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              bubble(chat2[0], true),
                              const SizedBox(height: 8),
                              bubble(chat2[1], true),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat1[0], false),
                              const SizedBox(height: 8),
                              bubble(chat1[1], false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              bubble(chat2[0], true),
                              const SizedBox(height: 8),
                              bubble(chat2[1], true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat3[0], false),
                            ],
                          ),
                        ),
                        isInput
                            ? Container()
                            : const SizedBox(height: 120), // 마지막 필수
                      ],
                    ),
                  ),
            Container(
              color: darkMode ? Colors.grey[900] : Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      size: 25,
                      color: darkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  isEmpty
                      ? const SizedBox()
                      : Container(
                          margin: const EdgeInsets.only(right: 10),
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                if (isInput == true) {
                                  isInput = false;
                                } else {
                                  isInput = true;
                                }
                              });
                            },
                            style: TextButton.styleFrom(
                              primary: darkMode ? Colors.white : Colors.black,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              side: BorderSide(
                                  color: darkMode ? Colors.white : Colors.black,
                                  width: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              '모드 변경', // 모드라는 이름 헷갈려서 바꿔야함
                              style: TextStyle(
                                color: darkMode ? Colors.white : Colors.black,
                                fontSize: 15,
                                fontFamily: 'SCBold',
                              ),
                            ),
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: TextButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    chatModalBuilder(context))
                            .then((value) => setState(() {}));
                      },
                      style: TextButton.styleFrom(
                        primary: darkMode ? Colors.black : Colors.white,
                        backgroundColor: darkMode ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 12),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        '저장',
                        style: TextStyle(
                          color: darkMode ? Colors.black : Colors.white,
                          fontSize: 15,
                          fontFamily: 'SCBold',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            isEmpty
                ? Positioned(
                    bottom: 0,
                    width: screenWidth,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Dismissible(
                          key: const Key('1'),
                          direction: DismissDirection.up,
                          background: Stack(
                            alignment: AlignmentDirectional.centerStart,
                            children: [
                              Container(
                                  width: 120,
                                  color: Colors.grey.withOpacity(0.5)),
                              Container(
                                  width: 100,
                                  color: Colors.grey.withOpacity(0.5)),
                            ],
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              isInput = false;
                              isEmpty = false;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(150))),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.grey.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(150))),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.mic_rounded,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        Text(
                                          '소리 듣기',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Dismissible(
                          key: const Key('2'),
                          direction: DismissDirection.up,
                          background: Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              Container(
                                  width: 120, color: kMain.withOpacity(0.5)),
                              Container(
                                  width: 100, color: kMain.withOpacity(0.5)),
                            ],
                          ),
                          onDismissed: (direction) {
                            setState(() {
                              isInput = true;
                              isEmpty = false;
                            });
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                    color: kMain.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(150))),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: kMain.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(150))),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, left: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.keyboard_rounded,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        Text(
                                          '입력하기',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : isInput
                    ? Positioned(
                        bottom: 0,
                        width: screenWidth,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: TextField(
                              onChanged: (value) {},
                              style: TextStyle(
                                  fontSize: 16,
                                  color:
                                      darkMode ? Colors.white : Colors.black),
                              autofocus: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
                                hintText: "입력하세요",
                                hintStyle: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                                counterText: "",
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 15),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: darkMode
                                          ? Colors.white
                                          : Colors.black),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              )),
                        ),
                      )
                    : Positioned(
                        bottom: 0,
                        height: 100,
                        width: screenWidth,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            SizedBox(
                              height: 40,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  waveForm(6.0),
                                  waveForm(6.0),
                                  waveForm(6.0),
                                  waveForm(6.0),
                                  waveForm(6.0),
                                ],
                              ),
                            ),
                            Text(
                              '대화를 듣고 있습니다...',
                              style: TextStyle(
                                color: darkMode
                                    ? Colors.white
                                    : const Color(0xFF434343),
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
