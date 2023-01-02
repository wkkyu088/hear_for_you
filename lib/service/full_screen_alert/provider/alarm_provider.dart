import 'package:flutter/material.dart';

class AlarmProvider extends ChangeNotifier {
  DateTime? _time;
  String? _alarmName;

  void setAlarm(time, alarmName) {
    if (time != null) {
      _time = time;
      _alarmName = alarmName;
      notifyListeners();
    }
  }

  List? getAlarm() {
    if (_time != null) {
      return [_time, _alarmName];
    }
    return null;
  }
}
