import 'package:flutter/material.dart';
import '../constants.dart';

// 단순 확인용으로 쓸 수 있는 버튼 1개 모달
Widget oneButtonDialog(context, title, content, btn, onPressed,
    {color = Colors.black}) {
  final screenWidth = MediaQuery.of(context).size.width;

  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actionsAlignment: MainAxisAlignment.spaceEvenly,
    contentPadding: const EdgeInsets.only(top: 30),
    insetPadding: EdgeInsets.zero,
    content: SizedBox(
      width: screenWidth * 0.7,
      height: 200,
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: kL, color: kMain),
          ),
          Expanded(
            child: Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: kM, height: 1.4, color: color),
              ),
            ),
          ),
          TextButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            style: TextButton.styleFrom(
              primary: kWhite,
              backgroundColor: kMain,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              minimumSize: const Size.fromHeight(50),
            ),
            child: Text(btn, style: TextStyle(color: kWhite, fontSize: kS)),
          ),
        ],
      ),
    ),
  );
}

// 확인 혹은 취소 중 선택할 수 있는 버튼 2개 모달
Widget twoButtonDialog(
    context, title, content, btn1, btn2, onPressed1, onPressed2,
    {isDelete = false}) {
  final screenWidth = MediaQuery.of(context).size.width;

  return AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    actionsAlignment: MainAxisAlignment.spaceEvenly,
    contentPadding: const EdgeInsets.only(top: 30),
    content: SizedBox(
      width: screenWidth * 0.7,
      height: 200,
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: kL, color: isDelete ? Colors.red : kMain)),
          Expanded(
            child: Center(
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: kM, height: 1.4),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: onPressed1,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kGrey4,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Text(btn1,
                        style: TextStyle(color: kWhite, fontSize: kS)),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: onPressed2,
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isDelete ? Colors.red : kMain,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10)),
                    ),
                    child: Text(btn2,
                        style: TextStyle(color: kWhite, fontSize: kS)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
