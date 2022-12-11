import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hear_for_you/widgets/chat_modal.dart';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../constants.dart';

class VoiceScreenTest extends StatefulWidget {
  const VoiceScreenTest({Key? key}) : super(key: key);

  @override
  State<VoiceScreenTest> createState() => _VoiceScreenTestState();
}

class _VoiceScreenTestState extends State<VoiceScreenTest> {
  late bool isInput;
  bool isOpen = false;
  var gloabalKey = GlobalKey();
  final TextEditingController textController = TextEditingController();

  @override
  initState() {
    super.initState();
    // isEmpty = true;
    isInput = true;
    _initSpeech();
  }

  //////////////////////////////////// STT ////////////////////////////////////
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _speechAvailable = false;
  String _lastWords = '';
  String _currentWords = '';

  final String _selectedLocaleId = 'ko_KR';

  // This has to happen only once per app
  void _initSpeech() async {
    _speechAvailable = await _speechToText.initialize(
        onError: errorListener, onStatus: statusListener);
    setState(() {});
  }

  void errorListener(SpeechRecognitionError error) {
    debugPrint(error.errorMsg.toString());
  }

  //
  /// stt가 특정시간이 지나면 자동종료가 되기때문에 다시 시작해주는 코드 필요
  void statusListener(String status) async {
    debugPrint("status $status");
    // 갱신하고 다시 재인식
    if (status == "done" && _speechEnabled) {
      setState(() {
        _lastWords += " $_currentWords";
        voiceScreenChat.add([_lastWords, false]);

        _currentWords = "";
        _speechEnabled = false;
      });
      await _startListening();
    }
  }

  /// Each time to start a speech recognition session
  Future _startListening() async {
    regularValue = false;
    await _stopListening();
    await Future.delayed(const Duration(milliseconds: 1));
    await _speechToText.listen(
        // [listenFor] sets the maximum duration that it will listen for, after that it automatically stops the listen for you.
        // [pauseFor] sets the maximum duration of a pause in speech with no words detected, after that it automatically stops the listen for you.
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        localeId: _selectedLocaleId,
        cancelOnError: false,
        partialResults: false,
        listenMode: ListenMode.confirmation);
    setState(() {
      _speechEnabled = true;
    });
  }

  Future _stopListening() async {
    setState(() {
      _speechEnabled = false;
      regularValue = true;
    });
    await _speechToText.stop();
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _currentWords = result.recognizedWords;
    });
  }

  ////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    // 채팅 메세지가 담길 버블
    Widget bubble(str, user, last) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          user ? const Spacer() : const SizedBox(),
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
          user ? const SizedBox() : const Spacer(),
        ],
      );
    }

    // 소리를 듣고 있다는 표시
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

    // 입력 필드 전송 관리, 사용자 발화 추가
    void _handleSubmitted(String text) {
      textController.clear();
      if (text != "") {
        setState(() {
          voiceScreenChat.add([text, true]);
        });
      }
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
            Container(
              color: darkMode ? kBlack : kGrey1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          // 소리듣기로 전환
                          if (isInput == true) {
                            isInput = false;
                            _startListening();
                          }
                          // 입력하기로 전환
                          else {
                            isInput = true;
                            _stopListening();
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
                        isInput ? '소리 듣기' : '입력하기',
                        style: TextStyle(
                          color: darkMode ? kWhite : kBlack,
                          fontSize: kS,
                          fontFamily: 'PretendardBold',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 10, top: 10, bottom: 10),
                    child: TextButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                                context: context,
                                builder: (BuildContext context) =>
                                    chatModalBuilder(context,
                                        globalKey: gloabalKey))
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
                          fontFamily: 'PretendardBold',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  width: screenWidth,
                ),
                Flexible(
                  child: RepaintBoundary(
                    key: gloabalKey,
                    child: ListView.builder(
                        // reverse: true,
                        itemCount: voiceScreenChat.length,
                        itemBuilder: (BuildContext context, idx) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            margin: EdgeInsets.only(
                                bottom: (idx + 1 < voiceScreenChat.length) &&
                                        (voiceScreenChat[idx][1] !=
                                            voiceScreenChat[idx + 1][1])
                                    ? 10
                                    : 5),
                            alignment: voiceScreenChat[idx][1]
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child:
                                // bubble(str, usr, last)
                                bubble(voiceScreenChat[idx][0],
                                    voiceScreenChat[idx][1], false),
                          );
                        }),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: isOpen ? 60 : 140),
                  width: screenWidth,
                ),
              ],
            ),
            isInput
                // 텍스트 필드
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
                        child: Row(
                          children: [
                            Flexible(
                              child: TextField(
                                controller: textController,
                                onSubmitted: _handleSubmitted,
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
                                ),
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              child: IconButton(
                                icon: Icon(Icons.send, color: kMain),
                                onPressed: () =>
                                    _handleSubmitted(textController.text),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                // 소리 듣기 표시
                : Positioned(
                    bottom: 80,
                    height: 80,
                    width: screenWidth,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.3),
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
                      child: _lastWords.isNotEmpty
                          ? Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: kGrey5),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text('$_lastWords $_currentWords'))
                          : Column(
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

// Container(
//   padding: EdgeInsets.symmetric(horizontal: 10),
//   child: _lastWords.isNotEmpty
//       ? bubble('$_lastWords $_currentWords', false, false)
//       : _speechAvailable
//           ? Text('Tap the microphone to start listening...')
//           : Text('Speech not available'),
// ),
