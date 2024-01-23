import 'package:flutter/cupertino.dart';
import 'package:my_app/model/course.dart';
import 'package:my_app/model/teacher.dart';
import 'package:my_app/network/models/course_api.dart';

class CourseRepository extends ChangeNotifier {
  List<Course> list = [];

  List<Teacher> filter = [];

  List<CourseApi> courseList = [];
  List<CourseApi> ebookList = [];
  String filterName = 'All';

  void update() {
    notifyListeners();
  }

  void add(Course course) {
    list.add(course);
  }

  void remove(Course course) {
    list.remove(course);
  }

  Course? getTeacherById(String id) {
    for (Course course in list) {
      if (course.id == id) {
        return course;
      }
    }
    return null;
  }

  CourseRepository() {
    list.add(Course.createCourse(
        'Life in the Internet Age',
        'lib/assets/images/course/course1.png',
        'Lets discuss how technology is changing the way we live',
        'Our world is rapidly changing thanks to new technology, and the vocabulary needed to discuss modern life is evolving almost daily. In this course you will learn the most up-to-date terminology from expertly crafted lessons as well from your native-speaking tutor.',
        'You will learn vocabulary related to timely topics like remote work, artificial intelligence, online privacy, and more. In addition to discussion questions, you will practice intermediate level speaking tasks such as using data to describe trends.',
        'Intermediate', [
      'The Internet',
      'Artificial Intelligence (AI)',
      'Social Media',
      'Internet Privacy',
      'Live Streaming',
      'Coding',
      'Technology Transforming Healthcare',
      'Smart Home Technology',
      'Remote Work - A Dream Job?'
    ]));
    list.add(Course.createCourse(
        'Caring for Our Planet',
        'lib/assets/images/course/course2.png',
        'Lets discuss our relationship as humans with our planet, Earth',
        'As climate change and environmentalism become increasingly global issues, this topic appears often in international news and is relevant to many international industries.',
        'This course covers intermediate level vocabulary related to sustainability and environmental science. In addition, you will complete technical tasks such as describing charts, analyzing data, and making estimations.',
        'Intermediate', [
      'Recycling for Sustainability',
      'Renewable Energy Sources',
      'Our Changing Climate',
      'Pollution Solutions',
      'The Zero Waste Movement',
      'Engaging in Ecosystems',
      'Exotic and Endangered Animals'
    ]));
    list.add(Course.createCourse(
        'You Are What You Eat',
        'lib/assets/images/course/course3.png',
        'Lets discuss the many aspects of living a long, happy life',
        '',
        'Discuss topics related to physical, mental, and emotional health. Learn about other cultures along the way in friendly conversations with tutors.',
        'Intermediate', [
      'You Are What You Eat',
      'Working Up A Sweat',
      'Drink Up',
      'Catching Some Z s',
      'Chill Out',
      'Look On The Bright Side'
    ]));
  }
}
