import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'regular_module_v2.dart';

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
    context.read<RecordModule>().dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecordModule>(builder: (context, state, child) {
      return Scaffold(
          backgroundColor: Colors.blue,
          appBar: AppBar(
            title: const Text('Simple Recorder'),
          ),
          body: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(3),
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF0E6),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 3,
                  ),
                ),
                child: Row(children: [
                  ElevatedButton(
                    onPressed: context.read<RecordModule>().getRecorderFn(),
                    child:
                        Text(state.mRecorder!.isRecording ? 'Stop' : 'Record'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(state.mRecorder!.isRecording
                      ? 'Recording in progress'
                      : 'Recorder is stopped'),
                ]),
              ),
              Container(
                margin: const EdgeInsets.all(3),
                padding: const EdgeInsets.all(3),
                height: 80,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFFAF0E6),
                  border: Border.all(
                    color: Colors.indigo,
                    width: 3,
                  ),
                ),
                child: Row(children: [
                  ElevatedButton(
                    onPressed: context.read<RecordModule>().getPlaybackFn(),
                    //color: Colors.white,
                    //disabledColor: Colors.grey,
                    child: Text(state.mPlayer!.isPlaying ? 'Stop' : 'Play'),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(state.mPlayer!.isPlaying
                      ? 'Playback in progress'
                      : 'Player is stopped'),
                ]),
              ),
            ],
          ));
    });
  }
}
