import 'package:flutter/material.dart';

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

class AppBarWidgetState extends State<AppBarWidget> {
  bool _isEnglishLanguage = true;
  final bool _isLogin = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
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
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
          ]),
          Row(children: [
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                icon: _isEnglishLanguage
                    ? Image.asset('lib/assets/icons/united-kingdom.png')
                    : Image.asset('lib/assets/icons/vietnam.png'),
                onPressed: () {
                  setState(() {
                    _isEnglishLanguage = !_isEnglishLanguage;
                  });
                },
              ),
            ),
            _isLogin
                ? SizedBox(
                    width: 50,
                    height: 50,
                    child: IconButton(
                      icon: Image.asset('lib/assets/icons/menu.png'),
                      onPressed: () {},
                    ),
                  )
                : const SizedBox.shrink(),
          ]),
        ]));
  }
}
