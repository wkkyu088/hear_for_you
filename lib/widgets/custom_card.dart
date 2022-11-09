import 'package:flutter/material.dart';

import 'package:hear_for_you/constants.dart';

// 구분자, 회색 실선
Widget spacer(margin) {
  return Container(
    margin: margin,
    height: 1,
    color: darkMode ? kGrey8 : kGrey2,
  );
}

// 설정 영역을 구분할 커스텀 카드
Widget customCard(title, child, padding, {nontitle = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      nontitle
          ? Container()
          : Container(
              padding: const EdgeInsets.only(left: 10, bottom: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(color: kGrey4, fontSize: kXS),
              ),
            ),
      Container(
        padding: padding,
        margin: const EdgeInsets.only(bottom: 22),
        decoration: BoxDecoration(
          color: darkMode ? kGrey9 : kWhite,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: darkMode ? kBlack : kBlack.withOpacity(0.05),
              spreadRadius: 3,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: child,
      ),
    ],
  );
}
