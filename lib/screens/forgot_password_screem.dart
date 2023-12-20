
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:my_app/network/network_request/user/reset_password_request.dart';
import 'package:my_app/repository/user_repository.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgotPasswordScreenState();
  }
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = context.watch<UserRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text(
                "Please enter your email address. You will receive a link to create a new password via email.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
              ),
              _buildTextFields(),
              _buildSendEmailButton(userRepository),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFields() {
    return _buildTextField('Email', 'mail@example.com');
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

  Widget _buildSendEmailButton(UserRepository userRepository) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Expanded(
              child: CustomButtonWidget(
                  content: "Send reset link",
                  function: () {
                    // if (userRepository.getUserByEmail(emailController.text) !=
                    //     null) {
                    //   _sendResetEmail();
                    //   Navigator.push(
                    //       context,
                    //       MaterialPageRoute(
                    //           builder: (context) => ResetPasswordScreen(
                    //               email: emailController.text)));
                    // } else {
                    //   CoolAlert.show(
                    //     confirmBtnText: 'OK',
                    //     context: context,
                    //     type: CoolAlertType.warning,
                    //     text: 'Your email not existed',
                    //   );
                    // }
                    if (emailController.text.isEmpty) {
                      CoolAlert.show(
                        confirmBtnText: 'OK',
                        context: context,
                        type: CoolAlertType.warning,
                        text: 'Please enter your email',
                      );
                    } else {
                      ResetPasswordRequest.resetPassword(emailController.text);
                      CoolAlert.show(
                        confirmBtnText: 'OK',
                        context: context,
                        type: CoolAlertType.success,
                        text: 'Please check your email to reset password',
                      );
                    }
                  },
                  color: Colors.blue)),
        ],
      ),
    );
  }

  void _sendResetEmail() {}
}
