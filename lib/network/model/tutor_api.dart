import 'package:my_app/network/model/course_api.dart';
import 'package:my_app/network/model/feed_back.dart';

class TutorApi {
  String? name;
  String? avatar;
  String? country;
  String? video;
  String? bio;
  String? education;
  String? experience;
  String? profession;
  String? accent;
  String? targetStudent;
  String? interests;
  String? languages;
  String? specialties;
  double? rating;
  bool? isNative;
  String? youtubeVideoId;
  String? userId;
  bool? isFavorite;
  double? avgRating;
  int? totalFeedback;
  List<FeedBack>? feedback;
  List<CourseApi>? courses;

  TutorApi(
      {this.name,
      this.avatar,
      this.country,
      this.video,
      this.bio,
      this.education,
      this.experience,
      this.profession,
      this.accent,
      this.targetStudent,
      this.interests,
      this.languages,
      this.specialties,
      this.rating,
      this.isNative,
      this.youtubeVideoId,
      this.userId,
      this.isFavorite,
      this.avgRating,
      this.totalFeedback,
      this.feedback,
      this.courses});

  TutorApi.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    rating = json['rating'];
    isNative = json['isNative'];
    youtubeVideoId = json['youtubeVideoId'];
    userId = json['userId'];
    isFavorite = json['isFavoriteTutor'];
    avgRating = json['avgRating'];
    totalFeedback = json['totalFeedback'];
    if (json['feedbacks'] != null) {
      feedback = <FeedBack>[];
      json['feedbacks'].forEach((v) {
        feedback!.add(FeedBack.fromJson(v));
      });
    }
  }

  TutorApi.fromJson2(Map<String, dynamic> json) {
    name = json['User']['name'];
    avatar = json['User']['avatar'];
    country = json['User']['country'];
    video = json['video'];
    bio = json['bio'];
    education = json['education'];
    experience = json['experience'];
    profession = json['profession'];
    accent = json['accent'];
    targetStudent = json['targetStudent'];
    interests = json['interests'];
    languages = json['languages'];
    specialties = json['specialties'];
    rating = json['rating'];
    isNative = json['isNative'];
    youtubeVideoId = json['youtubeVideoId'];
    userId = json['User']['id'];
    if (json['User']['courses'] != null) {
      courses = <CourseApi>[];
      json['User']['courses'].forEach((v) {
        courses!.add(CourseApi.fromJson(v));
      });
    }
    isFavorite = json['isFavorite'];
    if (avgRating is int) {
      avgRating = json['avgRating'];
    } else {
      avgRating = json['avgRating'].toDouble();
    }
    totalFeedback = json['totalFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    data['country'] = country;
    data['video'] = video;
    data['bio'] = bio;
    data['education'] = education;
    data['experience'] = experience;
    data['profession'] = profession;
    data['accent'] = accent;
    data['targetStudent'] = targetStudent;
    data['interests'] = interests;
    data['languages'] = languages;
    data['specialties'] = specialties;
    data['rating'] = rating;
    data['isNative'] = isNative;
    data['youtubeVideoId'] = youtubeVideoId;
    data['User']['id'] = userId;
    data['isFavorite'] = isFavorite;
    data['avgRating'] = avgRating;
    data['totalFeedback'] = totalFeedback;
    return data;
  }
}
