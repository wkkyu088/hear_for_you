import 'package:flutter/cupertino.dart';
import 'notification.dart' as notice;
import 'package:pytorch_mobile/model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pytorch_mobile/pytorch_mobile.dart';

class ModelClass {
  static late Model model;
  initState() {
    // Constructor에서 MakeModel 실행 -> 바로 모델 빌드 가능하도록.
    // Splash Screen에서 ModelClass를 실행해줘야 할듯.
    makeModel();
  }

  // 모델을 불러오는 부분.
  static Future<String> makeModel() async {
    try {
      model = await PyTorchMobile.loadModel(
          'assets/model/model_60 Epochs_DNN_221117.pt');
      return "모델 불러오기 완료";
    } catch (e) {
      return "모델 불러오기에서 오류 발생 : $e";
    }
  }

  static Future<int> prediction(List<double> mfccs) {
    // mfccs를 그대로 받아서 바로 prediction에 넣어보자. 어떻게 잘 되나...

    return Future<int>.delayed(const Duration(seconds: 5), () {
      return 4;
    });
  }
}

class ModelPopup extends StatefulWidget {
  const ModelPopup({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => PopupState();
}

class PopupState extends State<ModelPopup> {
  Widget object = loadingWidget();
  @override
  initState() {
    super.initState();
    Future<int> prediction = ModelClass.prediction([1, 2, 3, 4, 5]);

    prediction.then((val) {
      object = resultWidget(val);
      setState(() {});
    }).catchError((error) {
      object = resultWidget(-1);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [Center(child: Text("소리 감별 중입니다")), object]);
  }
}

Widget loadingWidget() {
  return Center(child: Text("분석중입니다"));
}

Widget resultWidget(int result) {
  String? content = '가 들립니다. 주의하세요.';

  switch (result) {
    case 0:
      content = "개 짖는 소리$content";
      break;

    case 1:
      content = "차량 사이렌 소리$content";
      break;

    case 2:
      content = "차량 경적 소리$content";
      break;

    case 3:
      content = "총소리$content";
      break;

    case 4:
      content = "화재 사이렌 소리$content";
      break;

    case 5:
      content = "비명소리$content";
      break;

    case 6:
      content = "차량 급정거 소리$content";
      break;

    default:
      content = "분석에 실패하였습니다.";
  }
  notice.showNotification(content);
  return Center(child: Text(content));
}
