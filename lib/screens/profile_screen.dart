import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:my_app/network/models/tokens.dart';
import 'package:my_app/network/models/user_api.dart';
import 'package:my_app/network/network_request/user/get_user_info_request.dart';
import 'package:my_app/network/network_request/user/update_user_info_request.dart';
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

  UserApi userApi = UserApi();
  Tokens tokens = Tokens();
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
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
                  // var random = Random().nextInt(10);
                  // user.changeAvatar(
                  //     'lib/assets/icons/user/avatar/avatar$random.png');
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
              studyScheduleController.text);

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
