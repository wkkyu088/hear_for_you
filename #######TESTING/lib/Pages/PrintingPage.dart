import 'package:flutter/material.dart';
import '../Settings.dart' as settings;
import '../notification.dart' as notice;

class PrintingPage extends StatefulWidget {
  const PrintingPage({Key? key}) : super(key: key);

  @override
  State<PrintingPage> createState() => PrintingPageState();
}

class PrintingPageState extends State<PrintingPage> {
  @override
  Widget build(BuildContext context) {
    //notice.showNotification(settings.value);
    return Scaffold(
        body: Center(
      child: Text(settings.value,
          style: TextStyle(
            color: Colors.blue,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )),
    ));
  }
}
