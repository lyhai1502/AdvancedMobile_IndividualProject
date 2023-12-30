import 'package:flutter/material.dart';
import 'package:my_app/network/models/tutor_api.dart';

class UserApi extends ChangeNotifier {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  String? language;
  String? birthday;
  bool? isActivated;
  TutorApi? tutorApi;
  WalletInfo? walletInfo;
  String? requireNote;
  String? level;
  List<LearnTopics>? learnTopics;
  List<TestPreparations>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  ReferralInfo? referralInfo;
  String? studySchedule;
  bool? canSendMessage;
  // Null? studentGroup;
  // Null? studentInfo;
  int? avgRating;

  UserApi(
      {this.id,
      this.email,
      this.name,
      this.avatar,
      this.country,
      this.phone,
      this.roles,
      this.language,
      this.birthday,
      this.isActivated,
      this.tutorApi,
      this.walletInfo,
      this.requireNote,
      this.level,
      this.learnTopics,
      this.testPreparations,
      this.isPhoneActivated,
      this.timezone,
      this.referralInfo,
      this.studySchedule,
      this.canSendMessage,
      // this.studentGroup,
      // this.studentInfo,
      this.avgRating});

  UserApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    tutorApi =
        json['tutorInfo'] != null ? TutorApi.fromJson(json['tutorInfo']) : null;
    walletInfo = json['walletInfo'] != null
        ? WalletInfo.fromJson(json['walletInfo'])
        : null;
    requireNote = json['requireNote'];
    level = json['level'];
    if (json['learnTopics'] != null) {
      learnTopics = <LearnTopics>[];
      json['learnTopics'].forEach((v) {
        learnTopics!.add(LearnTopics.fromJson(v));
      });
    }
    if (json['testPreparations'] != null) {
      testPreparations = <TestPreparations>[];
      json['testPreparations'].forEach((v) {
        testPreparations!.add(TestPreparations.fromJson(v));
      });
    }
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    referralInfo = json['referralInfo'] != null
        ? ReferralInfo.fromJson(json['referralInfo'])
        : null;
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
    // studentGroup = json['studentGroup'];
    // studentInfo = json['studentInfo'];
    // if (avgRating is int) {
    //   avgRating = json['avgRating'];
    // } else {
    //   avgRating = json['avgRating'].toDouble();
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['name'] = name;
    data['avatar'] = avatar;
    data['country'] = country;
    data['phone'] = phone;
    data['roles'] = roles;
    data['language'] = language;
    data['birthday'] = birthday;
    data['isActivated'] = isActivated;
    if (tutorApi != null) {
      data['tutorInfo'] = tutorApi!.toJson();
    }
    if (walletInfo != null) {
      data['walletInfo'] = walletInfo!.toJson();
    }
    data['requireNote'] = requireNote;
    data['level'] = level;
    if (learnTopics != null) {
      data['learnTopics'] = learnTopics!.map((v) => v.toJson()).toList();
    }
    if (this.testPreparations != null) {
      data['testPreparations'] =
          this.testPreparations!.map((v) => v.toJson()).toList();
    }
    data['isPhoneActivated'] = isPhoneActivated;
    data['timezone'] = timezone;
    if (referralInfo != null) {
      data['referralInfo'] = referralInfo!.toJson();
    }
    data['studySchedule'] = studySchedule;
    data['canSendMessage'] = canSendMessage;
    // data['studentGroup'] = this.studentGroup;
    // data['studentInfo'] = this.studentInfo;
    data['avgRating'] = avgRating;
    return data;
  }
}

class WalletInfo {
  String? amount;
  bool? isBlocked;
  int? bonus;

  WalletInfo({this.amount, this.isBlocked, this.bonus});

  WalletInfo.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    isBlocked = json['isBlocked'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount'] = amount;
    data['isBlocked'] = isBlocked;
    data['bonus'] = bonus;
    return data;
  }
}

class LearnTopics {
  int? id;
  String? key;
  String? name;

  LearnTopics({this.id, this.key, this.name});

  LearnTopics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    return data;
  }
}

class TestPreparations {
  int? id;
  String? key;
  String? name;

  TestPreparations({this.id, this.key, this.name});

  TestPreparations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['key'] = key;
    data['name'] = name;
    return data;
  }
}

class ReferralInfo {
  String? referralCode;
  ReferralPackInfo? referralPackInfo;

  ReferralInfo({this.referralCode, this.referralPackInfo});

  ReferralInfo.fromJson(Map<String, dynamic> json) {
    referralCode = json['referralCode'];
    referralPackInfo = json['referralPackInfo'] != null
        ? ReferralPackInfo.fromJson(json['referralPackInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referralCode'] = referralCode;
    if (referralPackInfo != null) {
      data['referralPackInfo'] = referralPackInfo!.toJson();
    }
    return data;
  }
}

class ReferralPackInfo {
  int? earnPercent;

  ReferralPackInfo({this.earnPercent});

  ReferralPackInfo.fromJson(Map<String, dynamic> json) {
    earnPercent = json['earnPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['earnPercent'] = earnPercent;
    return data;
  }
}
