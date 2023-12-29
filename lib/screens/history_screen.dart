import 'package:flutter/material.dart';
import 'package:my_app/model/booking.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/network/models/schedule_api.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/network_request/schedule/get_booked_class_request.dart';
import 'package:my_app/repository/booking_repository.dart';
import 'package:my_app/widgets/history_item.dart';
import 'package:provider/provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HistoryScreenState();
  }
}

class HistoryScreenState extends State<HistoryScreen> {
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
        tokens.access?.token,
        1,
        20,
        DateTime.now().millisecondsSinceEpoch,
        'meeting',
        'desc');
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
    List<Booking> list =
        bookingRepository.getAllBeforePresentByUserId(user.userId);
    BookingRepository.sortHistoryItemByAscendingTime(list);

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
                child: Image.asset('lib/assets/icons/history.png'),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const Text(
            "History",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          const Text(
            "The following is a list of lessons you have attended\n"
            "You can review the details of the lessons you have attended",
            style: TextStyle(fontSize: 17, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
            Column(
              children: [
                for (ScheduleApi schedule in scheduleList)
                  HistoryItemWidget(scheduleApi: schedule)
              ],
            )
        ]),
      ),
    );
  }
}
