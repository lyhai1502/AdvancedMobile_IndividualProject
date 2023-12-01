import 'package:flutter/material.dart';
import 'package:my_app/model/booking.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/repository/booking_repository.dart';
import 'package:my_app/widgets/schedule_item.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScheduleScreenState();
  }
}

class ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    BookingRepository bookingRepository = context.watch<BookingRepository>();
    User user = context.watch<User>();
    List<Booking> list = bookingRepository.getAllByUserId(user.userId);
    sortScheduleItemByAscendingTime(list);

    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(30),
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Image.asset('lib/assets/icons/schedule.png'),
              ),
            ],
          ),
          const Text(
            "Schedule",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const Text(
            "Here is a list of the sessions you have booked "
            "You can track when the meeting starts, join the meeting with one click or can cancel the meeting before 2 hours",
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          const Text(
            'Total study hours',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${list.length * 25 ~/ 60} hours  ${list.length * 25 % 60} minutes',
              style: const TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const Text(
            'Latest book',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Table(
            border: TableBorder.all(color: Colors.black12),
            columnWidths: const {
              0: FlexColumnWidth(1.0),
              1: FlexColumnWidth(2.0)
            },
            children: [
              TableRow(children: [
                TableCell(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Center(child: Text('Name')),
                  ),
                ),
                const TableCell(
                  child: SizedBox(
                    height: 40,
                    child: Center(child: Text('sample.pdf')),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Center(child: Text('Page')),
                  ),
                ),
                const TableCell(
                  child: SizedBox(
                    height: 40,
                    child: Center(child: Text('0')),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Center(child: Text('Description')),
                  ),
                ),
                const TableCell(
                  child: SizedBox(
                    height: 40,
                    child: Center(child: Text('...')),
                  ),
                ),
              ]),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          Column(
            children: [
              for (Booking booking in list) ScheduleItemWidget(booking: booking)
            ],
          )
        ]),
      ),
    );
  }

  void sortScheduleItemByAscendingTime(List<Booking> list) {
    list.sort((a, b) => a.bookingStart.compareTo(b.bookingStart));
  }
}
