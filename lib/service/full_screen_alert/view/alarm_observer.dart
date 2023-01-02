import 'package:flutter/material.dart';
import '../provider/alarm_provider.dart';
import '../provider/alarm_state.dart';
import 'package:provider/provider.dart';
import '../service/alarm_polling_worker.dart';
import '../view/alarm_screen.dart';

class AlarmObserver extends StatefulWidget {
  final Widget child;

  const AlarmObserver({Key? key, required this.child}) : super(key: key);

  @override
  State<AlarmObserver> createState() => _AlarmObserverState();
}

class _AlarmObserverState extends State<AlarmObserver>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        AlarmPollingWorker().createPollingWorker(context.read<AlarmState>());
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AlarmState>(builder: (context, state, child) {
      Widget? alarmScreen;

      if (state.isFired) {
        // final callbackId = state.callbackAlarmId!;
        // debugPrint("observer callbakId: $callbackId");
        List? alarmInfo = context.read<AlarmProvider>().getAlarm();
        DateTime? time = alarmInfo![0];
        String alarmName = alarmInfo[1];
        // debugPrint("observer isFired ${state.isFired}");
        debugPrint("observer time $time");
        if (time != null) {
          debugPrint("screen on time ${DateTime.now()}");
          alarmScreen = AlarmScreen(alarmName: alarmName);
        }
      }
      return IndexedStack(
        index: alarmScreen != null ? 0 : 1,
        children: [
          alarmScreen ?? Container(),
          widget.child,
        ],
      );
    });
  }
}
