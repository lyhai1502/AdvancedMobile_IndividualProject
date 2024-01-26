import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:my_app/network/model/tokens.dart';
import 'package:my_app/network/model/user_api.dart';
import 'package:my_app/network/network_request/user/get_user_info_request.dart';
import 'package:my_app/network/network_request/user/update_user_info_request.dart';
import 'package:my_app/widget/custom_button.dart';
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

  UserApi userApi = UserApi();
  Tokens tokens = Tokens();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    tokens = context.read<Tokens>();

    Future<dynamic> future =
        GetInfoUserRequest.getUserInformation(tokens.access?.token);
    await future.then((value) {
      setState(() {
        userApi = value;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: !_isLoading
          ? SingleChildScrollView(
              child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserHeader(userApi),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  _buildUserInformation(userApi),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                  _buildSaveButton(userApi)
                ],
              ),
            ))
          : Center(
              heightFactor: MediaQuery.of(context).size.height / 2,
              child: const CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
    );
  }

  Widget _buildUserHeader(UserApi userApi) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SizedBox(
            height: 100,
            width: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage(userApi.avatar!),
            )),
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${userApi.name}',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              Text('Account ID: ${userApi.id}'),
              Text('Email: ${userApi.email}'),
              CustomButtonWidget(
                content: 'Change avatar',
                function: () {
                  setState(() {
                    Random random = Random();
                    String randomAvatarApi =
                        "https://xsgames.co/randomusers/assets/avatars/male/${random.nextInt(20)}.jpg";
                    userApi.avatar = randomAvatarApi;
                  });
                },
                color: Colors.blue,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInformation(UserApi userApi) {
    nameController.text = userApi.name!;
    countryController.text = userApi.country!;
    phoneNumberController.text = userApi.phone!;
    birthdayController.text = userApi.birthday!;
    levelController.text = userApi.level!;
    studyScheduleController.text = userApi.studySchedule!;

    return Column(children: [
      _buildTextField('Name', nameController),
      _buildTextField('Country', countryController),
      _buildTextField('Phone number', phoneNumberController),
      _buildBirthdayPicker('Birthday', birthdayController, context),
      _buildMyLevelDropDown('My level', levelController),
      _buildWanttoLearnMultiDropDown(
          'Want to learn', userApi.learnTopics, userApi.testPreparations),
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

  Widget _buildSaveButton(UserApi userApi) {
    return Center(
      child: CustomButtonWidget(
        content: 'Save change',
        function: () {
          // User saveUser = User();
          // saveUser.email = userApi.email!;
          // saveUser.password = user.password;

          // saveUser.name = nameController.text;
          // saveUser.country = countryController.text;
          // saveUser.phoneNumber = phoneNumberController.text;
          // saveUser.birthday = birthdayController.text;
          // saveUser.level = levelController.text;
          // saveUser.studySchedule = studyScheduleController.text;
          // saveUser.avatarUrl = user.avatarUrl;

          // user.cloneUser(saveUser);
          UpdateUserInfoRequest.updateUserInfo(
            tokens.access?.token,
            nameController.text,
            countryController.text,
            // phoneNumberController.text,
            birthdayController.text,
            levelController.text,
            studyScheduleController.text,
            userApi.avatar,
          );

          CoolAlert.show(
            confirmBtnText: 'OK',
            context: context,
            type: CoolAlertType.success,
            text: 'Save successfully!',
          );
        },
        color: Colors.blue,
      ),
    );
  }
}

Widget _buildWanttoLearnMultiDropDown(String label,
    List<LearnTopics>? learnTopics, List<TestPreparations>? testPreparations) {
  Map<String, String> learnTopics0 = {
    'english-for-kids': 'English for Kids',
    'business-english': 'Business English',
    'conversational-english': 'Conversational English',
  };
  Map<String, String> testPreparations0 = {
    'starters': 'STARTERS',
    'movers': 'MOVERS',
    'flyers': 'FLYERS',
    'ket': 'KET',
    'pet': 'PET',
    'ielts': 'IELTS',
    'toefl': 'TOEFL',
    'toeic': 'TOEIC',
  };
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
        MultiSelectDropDown(
          hint: 'Select topics',
          showClearIcon: true,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.black45),
          onOptionSelected: (List<ValueItem<dynamic>> selected) {
            testPreparations = [];
            for (var element in selected) {
              if (learnTopics0.containsKey(element.value)) {
                learnTopics.add(LearnTopics(
                    key: element.value, name: learnTopics0[element.value]));
              } else {
                testPreparations!.add(TestPreparations(
                    key: element.value,
                    name: testPreparations0[element.value]));
              }
            }
          },
          selectedOptions: [
            for (var item in learnTopics!)
              ValueItem(label: item.name!, value: item.key),
            for (var item in testPreparations!)
              ValueItem(label: item.name!, value: item.key)
          ],
          options: [
            for (var item in learnTopics0.entries)
              ValueItem(label: item.value, value: item.key),
            for (var item in testPreparations0.entries)
              ValueItem(label: item.value, value: item.key)
          ],
          selectionType: SelectionType.multi,
          selectedOptionTextColor: Colors.blue,
          dropdownHeight: 550,
          optionTextStyle: const TextStyle(fontSize: 15),
          selectedOptionIcon: const Icon(Icons.check_circle),
        )
      ],
    ),
  );
}

Widget _buildMyLevelDropDown(String label, TextEditingController controller) {
  Map<String, String> levels = {
    'Pre A1 (Beginner)': 'BEGINNER',
    'A1 (Higher Beginner)': 'HIGHER_BEGINNER',
    'A2 (Pre-Intermediate)': 'PRE_INTERMEDIATE',
    'B1 (Intermediate)': 'INTERMEDIATE',
    'B2 (Upper-Intermediate)': 'UPPER_INTERMEDIATE',
    'C1 (Advanced)': 'ADVANCED',
    'C2 (Proficiency)': 'PROFICIENCY',
  };
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
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          value: controller.text,
          onChanged: (String? newValue) {
            controller.text = newValue!;
          },
          items: levels.entries.map((MapEntry<String, String> entry) {
            return DropdownMenuItem<String>(
              value: entry.value,
              child: Text(entry.key),
            );
          }).toList(),
        )
      ],
    ),
  );
}

Widget _buildBirthdayPicker(
    String label, TextEditingController controller, BuildContext context) {
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
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            controller.text = date.toString().substring(0, 10);
          },
        ),
      ],
    ),
  );
}
