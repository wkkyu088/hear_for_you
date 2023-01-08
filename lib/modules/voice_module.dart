import 'package:flutter/material.dart';
import 'package:hear_for_you/constants.dart';

import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceModule extends ChangeNotifier {
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _lastWords = '';
  String _currentWords = '';

  // This has to happen only once per app
  void initSpeech() async {
    debugPrint('debugging : 음성모드 init');

    await _speechToText.initialize(
        onError: errorListener, onStatus: statusListener);
  }

  // 에러 종류에 따라 팝업 띄우기
  // error_speech_timeout, error_busy, error_network, error_
  void errorListener(SpeechRecognitionError error) {
    debugPrint('debugging : onerror $error');
    notifyListeners();
  }

  // stt가 특정시간이 지나면 자동종료가 되기때문에 다시 시작해주는 코드 필요
  void statusListener(String status) async {
    if (!_isListening) {
      debugPrint('debugging : not for STT');
      stopListening();
    } else {
      debugPrint('debugging : $status / _isListening $_isListening');

      // 갱신하고 다시 재인식
      if (status == "done" && _isListening) {
        _lastWords += " $_currentWords";
        if (_lastWords.isNotEmpty && _lastWords != " ") {
          voiceScreenChat.insert(0, [_lastWords, false]);
          debugPrint('debugging : $_lastWords');

          notifyListeners();
        }
        _lastWords = "";
        _currentWords = "";
        notifyListeners();

        await startListening();
        notifyListeners();
      }
      // if (status == "notListening" && !_isListening) {
      //   await _stopListening();
      // }
    }
  }

  /// Each time to start a speech recognition session
  Future startListening() async {
    debugPrint('debugging : 음성모드 on');

    _isListening = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    await _speechToText.listen(
        onResult: (SpeechRecognitionResult result) {
          _currentWords = " ${result.recognizedWords}";
          notifyListeners();
        },
        localeId: 'ko_KR',
        partialResults: false,
        listenMode: ListenMode.confirmation,
        listenFor: const Duration(seconds: 10));
  }

  Future stopListening() async {
    debugPrint('debugging : 음성모드 off');

    if (_isListening) {
      _isListening = false;
    }
    await _speechToText.stop();
    notifyListeners();
  }
}
