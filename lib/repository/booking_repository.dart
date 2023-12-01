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

  List<Booking> getAllByUserId(String userId) {
    List<Booking> listTemp = [];

    for (Booking booking in list) {
      if (booking.userId == userId) {
        listTemp.add(booking);
      }
    }
    return listTemp;
  }
}
