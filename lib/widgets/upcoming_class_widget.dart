import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_app/widgets/custom_button.dart';

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
      DateTime.now().add(Duration(minutes: 30 - DateTime.now().minute));

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
                        'Total lesson time is 533 hours 20 minutes',
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
