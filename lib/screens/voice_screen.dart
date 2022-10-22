import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool isOpen = false;
  final ScrollController _controller = ScrollController();

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

    final List chat1 = ['이것은 음성모드입니다.', '대화를 인식하여 텍스트로 보여줍니다.'];
    final List chat2 = ['이것은 사용자의 발화입니다.', '키보드로 입력하여 전달합니다.'];
    final List chat3 = ['종료 버튼을 눌러 대화를 종료하거나 진행한 대화를 저장 또는 공유할 수 있습니다.'];

    Widget bubble(str, user, last) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          user ? const Spacer() : const SizedBox(),
          (user == true && last == true)
              ? Text(
                  '03:30 ',
                  style: TextStyle(color: kGrey5, fontSize: kXS - 1),
                )
              : const SizedBox(),
          Container(
            padding: const EdgeInsets.all(12),
            constraints: BoxConstraints(maxWidth: screenWidth * 0.65),
            decoration: BoxDecoration(
              color: user
                  ? kMain
                  : darkMode
                      ? kGrey8
                      : kGrey2,
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
                      ? kWhite
                      : darkMode
                          ? kWhite
                          : kGrey5,
                  fontSize: kS),
            ),
          ),
          (user == false && last == true)
              ? Text(
                  ' 18:30',
                  style: TextStyle(color: kGrey5, fontSize: kXS - 1),
                )
              : const SizedBox(),
          user ? const SizedBox() : const Spacer(),
        ],
      );
    }

    Widget waveForm(height) {
      return Container(
        width: 6,
        height: height,
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: darkMode ? kWhite : const Color(0xFF434343),
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            const SizedBox(height: 10),
            isEmpty
                ? Flexible(
                    child: Center(
                      child: Text(
                        '음성모드 화면입니다.\n하단의 버튼을 눌러 대화를 시작하세요.',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: kGrey5, fontSize: kS, height: 2),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(
                        top: 20,
                        bottom: isOpen
                            ? 60
                            : isInput
                                ? 140
                                : 80),
                    width: screenWidth,
                    child: ListView(
                      reverse: true,
                      children: [
                        SizedBox(height: isInput ? 0 : 80),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat1[0], false, false),
                              const SizedBox(height: 6),
                              bubble(chat1[1], false, true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              bubble(chat2[0], true, false),
                              const SizedBox(height: 6),
                              bubble(chat2[1], true, true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat3[0], false, true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat1[0], false, false),
                              const SizedBox(height: 6),
                              bubble(chat1[1], false, false),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              bubble(chat2[0], true, false),
                              const SizedBox(height: 6),
                              bubble(chat2[1], true, true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat1[0], false, false),
                              const SizedBox(height: 6),
                              bubble(chat1[1], false, true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              bubble(chat2[0], true, false),
                              const SizedBox(height: 6),
                              bubble(chat2[1], true, true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              bubble(chat3[0], false, true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
            !isEmpty
                ? Container(
                    color: darkMode ? kBlack : kGrey1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10),
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
                              primary: darkMode ? kWhite : kBlack,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              side: BorderSide(
                                  color: darkMode ? kWhite : kBlack, width: 2),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 12),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              isInput ? '소리 듣기' : '입력하기', // 모드라는 이름 헷갈려서 바꿔야함
                              style: TextStyle(
                                color: darkMode ? kWhite : kBlack,
                                fontSize: kS,
                                fontFamily: 'SCBold',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              right: 10, top: 10, bottom: 10),
                          child: TextButton(
                            onPressed: () {
                              showCupertinoModalPopup(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          chatModalBuilder(context))
                                  .then((value) => setState(() {}));
                            },
                            style: TextButton.styleFrom(
                              primary: darkMode ? kBlack : kWhite,
                              backgroundColor: darkMode ? kWhite : kBlack,
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
                                color: darkMode ? kBlack : kWhite,
                                fontSize: kS,
                                fontFamily: 'SCBold',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            isEmpty
                ? Positioned(
                    bottom: 80,
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
                                  width: 120, color: kGrey5.withOpacity(0.5)),
                              Container(
                                  width: 100, color: kGrey5.withOpacity(0.5)),
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
                                    color: kGrey5.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(150))),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: kGrey5.withOpacity(0.5),
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(150))),
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 15, right: 15),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.mic_rounded,
                                          color: kWhite,
                                          size: 35,
                                        ),
                                        Text(
                                          '소리 듣기',
                                          style: TextStyle(
                                              color: kWhite, fontSize: kXS),
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
                                      children: [
                                        Icon(
                                          Icons.keyboard_rounded,
                                          color: kWhite,
                                          size: 35,
                                        ),
                                        Text(
                                          '입력하기',
                                          style: TextStyle(
                                              color: kWhite, fontSize: kXS),
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
                        bottom: isOpen ? 0 : 80,
                        width: screenWidth,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          child: Focus(
                            onFocusChange: (focused) {
                              setState(() {
                                isOpen = focused ? true : false;
                              });
                            },
                            child: TextField(
                                onChanged: (value) {},
                                style: TextStyle(
                                    fontSize: kS,
                                    color: darkMode ? kWhite : kBlack),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: darkMode ? kBlack : kGrey1,
                                  hintText: "입력하세요",
                                  hintStyle:
                                      TextStyle(fontSize: kS, color: kGrey5),
                                  counterText: "",
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 15),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: darkMode ? kWhite : kBlack),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: kGrey5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                )),
                          ),
                        ),
                      )
                    : Positioned(
                        bottom: 80,
                        height: 80,
                        width: screenWidth,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.3),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: darkMode
                                    ? kBlack.withOpacity(0.65)
                                    : kWhite.withOpacity(0.85),
                                blurRadius: 20,
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
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
                                      ? kWhite
                                      : const Color(0xFF434343),
                                  fontSize: kXS,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
