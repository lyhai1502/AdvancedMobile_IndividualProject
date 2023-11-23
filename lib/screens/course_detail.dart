import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/app_bar.dart';

class CourseDetailScreen extends StatefulWidget {
  const CourseDetailScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CourseDetailScreenState();
  }
}

class CourseDetailScreenState extends State<CourseDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Card(
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
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Container(
                      margin: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Life In The Internet Age",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                          ),
                          const Text(
                            "Let's discuss how technology is changing the way we live",
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 15,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          Row(children: [
                            Expanded(
                                child: ElevatedButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, '/CourseLearnDetail'),
                                    style: ButtonStyle(
                                        textStyle: MaterialStateProperty.all(
                                            const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.blue),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    child: Text('Discover'.toUpperCase())))
                          ]),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              "Overview",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.question_mark_rounded,
                  color: Colors.red,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Why take this course",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Text(
                      "Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.question_mark_rounded,
                  color: Colors.red,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What will you be able to do",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                    ),
                    Text(
                      "You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.",
                      style: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ],
                )),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            const Text(
              "Experience Level",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                Text(
                  "Intermediate",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            const Text(
              "Course Length",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.book,
                  color: Colors.blue,
                ),
                Text(
                  "9 topics",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
            const Text(
              "List Topics",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            Column(
              children: [
                for (var i = 0; i < 9; i++)
                  GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, '/CourseLearnDetail'),
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
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    "1.",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                  ),
                                  Text(
                                    "The Internet",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            const Text(
              "Suggested Tutors",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
            RichText(
                text: TextSpan(
              style: const TextStyle(fontSize: 18, color: Colors.black),
              children: [
                const TextSpan(
                  text: 'Keegan',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const TextSpan(text: '     '),
                TextSpan(
                  style: const TextStyle(color: Colors.blueAccent),
                  text: 'More Info',
                  recognizer: TapGestureRecognizer()..onTap = () {},
                )
              ],
            )),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
            ),
          ]),
        ),
      ),
    );
  }
}
