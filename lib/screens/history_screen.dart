import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/app_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HistoryScreenState();
  }
}

class HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset('lib/assets/icons/history.png'),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              "History",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              "The following is a list of lessons you have attended\n"
              "You can review the details of the lessons you have attended",
              style: TextStyle(fontSize: 17, color: Colors.black),
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
                            const Text("5 days ago"),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.all(10),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: 100,
                                    child: Image.asset(
                                        'lib/assets/icons/facebook.png'),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                  text: 'Durect Message',
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
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lesson time: ",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                  Text(
                                    "18:00 - 18:25",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              margin: const EdgeInsets.only(top: 20),
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
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
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Request for lesson",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                              "Currently there are no requests for this class. Please write down any requests for the teacher."),
                                        )),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Review from tutor",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                              "Session 1: 20:30 - 20:55\n"
                                              "Lesson status: On progress\n"
                                              "Behavior ():\n"
                                              "Listening ():\n"
                                              "Speaking ():\n"
                                              "Vocabulary ():\n"
                                              "Overall comment: dfsafdsa"),
                                        )),
                                      ]),
                                      TableRow(children: [
                                        TableCell(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    RichText(
                                                        text: TextSpan(
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                            children: [
                                                          TextSpan(
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blueAccent),
                                                            text:
                                                                'Add a rating',
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap =
                                                                      () {},
                                                          )
                                                        ])),
                                                    RichText(
                                                        text: TextSpan(
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                            children: [
                                                          TextSpan(
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blueAccent),
                                                            text: 'Report',
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap =
                                                                      () {},
                                                          )
                                                        ]))
                                                  ],
                                                ))),
                                      ]),
                                    ],
                                  ),
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
      ),
    );
  }
}
