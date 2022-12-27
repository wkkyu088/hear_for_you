import 'package:flutter/material.dart';

import 'package:hear_for_you/constants.dart';

import '../service/Functions.dart';

// 미확인 알림 팝업

class MissedAlert extends StatefulWidget {
  final String title;
  final DateTime time;
  const MissedAlert({Key? key, required this.title, required this.time})
      : super(key: key);

  @override
  State<MissedAlert> createState() => _MissedAlertState();
}

class _MissedAlertState extends State<MissedAlert> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Positioned(
      left: 15,
      right: 15,
      bottom: 90,
      // 1. 외부 컨테이너
      child: Container(
        width: screenWidth,
        height: 120,
        padding: const EdgeInsets.only(top: 5, bottom: 12, left: 15, right: 15),
        decoration: BoxDecoration(
          color: darkMode ? kGrey8.withOpacity(0.8) : kWhite.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: darkMode ? kBlack : kBlack.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 15,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // 2. 팝업 이름와 팝업 끄기 버튼
            Row(
              children: [
                Text(
                  '미확인 알림',
                  style: TextStyle(fontSize: kXS, color: kGrey5),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    size: 20,
                    color: kGrey5,
                  ),
                  onPressed: () {
                    setState(() {
                      missedAlertOpen = !missedAlertOpen;
                    });
                  },
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            // 3. 알림 이름과 알림이 발생된 시각
            Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'PretendardBold',
                    fontSize: kS,
                    color: darkMode ? kWhite : kBlack,
                  ),
                  children: [
                    TextSpan(
                        text: widget.title, style: TextStyle(fontSize: kL)),
                    TextSpan(
                        text: ' (${widget.time.hour}시 ${widget.time.minute}분)'),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // 4. 확인 버튼
            Row(
              children: [
                Text(
                  '확인하셨나요?',
                  style: TextStyle(
                      fontSize: kM, color: darkMode ? kWhite : kBlack),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '네',
                    style: TextStyle(fontSize: kS, color: kMain),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    '아니오',
                    style: TextStyle(fontSize: kS, color: kGrey5),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
