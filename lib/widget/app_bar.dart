import 'package:flutter/material.dart';
import 'package:my_app/repository/brightness_repository.dart';
import 'package:my_app/repository/language_repository.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  AppBarWidget({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);
  @override
  State<StatefulWidget> createState() {
    return AppBarWidgetState();
  }

  @override
  Size preferredSize;
}

IconData? _iconLight = Icons.wb_sunny;
IconData? _iconDark = Icons.nights_stay;

class AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BrightnessRepository brightness = context.watch<BrightnessRepository>();
    LanguageRepository language = context.watch<LanguageRepository>();

    return AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                language.changeLanguage();
              });
            },
            icon: !language.isEnglish
                ? Image.asset(
                    'lib/assets/icons/english_language.png',
                  )
                : Image.asset(
                    'lib/assets/icons/vietnam_language.png',
                  ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  brightness.changeBrightness();
                });
              },
              icon: Icon(
                brightness.isDarkModeOn ? _iconLight : _iconDark,
                color: Colors.blue,
              ))
        ],
        backgroundColor: brightness.isDarkModeOn ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              icon: Image.asset(
                'lib/assets/icons/logo.png',
                color: Colors.blue,
              ),
              onPressed: () {},
            ),
          ),
          const Text(
            'LetTutor',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Expanded(child: Container()),
        ]));
  }
}
