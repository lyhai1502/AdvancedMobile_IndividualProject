import 'package:flutter/material.dart';
import 'package:my_app/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.white,
                title: Row(children: [
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
                ])),
            body: LoginScreen()));
  }
}
