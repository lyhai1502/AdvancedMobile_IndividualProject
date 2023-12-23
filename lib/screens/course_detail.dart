import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/network/models/course_api.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/network_request/course/get_course_info_request.dart';
import 'package:my_app/screens/pdf_view_screen.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({Key? key, required this.courseId})
      : super(key: key);

  final String? courseId;
  @override
  State<StatefulWidget> createState() {
    return CourseDetailScreenState();
  }
}

class CourseDetailScreenState extends State<CourseDetailScreen> {
  CourseApi courseApi = CourseApi();
  Tokens tokens = Tokens();
  bool _isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    tokens = context.read<Tokens>();

    Future<dynamic> future =
        CourseInfoRequest.getCourseInfo(tokens.access?.token, widget.courseId);
    await future.then((value) {
      setState(() {
        courseApi = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Course detail'),
        ),
        body: !_isLoading
            ? SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _buildCourseCard(context),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      _buildSection("Overview", [
                        _buildListItem(Icons.question_mark_rounded,
                            "Why take this course", courseApi.reason ?? ''),
                        const Padding(padding: EdgeInsets.only(top: 20)),
                        _buildListItem(
                            Icons.question_mark_rounded,
                            "What will you be able to do",
                            courseApi.purpose ?? ''),
                      ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      _buildSection("Experience Level", [
                        _buildInfoRow(
                            Icons.person, courseLevel(courseApi.level ?? '')),
                      ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      _buildSection("Course Length", [
                        _buildInfoRow(
                            Icons.book, "${courseApi.topics?.length} topics"),
                      ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      _buildSection("List Topics", [
                        for (var i = 0; i < courseApi.topics!.length; i++)
                          _buildTopicCard(courseApi.topics![i], i + 1),
                      ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10)),
                      _buildSection("Suggested Tutors", [
                        _buildSuggestedTutor("Keegan"),
                      ]),
                      const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20)),
                    ],
                  ),
                ),
              )
            : Center(
                heightFactor: MediaQuery.of(context).size.height / 2,
                child: const CircularProgressIndicator(
                  color: Colors.blue,
                ),
              ));
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
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: Image.network(
                  courseApi.imageUrl ?? '',
                  width: 400,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseApi.name ?? '',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  Text(
                    courseApi.description ?? '',
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

  Widget _buildTopicCard(Topics topic, int indexTopic) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PdfViewScreen(
                    pdfUrl: courseApi.topics?[indexTopic].nameFile ?? '')));
      },
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
                      topic.name ?? '',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
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

  String courseLevel(String? courseLevel) {
    switch (courseLevel) {
      case '0':
        return 'Any level';
      case '1':
        return 'Beginner';
      case '4':
        return 'Intermediate';
      case '7':
        return 'Advanced';
      default:
        return 'Unknown';
    }
  }
}
