import 'package:flutter/cupertino.dart';
import 'package:my_app/model/teacher.dart';

class TeacherRepository extends ChangeNotifier {
  List<Teacher> list = [];

  List<Teacher> filter = [];
  String filterName = 'All';

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
    return null;
  }

  void sortTeacherByRatingAndFavorite(String sortRating) {
    switch (sortRating) {
      case 'ascendingRating':
        {
          list.sort((a, b) => a.rating.compareTo(b.rating));
          filter.sort((a, b) => a.rating.compareTo(b.rating));

          break;
        }
      case 'descendingRating':
        {
          list.sort((a, b) => b.rating.compareTo(a.rating));
          filter.sort((a, b) => b.rating.compareTo(a.rating));

          break;
        }
      case 'ascendingFavorite':
        {
          list.sort((a, b) => a.favoriteNumber.compareTo(b.favoriteNumber));
          filter.sort((a, b) => a.favoriteNumber.compareTo(b.favoriteNumber));

          break;
        }
      case 'descendingFavorite':
        {
          list.sort((a, b) => b.favoriteNumber.compareTo(a.favoriteNumber));
          filter.sort((a, b) => b.favoriteNumber.compareTo(a.favoriteNumber));

          break;
        }
    }
  }

  void findByNameOrNation(String name) {
    filterName = name;
    filter.clear();
    for (Teacher teacher in list) {
      if (teacher.name.toLowerCase().contains(name.toLowerCase()) ||
          teacher.nation.toLowerCase() == name.toLowerCase()) {
        filter.add(teacher);
      }
    }
  }

  void filterSpecialities(String specialities) {
    filterName = specialities;
    filter.clear();
    for (Teacher teacher in list) {
      if (teacher.specialities.contains(specialities)) {
        filter.add(teacher);
      }
    }
    notifyListeners();
  }

  TeacherRepository() {
    list.add(Teacher.createTeacher(
        'Alice Johnson',
        'lib/assets/icons/teacher/avatar/avatar1.png',
        4,
        'USA',
        'Experienced English teacher passionate about literature.',
        'Bachelor in English Education',
        ['English', 'French'],
        ['TOEFL', 'KET', 'MOVERS'],
        'Reading, writing, hiking',
        '7 years of teaching English at high school level',
        'https://youtube.com/alice_teacher_video',
        57));

    list.add(Teacher.createTeacher(
        'Carlos Ramirez',
        'lib/assets/icons/teacher/avatar/avatar2.png',
        2,
        'Mexico',
        'Dynamic Mexico teacher with a focus on conversational skills.',
        'Master in Mexico Linguistics',
        ['Spanish', 'Italian', 'Mexican'],
        ['English for business', 'MOVERS', 'KET', 'IELTS'],
        'Salsa dancing, cooking, soccer',
        '10 years of teaching Spanish to international students',
        'https://youtube.com/carlos_teacher_video',
        122));

    list.add(Teacher.createTeacher(
        'Emily Chen',
        'lib/assets/icons/teacher/avatar/avatar3.png',
        4,
        'China',
        'Passionate Mandarin teacher dedicated to cultural immersion.',
        'TEFL Certification',
        ['Mandarin', 'English', 'Chinese'],
        ['STARTERS', 'TOEFL', 'PET'],
        'Calligraphy, travel, traditional Chinese music',
        '5 years of teaching Mandarin to foreign learners',
        'https://youtube.com/emily_teacher_video',
        83));

    list.add(Teacher.createTeacher(
        'Daniel Smith',
        'lib/assets/icons/teacher/avatar/avatar4.png',
        5,
        'Canada',
        'Interactive French teacher with a love for language games.',
        'Bachelor in French Literature',
        ['French', 'German'],
        ['English for kids'],
        'Board games, skiing, photography',
        '8 years of teaching French to diverse learners',
        'https://youtube.com/daniel_teacher_video',
        100));

    list.add(Teacher.createTeacher(
        'Isabella Martinez',
        'lib/assets/icons/teacher/avatar/avatar5.png',
        2,
        'Spain',
        'Energetic Spanish teacher specializing in practical language skills.',
        'Certified Spanish Teacher',
        ['Spanish', 'Portuguese'],
        ['FLYERS', 'MOVERS'],
        'Flamenco dancing, painting, hiking',
        '6 years of teaching Spanish to international students',
        'https://youtube.com/isabella_teacher_video',
        61));

    list.add(Teacher.createTeacher(
        'William Brown',
        'lib/assets/icons/teacher/avatar/avatar6.png',
        1,
        'UK',
        'Creative English teacher fostering a love for storytelling.',
        'MA in English Language Teaching',
        ['English', 'Japanese'],
        ['IELTS', 'TOEIC', 'Conversational'],
        'Writing short stories, tea tasting, archery',
        '9 years of teaching English in diverse cultural settings',
        'https://youtube.com/william_teacher_video',
        55));

    list.add(Teacher.createTeacher(
        'Sophie Dubois',
        'lib/assets/icons/teacher/avatar/avatar7.png',
        3,
        'France',
        'Innovative French teacher integrating technology into lessons.',
        'Certificat de Didactique du Français Langue Étrangère',
        ['French', 'Spanish'],
        ['English for business'],
        'Digital art, hiking, wine tasting',
        '11 years of teaching French to international students',
        'https://youtube.com/sophie_teacher_video',
        56));

// Example 8
    list.add(Teacher.createTeacher(
        'Liam Nguyen',
        'lib/assets/icons/teacher/avatar/avatar8.png',
        3,
        'Vietnam',
        'Adaptable Vietnamese teacher using multimedia for engaging lessons.',
        'TESOL Certification',
        ['Vietnamese', 'English'],
        ['TOEFL', 'KET', 'PET'],
        'Cooking Vietnamese cuisine, badminton, coding',
        '7 years of teaching Vietnamese to expatriates',
        'https://youtube.com/liam_teacher_video',
        92));

    list.add(Teacher.createTeacher(
        'Olivia Hansen',
        'lib/assets/icons/teacher/avatar/avatar9.png',
        1,
        'Australia',
        'Dedicated ESL teacher promoting a multicultural learning environment.',
        'TESOL Certificate',
        ['English', 'Mandarin'],
        ['TOEFL', 'Conversational'],
        'Bushwalking, photography, bird watching',
        '15 years of teaching English to speakers of other languages',
        'https://youtube.com/olivia_teacher_video',
        73));

    list.add(Teacher.createTeacher(
        'Muhammad Ali',
        'lib/assets/icons/teacher/avatar/avatar10.png',
        5,
        'Pakistan',
        'Motivated Urdu teacher with a focus on practical communication skills.',
        'Bachelor in Urdu Literature',
        ['Urdu', 'Arabic'],
        ['STARTERS', 'English for kids'],
        'Cricket, poetry, astronomy',
        '8 years of teaching Urdu to international learners',
        'https://youtube.com/muhammad_teacher_video',
        60));
  }
}
