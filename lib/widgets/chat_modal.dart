// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

import '../constants.dart';

_saveAsImage(globalKey, String fileName) async {
  RenderRepaintBoundary boundary =
      globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
  ui.Image image = await boundary.toImage();
  ByteData? byteData = await (image.toByteData(format: ui.ImageByteFormat.png));
  if (byteData != null) {
    final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        name: '$fileName-chat');
    print(result);
  }
}

/// storage/emulated/0/Android/data/com.example.hear_for_you/files/2022-12-17T12:41:41.844957.txt
_saveAsText(String fileName) async {
  final dir = await getExternalStorageDirectory();
  List reChatList = [];
  for (int i = 0; i < voiceScreenChat.length; i++) {
    if (voiceScreenChat[i][1] == true) {
      reChatList.add('[나]\t{$voiceScreenChat[i][0]}\n');
    } else {
      reChatList.add('[상대방]\t{$voiceScreenChat[i][0]}\n');
    }
  }
  print(reChatList);
  File('${dir!.path}/$fileName-chat.txt').writeAsString(reChatList.toString());
}

_endChat(context) {
  isEmpty = true;
  voiceScreenChat = [];
  Navigator.pop(context);
}

// 음성모드 저장시 뜨는 모달
CupertinoActionSheet chatModalBuilder(BuildContext context,
    {globalKey = GlobalKey}) {
  final fileName = DateTime.now().toIso8601String();

  return CupertinoActionSheet(
    actions: [
      // 전체 대화 이미지로 저장
      CupertinoActionSheetAction(
        child: const Text('이미지로 저장하기'),
        onPressed: () {
          _saveAsImage(globalKey, fileName);
          _endChat(context);

          // 음성모드 초기화면으로 가기
        },
      ),
      // 전체 대화 텍스트 파일로 저장
      CupertinoActionSheetAction(
        onPressed: () {
          _saveAsText(fileName);
          _endChat(context);
        },
        child: Text('텍스트 파일로 저장하기'),
      ),
      // 종료하고 대화 초기화하기
      CupertinoActionSheetAction(
        child: const Text(
          '종료하기',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          _endChat(context);
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
