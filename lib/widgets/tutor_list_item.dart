import 'package:flutter/material.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:my_app/screens/booking_calendar_screen.dart';
import 'package:my_app/screens/tutor_detail_screen.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:my_app/widgets/rating.dart';
import 'package:provider/provider.dart';

class TutorListItemWidget extends StatefulWidget {
  const TutorListItemWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TutorListItemWidgetState();
  }
}

class TutorListItemWidgetState extends State<TutorListItemWidget> {
  bool isFavorited = false;

  @override
  Widget build(BuildContext context) {
    TeacherRepository teacherRepository = context.watch<TeacherRepository>();

    // TODO: implement build
    return Center(
      child: Column(children: [
        for (Teacher teacher in (teacherRepository.filter.isEmpty &&
                teacherRepository.filterName == 'All'
            ? teacherRepository.list
            : teacherRepository.filter))
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TutorDetailScreen(teacher: teacher)));
            },
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildAvatar(teacher.avatarUrl),
                    _buildName(teacher.name),
                    _buildNation(teacher.nation),
                    RatingWidget(rating: teacher.rating),
                    _buildSpecialities(teacher.specialities),
                    _buildDescription(teacher.description),
                    _buildButtons(teacher),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ]),
    );
  }

  Widget _buildAvatar(String avatarUrl) {
    return SizedBox(
      width: 80,
      height: 80,
      child: IconButton(
        onPressed: () {},
        icon: Image.asset(avatarUrl),
      ),
    );
  }

  Widget _buildName(String name) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildNation(String nation) {
    String nationUrl = nation.toLowerCase();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset(
              'lib/assets/icons/user/country/$nationUrl.png',
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 5),
          ),
          Text(nation),
        ],
      ),
    );
  }

  Widget _buildSpecialities(List<String> specialities) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        children: [
          for (String item in specialities)
            CustomButtonWidget(
              content: item,
              function: () {},
              color: Colors.blue,
            )
        ],
      ),
    );
  }

  Widget _buildDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        description,
        style: const TextStyle(fontSize: 15, color: Colors.black),
      ),
    );
  }

  Widget _buildButtons(Teacher teacher) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          IconButton(
              onPressed: () {
                setState(() {
                  isFavorited = !isFavorited;
                  if (isFavorited) {
                    teacher.favoriteNumber++;
                  } else {
                    teacher.favoriteNumber--;
                  }
                });
              },
              icon: isFavorited
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite)),
          Text(teacher.favoriteNumber.toString())
        ]),
        ElevatedButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.green),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BookingCalendarScreen(teacher: teacher)));
          },
          icon: const Icon(
            Icons.calendar_month,
            size: 24.0,
          ),
          label: const Text('Book'),
        ),
      ],
    );
  }
}
