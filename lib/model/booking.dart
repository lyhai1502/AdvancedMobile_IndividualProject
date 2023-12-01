import 'package:flutter/material.dart';

class Booking extends ChangeNotifier {
  late String serviceId;
  late String userId;
  late String teacherId;
  late DateTime bookingStart;
  late DateTime bookingEnd;

  Booking() {
    serviceId = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
