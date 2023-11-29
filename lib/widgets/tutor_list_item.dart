import 'package:flutter/material.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:provider/provider.dart';

class TutorListItemWidget extends StatefulWidget {
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
    return Column(children: [
      for (Teacher teacher in teacherRepository.list)
        Center(
          child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, '/TutorDetail'),
            child: Card(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    _buildAvatar(),
                    _buildName(teacher.name),
                    _buildNation(teacher.nation),
                    _buildRating(teacher.rating),
                    _buildSpecialties(teacher.specialties),
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
        ),
    ]);
  }

  Widget _buildAvatar() {
    return SizedBox(
      width: 80,
      height: 80,
      child: IconButton(
        onPressed: () {},
        icon: Image.asset('lib/assets/icons/facebook.png'),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('lib/assets/icons/vietnam.png'),
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

  Widget _buildSpecialties(List<String> specialties) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Wrap(
        children: [
          for (String item in specialties)
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
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        description,
        style: TextStyle(fontSize: 15, color: Colors.black),
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
