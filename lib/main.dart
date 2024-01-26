// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:my_app/network/model/user_login.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/repository/booking_repository.dart';
import 'package:my_app/repository/brightness_repository.dart';
import 'package:my_app/repository/course_repository.dart';
import 'package:my_app/repository/teacher_repository.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:my_app/widget/material_app.dart';
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
  final User? user = User();
  final CourseRepository courseRepository = CourseRepository();
  final TeacherRepository teacherRepository = TeacherRepository();

  final BookingRepository? bookingRepository = BookingRepository();
  final Tokens? currentToken = Tokens();
  BrightnessRepository? brightness = BrightnessRepository();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        Provider(create: (context) => userRepository),
        ChangeNotifierProvider(create: (context) => user),
        ChangeNotifierProvider(create: (context) => courseRepository),
        ChangeNotifierProvider(
          create: (context) => teacherRepository,
        ),
        ChangeNotifierProvider(create: (context) => bookingRepository),
        ChangeNotifierProvider(create: (context) => currentToken),
        ChangeNotifierProvider(create: (context) => brightness),
      ],
      child: MaterialAppWidget(),
    );
  }
}
