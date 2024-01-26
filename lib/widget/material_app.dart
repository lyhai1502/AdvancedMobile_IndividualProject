import 'package:flutter/material.dart';
import 'package:my_app/repository/brightness_repository.dart';
import 'package:my_app/screen/course/course_list.dart';
import 'package:my_app/screen/authentication/forgot_password_screen.dart';
import 'package:my_app/screen/history/history_screen.dart';
import 'package:my_app/screen/home/home_screen.dart';
import 'package:my_app/screen/authentication/login_screen.dart';
import 'package:my_app/screen/user/profile_screen.dart';
import 'package:my_app/screen/authentication/register_screen.dart';
import 'package:my_app/screen/schedule/schedule_screen.dart';
import 'package:my_app/screen/setting/setting_screen.dart';
import 'package:my_app/screen/tutor/tutor_list_screen.dart';
import 'package:provider/provider.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = context.watch<BrightnessRepository>();
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness:
            brightness.isDarkModeOn ? Brightness.dark : Brightness.light,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.blue),
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ),
      routes: {
        '/Login': (context) => const LoginScreen(),
        '/Register': (context) => const RegisterScreen(),
        '/ForgotPassword': (context) => const ForgotPasswordScreen(),
        '/Home': (context) => const HomeScreen(),
        '/TutorList': (context) => const TutorListScreen(),
        '/CourseList': (context) => const CourseListScreen(),
        '/Schedule': (context) => const ScheduleScreen(),
        '/History': (context) => const HistoryScreen(),
        '/Profile': (context) => const ProfileScreen(),
        '/Setting': (context) => const SetttingScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
