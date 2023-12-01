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

  List<Booking> getAllAfterPresentByUserId(String userId) {
    List<Booking> listTemp = [];

    for (Booking booking in list) {
      if (booking.userId == userId &&
          booking.bookingStart.isAfter(DateTime.now())) {
        listTemp.add(booking);
      }
    }
    return listTemp;
  }

  List<Booking> getAllBeforePresentByUserId(String userId) {
    List<Booking> listTemp = [];

    for (Booking booking in list) {
      if (booking.userId == userId &&
          booking.bookingStart.isBefore(DateTime.now())) {
        listTemp.add(booking);
      }
    }
    return listTemp;
  }

  static void sortScheduleItemByAscendingTime(List<Booking> list) {
    list.sort((a, b) => a.bookingStart.compareTo(b.bookingStart));
  }

  static void sortHistoryItemByAscendingTime(List<Booking> list) {
    list.sort((a, b) => b.bookingStart.compareTo(a.bookingStart));
  }
}
