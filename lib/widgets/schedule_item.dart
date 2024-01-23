import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/network/models/schedule_api.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/network_request/other/get_flag_request.dart';
import 'package:my_app/network/network_request/schedule/cancel_booked_class_request.dart';
import 'package:my_app/network/response/sucess_response.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ScheduleItemWidget extends StatefulWidget {
  const ScheduleItemWidget({Key? key, required this.scheduleApi})
      : super(key: key);

  final ScheduleApi scheduleApi;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScheduleItemWidgetState();
  }
}

class ScheduleItemWidgetState extends State<ScheduleItemWidget> {
  Tokens tokens = Tokens();

  @override
  void initState() {
    tokens = context.read<Tokens>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.parse(
                  widget.scheduleApi.scheduleDetailInfo?.scheduleInfo?.date ??
                      '')),
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
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(widget.scheduleApi.scheduleDetailInfo
                    ?.scheduleInfo?.tutorInfo?.avatar ??
                ''),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.scheduleApi.scheduleDetailInfo?.scheduleInfo?.tutorInfo
                        ?.name ??
                    '',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 3)),
              GetFlagRequest.getFlag(widget.scheduleApi.scheduleDetailInfo
                      ?.scheduleInfo?.tutorInfo?.country ??
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.scheduleApi.scheduleDetailInfo?.startPeriod ?? ''} - ${widget.scheduleApi.scheduleDetailInfo?.endPeriod ?? ''}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
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
                onPressed: () {
                  setState(() {
                    CoolAlert.show(
                        confirmBtnText: 'OK',
                        context: context,
                        type: CoolAlertType.confirm,
                        text: 'Are you sure to delete this schedule?',
                        onConfirmBtnTap: () async {
                          Future<dynamic> future =
                              CancelBookedClassRequest.cancelBookedClass(
                                  tokens.access?.token,
                                  widget.scheduleApi.id ?? '');

                          await future.then((value) {
                            if (value is SuccessResponse) {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: 'Cancel class successfully!');
                                  
                            } else {
                              CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: value.message ?? '');
                            }
                          });
                        });
                  });
                },
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
                child: widget.scheduleApi.studentRequest != null
                    ? Text(widget.scheduleApi.studentRequest ?? '')
                    : const Text(
                        'Currently there are no requests for this class. Please write down any requests for the teacher.',
                        style: TextStyle(color: Colors.grey),
                      ),
              ))
            ],
          ),
        ],
      ),
    );
  }
}
