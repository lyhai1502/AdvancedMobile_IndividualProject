import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/network/response/ErrorResponse.dart';
import 'package:my_app/network/network_request/authentication/login_request.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:my_app/widgets/app_bar.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isObscured = false;

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    UserRepository? userRepository = context.watch<UserRepository>();
    User user = context.watch<User>();
    Tokens currentTokens = context.watch<Tokens>();
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildHeader(),
              _buildTextFields(),
              _buildLoginButton(userRepository, user, currentTokens),
              _buildForgotPasswordLink(),
              _buildContinueWithText(),
              _buildSocialButtons(),
              _buildSignUpLink(),
            ],
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
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            hintText: hintText,
          ),
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
      ],
    );
  }

  Widget _buildForgotPasswordLink() {
    return RichText(
      text: TextSpan(
        text: 'Forgot password?',
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.pushNamed(context, '/ForgotPassword');
          },
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.blueAccent,
        ),
      ),
    );
  }

  Widget _buildLoginButton(
      UserRepository userRepository, User user, Tokens currentTokens) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // if (userRepository.isLoginSucess(
                //     emailController.text, passwordController.text)) {
                //   user.cloneUser(
                //       userRepository.getUserByEmail(emailController.text));
                //   Navigator.pushNamed(context, '/Home');
                //   CoolAlert.show(
                //     confirmBtnText: 'OK',
                //     context: context,
                //     type: CoolAlertType.success,
                //     text: 'Login successfully!',
                //   );
                // } else {
                //   CoolAlert.show(
                //     confirmBtnText: 'OK',
                //     context: context,
                //     type: CoolAlertType.warning,
                //     text: 'Your email or password is incorrect',
                //   );
                // }
                // userTokenApi = await UserTokenApi()
                //     .login(emailController.text, passwordController.text);

                // if (kDebugMode) {
                //   print(userTokenApi.user != null);
                // }
                loginRequest(currentTokens);
              },
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text('Login'.toUpperCase()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueWithText() {
    return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text('Or continue with'));
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton('lib/assets/icons/facebook.png', () {}),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        _buildSocialButton('lib/assets/icons/google.png', () {}),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
        ),
        _buildSocialButton('lib/assets/icons/phone.png', () {}),
      ],
    );
  }

  Widget _buildSocialButton(String iconPath, VoidCallback onPressed) {
    return SizedBox(
      width: 60,
      height: 60,
      child: IconButton(
        icon: Image.asset(iconPath),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Column(
      children: [
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
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                text: 'Sign up',
                recognizer: TapGestureRecognizer()
                  ..onTap = () => Navigator.pushNamed(context, '/Register'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> loginRequest(Tokens currentTokens) async {
    dynamic tokens =
        await LoginRequest.login(emailController.text, passwordController.text);

    if (tokens is Tokens) {
      currentTokens.updateTokens(tokens);
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, '/Home');
      // ignore: use_build_context_synchronously
      CoolAlert.show(
        confirmBtnText: 'OK',
        context: context,
        type: CoolAlertType.success,
        text: 'Login successfully!',
      );
    } else if (tokens is ErrorResponse) {
      // ignore: use_build_context_synchronously
      CoolAlert.show(
          confirmBtnText: 'OK',
          context: context,
          type: CoolAlertType.warning,
          text: tokens.message);
    }
  }
}
