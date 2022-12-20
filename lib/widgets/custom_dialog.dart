import 'package:flutter/material.dart';
import '../constants.dart';

customDialog(title, content) {
  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actionsAlignment: MainAxisAlignment.spaceEvenly,
    contentPadding: const EdgeInsets.only(top: 30, bottom: 10),
    // 다이얼로그 제목
    title: Center(child: Text(title)),
    // 다이얼로그 본문
    content: Text(
      content,
      style: TextStyle(color: kBlack, fontSize: kM),
      textAlign: TextAlign.center,
    ),
    // 하단 버튼 (onPressed 따로 설정 필요)
    actions: [
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(primary: kGrey4),
        child: Text('취소', style: TextStyle(color: kGrey4, fontSize: kS)),
      ),
      TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(primary: kGrey4),
        child: Text("확인", style: TextStyle(color: kGrey9, fontSize: kS)),
      ),
    ],
  );
}
