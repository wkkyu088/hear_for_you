import 'dart:async';
import 'dart:io';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:hear_for_you/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

import 'package:toast/toast.dart';

import '../service/functions.dart';

class RecordModule extends ChangeNotifier {
  var _context;
  var _recordTimer;
  var _currentWords;

  var theSource = AudioSource.microphone;

  SpeechToText regular_stt = SpeechToText();

  String _mPath = '';
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  late StreamSubscription<RecordingDisposition> _recorderSubscription;

  Future<void> initState() async {
    debugPrint('debugging : 상시모드 init');
    var dir;

    if (Platform.isAndroid) {
      dir = await getExternalStorageDirectory();
    } else {
      dir = await getApplicationDocumentsDirectory();
    }
    _mPath = "${dir?.path}/audio${DateTime.now().second}.wav";
    openTheRecorder().then((value) {
      _mRecorderIsInited = true;
      mRecorder!.setSubscriptionDuration(const Duration(seconds: 1));
      notifyListeners();
    });
  }

  Future<void> disposeState() async {
    debugPrint('debugging : 상시모드 off');
    await stop();
    await mRecorder!.closeRecorder();
    notifyListeners();
  }

  Future<void> openTheRecorder() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }

    await mRecorder!.openRecorder();
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
    _mRecorderIsInited = true;
  }

  void setContext(BuildContext context) {
    _context = context;
  }

  void onData(RecordingDisposition event) async {
    double? decibel = event.decibels;
    debugPrint('debugging : decibel $decibel');
    if (decibel! >= dB) {
      debugPrint('debugging : over $dB dB');

      await stop();
      FunctionClass.showPopup(_context);
      await record();
    }
  }

  // ----------------------  Here is the code for recording and playback -------

  Future<void> record() async {
    Toast.show('5초 뒤 상시모드가 시작됩니다.',
        duration: Toast.lengthLong, gravity: Toast.top);
    debugPrint('debugging : 상시모드 on');
    _recordTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      debugPrint('debugging : recordTimer ${DateTime.now().second}');
      // 녹음 시작
      await mRecorder!.startRecorder(toFile: _mPath).then((value) {
        notifyListeners();
        try {
          _recorderSubscription = mRecorder!.onProgress!.listen(onData);
          notifyListeners();
        } catch (err) {
          debugPrint('debugging : _recorderSubscription $err');
        }
        notifyListeners();
      });
    });
    regular_stt.listen(
        onResult: (SpeechRecognitionResult result) {
          _currentWords = " ${result.recognizedWords}";
          notifyListeners();
        },
        onSoundLevelChange: (level) {
          if (level >= dB) {
            print('debugging : $level -> ${regular_stt.lastRecognizedWords}');
          }
        },
        localeId: 'ko_KR',
        partialResults: false,
        listenMode: ListenMode.confirmation);
  }

  Future<void> stop() async {
    debugPrint('debugging : stop recording');
    const Duration(milliseconds: 500);
    await mRecorder!.stopRecorder().then((value) {
      _recordTimer?.cancel();
      _recorderSubscription.cancel();
      notifyListeners();
    });
  }
}
