import 'dart:io';
import 'package:dio/dio.dart';
import 'package:wav/wav.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart' as setting;
import 'notification.dart' as notification;

class FunctionClass {
  // 이 함수를 부르면 파일 자르기, 서버로 데이터 전송, 데이터 받아서 반환 등의 과정을 자동으로 처리하고 알람을 띄워줌
  static Future<String> getPrediction() async {
    try {
      var cuttedPath = await cutFile();
      var result = await uploadFile();
      return result;
    } catch (e) {
      print("Processing에서 에러 처리");
      // 처리 과정 중 에러가 발생했으면 여기서도 에러 반환
      rethrow;
      // throw e.toString();
    }
  }

  // 일정 데시벨 이상의 소리가 울렸을 때, 저장된 경로를 반환해주는 함수.
  // fileName에 아무 값도 넣지 않으면 초기 음원파일이 저장된 경로를 반환하고, 파일명이 들어온다면 해당 파일명을 넣어서 반환해준다.
  static Future<String> getPath({fileName = "audio.wav"}) async {
    var appDirectory = await getApplicationDocumentsDirectory();
    return "${appDirectory.path}/$fileName";
  }

  // 파일을 마지막 1초만 두고 자르고, 자른 파일의 경로를 반환해주는 함수
  static Future<String> cutFile() async {
    try {
      String path = await getPath();
      print("cutFile : 읽어올 경로는 $path입니다");

      // wav package를 이용하여 경로의 파일을 읽기
      var readedFile = await Wav.readFile(path);

      // 잘린 파일의 channel을 보니 두개이다! 왼쪽,오른쪽이라고 하는데 첫번째것만 남기기
      print("channels의 길이 : ${readedFile.channels.length}");

      // 전체 길이 - samplesPerSecond부터 슬라이싱하면 마지막 1초간의 데이터만 남게 됨
      for (int i = 0; i < readedFile.channels.length; i++) {
        readedFile.channels[i] = readedFile.channels[i].sublist(
            readedFile.channels[i].length - readedFile.samplesPerSecond,
            readedFile.channels[i].length);
      }

      // 잘린 데이터의 길이 재확인하기, 1초간의 데이터이면 samplesPerSecond와 같은 길이를 가져야 함.
      // 같지 않다면 Exception을 출력하도록 함
      if (readedFile.channels[0].length != readedFile.samplesPerSecond) {
        throw const FormatException("데이터를 제대로 자르지 못했습니다");
      }

      // 파일 저장하기
      path = await getPath(fileName: "cuttedFile.wav");
      print("cutFile : 저장할 경로는 $path입니다");
      readedFile.writeFile(path);

      return path;
    } catch (e) {
      rethrow;
    }
  }

  // 서버와 상호작용하고 결과를 반환해준다
  static Future<String> uploadFile() async {
    try {
      var pref = await SharedPreferences.getInstance();
      // 기록을 위한 로그파일 불러오기
      String singleLog = "";

      // dio 생성 (http request를 수행해줌)
      var dio = Dio();
      var target = await getPath(fileName: "cuttedFile.wav");
      print("uploadFile : 전송할 파일은 $target");

      // 접속할 주소 설정, 만약 외부 서버를 쓴다면 외부 서버의 ip를 입력해주면 됨!
      const address = "http://3.39.56.58:8000";
      // const address = "http://127.0.0.1:8000";

      // 파일 경로를 통해 전달할 데이터를 생성함
      // 현재는 파일과 유저명을 전달하는데, 유저명이 겹칠 수 있으므로 유저번호?를 사용해도 좋을 듯!
      var formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(target),
        // 이거 유저네임을 어떻게 받아오는지?..
        'userName': setting.name
      });

      print("uploadFile : 파일 폼데이터 만들기에 성공했습니다");

      // dio객체를 이용해서 서버와 상호작용하는 부분
      var response = await dio.post("$address/uploadFile", data: formData);
      print("uploadFile : 서버와 통신에 성공했습니다.");

      // 서버가 반환해준 결과를 result에 저장
      var result = response.data['prediction'];
      var message = response.data['message'];

      if (result == "unknown") {
        notification.showNotification("분석 실패", "큰 소리가 발생했습니다. 주변을 확인하세요");
      } else {
        notification.showNotification("분석 성공", "$result가 들립니다. 주의하세요");
      }

      // 로그에 분석 결과와 분석 시간 삽입, 확인 여부는 일단 False로 하고 넣기
      singleLog += "$result,";
      singleLog += "${DateFormat("HH시 mm분 ss초").format(DateTime.now())},";
      singleLog += "false,";
      singleLog += "${getMinuteValue(DateTime.now())}";
      setting.logList.add(singleLog);

      // 갯수가 5개가 넘어가면 하나씩 지우기
      if (setting.logList.length > 5) {
        setting.logList.removeAt(0);
      }

      // 이후 SharedPreference에 저장
      pref.setStringList("logList", setting.logList);
      //반환된 값이 null이라면 분석에 실패한 것이므로 exception을 반환
      if (result == "unknown") {
        throw SignalException;
      } else {
        return result.toString();
      }
    } catch (e) {
      rethrow;
    }
  }

  static bool lowerDecibelCheck() {
    try {
      // 가장 최근에 발생한(4번째로 저장되어있는) 큰 소리의 시간을 가져오기
      String timeLatest = setting.logList[4].split(",")[3];
      // 이것보다 5개 이전에 발생한(0번쨰로 저장되어있는)
      // 이 때 기록된 것이 5개 이하라면 여기서 오류가 날 수 있으므로 try-catch
      String timePrevious = setting.logList[0].split(",")[3];

      // 비교를 위해 int형으로 변환
      int minLatest = int.parse(timeLatest);
      int minPrevious = int.parse(timePrevious);

      // 둘을 뺐을 때 10이하면, 데시벨 이상의 소리가 10분 이내에 5번 발생한 것이므로 true를 반환해서 내리도록, 아니면 false 반환
      if (minLatest - minPrevious < 10) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // 에러가 났을 경우에는 기록된 것이 5개 이하인 경우일 것이므로 false 반환
      print("decibelCheck에서 에러 : $e");
      return false;
    }
  }

  // DateTime 자로형을 Minute단위로 바꿔서 반환
  static int getMinuteValue(DateTime time) {
    int forReturn = 0;
    forReturn += (int.parse(DateFormat("dd").format(DateTime.now())) * 60 * 24);
    forReturn += (int.parse(DateFormat("HH").format(DateTime.now())) * 60);
    forReturn += (int.parse(DateFormat("mm").format(DateTime.now())));
    return forReturn;
  }

  /// @@@@@@ 저장되었던 logList를 로그에 사용할 String의 리스트로 반환해준다. @@@@@@@
  /// Example --------------------------------------------------------
  /// ["사이렌 소리가 17시 30분 24초에 발생하였습니다. 확인하셨나요?",
  /// "차량 급정거 소리가 18시 31분 02초에 발생하였습니다. 확인하셨나요?"]
  /// ----------------------------------------------------------------
  static List<String> getLogString() {
    List<String> logList = [];
    for (int i = 0; i < setting.logList.length; i++) {
      var splitted = setting.logList[i].split(",");
      //if (splitted[0] != "unknown" && splitted[2] == "false") {
      logList.add("${splitted[0]}가 ${splitted[1]}에 발생하였습니다. 확인하셨나요?");
      //}
    }
    return logList;
  }
}
