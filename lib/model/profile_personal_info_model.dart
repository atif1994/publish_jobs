// To parse this JSON data, do
//
//     final profilePersonalInfoModel = profilePersonalInfoModelFromJson(jsonString);

import 'dart:convert';

ProfilePersonalInfoModel profilePersonalInfoModelFromJson(String str) => ProfilePersonalInfoModel.fromJson(json.decode(str));

String profilePersonalInfoModelToJson(ProfilePersonalInfoModel data) => json.encode(data.toJson());

class ProfilePersonalInfoModel {
  ProfilePersonalInfoModel({
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.userImage,
    this.jobseekerInfo,
    this.countryOption,
    this.cityOption,
    this.userMobile,
  });

  String? email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  dynamic updatedAt;
  User? userImage;
  JobseekerInfo? jobseekerInfo;
  List<CountryOption>? countryOption;
  List<CityOption>? cityOption;
  User? userMobile;

  factory ProfilePersonalInfoModel.fromJson(Map<String, dynamic> json) => ProfilePersonalInfoModel(
    email: json["email"],
    emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    userImage: User.fromJson(json["user_image"]),
    jobseekerInfo: JobseekerInfo.fromJson(json["jobseeker_info"]),
    countryOption: List<CountryOption>.from(json["country_option"].map((x) => CountryOption.fromJson(x))),
    cityOption: List<CityOption>.from(json["city_option"].map((x) => CityOption.fromJson(x))),
    userMobile: User.fromJson(json["user_mobile"]),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "email_verified_at": emailVerifiedAt!.toIso8601String(),
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt,
    "user_image": userImage!.toJson(),
    "jobseeker_info": jobseekerInfo!.toJson(),
    "country_option": List<dynamic>.from(countryOption!.map((x) => x.toJson())),
    "city_option": List<dynamic>.from(cityOption!.map((x) => x.toJson())),
    "user_mobile": userMobile!.toJson(),
  };
}

class CityOption {
  CityOption({
    this.id,
    this.uuid,
    this.title,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int? id;
  String? uuid;
  String? title;
  int? countryId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  CityOptionPivot? pivot;

  factory CityOption.fromJson(Map<String, dynamic> json) => CityOption(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    countryId: json["country_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: CityOptionPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "country_id": countryId,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "pivot": pivot!.toJson(),
  };
}

class CityOptionPivot {
  CityOptionPivot({
    this.userId,
    this.cityId,
  });

  int? userId;
  int? cityId;

  factory CityOptionPivot.fromJson(Map<String, dynamic> json) => CityOptionPivot(
    userId: json["user_id"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "city_id": cityId,
  };
}

class CountryOption {
  CountryOption({
    this.id,
    this.uuid,
    this.title,
    this.flag,
    this.code,
    this.shortname,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int? id;
  String? uuid;
  String? title;
  String? flag;
  String? code;
  String? shortname;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  CountryOptionPivot? pivot;

  factory CountryOption.fromJson(Map<String, dynamic> json) => CountryOption(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    flag: json["flag"],
    code: json["code"],
    shortname: json["shortname"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: CountryOptionPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "flag": flag,
    "code": code,
    "shortname": shortname,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "pivot": pivot!.toJson(),
  };
}

class CountryOptionPivot {
  CountryOptionPivot({
    this.userId,
    this.countryId,
  });

  int? userId;
  int? countryId;

  factory CountryOptionPivot.fromJson(Map<String, dynamic> json) => CountryOptionPivot(
    userId: json["user_id"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "country_id": countryId,
  };
}

class JobseekerInfo {
  JobseekerInfo({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? firstName;
  String? lastName;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory JobseekerInfo.fromJson(Map<String, dynamic> json) => JobseekerInfo(
    id: json["id"],
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class User {
  User({
    this.id,
    this.uuid,
    this.userId,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.mobile,
  });

  int? id;
  String? uuid;
  int? userId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? mobile;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    image: json["image"] == null ? null : json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    mobile: json["mobile"] == null ? null : json["mobile"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "image": image == null ? null : image,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "mobile": mobile == null ? null : mobile,
  };
}
