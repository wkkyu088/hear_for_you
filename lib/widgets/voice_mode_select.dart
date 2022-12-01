import 'package:flutter/material.dart';

import '../constants.dart';

Widget voiceModeSelect(color, borderRadius, padding, icon, text, onTap,
    {isRight = false}) {
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: color.withOpacity(0.5),
            borderRadius: borderRadius,
          ),
        ),
        Positioned(
          bottom: 0,
          right: isRight ? 0 : null,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color.withOpacity(0.5),
              borderRadius: borderRadius,
            ),
            child: Container(
              padding:
                  EdgeInsets.only(top: 15, left: padding[0], right: padding[1]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: kWhite,
                    size: 35,
                  ),
                  Text(
                    text,
                    style: TextStyle(color: kWhite, fontSize: kXS),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
