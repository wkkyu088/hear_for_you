import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Route chatModalBuilder(BuildContext context, Object? arguments) {
  return CupertinoModalPopupRoute<void>(
    barrierDismissible: false,
    builder: (BuildContext context) {
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
            onPressed: () {},
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('취소', style: TextStyle(color: Colors.orange)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );
    },
  );
}
