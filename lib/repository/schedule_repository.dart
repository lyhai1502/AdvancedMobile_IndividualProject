import 'package:flutter/material.dart';
import 'package:my_app/network/model/schedule_api.dart';

class ScheduleRepository extends ChangeNotifier {
  List<ScheduleApi> scheduleList = [];

  void update() {
    notifyListeners();
  }
}
