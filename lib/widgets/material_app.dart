import 'package:flutter/material.dart';
import 'package:my_app/repository/brightness_repository.dart';
import 'package:my_app/screens/course_list.dart';
import 'package:my_app/screens/forgot_password_screem.dart';
import 'package:my_app/screens/history_screen.dart';
import 'package:my_app/screens/home.dart';
import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/profile_screen.dart';
import 'package:my_app/screens/register_screen.dart';
import 'package:my_app/screens/schedule_screen.dart';
import 'package:my_app/screens/setting_screen.dart';
import 'package:my_app/screens/tutor_list_screen.dart';
import 'package:my_app/screens/video_call_screen.dart';
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
          color: Colors.black,
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
        '/VideoCall': (context) => const VideoCallScreen(),
      },
      home: const LoginScreen(),
    );
  }
}
