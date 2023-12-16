import 'dart:convert';
import 'package:http/http.dart' as http;

class UserTokenApi {
  UserApi? user;
  Tokens? tokens;

  UserTokenApi({this.user, this.tokens});

  UserTokenApi.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new UserApi.fromJson(json['user']) : null;
    tokens =
        json['tokens'] != null ? new Tokens.fromJson(json['tokens']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.tokens != null) {
      data['tokens'] = this.tokens!.toJson();
    }
    return data;
  }

  Future<UserTokenApi> login(String email, String password) async {
    final body = {
      "email": email,
      "password": password,
    };
    final url = "https://sandbox.api.lettutor.com/auth/login";
    final uri = Uri.parse(url);

    final response = await http.post(uri, body: body);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final userTokenApi = UserTokenApi.fromJson(json);
      return userTokenApi;
    }
    return UserTokenApi();
  }
}

class UserApi {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? country;
  String? phone;
  List<String>? roles;
  // Null? language;
  String? birthday;
  bool? isActivated;
  WalletInfo? walletInfo;
  // List<Null>? courses;
  String? requireNote;
  String? level;
  List<LearnTopics>? learnTopics;
  // List<Null>? testPreparations;
  bool? isPhoneActivated;
  int? timezone;
  String? studySchedule;
  bool? canSendMessage;

  UserApi(
      {this.id,
      this.email,
      this.name,
      this.avatar,
      this.country,
      this.phone,
      this.roles,
      // this.language,
      this.birthday,
      this.isActivated,
      this.walletInfo,
      // this.courses,
      this.requireNote,
      this.level,
      this.learnTopics,
      // this.testPreparations,
      this.isPhoneActivated,
      this.timezone,
      this.studySchedule,
      this.canSendMessage});

  UserApi.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    country = json['country'];
    phone = json['phone'];
    roles = json['roles'].cast<String>();
    // language = json['language'];
    birthday = json['birthday'];
    isActivated = json['isActivated'];
    walletInfo = json['walletInfo'] != null
        ? new WalletInfo.fromJson(json['walletInfo'])
        : null;
    // if (json['courses'] != null) {
    //   courses = <Null>[];
    //   json['courses'].forEach((v) {
    //     courses!.add(new Null.fromJson(v));
    //   });
    // }
    requireNote = json['requireNote'];
    level = json['level'];
    if (json['learnTopics'] != null) {
      learnTopics = <LearnTopics>[];
      json['learnTopics'].forEach((v) {
        learnTopics!.add(new LearnTopics.fromJson(v));
      });
    }
    // if (json['testPreparations'] != null) {
    //   testPreparations = <Null>[];
    //   json['testPreparations'].forEach((v) {
    //     testPreparations!.add(new Null.fromJson(v));
    //   });
    // }
    isPhoneActivated = json['isPhoneActivated'];
    timezone = json['timezone'];
    studySchedule = json['studySchedule'];
    canSendMessage = json['canSendMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['country'] = this.country;
    data['phone'] = this.phone;
    data['roles'] = this.roles;
    // data['language'] = this.language;

    data['birthday'] = this.birthday;
    data['isActivated'] = this.isActivated;
    if (this.walletInfo != null) {
      data['walletInfo'] = this.walletInfo!.toJson();
    }
    // if (this.courses != null) {
    //   data['courses'] = this.courses!.map((v) => v.toJson()).toList();
    // }
    data['requireNote'] = this.requireNote;
    data['level'] = this.level;
    if (this.learnTopics != null) {
      data['learnTopics'] = this.learnTopics!.map((v) => v.toJson()).toList();
    }
    // if (this.testPreparations != null) {
    //   data['testPreparations'] =
    //       this.testPreparations!.map((v) => v.toJson()).toList();
    // }
    data['isPhoneActivated'] = this.isPhoneActivated;
    data['timezone'] = this.timezone;
    data['studySchedule'] = this.studySchedule;
    data['canSendMessage'] = this.canSendMessage;
    return data;
  }
}

class WalletInfo {
  String? id;
  String? userId;
  String? amount;
  bool? isBlocked;
  String? createdAt;
  String? updatedAt;
  int? bonus;

  WalletInfo(
      {this.id,
      this.userId,
      this.amount,
      this.isBlocked,
      this.createdAt,
      this.updatedAt,
      this.bonus});

  WalletInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    amount = json['amount'];
    isBlocked = json['isBlocked'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    bonus = json['bonus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['amount'] = this.amount;
    data['isBlocked'] = this.isBlocked;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['bonus'] = this.bonus;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}

class Tokens {
  Access? access;
  Access? refresh;

  Tokens({this.access, this.refresh});

  Tokens.fromJson(Map<String, dynamic> json) {
    access =
        json['access'] != null ? new Access.fromJson(json['access']) : null;
    refresh =
        json['refresh'] != null ? new Access.fromJson(json['refresh']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.access != null) {
      data['access'] = this.access!.toJson();
    }
    if (this.refresh != null) {
      data['refresh'] = this.refresh!.toJson();
    }
    return data;
  }
}

class Access {
  String? token;
  String? expires;

  Access({this.token, this.expires});

  Access.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expires = json['expires'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['expires'] = this.expires;
    return data;
  }
}
