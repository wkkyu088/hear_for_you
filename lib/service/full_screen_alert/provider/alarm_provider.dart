import 'package:flutter/material.dart';

class AlarmProvider extends ChangeNotifier {
  DateTime? _time;

  void setAlarm(time) {
    if (time != null) {
      _time = time;
      notifyListeners();
    }
  }

  DateTime? getAlarm() {
    if (_time != null) {
      return _time;
    }
    return null;
  }
}
