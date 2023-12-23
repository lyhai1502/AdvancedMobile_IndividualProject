import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/models/tutor_api.dart';
import 'package:my_app/network/network_request/tutor/search_filter_tutor_request.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:my_app/widgets/fliter_button_list.dart';
import 'package:my_app/widgets/tutor_list_item.dart';
import 'package:my_app/widgets/upcoming_class_widget.dart';
import 'package:provider/provider.dart';

class TutorListScreen extends StatefulWidget {
  const TutorListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TutorListScreenState();
  }
}

class TutorListScreenState extends State<TutorListScreen> {
  final TeacherRepository teacherRepository = TeacherRepository();
  final TextEditingController searchTutorController = TextEditingController();

  List<TutorApi> tutorList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => teacherRepository,
        ),
      ],
      child: SingleChildScrollView(child: _buildTutorList()),
    );
  }

  Widget _buildTutorList() {
    return Column(
      children: [
        UpcomingClassWidget(),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderText(),
              _buildSearchTextField(),
              _buildSelectDropDown(
                hint: 'Sort by rating/favorite',
                options: <ValueItem>[
                  const ValueItem(
                      label: 'Ascending rating', value: 'ascendingRating'),
                  const ValueItem(
                      label: 'Descending rating', value: 'descendingRating'),
                  const ValueItem(
                      label: 'Ascending favorite', value: 'ascendingFavorite'),
                  const ValueItem(
                      label: 'Descending favorite',
                      value: 'descendingFavorite'),
                ],
                selectionType: SelectionType.single,
                onOptionSelected: (options) {
                  setState(() {
                    teacherRepository
                        .sortTeacherByRatingAndFavorite(options.first.value);
                  });
                },
              ),
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
          // teacherRepository.findByNameOrNation(searchTutorController.text);
          // print(value);
        });
      },
    );
  }

  Future<void> getSearchData() async {
    Future<dynamic> future = SearchFilterTutorRequest.searchTutor(
        context.read<Tokens>().access?.token, searchTutorController.text, 9, 1);
    await future.then((value) {
      setState(() {
        tutorList = value;
      });
    });
  }

  Widget _buildSelectDropDown({
    required String hint,
    required List<ValueItem> options,
    required SelectionType selectionType,
    required onOptionSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: MultiSelectDropDown(
        hint: hint,
        showClearIcon: false,
        hintStyle: const TextStyle(fontSize: 15, color: Colors.black45),
        onOptionSelected: onOptionSelected,
        options: options,
        selectionType: selectionType,
        dropdownHeight: 200,
        optionTextStyle: const TextStyle(fontSize: 15),
        selectedOptionIcon: const Icon(Icons.check_circle),
      ),
    );
  }

  Widget _buildFilterButtons() {
    return const Column(
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
    return TutorListItemWidget(tutorList: tutorList);
  }
}
