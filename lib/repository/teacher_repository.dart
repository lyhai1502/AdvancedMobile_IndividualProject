import 'package:my_app/model/teacher.dart';

class TeacherRepository {
  List<Teacher> list = [];

  List<Teacher> filter = [];
  String filterName = '';

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
          break;
        }
      case 'descendingRating':
        {
          list.sort((a, b) => b.rating.compareTo(a.rating));
          break;
        }
      case 'ascendingFavorite':
        {
          list.sort((a, b) => a.favoriteNumber.compareTo(b.favoriteNumber));
          break;
        }
      case 'descendingFavorite':
        {
          list.sort((a, b) => b.favoriteNumber.compareTo(a.favoriteNumber));
          break;
        }
    }
  }

  List<Teacher> filterBySpecialities(String specialities) {
    List<Teacher> listFilter = [];
    for (Teacher teacher in list) {
      if (teacher.specialities.contains(specialities)) {
        listFilter.add(teacher);
      }
    }
    return listFilter;
  }

  void findByNameOrNation(String name) {
    filterName = name;
    filter.clear();
    for (Teacher teacher in list) {
      if (teacher.name.toLowerCase().contains(name.toLowerCase()) ||
          teacher.nation.toLowerCase().contains(name.toLowerCase())) {
        filter.add(teacher);
      }
    }
    print(filter.length);
  }

  TeacherRepository() {
    list.add(Teacher.createTeacher(
        'Alice Johnson',
        'https://example.com/alice_avatar',
        4,
        'USA',
        'Experienced English teacher passionate about literature.',
        'Bachelor in English Education',
        ['English', 'French'],
        ['TOEFL', 'KET'],
        'Reading, writing, hiking',
        '7 years of teaching English at high school level',
        'https://youtube.com/alice_teacher_video',
        57));

    list.add(Teacher.createTeacher(
        'Carlos Ramirez',
        'https://example.com/carlos_avatar',
        2,
        'Mexico',
        'Dynamic Spanish teacher with a focus on conversational skills.',
        'Master in Spanish Linguistics',
        ['Spanish', 'Italian'],
        ['English for business', 'MOVERS'],
        'Salsa dancing, cooking, soccer',
        '10 years of teaching Spanish to international students',
        'https://youtube.com/carlos_teacher_video',
        68));

    list.add(Teacher.createTeacher(
        'Emily Chen',
        'https://example.com/emily_avatar',
        4,
        'China',
        'Passionate Mandarin teacher dedicated to cultural immersion.',
        'TEFL Certification',
        ['Mandarin', 'English'],
        ['HSK', 'TOEFL'],
        'Calligraphy, travel, traditional Chinese music',
        '5 years of teaching Mandarin to foreign learners',
        'https://youtube.com/emily_teacher_video',
        89));

    list.add(Teacher.createTeacher(
        'Daniel Smith',
        'https://example.com/daniel_avatar',
        5,
        'Canada',
        'Interactive French teacher with a love for language games.',
        'Bachelor in French Literature',
        ['French', 'German'],
        ['DELF', 'Goethe-Zertifikat'],
        'Board games, skiing, photography',
        '8 years of teaching French to diverse learners',
        'https://youtube.com/daniel_teacher_video',
        75));

    list.add(Teacher.createTeacher(
        'Isabella Martinez',
        'https://example.com/isabella_avatar',
        2,
        'Spain',
        'Energetic Spanish teacher specializing in practical language skills.',
        'Certified Spanish Teacher',
        ['Spanish', 'Portuguese'],
        ['DELE', 'CELPE-Bras'],
        'Flamenco dancing, painting, hiking',
        '6 years of teaching Spanish to international students',
        'https://youtube.com/isabella_teacher_video',
        63));

    list.add(Teacher.createTeacher(
        'William Brown',
        'https://example.com/william_avatar',
        1,
        'UK',
        'Creative English teacher fostering a love for storytelling.',
        'MA in English Language Teaching',
        ['English', 'Japanese'],
        ['IELTS', 'JLPT'],
        'Writing short stories, tea tasting, archery',
        '9 years of teaching English in diverse cultural settings',
        'https://youtube.com/william_teacher_video',
        80));

    list.add(Teacher.createTeacher(
        'Sophie Dubois',
        'https://example.com/sophie_avatar',
        3,
        'France',
        'Innovative French teacher integrating technology into lessons.',
        'Certificat de Didactique du Français Langue Étrangère',
        ['French', 'Spanish'],
        ['DALF', 'DELE'],
        'Digital art, hiking, wine tasting',
        '11 years of teaching French to international students',
        'https://youtube.com/sophie_teacher_video',
        55));

// Example 8
    list.add(Teacher.createTeacher(
        'Liam Nguyen',
        'https://example.com/liam_avatar',
        3,
        'Vietnam',
        'Adaptable Vietnamese teacher using multimedia for engaging lessons.',
        'TESOL Certification',
        ['Vietnamese', 'English'],
        ['TOEFL', 'Hanoi Proficiency Test'],
        'Cooking Vietnamese cuisine, badminton, coding',
        '7 years of teaching Vietnamese to expatriates',
        'https://youtube.com/liam_teacher_video',
        92));

    list.add(Teacher.createTeacher(
        'Olivia Hansen',
        'https://example.com/olivia_avatar',
        1,
        'Australia',
        'Dedicated ESL teacher promoting a multicultural learning environment.',
        'TESOL Certificate',
        ['English', 'Mandarin'],
        ['TOEFL', 'YCT'],
        'Bushwalking, photography, bird watching',
        '15 years of teaching English to speakers of other languages',
        'https://youtube.com/olivia_teacher_video',
        77));

    list.add(Teacher.createTeacher(
        'Muhammad Ali',
        'https://example.com/muhammad_avatar',
        5,
        'Pakistan',
        'Motivated Urdu teacher with a focus on practical communication skills.',
        'Bachelor in Urdu Literature',
        ['Urdu', 'Arabic'],
        ['ALIM', 'Arabic Proficiency Test'],
        'Cricket, poetry, astronomy',
        '8 years of teaching Urdu to international learners',
        'https://youtube.com/muhammad_teacher_video',
        60));
  }
}
