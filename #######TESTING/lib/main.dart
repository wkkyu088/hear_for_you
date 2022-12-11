import 'package:flutter/material.dart';
import 'notification.dart' as notice;
import 'Pages/InputPage.dart' as input_page;
import 'Pages/PrintingPage.dart' as printing_page;
import 'Pages/testingPage.dart' as testing_page;
import "Settings.dart" as settings;
import 'soundTestPage.dart' as sound;
import 'AI.dart' as AI;

void main() {
  settings.value = "아직 설정된 값이 없습니다";
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ours_',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.lightGreen),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainPage(),
          '/input': (context) => const input_page.InputPage(),
          '/print': (context) => const printing_page.PrintingPage(),
        });
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  // ignore: prefer_final_fields
  int _pageIndex = 0;

  //Main에서의 생성자. 생성시에 Model을 불러오기 위해 ModelClass의 makeModel 실행
  @override
  initState() {
    super.initState();
    //AI.ModelClass.makeModel();
  }

  List pageList = [
    const input_page.InputPage(),
    const printing_page.PrintingPage(),
    const testing_page.PopupTestPage(),
    const sound.SoundPage(),
  ];

  @override
  Widget build(BuildContext context) {
    notice.initNotification();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "그냥 만들어본 페이지",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'Gothic',
          ),
        ),
      ),
      body: Center(
        child: pageList[_pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: _navigationBarTapped,
          currentIndex: _pageIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.text_fields),
              label: "Input Page",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.print),
              label: "Print Page",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.temple_hindu),
              label: "Test Page",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: "Sound Page",
            ),
          ]),
    );
  }

  void _navigationBarTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }
}
