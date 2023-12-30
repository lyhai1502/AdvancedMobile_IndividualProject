import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/network/models/schedule_api.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/network_request/schedule/get_upcoming_class_request.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class UpcomingClassWidget extends StatefulWidget {
  const UpcomingClassWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UpcomingClassWidgetState();
  }
}

class UpcomingClassWidgetState extends State<UpcomingClassWidget> {
  DateTime nextClassStartTime =
      DateTime.now().add(Duration(minutes: 31 - DateTime.now().minute));

  Tokens tokens = Tokens();
  ScheduleApi schedule = ScheduleApi();

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    tokens = context.read<Tokens>();
    Future<dynamic> future = GetUpcomingClassRequest.getUpComingClass(
        tokens.access?.token,
        1,
        20,
        DateTime.now().add(const Duration(minutes: 5)).millisecondsSinceEpoch,
        'meeting',
        'desc');
    await future.then((value) {
      setState(() {
        schedule = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 250,
            child: Card(
              color: Colors.white10,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    _buildHeaderOfInformation(
                        'Upcoming lesson', 25, Colors.white),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    _buildHeaderOfInformation(
                        '${DateFormat('MMM d, h:mm a').format(nextClassStartTime)} - ${DateFormat.jm().format(nextClassStartTime.add(const Duration(minutes: 30)))}',
                        18,
                        Colors.white),
                    _buildHeaderOfInformation(
                        '(class time: 00:10:49)', 15, Colors.greenAccent),
                    const Padding(padding: EdgeInsets.only(top: 15)),
                    CustomButtonWidget(
                      content: 'Enter lesson room',
                      function: () {
                        Navigator.pushNamed(context, '/VideoCall');
                      },
                      color: Colors.blue,
                    ),
                    _buildHeaderOfInformation(
                        'Total lesson time is 86 hours 40 minutes',
                        15,
                        Colors.white),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildHeaderOfInformation(String header, double size, Color color) {
    return Text(
      header,
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }
}
