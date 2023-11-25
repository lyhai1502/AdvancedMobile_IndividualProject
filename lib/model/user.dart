class User {
  final String userId;
  final String email;
  final String password;
  User({required this.userId, required this.email, required this.password});

  static User createUser(String userEmail, String userPassword) {
    return User(
        userId: DateTime.now().millisecondsSinceEpoch.toString(),
        email: userEmail,
        password: userPassword);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $userId, email: $email';
  }
}
