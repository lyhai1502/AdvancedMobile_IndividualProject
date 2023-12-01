import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  final String email;
  @override
  State<StatefulWidget> createState() {
    return ResetPasswordScreenState();
  }
}

class ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final GlobalKey<FlutterPwValidatorState> _validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  bool _isObscured = false;
  bool _isPasswordValid = false;
  bool _isConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.email);
    UserRepository userRepository = context.watch<UserRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              _buildTextFields(),
              _buildConfirmButton(userRepository),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPasswordField(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        _buildPasswordConfirmField(),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New password'.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 165, 153, 153),
          ),
        ),
        TextField(
          controller: passwordController,
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
            ),
          ),
        ),
        FlutterPwValidator(
          key: _validatorKey,
          controller: passwordController,
          minLength: 8,
          uppercaseCharCount: 1,
          numericCharCount: 1,
          specialCharCount: 1,
          width: 400,
          height: 150,
          onSuccess: () {
            _isPasswordValid = true;
          },
          onFail: () {
            _isPasswordValid = false;
          },
        ),
      ],
    );
  }

  Widget _buildPasswordConfirmField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password Confirm'.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        TextField(
          controller: passwordConfirmController,
          obscureText: _isObscured,
          enableSuggestions: false,
          autocorrect: false,
          onChanged: (value) {
            setState(() {
              if (value == passwordController.text) {
                _isConfirmPassword = true;
              } else {
                _isConfirmPassword = false;
              }
            });
          },
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
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.all(5)),
        !_isConfirmPassword
            ? const Text(
                'Your confirm password is incorrect',
                style: TextStyle(color: Colors.red, fontSize: 15),
              )
            : const Text(''),
      ],
    );
  }

  Widget _buildConfirmButton(UserRepository userRepository) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (_isPasswordValid && _isConfirmPassword) {
                  userRepository
                      .getUserByEmail(widget.email)
                      ?.changePassword(passwordController.text);
                  CoolAlert.show(
                    confirmBtnText: 'OK',
                    context: context,
                    type: CoolAlertType.success,
                    text: 'Register successfully!',
                    onConfirmBtnTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                  );
                }
              },
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text('Confirm'.toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }
}
