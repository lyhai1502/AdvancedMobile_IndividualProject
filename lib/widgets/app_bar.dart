import 'package:flutter/material.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/widgets/menu.dart';
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

class AppBarWidgetState extends State<AppBarWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String userLoginId = context.watch<String>();

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
          userLoginId != '' ? const PopUpMenuWidget() : const SizedBox.shrink(),
        ]));
  }
}
