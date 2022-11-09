import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

// 음성모드 저장시 뜨는 모달
CupertinoActionSheet chatModalBuilder(BuildContext context) {
  return CupertinoActionSheet(
    actions: [
      CupertinoActionSheetAction(
        child: const Text('이미지로 저장하기'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: const Text('텍스트 파일로 저장하기'),
        onPressed: () {},
      ),
      CupertinoActionSheetAction(
        child: const Text(
          '종료하기',
          style: TextStyle(color: Colors.red),
        ),
        onPressed: () {
          isEmpty = true;
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
