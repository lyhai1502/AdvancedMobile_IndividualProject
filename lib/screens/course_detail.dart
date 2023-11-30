import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/app_bar.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CourseDetailScreenState();
  }
}

class CourseDetailScreenState extends State<CourseDetailScreen> {
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
              _buildCourseCard(context),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildSection("Overview", [
                _buildListItem(
                  Icons.question_mark_rounded,
                  "Why take this course",
                  "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
                ),
                _buildListItem(
                  Icons.question_mark_rounded,
                  "What will you be able to do",
                  "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
                ),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              _buildSection("Experience Level", [
                _buildInfoRow(Icons.person, "Intermediate"),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              _buildSection("Course Length", [
                _buildInfoRow(Icons.book, "9 topics"),
              ]),
              const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              _buildSection("List Topics", [
                for (var i = 0; i < 9; i++)
                  _buildTopicCard(context, index: i + 1),
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
                child: Image.asset('lib/assets/images/bg.png'),
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Life In The Internet Age",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                  const Text(
                    "Let's discuss how technology is changing the way we live",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 15)),
                  Row(children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/CourseLearnDetail'),
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                        ),
                        child: Text('Discover'.toUpperCase()),
                      ),
                    )
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

  Widget _buildTopicCard(BuildContext context, {required int index}) {
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
                      "$index.",
                      style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                    const Text(
                      "The Internet",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
