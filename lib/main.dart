import 'package:flutter/material.dart';
import 'package:my_app/screens/course_list.dart';
import 'package:my_app/screens/history_screen.dart';
import 'package:my_app/screens/schedule_screen.dart';
import 'package:my_app/screens/tutor_detail_screen.dart';
import 'package:my_app/widgets/app_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(appBar: AppBarWidget(), body: CourseScreenWidget()));
  }
}
