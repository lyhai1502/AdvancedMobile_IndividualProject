import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/model/booking.dart';
import 'package:my_app/widgets/custom_button.dart';

class ScheduleItemWidget extends StatefulWidget {
  const ScheduleItemWidget({Key? key, required this.booking}) : super(key: key);

  final Booking booking;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScheduleItemWidgetState();
  }
}

class ScheduleItemWidgetState extends State<ScheduleItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, MMM d, yyyy')
                  .format(widget.booking.bookingStart),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Text("1 lesson"),
            _buildProfileInfo(),
            _buildMeetingDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(widget.booking.teacher.avatarUrl),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.booking.teacher.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Image.asset(
                      'lib/assets/icons/user/country/${widget.booking.teacher.nation.toLowerCase()}.png',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  Text(widget.booking.teacher.nation),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    color: Colors.blue,
                    onPressed: () {},
                    icon: const Icon(Icons.message),
                  ),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          style: const TextStyle(color: Colors.blueAccent),
                          text: 'Edit Request',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingDetails() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateFormat.jm().format(widget.booking.bookingStart)} - ${DateFormat.jm().format(widget.booking.bookingEnd)}',
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          _buildTable(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButtonWidget(
                content: 'Go to meeting',
                function: () {
                  Navigator.pushNamed(context, '/VideoCall');
                },
                color: Colors.blue,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTable() {
    return Container(
      color: Colors.white,
      child: Table(
        border: TableBorder.all(color: Colors.black12),
        columnWidths: const {
          0: FlexColumnWidth(1.0),
          1: FlexColumnWidth(2.0),
        },
        children: [
          TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Request for lesson",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                              text: 'Edit Request',
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          TableRow(
            children: [
              TableCell(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: widget.booking.request != ''
                      ? Text(widget.booking.request)
                      : const Text(
                          'Currently there are no requests for this class. Please write down any requests for the teacher.',
                          style: TextStyle(color: Colors.grey),
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
