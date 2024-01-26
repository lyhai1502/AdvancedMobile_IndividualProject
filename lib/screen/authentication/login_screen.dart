import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_app/network/model/user_login.dart';
import 'package:my_app/network/network_reponse/error_response.dart';
import 'package:my_app/network/network_request/authentication/login_request.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:my_app/widget/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  bool _isLoading = false;

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
        Text(
          AppLocalizations.of(context)!.title,
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
        Text(
          AppLocalizations.of(context)!.description,
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
        _buildTextField(
            AppLocalizations.of(context)!.emailLogin, 'mail@example.com'),
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
          AppLocalizations.of(context)!.passwordLogin.toUpperCase(),
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
        text: AppLocalizations.of(context)!.forgotPassword,
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
                  setState(() {
                    _isLoading = true;
                    loginRequest(currentTokens);
                  });
                },
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all(
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: !_isLoading
                    ? Text(
                        AppLocalizations.of(context)!.loginButton.toUpperCase())
                    : const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueWithText() {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(AppLocalizations.of(context)!.orContinueWith));
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton('lib/assets/icons/facebook.png', () {
          _loginWithFacebook();
        }),
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
              TextSpan(text: AppLocalizations.of(context)!.notAMemberYet),
              TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                text: AppLocalizations.of(context)!.registerButton,
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
    _isLoading = false;
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
          text: tokens.message,
          onConfirmBtnTap: () {
            setState(() {
              _isLoading = false;
            });
          });
    }
  }
}

// ...

void _loginWithFacebook() async {}
