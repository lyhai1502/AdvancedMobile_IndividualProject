import 'package:flutter/material.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:my_app/screens/course_detail.dart';
import 'package:my_app/screens/course_learn_detail.dart';
import 'package:my_app/screens/course_list.dart';
import 'package:my_app/screens/history_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/schedule_screen.dart';
import 'package:my_app/screens/tutor_detail_screen.dart';
import 'package:my_app/screens/tutor_list_screen.dart';
import 'package:my_app/widgets/app_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final UserRepository userRepository = UserRepository();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [Provider(create: (context) => userRepository)],
      child: MaterialApp(routes: {
        '/Login': (context) => LoginScreen(),
        '/Register': (context) => RegisterScreen(),
        '/TutorList': (context) => TutorListScreen(),
        '/TutorDetail': (context) => TutorDetailScreen(),
        '/CourseList': (context) => CourseListScreen(),
        '/CourseDetail': (context) => CourseDetailScreen(),
        '/CourseLearnDetail': (context) => CourseLearnDetailScreen(),
        '/Schedule': (context) => ScheduleScreen(),
        '/History': (context) => HistoryScreen(),
      }, home: LoginScreen()),
    );
  }
}
