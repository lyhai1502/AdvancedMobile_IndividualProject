import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/network/models/schedule_api.dart';
import 'package:my_app/network/network_request/other/get_flag_request.dart';

class HistoryItemWidget extends StatelessWidget {
  const HistoryItemWidget({Key? key, required this.scheduleApi})
      : super(key: key);

  final ScheduleApi scheduleApi;

  @override
  Widget build(BuildContext context) {
    DateTime scheduleDate = DateTime.parse(
        scheduleApi.scheduleDetailInfo?.scheduleInfo?.date ?? '');
    scheduleDate = DateTime(
      scheduleDate.year,
      scheduleDate.month,
      scheduleDate.day,
      int.parse(
          scheduleApi.scheduleDetailInfo?.startPeriod?.split(':')[0] ?? ''),
      int.parse(
          scheduleApi.scheduleDetailInfo?.startPeriod?.split(':')[1] ?? ''),
    );
    DateTime now = DateTime.now();
    Duration passedTime = now.difference(scheduleDate);

    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(scheduleDate),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              passedTime.inDays == 0
                  ? ' ${passedTime.inHours} hours ${passedTime.inMinutes.remainder(60)} minutes ago'
                  : ' ${passedTime.inDays} days ago',
            ),
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
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(scheduleApi
                    .scheduleDetailInfo?.scheduleInfo?.tutorInfo?.avatar ??
                ''),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                scheduleApi.scheduleDetailInfo?.scheduleInfo?.tutorInfo?.name ??
                    '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              GetFlagRequest.getFlag(scheduleApi
                      .scheduleDetailInfo?.scheduleInfo?.tutorInfo?.country ??
                  ''),
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
              '${scheduleApi.scheduleDetailInfo?.startPeriod ?? ''} - ${scheduleApi.scheduleDetailInfo?.endPeriod ?? ''}',
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
                    child: scheduleApi.studentRequest != null
                        ? Text(scheduleApi.studentRequest ?? '')
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
