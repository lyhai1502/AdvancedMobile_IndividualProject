import 'dart:math';

class Teacher {
  String id = '';
  String name = '';
  String avatarUrl = '';
  int rating = 0;
  String nation = '';
  String description = '';

  String education = '';
  List<String> languages = [];
  List<String> specialties = [];
  String interests = '';
  String experience = '';
  String videoUrl = '';

  int favoriteNumber = 0;

  Teacher();

  static Teacher createTeacher(
      String name,
      String avatarUrl,
      int rating,
      String nation,
      String description,
      String education,
      List<String> languages,
      List<String> specicalties,
      String interests,
      String experience,
      String videoUrl,
      int favoriteNumber) {
    Teacher teacher = Teacher();
    teacher.id = DateTime.now().millisecondsSinceEpoch.toString();
    teacher.name = name;
    teacher.avatarUrl = avatarUrl;
    teacher.rating = rating;
    teacher.nation = nation;
    teacher.education = education;
    teacher.languages = languages;
    teacher.specialties = specicalties;
    teacher.interests = interests;
    teacher.experience = experience;
    teacher.videoUrl = videoUrl;
    teacher.description = description;
    teacher.favoriteNumber = favoriteNumber;

    return teacher;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'id: $id, name: $name';
  }
}
