import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class AlarmScheduler {
  static Future<void> scheduleRepeatable(DateTime time) async {
    await AndroidAlarmManager.oneShotAt(
      time,
      1,
      _emptyCallback,
      alarmClock: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
    debugPrint('Alarm scheduled at $time');
  }
}

void _emptyCallback() {}
