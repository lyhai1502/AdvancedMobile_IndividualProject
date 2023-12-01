class Course {
  String id = '';
  String name = '';
  String image = '';
  String description = '';
  String target = '';
  String todo = '';
  String level = '';
  // List<Topic> listTopics = [];
  List<String> topics = [];

  Course();

  static Course createCourse(
      String name,
      String image,
      String description,
      String target,
      String todo,
      String level,
      // List<Topic> listTopics,
      List<String> topics) {
    Course course = Course();
    course.id = DateTime.now().millisecondsSinceEpoch.toString();
    course.name = name;
    course.image = image;
    course.description = description;
    course.target = target;
    course.todo = todo;
    course.level = level;
    // course.listTopics = listTopics;
    course.topics = topics;

    return course;
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'name: $name';
  }
}
