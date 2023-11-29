import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/models/value_item.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:my_app/widgets/app_bar.dart';
import 'package:my_app/widgets/tutor_list_item.dart';
import 'package:provider/provider.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({Key? key}) : super(key: key);

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

  String _selectedFilterItem = 'All';

  int sortFavorite = 0;

  final TeacherRepository teacherRepository = TeacherRepository();

  @override
  Widget build(BuildContext context) {
    teacherRepository.add(Teacher.createTeacher(
        'name',
        'avatarUrl',
        5,
        'nation',
        'description',
        'education',
        [],
        ["hello", "hello2"],
        'interests',
        'experience',
        'videoUrl',
        100));
    teacherRepository.add(Teacher.createTeacher(
        'name2',
        'avatarUrl',
        3,
        'nation',
        'description',
        'education',
        [],
        [],
        'interests',
        'experience',
        'videoUrl',
        67));
    teacherRepository.add(Teacher.createTeacher(
        'nam3',
        'avatarUrl',
        2,
        'nation',
        'description',
        'education',
        [],
        [],
        'interests',
        'experience',
        'videoUrl',
        88));
    teacherRepository.add(Teacher.createTeacher(
        'name4',
        'avatarUrl',
        4,
        'nation',
        'description',
        'education',
        [],
        [],
        'interests',
        'experience',
        'videoUrl',
        12));

    return MultiProvider(
      providers: [
        Provider(create: (context) => teacherRepository),
      ],
      child: Scaffold(
        appBar: AppBarWidget(),
        body: SingleChildScrollView(
          child: _buildTutorList(),
        ),
      ),
    );
  }

  Widget _buildTutorList() {
    return Container(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeaderText(),
          _buildSearchTextField(),
          _buildSelectDropDown(
            hint: 'Sort by rating',
            options: <ValueItem>[
              ValueItem(label: 'Ascending rating', value: 'ascending'),
              ValueItem(label: 'Descending rating', value: 'descending'),
            ],
            selectionType: SelectionType.single,
            onOptionSelected: (options) {
              setState(() {
                teacherRepository.sortTeacherByRating(options.first.value);
              });
            },
          ),
          _buildSelectDropDown(
            hint: 'Sort by favorite',
            options: <ValueItem>[
              ValueItem(label: 'Ascending rating', value: 'ascending'),
              ValueItem(label: 'Descending rating', value: 'descending'),
            ],
            selectionType: SelectionType.single,
            onOptionSelected: (options) {
              setState(() {
                teacherRepository
                    .sortTeacherByFavoriteNumber(options.first.value);
              });
            },
          ),
          _buildFilterButtons(),
          _buildResetFilterButton(),
          _buildRecommendTutors(),
        ],
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Column(
      children: [
        Text(
          'Find a tutor',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        ),
      ],
    );
  }

  Widget _buildSearchTextField() {
    return const CupertinoSearchTextField(
      placeholder: 'Search tutor name',
    );
  }

  Widget _buildSelectDropDown({
    required String hint,
    required List<ValueItem> options,
    required SelectionType selectionType,
    required onOptionSelected,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: MultiSelectDropDown(
        hint: hint,
        showClearIcon: false,
        hintStyle: const TextStyle(fontSize: 15, color: Colors.black45),
        onOptionSelected: onOptionSelected,
        options: options,
        selectionType: selectionType,
        dropdownHeight: 100,
        optionTextStyle: const TextStyle(fontSize: 15),
        selectedOptionIcon: const Icon(Icons.check_circle),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select available tutoring time:',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Wrap(
          children: [
            for (String item in items) _buildFilterButton(item),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterButton(String item) {
    return Container(
      padding: const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          backgroundColor: _selectedFilterItem == item
              ? MaterialStateProperty.all(Colors.blue)
              : MaterialStateProperty.all(Colors.white54),
          foregroundColor: _selectedFilterItem == item
              ? MaterialStateProperty.all(Colors.white)
              : MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () {
          setState(() {
            _selectedFilterItem = item;
          });
        },
        child: Text(item),
      ),
    );
  }

  Widget _buildResetFilterButton() {
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
          _selectedFilterItem = 'All';
        });
      },
      child: const Text('Reset filter'),
    );
  }

  Widget _buildRecommendTutors() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        const Text(
          'Recommend Tutors',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        _buildTutorListCard(),
      ],
    );
  }

  Widget _buildTutorListCard() {
    return TutorListItemWidget();
  }
}
