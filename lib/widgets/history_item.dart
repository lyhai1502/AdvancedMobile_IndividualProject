import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/model/booking.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({Key? key, required this.booking}) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('EEEE, MMM d, yyyy').format(booking.bookingStart),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
                '${DateTime.now().hour - booking.bookingStart.hour - 1} hours ago'),
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
            child: Image.asset(booking.teacher.avatarUrl),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                booking.teacher.name,
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
                      'lib/assets/icons/user/country/${booking.teacher.nation.toLowerCase()}.png',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  Text(booking.teacher.nation),
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
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '${DateFormat.jm().format(booking.bookingStart)} - ${DateFormat.jm().format(booking.bookingEnd)}',
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: Colors.white,
            child: Table(
              border: TableBorder.all(color: Colors.black12),
              columnWidths: const {
                0: FlexColumnWidth(1.0),
                1: FlexColumnWidth(2.0)
              },
              children: [
                TableRow(children: [
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Request for lesson",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    child: booking.request != ''
                        ? Text(booking.request)
                        : const Text(
                            'No request for lesson',
                            style: TextStyle(color: Colors.grey),
                          ),
                  ))
                ]),
                TableRow(children: [
                  TableCell(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Review from tutor",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      'Tutor have not reviewed yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
                ]),
                TableRow(children: [
                  TableCell(
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      children: [
                                    TextSpan(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                      text: 'Add a rating',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    )
                                  ])),
                              RichText(
                                  text: TextSpan(
                                      style:
                                          const TextStyle(color: Colors.black),
                                      children: [
                                    TextSpan(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                      text: 'Report',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {},
                                    )
                                  ]))
                            ],
                          ))),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
