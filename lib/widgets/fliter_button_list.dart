import 'package:flutter/material.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/models/tutor_api.dart';
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
    TeacherRepository teacherRepository = context.watch<TeacherRepository>();
    List<TutorApi> tutorList = context.watch<List<TutorApi>>();
    // TODO: implement build
    return Wrap(
      children: [
        for (String item in specialitiesFilters)
          _buildFilterButton(item, teacherRepository, tutorList),
        _buildResetFilterButton(teacherRepository, tutorList),
      ],
    );
  }

  Widget _buildFilterButton(String item, TeacherRepository teacherRepository,
      List<TutorApi> tutorList) {
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
            getFilterData('flyer', tutorList);
            // teacherRepository.filterSpecialities(selectSpecialitiesFilter);
          });
        },
        child: Text(item),
      ),
    );
  }

  Future<void> getFilterData(String item, List<TutorApi> tutorList) async {
    Future<dynamic> future = SearchFilterTutorRequest.filterTutor(
        context.read<Tokens>().access?.token, item, 9, 1);
    await future.then((value) {
      setState(() {
        tutorList = value;
        print(tutorList.length);
      });
    });
  }

  Widget _buildResetFilterButton(
      TeacherRepository teacherRepository, List<TutorApi> tutorList) {
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
          teacherRepository.filterSpecialities(selectSpecialitiesFilter);
        });
      },
      child: const Text('Reset filter'),
    );
  }
}
