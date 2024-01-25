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
  Tokens tokens = Tokens();
  ScheduleApi schedule = ScheduleApi();
  int totalHours = 0;
  late final startPeriodTimestamp;
  late final formattedStartTimestamp;
  late final formattedEndTimestamp;

  bool _isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    _isLoading = true;
    tokens = context.read<Tokens>();
    Future<dynamic> future =
        GetUpcomingClassRequest.getUpComingClass(tokens.access?.token);
    await future.then((value) {
      setState(() {
        schedule = value;
      });
    });

    Future<dynamic> future2 =
        GetUpcomingClassRequest.getTotalHours(tokens.access?.token);
    await future2.then((value) {
      setState(() {
        totalHours = value;
      });
    });
    _isLoading = false;

    startPeriodTimestamp = schedule.scheduleDetailInfo?.startPeriodTimestamp;
    formattedStartTimestamp = DateFormat('E, d MMM yyyy HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(startPeriodTimestamp!));

    final endPeriodTimestamp = schedule.scheduleDetailInfo?.endPeriodTimestamp;
    formattedEndTimestamp = DateFormat('HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(endPeriodTimestamp!));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !_isLoading
        ? Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 250,
                  child: Card(
                    color: Color.fromARGB(255, 0, 38, 255),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          _buildHeaderOfInformation(
                              'Upcoming lesson', 25, Colors.white),
                          const Padding(padding: EdgeInsets.only(top: 15)),
                          _buildHeaderOfInformation(
                              '$formattedStartTimestamp - $formattedEndTimestamp',
                              18,
                              Colors.white),
                          _buildRemaningTime(),
                          const Padding(padding: EdgeInsets.only(top: 15)),
                          CustomButtonWidget(
                            content: 'Enter lesson room',
                            function: () {
                              Navigator.pushNamed(context, '/VideoCall');
                            },
                            color: Colors.blue,
                          ),
                          _buildTotalHour(totalHours)
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        : const Center(
            child: CircularProgressIndicator(
            color: Colors.blue,
          ));
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

  Widget _buildRemaningTime() {
    Duration remainingTime =
        DateTime.fromMillisecondsSinceEpoch(startPeriodTimestamp!)
            .difference(DateTime.now());
    int hours = remainingTime.inHours;
    int minutes = remainingTime.inMinutes.remainder(60);
    int seconds = remainingTime.inSeconds.remainder(60);
    String formattedRemainingTime =
        '$hours hours $minutes minutes $seconds seconds';

    return Text('Class time: $formattedRemainingTime',
        style: const TextStyle(
          fontSize: 15,
          color: Color.fromARGB(255, 0, 255, 8),
        ));
  }

  Widget _buildTotalHour(int totalHours) {
    String formattedTotalHours =
        '${totalHours ~/ 60} hours ${totalHours % 60} minutes';

    return Text(
      'Total lesson time is $formattedTotalHours',
      style: const TextStyle(
          fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }
}
