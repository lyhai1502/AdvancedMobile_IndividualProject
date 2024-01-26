import 'package:flutter/material.dart';
import 'package:my_app/network/model/schedule_api.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/network/network_request/schedule/get_schedule_booked_class_request.dart';
import 'package:my_app/repository/schedule_repository.dart';
import 'package:my_app/screen/schedule/schedule_item.dart';
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
  ScheduleRepository scheduleRepository = ScheduleRepository();
  bool _isLoading = true;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    _isLoading = true;
    tokens = context.read<Tokens>();
    Future<dynamic> future =
        GetScheduleBookedClassRequest.getScheduleBookedClass(
            tokens.access?.token, currentPage, 2, null, 'meeting', 'asc');
    await future.then((value) {
      setState(() {
        scheduleRepository.scheduleList = value;
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
                for (ScheduleApi schedule in scheduleRepository.scheduleList)
                  ScheduleItemWidget(scheduleApi: schedule)
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
              if (scheduleRepository.scheduleList.length == 2) currentPage++;
              getData();
            });
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
