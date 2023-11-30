import 'package:flutter/material.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:my_app/screens/course_detail.dart';
import 'package:my_app/screens/course_learn_detail.dart';
import 'package:my_app/screens/course_list.dart';
import 'package:my_app/screens/history_screen.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/reset_password_screen.dart';
import 'package:my_app/screens/schedule_screen.dart';
import 'package:my_app/screens/tutor_detail_screen.dart';
import 'package:my_app/screens/tutor_list_screen.dart';
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
  final UserRepository? userRepository = UserRepository();
  final String? userLoginId = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        Provider(create: (context) => userRepository),
        Provider(create: (context) => userLoginId)
      ],
      child: MaterialApp(
          theme: ThemeData(
              primarySwatch: Colors.blue,
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.blue),
                  color: Colors.white,
                  titleTextStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue) //<-- SEE HERE
                  )),
          routes: {
            '/Login': (context) => const LoginScreen(),
            '/Register': (context) => const RegisterScreen(),
            '/ResetPassword': (context) => const ResetPasswordScreen(),
            '/TutorList': (context) => const TutorListScreen(),
            '/TutorDetail': (context) => const TutorDetailScreen(),
            '/CourseList': (context) => const CourseListScreen(),
            '/CourseDetail': (context) => const CourseDetailScreen(),
            '/CourseLearnDetail': (context) => const CourseLearnDetailScreen(),
            '/Schedule': (context) => const ScheduleScreen(),
            '/History': (context) => const HistoryScreen(),
          },
          home: const TutorListScreen()),
    );
  }
}
