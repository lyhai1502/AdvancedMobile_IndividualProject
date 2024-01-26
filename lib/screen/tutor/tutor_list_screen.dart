import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/network/network_request/tutor/search_filter_tutor_request.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:my_app/widget/fliter_button_list.dart';
import 'package:my_app/screen/tutor/tutor_list_item.dart';
import 'package:my_app/widget/upcoming_class_widget.dart';
import 'package:provider/provider.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TutorListScreenState();
  }
}

class TutorListScreenState extends State<TutorListScreen> {
  TeacherRepository teacherRepository = TeacherRepository();
  final TextEditingController searchTutorController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    teacherRepository = context.watch<TeacherRepository>();
    return SingleChildScrollView(child: _buildTutorList());
  }

  Widget _buildTutorList() {
    return Column(
      children: [
        const UpcomingClassWidget(),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(),
              _buildSearchTextField(),
              _buildFilterButtons(),
              _buildRecommendTutors(),
            ],
          ),
        ),
      ],
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
    return CupertinoSearchTextField(
      placeholder: 'Search tutor name',
      controller: searchTutorController,
      onChanged: (value) {
        setState(() {
          getSearchData();
        });
      },
    );
  }

  Future<void> getSearchData() async {
    Future<dynamic> future = SearchFilterTutorRequest.searchTutor(
        context.read<Tokens>().access?.token, searchTutorController.text, 9, 1);
    await future.then((value) {
      setState(() {
        teacherRepository.tutorList = value;
        teacherRepository.update();
      });
    });
  }

  Widget _buildFilterButtons() {
    return const Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select available tutoring time:',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          FilterButtonList(),
        ],
      ),
    );
  }

  Widget _buildRecommendTutors() {
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        Text(
          'Recommend Tutors',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        TutorListItemWidget(),
      ],
    );
  }
}
