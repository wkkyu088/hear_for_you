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
    var items = [1, 2, 3, 4, 5].map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
              width: screenWidth,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(color: kGrey2),
              child: Center(
                child: Text('content $i'),
              ));
        },
      );
    }).toList();

    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: 10 + statusBarHeight, left: 10, right: 10),
            width: screenWidth,
            height: 100,
            child: Stack(
              children: [
                Positioned(
                  right: 0,
                  child: TextButton(
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
                    child: Text("건너뛰기"),
                  ),
                ),
                Center(
                  child: Text(
                    "title ${currentIdx + 1}",
                    style: TextStyle(fontSize: kXL),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: CarouselSlider(
              items: items,
              carouselController: controller,
              options: CarouselOptions(
                  aspectRatio: 0.7,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.2,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIdx = index;
                    });
                  }),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "description ${currentIdx + 1}",
                style: TextStyle(fontSize: kM),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => controller.animateToPage(entry.key),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: kGrey9
                          .withOpacity(currentIdx == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
