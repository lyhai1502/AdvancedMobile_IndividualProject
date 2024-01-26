import 'package:flutter/material.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/network/network_request/tutor/search_filter_tutor_request.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:provider/provider.dart';

class FilterButtonList extends StatefulWidget {
  const FilterButtonList({super.key});

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
    'Business English',
    'Conversational English',
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
    TeacherRepository teacherRepository = context.watch<TeacherRepository>();

    // TODO: implement build
    return Wrap(
      children: [
        for (String item in specialitiesFilters)
          _buildFilterButton(item, teacherRepository),
        _buildResetFilterButton(teacherRepository),
      ],
    );
  }

  Widget _buildFilterButton(String item, TeacherRepository teacherRepository) {
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
            if (item == 'All') {
              item = '';
            }
            getFilterData(
                item.replaceAll(' ', '-').toLowerCase(), teacherRepository);
            // teacherRepository.filterSpecialities(selectSpecialitiesFilter);
          });
        },
        child: Text(item),
      ),
    );
  }

  Future<void> getFilterData(
      String item, TeacherRepository teacherRepository) async {
    Future<dynamic> future = SearchFilterTutorRequest.filterTutor(
        context.read<Tokens>().access?.token, item, 9, 1);
    await future.then((value) {
      setState(() {
        teacherRepository.tutorList = value;
        teacherRepository.update();
      });
    });
  }

  Widget _buildResetFilterButton(TeacherRepository teacherRepository) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            side: const BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        foregroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      onPressed: () {
        setState(() {
          selectSpecialitiesFilter = 'All';
          getFilterData('', teacherRepository);
        });
      },
      child: const Text('Reset filter'),
    );
  }
}
