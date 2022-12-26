import 'package:flutter/material.dart';

double bottomHeight = 80.0;

// Shared_Preference에 들어가는 변수들
String name = '';
int profileValue = 0;
bool regularValue = true;
double dB = 70;
bool darkMode = false;
int selectedColor = 7;
List<bool> fontSizes = [false, true, false];
int fontSizeId = 1;
List<bool> cases = [true, false, false];
List<List<bool>> caseDetails = [
  [true, false, true],
  [false, true, true],
  [false, false, true]
];
List<String> logList = [];

final profileItems = [
  "중증 청각장애 (2~3급)",
  "경증 청각장애 (4~6급)",
  "청각중복장애 (시각 등)",
  "직접 설정",
];
List<String> caseTitle = ['긴급 재난', '실외 위험', '실내 위험'];
List<String> detailTitle = ['진동 알림', '플래시 알림', '전체화면 알림'];
List<String> caseContents = [
  '긴급 재난 알림입니다.\n설명설명 어떤 상황인지 설명하고 예시로 뭐가 있는지 설명하고',
  '실외 위험 알림입니다.\n설명설명 어떤 상황인지 설명하고 예시로 뭐가 있는지 설명하고',
  '실내 위험 알림입니다.\n설명설명 어떤 상황인지 설명하고 예시로 뭐가 있는지 설명하고'
];

bool missedAlertOpen = true;
late bool isEmpty;

Color kMain = colorChart[selectedColor];
Color kWhite = const Color(0xFFFEFEFE);
Color kBlack = const Color(0xFF212121); // grey[900]

Color kGrey9 = const Color(0xFF303030); // grey[850]
Color kGrey8 = const Color(0xFF424242); // grey[800]
Color kGrey7 = const Color(0xFF616161); // grey[700]
Color kGrey6 = const Color(0xFF757575); // grey[600]
Color kGrey5 = const Color(0xFF9E9E9E); // grey[500]
Color kGrey4 = const Color(0xFFBDBDBD); // grey[400]
Color kGrey3 = const Color(0xFFE0E0E0); // grey[300]
Color kGrey2 = const Color(0xFFEEEEEE); // grey[200]
Color kGrey1 = const Color(0xFFFAFAFA); // grey[50]

Color kAlert1 = const Color(0xFFC80000);
Color kAlert2 = const Color(0xFFF8AE24);

double kXL = fontSizeId == 0
    ? 19
    : fontSizeId == 1
        ? 21
        : 23;
double kL = fontSizeId == 0
    ? 17
    : fontSizeId == 1
        ? 19
        : 21;
double kM = fontSizeId == 0
    ? 15
    : fontSizeId == 1
        ? 17
        : 19;
double kS = fontSizeId == 0
    ? 13
    : fontSizeId == 1
        ? 15
        : 17;
double kXS = fontSizeId == 0
    ? 11
    : fontSizeId == 1
        ? 13
        : 15;

List<bool> checked = List.filled(colorChart.length, false);
final List colorChart = [
  const Color(0xFFED504B),
  const Color(0xFFF8883D),
  const Color(0xFFFFBC50),
  const Color(0xFFBADCA4),
  const Color(0xFF53A693),
  const Color(0xFF00ABC0),
  const Color(0xFF7DA8FF),
  const Color(0xFF007FFF),
  const Color(0xFFCFB8E0),
  const Color(0xFF8C65AC),
  const Color(0xFFEC7B97),
];

List voiceScreenChat = [
  ['종료 버튼을 눌러 대화를 종료하거나 진행한 대화를 저장할 수 있습니다.', false],
  ['키보드로 입력하여 전달합니다.', true],
  ['이것은 사용자의 발화입니다.', true],
  ['대화를 인식하여 텍스트로 보여줍니다.', false],
  ['이것은 음성모드입니다.', false],
];
