import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:my_app/l10n/l10n.dart';
import 'package:my_app/repository/brightness_repository.dart';
import 'package:my_app/repository/language_repository.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = context.watch<BrightnessRepository>();
    final language = context.watch<LanguageRepository>();
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
        '/Login': (context) => LoginScreen(),
        '/Register': (context) => RegisterScreen(),
        '/ForgotPassword': (context) => ForgotPasswordScreen(),
        '/Home': (context) => HomeScreen(),
        '/TutorList': (context) => TutorListScreen(),
        '/CourseList': (context) => CourseListScreen(),
        '/Schedule': (context) => ScheduleScreen(),
        '/History': (context) => HistoryScreen(),
        '/Profile': (context) => ProfileScreen(),
        '/Setting': (context) => SetttingScreen(),
      },
      supportedLocales: L10n.all,
      locale: language.isEnglish ? const Locale('en') : const Locale('vi'),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      home: const LoginScreen(),
    );
  }
}
