import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/course.dart';
import 'package:my_app/widgets/custom_button.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({Key? key, required this.course}) : super(key: key);

  final Course course;
  @override
  State<StatefulWidget> createState() {
    return CourseDetailScreenState();
  }
}

class CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course detail'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCourseCard(context),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildSection("Overview", [
                _buildListItem(Icons.question_mark_rounded,
                    "Why take this course", widget.course.target),
                const Padding(padding: EdgeInsets.only(top: 20)),
                _buildListItem(Icons.question_mark_rounded,
                    "What will you be able to do", widget.course.todo),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              _buildSection("Experience Level", [
                _buildInfoRow(Icons.person, widget.course.level),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              _buildSection("Course Length", [
                _buildInfoRow(
                    Icons.book, "${widget.course.topics.length} topics"),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              _buildSection("List Topics", [
                for (var i = 0; i < widget.course.topics.length; i++)
                  _buildTopicCard(widget.course.topics[i], i + 1),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildSection("Suggested Tutors", [
                _buildSuggestedTutor("Keegan"),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 20)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context) {
    return Card(
      elevation: 0,
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                height: 200,
                width: 300,
                child: Image.asset(widget.course.image),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.course.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    widget.course.description,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  Row(children: [
                    Expanded(
                        child: CustomButtonWidget(
                            content: 'DISCOVER',
                            function: () {
                              Navigator.pushNamed(
                                  context, '/CourseLearnDetail');
                            },
                            color: Colors.blue))
                  ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        ...content,
      ],
    );
  }

  Widget _buildListItem(IconData icon, String title, String description) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.red,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text(
                description,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.blue,
        ),
        Text(
          text,
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ],
    );
  }

  Widget _buildTopicCard(String topic, int indexTopic) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/CourseLearnDetail'),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      '$indexTopic',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    Text(
                      topic,
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestedTutor(String tutorName) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 18, color: Colors.black),
        children: [
          TextSpan(
            text: tutorName,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const TextSpan(text: '     '),
          TextSpan(
            style: const TextStyle(color: Colors.blueAccent),
            text: 'More Info',
            recognizer: TapGestureRecognizer()..onTap = () {},
          )
        ],
      ),
    );
  }
}
