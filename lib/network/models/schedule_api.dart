class ScheduleApi {
  int? createdAtTimeStamp;
  int? updatedAtTimeStamp;
  String? id;
  String? userId;
  String? scheduleDetailId;
  String? tutorMeetingLink;
  String? studentMeetingLink;
  // Null? googleMeetLink;
  String? studentRequest;
  // Null? tutorReview;
  // Null? scoreByTutor;
  String? createdAt;
  String? updatedAt;
  // Null? recordUrl;
  // Null? cancelReasonId;
  // Null? lessonPlanId;
  // Null? cancelNote;
  // Null? calendarId;
  bool? isDeleted;
  bool? isTrial;
  int? convertedLesson;
  ScheduleDetailInfo? scheduleDetailInfo;
  // Null? classReview;
  // Null? trialBookingReview;
  bool? showRecordUrl;
  // List<Null>? studentMaterials;
  // List<Null>? feedbacks;

  ScheduleApi({
    this.createdAtTimeStamp,
    this.updatedAtTimeStamp,
    this.id,
    this.userId,
    this.scheduleDetailId,
    this.tutorMeetingLink,
    this.studentMeetingLink,
    // this.googleMeetLink,
    this.studentRequest,
    // this.tutorReview,
    // this.scoreByTutor,
    this.createdAt,
    this.updatedAt,
    // this.recordUrl,
    // this.cancelReasonId,
    // this.lessonPlanId,
    // this.cancelNote,
    // this.calendarId,
    this.isDeleted,
    this.isTrial,
    this.convertedLesson,
    this.scheduleDetailInfo,
    // this.classReview,
    // this.trialBookingReview,
    this.showRecordUrl,
    // this.studentMaterials,
    // this.feedbacks
  });

  ScheduleApi.fromJson(Map<String, dynamic> json) {
    createdAtTimeStamp = json['createdAtTimeStamp'];
    updatedAtTimeStamp = json['updatedAtTimeStamp'];
    id = json['id'];
    userId = json['userId'];
    scheduleDetailId = json['scheduleDetailId'];
    tutorMeetingLink = json['tutorMeetingLink'];
    studentMeetingLink = json['studentMeetingLink'];
    // googleMeetLink = json['googleMeetLink'];
    studentRequest = json['studentRequest'];
    // tutorReview = json['tutorReview'];
    // scoreByTutor = json['scoreByTutor'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    // recordUrl = json['recordUrl'];
    // cancelReasonId = json['cancelReasonId'];
    // lessonPlanId = json['lessonPlanId'];
    // cancelNote = json['cancelNote'];
    // calendarId = json['calendarId'];
    isDeleted = json['isDeleted'];
    isTrial = json['isTrial'];
    convertedLesson = json['convertedLesson'];
    scheduleDetailInfo = json['scheduleDetailInfo'] != null
        ? new ScheduleDetailInfo.fromJson(json['scheduleDetailInfo'])
        : null;
    // classReview = json['classReview'];
    // trialBookingReview = json['trialBookingReview'];
    showRecordUrl = json['showRecordUrl'];
    // if (json['studentMaterials'] != null) {
    //   studentMaterials = <Null>[];
    //   json['studentMaterials'].forEach((v) {
    //     studentMaterials!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['feedbacks'] != null) {
    //   feedbacks = <Null>[];
    //   json['feedbacks'].forEach((v) {
    //     feedbacks!.add(new Null.fromJson(v));
    //   });
    // }
  }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['createdAtTimeStamp'] = this.createdAtTimeStamp;
//     data['updatedAtTimeStamp'] = this.updatedAtTimeStamp;
//     data['id'] = this.id;
//     data['userId'] = this.userId;
//     data['scheduleDetailId'] = this.scheduleDetailId;
//     data['tutorMeetingLink'] = this.tutorMeetingLink;
//     data['studentMeetingLink'] = this.studentMeetingLink;
//     data['googleMeetLink'] = this.googleMeetLink;
//     data['studentRequest'] = this.studentRequest;
//     data['tutorReview'] = this.tutorReview;
//     data['scoreByTutor'] = this.scoreByTutor;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['recordUrl'] = this.recordUrl;
//     data['cancelReasonId'] = this.cancelReasonId;
//     data['lessonPlanId'] = this.lessonPlanId;
//     data['cancelNote'] = this.cancelNote;
//     data['calendarId'] = this.calendarId;
//     data['isDeleted'] = this.isDeleted;
//     data['isTrial'] = this.isTrial;
//     data['convertedLesson'] = this.convertedLesson;
//     if (this.scheduleDetailInfo != null) {
//       data['scheduleDetailInfo'] = this.scheduleDetailInfo!.toJson();
//     }
//     data['classReview'] = this.classReview;
//     data['trialBookingReview'] = this.trialBookingReview;
//     data['showRecordUrl'] = this.showRecordUrl;
//     if (this.studentMaterials != null) {
//       data['studentMaterials'] =
//           this.studentMaterials!.map((v) => v.toJson()).toList();
//     }
//     if (this.feedbacks != null) {
//       data['feedbacks'] = this.feedbacks!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
}

class ScheduleDetailInfo {
  int? startPeriodTimestamp;
  int? endPeriodTimestamp;
  String? id;
  String? scheduleId;
  String? startPeriod;
  String? endPeriod;
  String? createdAt;
  String? updatedAt;
  ScheduleInfo? scheduleInfo;

  ScheduleDetailInfo(
      {this.startPeriodTimestamp,
      this.endPeriodTimestamp,
      this.id,
      this.scheduleId,
      this.startPeriod,
      this.endPeriod,
      this.createdAt,
      this.updatedAt,
      this.scheduleInfo});

  ScheduleDetailInfo.fromJson(Map<String, dynamic> json) {
    startPeriodTimestamp = json['startPeriodTimestamp'];
    endPeriodTimestamp = json['endPeriodTimestamp'];
    id = json['id'];
    scheduleId = json['scheduleId'];
    startPeriod = json['startPeriod'];
    endPeriod = json['endPeriod'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    scheduleInfo = json['scheduleInfo'] != null
        ? new ScheduleInfo.fromJson(json['scheduleInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['startPeriodTimestamp'] = this.startPeriodTimestamp;
    data['endPeriodTimestamp'] = this.endPeriodTimestamp;
    data['id'] = this.id;
    data['scheduleId'] = this.scheduleId;
    data['startPeriod'] = this.startPeriod;
    data['endPeriod'] = this.endPeriod;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.scheduleInfo != null) {
      data['scheduleInfo'] = this.scheduleInfo!.toJson();
    }
    return data;
  }
}

class ScheduleInfo {
  String? date;
  int? startTimestamp;
  int? endTimestamp;
  String? id;
  String? tutorId;
  String? startTime;
  String? endTime;
  bool? isDeleted;
  String? createdAt;
  String? updatedAt;
  TutorInfo? tutorInfo;

  ScheduleInfo(
      {this.date,
      this.startTimestamp,
      this.endTimestamp,
      this.id,
      this.tutorId,
      this.startTime,
      this.endTime,
      this.isDeleted,
      this.createdAt,
      this.updatedAt,
      this.tutorInfo});

  ScheduleInfo.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startTimestamp = json['startTimestamp'];
    endTimestamp = json['endTimestamp'];
    id = json['id'];
    tutorId = json['tutorId'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    tutorInfo = json['tutorInfo'] != null
        ? new TutorInfo.fromJson(json['tutorInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['startTimestamp'] = this.startTimestamp;
    data['endTimestamp'] = this.endTimestamp;
    data['id'] = this.id;
    data['tutorId'] = this.tutorId;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['isDeleted'] = this.isDeleted;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    if (this.tutorInfo != null) {
      data['tutorInfo'] = this.tutorInfo!.toJson();
    }
    return data;
  }
}

class TutorInfo {
  String? id;
  String? level;
  String? email;
  Null? google;
  Null? facebook;
  Null? apple;
  String? avatar;
  String? name;
  String? country;
  String? phone;
  String? language;
  String? birthday;
  bool? requestPassword;
  bool? isActivated;
  Null? isPhoneActivated;
  Null? requireNote;
  int? timezone;
  Null? phoneAuth;
  bool? isPhoneAuthActivated;
  String? studySchedule;
  bool? canSendMessage;
  bool? isPublicRecord;
  Null? caredByStaffId;
  Null? zaloUserId;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;
  Null? studentGroupId;

  TutorInfo(
      {this.id,
      this.level,
      this.email,
      this.google,
      this.facebook,
      this.apple,
      this.avatar,
      this.name,
      this.country,
      this.phone,
      this.language,
      this.birthday,
      this.requestPassword,
      this.isActivated,
      this.isPhoneActivated,
      this.requireNote,
      this.timezone,
      this.phoneAuth,
      this.isPhoneAuthActivated,
      this.studySchedule,
      this.canSendMessage,
      this.isPublicRecord,
      this.caredByStaffId,
      this.zaloUserId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.studentGroupId});

  TutorInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    level = json['level'];
    email = json['email'];
    google = json['google'];
    facebook = json['facebook'];
    apple = json['apple'];
    avatar = json['avatar'];
    name = json['name'];
    country = json['country'];
    phone = json['phone'];
    language = json['language'];
    birthday = json['birthday'];
    requestPassword = json['requestPassword'];
    isActivated = json['isActivated'];
    isPhoneActivated = json['isPhoneActivated'];
    requireNote = json['requireNote'];
    timezone = json['timezone'];
    phoneAuth = json['phoneAuth'];
    isPhoneAuthActivated = json['isPhoneAuthActivated'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    isPublicRecord = json['isPublicRecord'];
    caredByStaffId = json['caredByStaffId'];
    zaloUserId = json['zaloUserId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    studentGroupId = json['studentGroupId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['level'] = this.level;
    data['email'] = this.email;
    data['google'] = this.google;
    data['facebook'] = this.facebook;
    data['apple'] = this.apple;
    data['avatar'] = this.avatar;
    data['name'] = this.name;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['language'] = this.language;
    data['birthday'] = this.birthday;
    data['requestPassword'] = this.requestPassword;
    data['isActivated'] = this.isActivated;
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['requireNote'] = this.requireNote;
    data['timezone'] = this.timezone;
    data['phoneAuth'] = this.phoneAuth;
    data['isPhoneAuthActivated'] = this.isPhoneAuthActivated;
    data['studySchedule'] = this.studySchedule;
    data['canSendMessage'] = this.canSendMessage;
    data['isPublicRecord'] = this.isPublicRecord;
    data['caredByStaffId'] = this.caredByStaffId;
    data['zaloUserId'] = this.zaloUserId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['studentGroupId'] = this.studentGroupId;
    return data;
  }
}
