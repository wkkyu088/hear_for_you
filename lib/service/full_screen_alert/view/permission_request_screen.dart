import 'package:flutter/material.dart';
import 'package:hear_for_you/constants.dart';
import '../provider/permission_provider.dart';
import 'package:provider/provider.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Consumer<PermissionProvider>(
      builder: (context, provider, _) {
        if (provider.isGrantedAll()) {
          return child;
        }
        return Scaffold(
          body: Stack(
            children: [
              Container(
                width: screenWidth,
                height: screenHeight,
                alignment: Alignment.bottomCenter,
                child: Image.asset("lib/assets/images/blur_image.jpg"),
              ),
              Container(
                width: screenWidth,
                height: screenHeight,
                alignment: Alignment.bottomCenter,
                color: Colors.black.withOpacity(0.5),
              ),
              Center(
                child: Container(
                  width: screenWidth * 0.8,
                  height: screenHeight * 0.6,
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          '히어포유 사용을 위해\n다음 권한을 허용해 주시기 바랍니다.',
                          style: TextStyle(fontSize: kXL),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 1,
                        color: kGrey2,
                        margin: const EdgeInsets.symmetric(vertical: 30),
                      ),
                      Text(
                        '필수 접근 권한',
                        style: TextStyle(fontSize: kM),
                      ),
                      TextButton(
                        onPressed: provider.requestSystemAlertWindow,
                        child: const Text('다른 앱 위에 표시 설정하기'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('마이크 접근 허용 설정하기'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('기기 사진, 미디어, 파일 엑세스 설정'),
                      ),
                      Expanded(child: Container()),
                      Text(
                        '접근권한 변경 방법',
                        style: TextStyle(fontSize: kM),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '휴대폰 설정 > 앱 또는 어플리케이션 설정',
                        style: TextStyle(fontSize: kXS),
                        textAlign: TextAlign.center,
                      ),
                      // Row(
                      //   children: [
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: const Text('취소'),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: const Text('확인'),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
