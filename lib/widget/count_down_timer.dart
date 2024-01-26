import 'package:flutter/material.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CountDownTimerWidget extends StatelessWidget {
  final int? startPeriodTimestamp;
  CountDownTimerWidget({Key? key, required this.startPeriodTimestamp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? now = DateTime.now();
    int? currentTimestamp = now.millisecondsSinceEpoch;
    int? timeLeft = startPeriodTimestamp! - currentTimestamp;

    return Countdown(
      seconds: timeLeft ~/ 1000,
      build: (BuildContext context, double time) {
        int hours = (time ~/ 3600).toInt();
        int minutes = ((time % 3600) ~/ 60).toInt();
        int seconds = (time % 60).toInt();

        return Text('(Starts in: $hours:$minutes:$seconds)',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.red));
      },
      onFinished: () {
        print('Timer is done!');
      },
    );
  }
}
