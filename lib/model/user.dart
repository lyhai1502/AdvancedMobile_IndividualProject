class User {
  String userId = '';
  String email = '';
  String password = '';
  User();

  static User createUser(String userEmail, String userPassword) {
    User user = User();
    user.userId = DateTime.now().millisecondsSinceEpoch.toString();
    user.email = userEmail;
    user.password = userPassword;

    return user;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $userId, email: $email';
  }
}
