import 'package:flutter/material.dart';
import 'package:my_app/screens/course_detail.dart';
import 'package:my_app/screens/course_learn_detail.dart';
import 'package:my_app/screens/course_list.dart';
import 'package:my_app/screens/history_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/schedule_screen.dart';
import 'package:my_app/screens/tutor_detail_screen.dart';
import 'package:my_app/screens/tutor_list_screen.dart';
import 'package:my_app/widgets/app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(routes: {
      '/TutorList': (context) => TutorListScreen(),
      '/TutorDetail': (context) => TutorDetailScreen(),
      '/CourseList': (context) => CourseListScreen(),
      '/CourseDetail': (context) => CourseDetailScreen(),
      '/CourseLearnDetail': (context) => CourseLearnDetailScreen(),
      '/Schedule': (context) => ScheduleScreen(),
      '/History': (context) => HistoryScreen(),
    }, home: Scaffold(appBar: AppBarWidget(), body: const LoginScreen()));
  }
}
