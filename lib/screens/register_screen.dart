import 'package:flutter/material.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:my_app/widgets/app_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  final _formkey = GlobalKey<FormState>();
  final GlobalKey<FlutterPwValidatorState> validatorKey =
      GlobalKey<FlutterPwValidatorState>();

  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = context.watch<UserRepository>();

    return Scaffold(
      appBar: AppBarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Container(
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                _buildHeader(),
                _buildTextFields(),
                _buildRegisterButton(userRepository),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        SizedBox(
          width: 400,
          height: 350,
          child: Image.asset('lib/assets/images/background.png'),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        const Text(
          "Say hello to your English tutors",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
        const Text(
          "Become fluent faster through one on one video chat lessons tailored to your goals.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
        ),
      ],
    );
  }

  Widget _buildTextFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Email', 'mail@example.com'),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        _buildPasswordField(),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
        ),
        _buildPasswordConfirmField(),
      ],
    );
  }

  Widget _buildTextField(String label, String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        TextFormField(
          validator: MultiValidator([
            RequiredValidator(errorText: 'Enter email address'),
            EmailValidator(errorText: 'Please correct email filled'),
          ]),
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hintText,
            errorStyle: const TextStyle(fontSize: 15.0),
          ),
          onChanged: (value) {
            _formkey.currentState!.validate();
          },
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password'.toUpperCase(),
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
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
          key: validatorKey,
          controller: passwordController,
          minLength: 8,
          uppercaseCharCount: 1,
          numericCharCount: 1,
          specialCharCount: 1,
          width: 400,
          height: 150,
          onSuccess: () {},
          onFail: () {},
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
      ],
    );
  }

  Widget _buildRegisterButton(UserRepository userRepository) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                userRepository.add(User.createUser(
                    emailController.text, passwordController.text));
                print(userRepository.list);
                Navigator.pushNamed(context, '/Login');
              },
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text('Register'.toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }
}
