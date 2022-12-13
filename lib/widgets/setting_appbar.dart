import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

// 설정 페이지들의 커스텀 앱바
PreferredSizeWidget settingAppbar(title, context, {isLeading = true}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    systemOverlayStyle:
        darkMode ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
    centerTitle: true,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'PretendardBold',
        fontSize: kL,
        color: darkMode ? kWhite : kBlack,
      ),
    ),
    leading: isLeading
        ? IconButton(
            icon: Icon(
              Icons.chevron_left_rounded,
              size: 25,
              color: darkMode ? kWhite : kBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : Container(),
  );
}
