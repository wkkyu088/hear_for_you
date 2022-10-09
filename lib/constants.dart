import 'package:flutter/material.dart';

int profileValue = 2;
bool regularValue = true;
double dB = 70;
List<String> caseTitle = ['긴급 재난', '실외 위험', '실내 위험'];
List<String> detailTitle = ['진동 알림', '플래시 알림', '전체화면 알림'];
List<bool> cases = [true, false, false];
List<List<bool>> caseDetails = [
  [true, false, true],
  [false, true, true],
  [false, false, true]
];
List<String> caseContents = [
  '긴급 재난 알림입니다.\n설명설명 어떤 상황인지 설명하고 예시로 뭐가 있는지 설명하고',
  '실외 위험 알림입니다.\n설명설명 어떤 상황인지 설명하고 예시로 뭐가 있는지 설명하고',
  '실내 위험 알림입니다.\n설명설명 어떤 상황인지 설명하고 예시로 뭐가 있는지 설명하고'
];
bool darkMode = false;
int fontSize = 15;

Color kMain = const Color(0xFFED7D31);
