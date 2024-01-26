import 'package:my_app/network/model/user_login.dart';

class UserRepository {
  List<User> list = [];

  void add(User user) {
    list.add(user);
  }

  void remove(User user) {
    list.remove(user);
  }

  User? getUserByEmail(String email) {
    for (User user in list) {
      if (user.email.compareTo(email) == 0) return user;
    }
    return null;
  }

  bool isUserExisted(String email) {
    return getUserByEmail(email) != null ? true : false;
  }

  String? getPasswordByEmail(String email) {
    return getUserByEmail(email)?.password;
  }

  bool isLoginSucess(String email, String password) {
    return isUserExisted(email) &&
            (getPasswordByEmail(email)?.compareTo(password) == 0)
        ? true
        : false;
  }
}
