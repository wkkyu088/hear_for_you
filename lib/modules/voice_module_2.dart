/*
모듈화를 시도했으나 다른 파일에서 
VoiceModule vm = VoiceModule;
vm.____;
뜨지 않음
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../constants.dart';

class VoiceModule extends State {
  ////////////////////////////////////////////////////////////////////////////////////
  ///
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
        _lastWords += _currentWords;
        if (_lastWords.isNotEmpty) {
          voiceScreenChat.insert(0, [_lastWords, false]);
        }
        _lastWords = "";
        _currentWords = "";
        _speechEnabled = false;
      });
      await _startListening();
    }
  }

  /// Each time to start a speech recognition session
  Future _startListening() async {
    regularValue = false;
    // await _stopListening();
    await Future.delayed(const Duration(milliseconds: 1));
    await _speechToText.listen(
        onResult: _onSpeechResult,
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
      _currentWords = " ${result.recognizedWords}";
    });
  }

////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
