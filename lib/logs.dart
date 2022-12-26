// 오직 로그 저장을 위한 파일

/// 로그는 각각의 로그가 모두 List<dynamic>의 형태
/// [분류 결과(String), 발생 시간(DateTime), 확인 결과(false)]
/// DateTime의 사용 방법은
/// import 'package:intl/intl.dart'; 한 후에
/// https://api.flutter.dev/flutter/intl/DateFormat-class.html 사이트 참조하기.
///
/// Example)
/// f = DateFormat("yyyy년 M월 d일 H시 m분 s초");
///    _time = f.format(DateTime.now());
/// 한 경우에 2022년 3월 29일 17시 8분 2초 로 나옴.
///
/// f = DateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초");
/// 로 바꾼다면 2022년 03월 29일 17시 08분 02초 로 나옴.

List<List<dynamic>> logList = [];
