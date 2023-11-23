import 'package:flutter/material.dart';
import 'package:my_app/widgets/menu.dart';

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
  final bool _isLogin = true;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
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
          _isLogin ? PopUpMenuWidget() : const SizedBox.shrink(),
        ]));
  }
}
