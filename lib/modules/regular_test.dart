import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'regular_module.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecordModule(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RecordScreen(),
    );
  }
}

/// Example app.
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  _RecordScreenState createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  @override
  void initState() {
    context.read<RecordModule>().initState();
    super.initState();
  }

  @override
  void dispose() {
    context.read<RecordModule>().disposeState();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<RecordModule>().setContext(context);
    ToastContext().init(context);

    return Consumer<RecordModule>(builder: (context, state, child) {
      return Scaffold(
        appBar: AppBar(),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Toast.show('5초 뒤 상시모드가 시작됩니다.',
                  duration: Toast.lengthLong, gravity: Toast.top);
              context.read<RecordModule>().record();
            },
            child: const Text('상시모드 켜기'),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              await context.read<RecordModule>().stop();
            },
            child: const Text('상시모드 끄기'),
          ),
        ])),
      );
    });
  }
}
