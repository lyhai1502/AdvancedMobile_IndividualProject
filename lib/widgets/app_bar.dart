import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(children: [
            SizedBox(
              width: 50,
              height: 50,
              child: IconButton(
                icon: Image.asset('lib/assets/icons/logo.png'),
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
          SizedBox(
            width: 50,
            height: 50,
            child: IconButton(
              icon: Image.asset('lib/assets/icons/united-kingdom.png'),
              onPressed: () {},
            ),
          ),
        ]));
  }
}
