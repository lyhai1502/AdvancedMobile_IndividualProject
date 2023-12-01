import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String userId = '';
  String email = '';
  String password = '';
  String name = '';
  String avatarUrl = '';
  String country = '';
  String phoneNumber = '';
  String birthday = '';
  String level = '';
  List<String> wantToLearn = [];
  String studySchedule = '';

  User();

  static User createUser(String userEmail, String userPassword) {
    User user = User();
    user.userId = DateTime.now().millisecondsSinceEpoch.toString();
    user.email = userEmail;
    user.name = userEmail;
    user.password = userPassword;
    user.avatarUrl = 'lib/assets/icons/user/avatar/avatar0.png';

    return user;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $userId, email: $email';
  }

  void cloneUser(User? user) {
    userId = user!.userId;
    email = user.email;
    password = user.password;
    name = user.name;
    avatarUrl = user.avatarUrl;
    country = user.country;
    phoneNumber = user.phoneNumber;
    birthday = user.birthday;
    level = user.level;
    wantToLearn = user.wantToLearn;
    studySchedule = user.studySchedule;

    notifyListeners();
  }

  void save(
      TextEditingController nameController,
      TextEditingController countryController,
      TextEditingController phoneNumberController,
      TextEditingController birthdayController,
      TextEditingController levelController,
      TextEditingController studyScheduleController) {
    name = nameController.text;
    country = countryController.text;
    phoneNumber = phoneNumberController.text;
    birthday = birthdayController.text;
    level = levelController.text;
    studySchedule = studyScheduleController.text;

    notifyListeners();
  }

  void changeAvatar(String imageUrl) {
    avatarUrl = imageUrl;
    notifyListeners();
  }

  void changePassword(String password) {
    this.password = password;
    notifyListeners();
  }
}
