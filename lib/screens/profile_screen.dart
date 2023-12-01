import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:my_app/model/user.dart';
import 'package:my_app/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();
  TextEditingController levelController = TextEditingController();
  TextEditingController studyScheduleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUserHeader(user),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildUserInformation(user),
              const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
              _buildSaveButton(user)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserHeader(User user) {
    String id = user.userId;
    String email = user.email;
    String name = user.name;
    String avatarUrl = user.avatarUrl;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
          height: 100,
          width: 100,
          child: Image.asset(avatarUrl),
        ),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text('Account ID: $id'),
              Text('Email: $email'),
              CustomButtonWidget(
                  content: 'Change avatar',
                  function: () {
                    var random = Random().nextInt(10);
                    user.changeAvatar(
                        'lib/assets/icons/user/avatar/avatar$random.png');
                  })
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInformation(User user) {
    nameController.text = user.name;
    countryController.text = user.country;
    phoneNumberController.text = user.phoneNumber;
    birthdayController.text = user.birthday;
    levelController.text = user.level;
    studyScheduleController.text = user.studySchedule;

    return Column(children: [
      _buildTextField('Name', nameController),
      _buildTextField('Country', countryController),
      _buildTextField('Phone number', phoneNumberController),
      _buildTextField('Birthday', birthdayController),
      _buildTextField('My level', levelController),
      _buildTextField('Study schedule', studyScheduleController),
    ]);
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton(User user) {
    return Center(
      child: CustomButtonWidget(
          content: 'Save change',
          function: () {
            user.save(nameController, countryController, phoneNumberController,
                birthdayController, levelController, studyScheduleController);

            CoolAlert.show(
              confirmBtnText: 'OK',
              context: context,
              type: CoolAlertType.success,
              text: 'Save successfully!',
            );
          }),
    );
  }
}
