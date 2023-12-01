import 'package:flutter/material.dart';
import 'package:my_app/screens/course_list.dart';
import 'package:my_app/screens/history_screen.dart';
import 'package:my_app/screens/schedule_screen.dart';
import 'package:my_app/screens/setting_screen.dart';
import 'package:my_app/screens/tutor_list_screen.dart';
import 'package:my_app/widgets/app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    TutorListScreen(),
    ScheduleScreen(),
    HistoryScreen(),
    CourseListScreen(),
    SetttingScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('lib/assets/icons/navbar/tutor.png'),
            ),
            label: 'Tutors',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('lib/assets/icons/navbar/schedule.png'),
            ),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('lib/assets/icons/navbar/history.png'),
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('lib/assets/icons/navbar/courses.png'),
            ),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(
            () {
              _selectedIndex = index;
            },
          );
        },
      ),
    );
  }
}
