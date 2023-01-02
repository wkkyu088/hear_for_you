// import 'package:flutter/material.dart';
// import 'package:hear_for_you/constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../provider/permission_provider.dart';
// import 'package:provider/provider.dart';

// class PermissionRequestScreen extends StatefulWidget {
//   const PermissionRequestScreen({
//     Key? key,
//     required this.child,
//   }) : super(key: key);

//   final Widget child;

//   @override
//   State<PermissionRequestScreen> createState() =>
//       _PermissionRequestScreenState();
// }

// class _PermissionRequestScreenState extends State<PermissionRequestScreen> {
//   bool isSystemAlertWindowGranted = false;
//   bool isNotificationGranted = false;
//   bool isSpeechGranted = false;

//   @override
//   void initState() {
//     permissionCheck();
//     super.initState();
//   }

//   void permissionCheck() async {
//     final SharedPreferences pref = await SharedPreferences.getInstance();

//     isSystemAlertWindowGranted =
//         pref.getBool("systemAlertWindowGranted") ?? false;
//     isNotificationGranted = pref.getBool("notificationGranted") ?? false;
//     isSpeechGranted = pref.getBool("speechGranted") ?? false;

//     print("########## 권한 체크 ##########");
//     print("앱 위 : $isSystemAlertWindowGranted");
//     print("노티 : $isNotificationGranted");
//     print("녹음 : $isSpeechGranted");
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double screenWidth = MediaQuery.of(context).size.width;
//     final double screenHeight = MediaQuery.of(context).size.height;

//     permissionCheck();

//     return Consumer<PermissionProvider>(
//       builder: (context, provider, _) {
//         if (provider.isGrantedAll()) {
//           return widget.child;
//         }
//         return Scaffold(
//           body: Stack(
//             children: [
//               Container(
//                 width: screenWidth,
//                 height: screenHeight,
//                 alignment: Alignment.bottomCenter,
//                 child: Image.asset("lib/assets/images/blur_image.jpg"),
//               ),
//               Container(
//                 width: screenWidth,
//                 height: screenHeight,
//                 alignment: Alignment.bottomCenter,
//                 color: Colors.black.withOpacity(0.5),
//               ),
//               Center(
//                 child: Container(
//                   width: screenWidth * 0.8,
//                   height: screenHeight * 0.6,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: kWhite,
//                     borderRadius: BorderRadius.circular(18),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Text(
//                           '히어포유 사용을 위해\n다음 권한을 허용해 주시기 바랍니다.',
//                           style: TextStyle(fontSize: kXL),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       Container(
//                         height: 1,
//                         color: kGrey2,
//                         margin: const EdgeInsets.symmetric(vertical: 30),
//                       ),
//                       Text(
//                         '필수 접근 권한',
//                         style: TextStyle(fontSize: kM),
//                       ),
//                       Row(
//                         children: [
//                           Icon(isSystemAlertWindowGranted
//                               ? Icons.check_rounded
//                               : Icons.close_rounded),
//                           TextButton(
//                             onPressed: provider.requestSystemAlertWindow,
//                             child: const Text('다른 앱 위에 표시 설정하기'),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(isNotificationGranted
//                               ? Icons.check_rounded
//                               : Icons.close_rounded),
//                           TextButton(
//                             onPressed: provider.requestNotification,
//                             child: const Text('기기 알림 설정하기'),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(isSpeechGranted
//                               ? Icons.check_rounded
//                               : Icons.close_rounded),
//                           TextButton(
//                             onPressed: provider.requestSpeech,
//                             child: const Text('음성 녹음 설정하기'),
//                           ),
//                         ],
//                       ),
//                       Expanded(child: Container()),
//                       Text(
//                         '접근권한 변경 방법',
//                         style: TextStyle(fontSize: kM),
//                       ),
//                       const SizedBox(height: 20),
//                       Text(
//                         '휴대폰 설정 > 앱 또는 어플리케이션 설정',
//                         style: TextStyle(fontSize: kXS),
//                         textAlign: TextAlign.center,
//                       ),
//                       Text("########## 권한 체크 ##########"),
//                       Text("앱 위 : $isSystemAlertWindowGranted"),
//                       Text("노티 : $isNotificationGranted"),
//                       Text("녹음 : $isSpeechGranted"),
//                       Row(
//                         children: [
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text('취소'),
//                           ),
//                           TextButton(
//                             onPressed: () {},
//                             child: const Text('확인'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
