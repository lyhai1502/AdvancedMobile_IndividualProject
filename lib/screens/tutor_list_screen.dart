import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:my_app/widgets/app_bar.dart';
import 'package:my_app/widgets/fliter_button_list.dart';
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
  final TeacherRepository teacherRepository = TeacherRepository();
  final TextEditingController searchTutorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            hint: 'Sort by rating/favorite',
            options: <ValueItem>[
              const ValueItem(
                  label: 'Ascending rating', value: 'ascendingRating'),
              const ValueItem(
                  label: 'Descending rating', value: 'descendingRating'),
              const ValueItem(
                  label: 'Ascending favorite', value: 'ascendingFavorite'),
              const ValueItem(
                  label: 'Descending favorite', value: 'descendingFavorite'),
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
    return CupertinoSearchTextField(
      placeholder: 'Search tutor name/country',
      controller: searchTutorController,
      onSubmitted: (value) {
        setState(() {
          teacherRepository.findByNameOrNation(searchTutorController.text);
        });
      },
    );
  }

  Widget _buildSelectDropDown({
    required String hint,
    required List<ValueItem> options,
    required SelectionType selectionType,
    required onOptionSelected,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
        FilterButtonList()
      ],
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
        setState(() {});
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
