import 'package:flutter/material.dart';
import 'package:hear_for_you/widgets/setting_appbar.dart';

import '../../constants.dart';

class Developers extends StatelessWidget {
  const Developers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    List colors = [Colors.blue, Colors.red, Colors.brown];

    Widget profile(n, name, List desc) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: [
            n != 2
                ? Stack(
                    children: [
                      Positioned(
                        right: 0,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: n == 1
                                ? colors[0].withOpacity(0.15)
                                : colors[2].withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Image.asset("lib/assets/images/dev0$n.png"),
                      ),
                    ],
                  )
                : Container(),
            Container(
              width: screenWidth - 160 - 50,
              height: 160,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "$name",
                    style: TextStyle(
                        fontSize: kL,
                        color: colorChart[5],
                        fontFamily: 'PretendardBold'),
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ListView.builder(
                      itemCount: desc.length,
                      itemBuilder: ((context, i) {
                        return Container(
                          padding: const EdgeInsets.all(2),
                          alignment: Alignment.center,
                          child: Text(
                            "#${desc[i]}",
                            style: TextStyle(
                                fontSize: kS - 1,
                                color: kBlack,
                                fontFamily: 'PretendardLight'),
                          ),
                        );
                      }),
                    ),
                  )
                ],
              ),
            ),
            n == 2
                ? Stack(
                    children: [
                      Positioned(
                        left: 0,
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: colors[1].withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 160,
                        child: Image.asset("lib/assets/images/dev0$n.png"),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: darkMode ? kBlack : kGrey1,
      appBar: settingAppbar('?????? ?????????', context),
      body: RawScrollbar(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              margin: const EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  profile(1, "?????????", ["??????", "????????? ??????", "Android??????"]),
                  profile(2, "?????????", ["????????? ??????", "iOS??????", "AI??????"]),
                  profile(3, "?????????", ["????????? ??????", "Android??????", "UI?????????"]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
