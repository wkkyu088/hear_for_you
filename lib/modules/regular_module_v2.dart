import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// import 'package:flutter/foundation.dart' show kIsWeb;

class RecordModule extends ChangeNotifier {
  var theSource = AudioSource.microphone;

  final _codec = Codec.aacMP4;
  String _mPath = '';
  FlutterSoundPlayer? mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? mRecorder = FlutterSoundRecorder();
  bool _mPlayerIsInited = false;
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  void initState() async {
    // var dir = getApplicationDocumentsDirectory();
    var dir = await getExternalStorageDirectory();
    _mPath = "${dir?.path}/audio.wav";

    mPlayer!.openPlayer().then((value) {
      _mPlayerIsInited = true;
      notifyListeners();
    });

    openTheRecorder().then((value) {
      _mRecorderIsInited = true;
      notifyListeners();
    });
  }

  void dispose() {
    mPlayer!.closePlayer();
    mPlayer = null;

    mRecorder!.closeRecorder();
    mRecorder = null;
  }

  Future<void> openTheRecorder() async {
    // if (!kIsWeb) {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission not granted');
    }
    // }
    await mRecorder!.openRecorder();
    // if (!await mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
    //   _codec = Codec.opusWebM;
    //   _mPath = 'tau_file.webm';
    //   if (!await mRecorder!.isEncoderSupported(_codec) && kIsWeb) {
    //     _mRecorderIsInited = true;
    //     return;
    //   }
    // }
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

  // ----------------------  Here is the code for recording and playback -------

  void record() {
    mRecorder!
        .startRecorder(
      toFile: _mPath,
      // codec: _codec,
      // audioSource: theSource,
    )
        .then((value) {
      notifyListeners();
    });
  }

  void stopRecorder() async {
    await mRecorder!.stopRecorder().then((value) {
      //var url = value;
      _mplaybackReady = true;
      notifyListeners();
    });
  }

  void play() {
    assert(_mPlayerIsInited &&
        _mplaybackReady &&
        mRecorder!.isStopped &&
        mPlayer!.isStopped);
    mPlayer!
        .startPlayer(
            fromURI: _mPath,
            //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
            whenFinished: () {
              notifyListeners();
            })
        .then((value) {
      notifyListeners();
    });
  }

  void stopPlayer() {
    mPlayer!.stopPlayer().then((value) {
      notifyListeners();
    });
  }

// ----------------------------- UI --------------------------------------------

  void Function()? getRecorderFn() {
    if (!_mRecorderIsInited || !mPlayer!.isStopped) {
      return null;
    }
    return mRecorder!.isStopped ? record : stopRecorder;
  }

  void Function()? getPlaybackFn() {
    if (!_mPlayerIsInited || !_mplaybackReady || !mRecorder!.isStopped) {
      return null;
    }
    return mPlayer!.isStopped ? play : stopPlayer;
  }
}
