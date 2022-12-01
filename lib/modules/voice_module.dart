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
  late bool isEmpty;
  late bool isInput;
  bool isOpen = false;
  final ScrollController _controller = ScrollController();

  @override
  initState() {
    super.initState();
    isEmpty = true;
    isInput = false;
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
  void statusListener(String status) async {
    debugPrint("status $status");
    // 갱신하고 다시 재인식
    if (status == "done" && _speechEnabled) {
      setState(() {
        _lastWords += " $_currentWords";
        _currentWords = "";
        _speechEnabled = false;
      });
      await _startListening();
    }
  }

  /// Each time to start a speech recognition session
  /// stt가 특정시간이 지나면 자동종료가 되기때문에 다시 시작해주는 코드 필요
  Future _startListening() async {
    debugPrint("=================================================");
    await _stopListening();
    await Future.delayed(const Duration(milliseconds: 1));
    await _speechToText.listen(
        onResult: _onSpeechResult,
        localeId: _selectedLocaleId,
        cancelOnError: false,
        partialResults: true,
        listenMode: ListenMode.confirmation);
    setState(() {
      _speechEnabled = true;
    });
  }

  Future _stopListening() async {
    setState(() {
      _speechEnabled = false;
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

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      body: Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        width: screenWidth,
        height: screenHeight,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              TextButton(
                onPressed: _speechToText.isNotListening
                    ? _startListening
                    : _stopListening,
                style: TextButton.styleFrom(
                  primary: darkMode ? kWhite : kBlack,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  side: BorderSide(color: darkMode ? kWhite : kBlack, width: 2),
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  _speechEnabled ? '입력하기' : '소리 듣기', // 모드라는 이름 헷갈려서 바꿔야함
                  style: TextStyle(
                    color: darkMode ? kWhite : kBlack,
                    fontSize: kS,
                    fontFamily: 'SCBold',
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              // 저장하기
              Container(
                margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
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
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: _lastWords.isNotEmpty
                ? bubble('$_lastWords $_currentWords', false, false)
                : _speechAvailable
                    ? Text('Tap the microphone to start listening...')
                    : Text('Speech not available'),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}
