import 'package:flutter/material.dart';
import 'package:my_app/model/booking.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/network/models/schedule_api.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/network_request/schedule/get_booked_class_request.dart';
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
  Tokens tokens = Tokens();
  List<ScheduleApi> scheduleList = [];
  bool _isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    tokens = context.read<Tokens>();
    Future<dynamic> future = GetBookedClassRequest.getBookedClass(
        tokens.access?.token, 1, 20, null, 'meeting', 'desc');
    await future.then((value) {
      setState(() {
        scheduleList = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    BookingRepository bookingRepository = context.watch<BookingRepository>();
    User user = context.watch<User>();
    List<Booking>? list =
        bookingRepository.getAllAfterPresentByUserId(user.userId);
    BookingRepository.sortScheduleItemByAscendingTime(list);

    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
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
              '86 hours 40 minutes',
              style: const TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          // const Text(
          //   'Latest book',
          //   style: TextStyle(
          //       fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 5),
          // ),
          // Table(
          //   border: TableBorder.all(color: Colors.black12),
          //   columnWidths: const {
          //     0: FlexColumnWidth(1.0),
          //     1: FlexColumnWidth(2.0)
          //   },
          //   children: [
          //     TableRow(children: [
          //       TableCell(
          //         child: Container(
          //           height: 40,
          //           decoration: const BoxDecoration(
          //             color: Colors.black12,
          //           ),
          //           child: const Center(child: Text('Name')),
          //         ),
          //       ),
          //       const TableCell(
          //         child: SizedBox(
          //           height: 40,
          //           child: Center(child: Text('sample.pdf')),
          //         ),
          //       ),
          //     ]),
          //     TableRow(children: [
          //       TableCell(
          //         child: Container(
          //           height: 40,
          //           decoration: const BoxDecoration(
          //             color: Colors.black12,
          //           ),
          //           child: const Center(child: Text('Page')),
          //         ),
          //       ),
          //       const TableCell(
          //         child: SizedBox(
          //           height: 40,
          //           child: Center(child: Text('0')),
          //         ),
          //       ),
          //     ]),
          //     TableRow(children: [
          //       TableCell(
          //         child: Container(
          //           height: 40,
          //           decoration: const BoxDecoration(
          //             color: Colors.black12,
          //           ),
          //           child: const Center(child: Text('Description')),
          //         ),
          //       ),
          //       const TableCell(
          //         child: SizedBox(
          //           height: 40,
          //           child: Center(child: Text('...')),
          //         ),
          //       ),
          //     ]),
          //   ],
          // ),
          // const Padding(
          //   padding: EdgeInsets.symmetric(vertical: 20),
          // ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          else
            Column(
              children: [
                for (ScheduleApi schedule in scheduleList)
                  ScheduleItemWidget(scheduleApi: schedule)
              ],
            )
        ]),
      ),
    );
  }
}
