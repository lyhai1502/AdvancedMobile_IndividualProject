import 'package:flutter/material.dart';

/// Flutter code sample for [PopupMenuButton].

// This is the type used by the popup menu below.
enum SampleItem { Profile, Tutor, Course, Schedule, History }

class PopUpMenuWidget extends StatefulWidget {
  const PopUpMenuWidget({super.key});

  @override
  State<PopUpMenuWidget> createState() => PopUpMenuWidgetState();
}

class PopUpMenuWidgetState extends State<PopUpMenuWidget> {
  SampleItem? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SampleItem>(
      icon: Image.asset('lib/assets/icons/menu.png'),
      initialValue: selectedMenu,
      // Callback that sets the selected popup menu item.
      onSelected: (SampleItem item) {
        setState(() {
          selectedMenu = item;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
        const PopupMenuItem<SampleItem>(
          value: SampleItem.Profile,
          child: Text('Profile'),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.Tutor,
          child: const Text('Tutor'),
          onTap: () => Navigator.pushNamed(context, '/TutorList'),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.Course,
          child: const Text('Course'),
          onTap: () => Navigator.pushNamed(context, '/CourseList'),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.Schedule,
          child: const Text('Schedule'),
          onTap: () => Navigator.pushNamed(context, '/Schedule'),
        ),
        PopupMenuItem<SampleItem>(
          value: SampleItem.History,
          child: const Text('History'),
          onTap: () => Navigator.pushNamed(context, '/History'),
        ),
      ],
    );
  }
}
