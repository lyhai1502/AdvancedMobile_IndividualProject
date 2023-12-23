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
  Null? isNative;
  Null? youtubeVideoId;
  String? userId;
  bool? isFavorite;
  double? avgRating;
  int? totalFeedback;

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
      this.totalFeedback});

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
    isFavorite = json['isFavorite'];
    if (avgRating is int) {
      avgRating = json['avgRating'];
    } else {
      avgRating = json['avgRating'].toDouble();
    }
    totalFeedback = json['totalFeedback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['country'] = this.country;
    data['video'] = this.video;
    data['bio'] = this.bio;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['profession'] = this.profession;
    data['accent'] = this.accent;
    data['targetStudent'] = this.targetStudent;
    data['interests'] = this.interests;
    data['languages'] = this.languages;
    data['specialties'] = this.specialties;
    data['rating'] = this.rating;
    data['isNative'] = this.isNative;
    data['youtubeVideoId'] = this.youtubeVideoId;
    data['User']['id'] = this.userId;
    data['isFavorite'] = this.isFavorite;
    data['avgRating'] = this.avgRating;
    data['totalFeedback'] = this.totalFeedback;
    return data;
  }
}
