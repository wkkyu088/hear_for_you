import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class AlarmScheduler {
  static Future<void> scheduleRepeatable(DateTime time) async {
    final today = DateTime.now();
    // final fireTime = DateTime(
    //   today.year,
    //   today.month,
    //   today.day,
    //   today.hour,
    //   today.minute,
    //   today.second,
    //   today.microsecond + 100,
    // );
    // final callbackId = alarm.callbackIdOf();
    // await _oneShot(1,
    //     DateTime(today.year, today.month, today.day, alarm.hour, alarm.minute));
    // await _oneShot(1, time);
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
