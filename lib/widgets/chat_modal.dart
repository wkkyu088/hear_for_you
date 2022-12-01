import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';

// 음성모드 저장시 뜨는 모달
CupertinoActionSheet chatModalBuilder(BuildContext context, globalKey) {
  // 채팅 내역 캡처하여 디바이스에 저장
  void captureChat() async {
    print("START CAPTURE");
    var renderObject = globalKey.currentContext.findRenderObject();
    if (renderObject is RenderRepaintBoundary) {
      var boundary = renderObject;
      ui.Image image = await boundary.toImage();
      final directory = (await getApplicationDocumentsDirectory()).path;
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List? pngBytes = byteData?.buffer.asUint8List();
      print(pngBytes);
      File imgFile = File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes!);
      print("FINISH CAPTURE ${imgFile.path}");
      // /data/user/0/com.example.hear_for_you/app_flutter/screenshot.png
    }
  }

  return CupertinoActionSheet(
    actions: [
      // 전체 대화 이미지로 저장
      CupertinoActionSheetAction(
        child: const Text('이미지로 저장하기'),
        onPressed: () {
          captureChat();
        },
      ),
      // 전체 대화 텍스트 파일로 저장
      CupertinoActionSheetAction(
        child: const Text('텍스트 파일로 저장하기'),
        onPressed: () {},
      ),
      // 종료하고 대화 초기화하기
      CupertinoActionSheetAction(
        child: const Text(
          '종료하기',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          isEmpty = true;
          voiceScreenChat = [];
          Navigator.pop(context);
        },
      ),
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('취소', style: TextStyle(color: kMain)),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
