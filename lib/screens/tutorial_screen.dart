import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:hear_for_you/constants.dart';
import 'package:hear_for_you/main.dart';
import 'package:hear_for_you/service/full_screen_alert/view/alarm_observer.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  int currentIdx = 0;
  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: darkMode ? kBlack : kGrey1,
      systemNavigationBarIconBrightness:
          darkMode ? Brightness.light : Brightness.dark,
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
      statusBarBrightness: darkMode ? Brightness.dark : Brightness.light,
    ));

    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    var items = [0, 1, 2, 3, 4, 5, 6, 7, 8].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Center(
                child: Image.asset(
                    "lib/assets/images/tutorial$i.${i == 0 ? "png" : "PNG"}"),
              ));
        },
      );
    }).toList();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFF999999),
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 20 + statusBarHeight, left: 10, right: 10),
                width: screenWidth,
                height: 100,
                alignment: Alignment.center,
                child: Text("원활한 앱 사용을 위해 꼭 읽어주세요 !",
                    style: TextStyle(fontSize: kL, color: kWhite)),
              ),
              Expanded(
                child: SizedBox(
                  width: screenWidth,
                  child: CarouselSlider(
                    items: items,
                    carouselController: controller,
                    options: CarouselOptions(
                        aspectRatio: 9 / 16,
                        viewportFraction: 1,
                        initialPage: 0,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        enlargeFactor: 0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentIdx = index;
                          });
                        }),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: items.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => controller.animateToPage(entry.key),
                          child: Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 5.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    currentIdx == entry.key ? kBlack : kGrey4),
                          ),
                        );
                      }).toList(),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AlarmObserver(
                                child: BottomNavBar(selectedIndex: 1)),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "건너뛰기",
                        style: TextStyle(color: kWhite, fontSize: kS),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
