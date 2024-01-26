import 'package:flutter/cupertino.dart';
import 'package:my_app/network/model/course_api.dart';

class CourseRepository extends ChangeNotifier {
  List<CourseApi> list = [];

  List<CourseApi> courseList = [];
  List<CourseApi> ebookList = [];
  String filterName = 'All';

  void update() {
    notifyListeners();
  }

  void add(CourseApi course) {
    list.add(course);
  }

  void remove(CourseApi course) {
    list.remove(course);
  }
}
