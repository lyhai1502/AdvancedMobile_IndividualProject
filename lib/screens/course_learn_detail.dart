import 'package:flutter/material.dart';
import 'package:my_app/widgets/app_bar.dart';
import 'package:my_app/widgets/list_select.dart';

class CourseLearnDetailScreen extends StatefulWidget {
  const CourseLearnDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CourseLearnScreenState();
  }
}

class CourseLearnScreenState extends State<CourseLearnDetailScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCourseImage(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildCourseDetails(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildListTopics(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              const ListSelectWidget(),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseImage() {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('lib/assets/images/bg.png'),
          const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Life In The Internet Age",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text(
                "Let's discuss how technology is changing the way we live",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 15,
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseDetails() {
    return const Text(
      "List Topics",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildListTopics() {
    return const Padding(padding: EdgeInsets.symmetric(vertical: 10));
  }
}
