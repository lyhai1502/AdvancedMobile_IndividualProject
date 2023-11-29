import 'package:my_app/model/teacher.dart';

class TeacherRepository {
  List<Teacher> list = [];

  void add(Teacher teacher) {
    list.add(teacher);
  }

  void remove(Teacher teacher) {
    list.remove(teacher);
  }

  List<Teacher>? getTeachersByName(String name) {
    List<Teacher> listTemp = [];
    for (Teacher teacher in list) {
      if (teacher.name.contains(name)) {
        listTemp.add(teacher);
      }

      return listTemp;
    }
  }

  void sortTeacherByRating(String sortRating) {
    if (sortRating == 'ascending') {
      list.sort((a, b) => a.rating.compareTo(b.rating));
    } else if (sortRating == 'descending') {
      list.sort((a, b) => b.rating.compareTo(a.rating));
    }
  }

  void sortTeacherByFavoriteNumber(String sortFavorite) {
    if (sortFavorite == 'ascending') {
      list.sort((a, b) => a.favoriteNumber.compareTo(b.rating));
    } else if (sortFavorite == 'descending') {
      list.sort((a, b) => b.favoriteNumber.compareTo(a.rating));
    }
  }
}
