import 'package:flutter/material.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/repository/teacher_repository.dart';
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
            onTap: () => Navigator.pushNamed(context, '/TutorDetail'),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildAvatar(teacher.avatarUrl),
                    _buildName(teacher.name),
                    _buildNation(teacher.nation),
                    _buildRating(teacher.rating),
                    _buildSpecialties(teacher.specialities),
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
              'lib/assets/icons/teacher/country/${nationUrl}.png',
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

  Widget _buildRating(int rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < rating; i++)
            const Icon(Icons.star, size: 20, color: Colors.amberAccent),
          for (var j = rating; j < 5; j++) const Icon(Icons.star, size: 20),
        ],
      ),
    );
  }

  Widget _buildSpecialties(List<String> specialities) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        children: [
          for (String item in specialities)
            Container(
              padding: const EdgeInsets.only(right: 8),
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                onPressed: () {},
                child: Text(item.toString()),
              ),
            ),
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
                side: const BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white),
            foregroundColor: MaterialStateProperty.all(Colors.blue),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.task,
            size: 24.0,
          ),
          label: const Text('Book'),
        ),
      ],
    );
  }
}
