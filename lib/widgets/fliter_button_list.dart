import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterButtonList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FilterButtonListState();
  }
}

class FilterButtonListState extends State<FilterButtonList> {
  final List<String> specialitiesFilters = [
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

  String selectSpecialitiesFilter = 'All';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Wrap(
      children: [
        for (String item in specialitiesFilters) _buildFilterButton(item),
      ],
    );
  }

  Widget _buildFilterButton(String item) {
    return Container(
      padding: const EdgeInsets.only(right: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          backgroundColor: selectSpecialitiesFilter == item
              ? MaterialStateProperty.all(Colors.blue)
              : MaterialStateProperty.all(Colors.white54),
          foregroundColor: selectSpecialitiesFilter == item
              ? MaterialStateProperty.all(Colors.white)
              : MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          setState(() {
            selectSpecialitiesFilter = item;
          });
        },
        child: Text(item),
      ),
    );
  }
}
