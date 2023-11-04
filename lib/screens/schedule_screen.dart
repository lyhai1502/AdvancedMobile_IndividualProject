import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScheduleScreenState();
  }
}

class ScheduleScreenState extends State<ScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(30),
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
          const Text(
            'Latest book',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
          ),
          Table(
            border: TableBorder.all(color: Colors.black12),
            columnWidths: const {
              0: FlexColumnWidth(1.0),
              1: FlexColumnWidth(2.0)
            },
            children: [
              TableRow(children: [
                TableCell(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Center(child: Text('Name')),
                  ),
                ),
                const TableCell(
                  child: SizedBox(
                    height: 40,
                    child: Center(child: Text('sample.pdf')),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Center(child: Text('Page')),
                  ),
                ),
                const TableCell(
                  child: SizedBox(
                    height: 40,
                    child: Center(child: Text('0')),
                  ),
                ),
              ]),
              TableRow(children: [
                TableCell(
                  child: Container(
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Center(child: Text('Description')),
                  ),
                ),
                const TableCell(
                  child: SizedBox(
                    height: 40,
                    child: Center(child: Text('...')),
                  ),
                ),
              ]),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          Column(
            children: [
              for (var i = 0; i < 2; i++)
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black12,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Sun, 05 Nov 23",
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const Text("1 lesson"),
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Image.asset(
                                      'lib/assets/icons/facebook.png'),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Name",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 3),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: Image.asset(
                                              'lib/assets/icons/vietnam.png'),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 5),
                                        ),
                                        const Text('Vietnam')
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            color: Colors.blue,
                                            onPressed: () {},
                                            icon: const Icon(Icons.message)),
                                        RichText(
                                            text: TextSpan(
                                                style: const TextStyle(
                                                    color: Colors.black),
                                                children: [
                                              TextSpan(
                                                style: const TextStyle(
                                                    color: Colors.blueAccent),
                                                text: 'Edit Request',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () {},
                                              )
                                            ]))
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            margin: const EdgeInsets.only(top: 20),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "18:00 - 18:25",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.red),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          )),
                                        ),
                                        onPressed: () {},
                                        child: const Text("Cancel"))
                                  ],
                                ),
                                Table(
                                  border:
                                      TableBorder.all(color: Colors.black12),
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
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "Request for lesson",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              RichText(
                                                  text: TextSpan(
                                                      style: const TextStyle(
                                                          color: Colors.black),
                                                      children: [
                                                    TextSpan(
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors
                                                              .blueAccent),
                                                      text: 'Edit Request',
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {},
                                                    )
                                                  ]))
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
                                            "Currently there are no requests for this class. Please write down any requests for the teacher."),
                                      )),
                                    ]),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          )),
                                        ),
                                        onPressed: () {},
                                        child: const Text("Go to meeting"))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30),
                    ),
                  ],
                )
            ],
          )
        ]),
      ),
    );
  }
}
