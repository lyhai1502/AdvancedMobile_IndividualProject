import 'package:flutter/material.dart';
import 'package:my_app/network/model/schedule_api.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/network/network_request/history/get_history_booked_class_request.dart';
import 'package:my_app/screen/history/history_item.dart';
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
  int currentPage = 1;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    _isLoading = true;
    tokens = context.read<Tokens>();
    Future<dynamic> future = GetHistoryBookedClassRequest.getHistoryBookedClass(
        tokens.access?.token, currentPage, 9, 'meeting', 'desc');
    await future.then((value) {
      setState(() {
        scheduleList = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(vertical: 10),
          ),
          _buildPaginationButtons(),
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
                  HistoryItemWidget(scheduleApi: schedule)
              ],
            )
        ]),
      ),
    );
  }

  Widget _buildPaginationButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              if (currentPage > 1) {
                currentPage--;
                getData();
              }
            });
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        Text(
          '$currentPage',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              if (scheduleList.length == 9) currentPage++;
              getData();
            });
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
