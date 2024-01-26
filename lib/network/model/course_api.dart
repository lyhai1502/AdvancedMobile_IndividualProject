class CourseApi {
  String? id;
  String? name;
  String? description;
  String? imageUrl;
  String? level;
  String? reason;
  String? purpose;
  String? otherDetails;
  int? defaultPrice;
  int? coursePrice;
  Null courseType;
  Null sectionType;
  bool? visible;
  Null displayOrder;
  String? createdAt;
  String? updatedAt;
  List<Topics>? topics;
  List<Categories>? categories;

  CourseApi(
      {this.id,
      this.name,
      this.description,
      this.imageUrl,
      this.level,
      this.reason,
      this.purpose,
      this.otherDetails,
      this.defaultPrice,
      this.coursePrice,
      this.courseType,
      this.sectionType,
      this.visible,
      this.displayOrder,
      this.createdAt,
      this.updatedAt,
      this.topics,
      this.categories});

  CourseApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    imageUrl = json['imageUrl'];
    level = json['level'];
    reason = json['reason'];
    purpose = json['purpose'];
    otherDetails = json['other_details'];
    defaultPrice = json['default_price'];
    coursePrice = json['course_price'];
    courseType = json['courseType'];
    sectionType = json['sectionType'];
    visible = json['visible'];
    displayOrder = json['displayOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(new Topics.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageUrl'] = imageUrl;
    data['level'] = level;
    data['reason'] = reason;
    data['purpose'] = purpose;
    data['other_details'] = otherDetails;
    data['default_price'] = defaultPrice;
    data['course_price'] = coursePrice;
    data['courseType'] = courseType;
    data['sectionType'] = sectionType;
    data['visible'] = visible;
    data['displayOrder'] = displayOrder;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (topics != null) {
      data['topics'] = topics!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Topics {
  String? id;
  String? courseId;
  int? orderCourse;
  String? name;
  Null beforeTheClassNotes;
  Null afterTheClassNotes;
  String? nameFile;
  Null numberOfPages;
  String? description;
  Null videoUrl;
  Null type;
  String? createdAt;
  String? updatedAt;

  Topics(
      {this.id,
      this.courseId,
      this.orderCourse,
      this.name,
      this.beforeTheClassNotes,
      this.afterTheClassNotes,
      this.nameFile,
      this.numberOfPages,
      this.description,
      this.videoUrl,
      this.type,
      this.createdAt,
      this.updatedAt});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseId = json['courseId'];
    orderCourse = json['orderCourse'];
    name = json['name'];
    beforeTheClassNotes = json['beforeTheClassNotes'];
    afterTheClassNotes = json['afterTheClassNotes'];
    nameFile = json['nameFile'];
    numberOfPages = json['numberOfPages'];
    description = json['description'];
    videoUrl = json['videoUrl'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['courseId'] = courseId;
    data['orderCourse'] = orderCourse;
    data['name'] = name;
    data['beforeTheClassNotes'] = beforeTheClassNotes;
    data['afterTheClassNotes'] = afterTheClassNotes;
    data['nameFile'] = nameFile;
    data['numberOfPages'] = numberOfPages;
    data['description'] = description;
    data['videoUrl'] = videoUrl;
    data['type'] = type;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Categories {
  String? id;
  String? title;
  Null description;
  String? key;
  Null displayOrder;
  String? createdAt;
  String? updatedAt;

  Categories(
      {this.id,
      this.title,
      this.description,
      this.key,
      this.displayOrder,
      this.createdAt,
      this.updatedAt});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    key = json['key'];
    displayOrder = json['displayOrder'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['key'] = key;
    data['displayOrder'] = displayOrder;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
