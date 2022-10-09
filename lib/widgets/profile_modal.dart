import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

CupertinoActionSheet profileModalBuilder(BuildContext context) {
  final items = [
    "중증 청각장애 (2~3급)",
    "경증 청각장애 (4~6급)",
    "청각중복장애 (시각 등)",
    "직접 설정",
  ];
  return CupertinoActionSheet(
    actions: [
      SizedBox(
          height: MediaQuery.of(context).size.height * 0.2,
          child: CupertinoPicker(
            backgroundColor: Colors.white.withOpacity(0.5),
            itemExtent: 50, //height of each item
            children: items
                .map((item) => Center(
                      child: Text(
                        item,
                      ),
                    ))
                .toList(),
            onSelectedItemChanged: (index) {
              profileValue = index;

              print("Selected Iem: $index");
            },
          ))
    ],
    cancelButton: CupertinoActionSheetAction(
      child: Text('확인', style: TextStyle(color: kMain)),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}
