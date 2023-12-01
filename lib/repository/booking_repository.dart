import 'package:flutter/material.dart';
import 'package:my_app/model/booking.dart';

class BookingRepository extends ChangeNotifier {
  List<Booking> list = [];

  void add(Booking booking) {
    list.add(booking);
    notifyListeners();
  }

  void remove(Booking booking) {
    list.remove(booking);
    notifyListeners();
  }
}
