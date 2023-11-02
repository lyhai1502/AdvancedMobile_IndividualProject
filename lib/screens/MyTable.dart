import 'package:flutter/material.dart';

class MyTable extends StatelessWidget {
  const MyTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(color: Colors.black),
      children: [
        TableRow(children: [
          TableCell(
            child: Container(
              child: Center(child: Text('Latest Book')),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                border: Border.all(color: Colors.black),
              ),
            ),
          ),
        ]),
        TableRow(children: [
          TableCell(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Name'),
                    Text('sample.pdf'),
                  ],
                ),
              ),
            ),
          ),
          TableCell(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Page'),
                    Text('0'),
                  ],
                ),
              ),
            ),
          ),
          TableCell(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Description'),
                    Text(
                        'Use the above image information to reply when we discuss about the image.'),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ],
    );
  }
}
