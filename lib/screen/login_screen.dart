import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _isObscured = false;
  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              const Text(
                "Say hello to your English tutors",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              const Text(
                "Become fluent faster through one on one video chat lessons tailored to your goals.",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email'.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: 'mail@example.com',
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password'.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  TextField(
                    obscureText: _isObscured,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: IconButton(
                          icon: !_isObscured
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        )),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              RichText(
                text: TextSpan(
                  text: 'Forgot Password?',
                  recognizer: TapGestureRecognizer()..onTap = () {},
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Row(children: [
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                            textStyle: MaterialStateProperty.all(
                                const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        child: Text('Login'.toUpperCase())))
              ]),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              const Text('Or continue with'),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: Image.asset('lib/assets/icons/facebook.png'),
                      onPressed: () {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: Image.asset('lib/assets/icons/google.png'),
                      onPressed: () {},
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: IconButton(
                      icon: Image.asset('lib/assets/icons/phone.png'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              RichText(
                  text: TextSpan(
                style: const TextStyle(color: Colors.black),
                children: [
                  const TextSpan(text: 'Not a member yet?   '),
                  TextSpan(
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    text: 'Sign up',
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  )
                ],
              )),
              SizedBox(
                width: 400,
                height: 400,
                child: IconButton(
                  icon: Image.asset('lib/assets/images/background.png'),
                  onPressed: () {},
                ),
              ),
            ],
          )),
    );
  }
}
