import 'package:flutter/material.dart';
import 'package:my_app/widgets/tutor_list_item.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return TutorListScreenState();
  }
}

class TutorListScreenState extends State<TutorListScreen> {
  final List<String> items = [
    'All',
    'English for kids',
    'English for business',
    'Conversational',
    'STARTERS',
    'MOVERS',
    'FLYERS',
    'KET',
    'PET',
    'IELTS',
    'TOEFL',
    'TOEIC'
  ];

  String _selectedFilterItem = '';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
      padding: const EdgeInsets.all(30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Find a tutor',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        SizedBox(
            height: 35,
            width: 200,
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: 'Enter tutor name'),
            )),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
        const Text(
          'Select available tutoring time:',
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Wrap(
          children: [
            for (String item in items)
              Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          )),
                          backgroundColor: _selectedFilterItem == item
                              ? MaterialStateProperty.all(Colors.blue)
                              : MaterialStateProperty.all(Colors.white54),
                          foregroundColor: _selectedFilterItem == item
                              ? MaterialStateProperty.all(Colors.white)
                              : MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        setState(() {
                          _selectedFilterItem = item;
                        });
                      },
                      child: Text(item)))
          ],
        ),
        ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(15.0),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                foregroundColor: MaterialStateProperty.all(Colors.blue)),
            onPressed: () {
              setState(() {
                _selectedFilterItem = 'All';
              });
            },
            child: const Text('Reset filter')),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        const Text(
          'Recommend Tutors',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        Column(children: [
          // ignore: unused_local_variable
          for (String item in items)
            const Card(
              child: CardExample(),
            )
        ])
      ]),
    ));
  }
}
