import 'package:flutter/material.dart';
import 'package:my_app/model/teacher.dart';

class Booking extends ChangeNotifier {
  late String serviceId;
  late String userId;
  late Teacher teacher;
  late DateTime bookingStart;
  late DateTime bookingEnd;
  late String request;

  Booking() {
    serviceId = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
