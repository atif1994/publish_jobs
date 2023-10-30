// To parse this JSON data, do
//
//     final userDataNdProfileModel = userDataNdProfileModelFromJson(jsonString);

import 'dart:convert';

UserDataNdProfileModel userDataNdProfileModelFromJson(String str) => UserDataNdProfileModel.fromJson(json.decode(str));

String userDataNdProfileModelToJson(UserDataNdProfileModel data) => json.encode(data.toJson());

class UserDataNdProfileModel {
  UserDataNdProfileModel({
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.userImage,
    this.userMobile,
    this.countryOption,
  });

  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  User? username;
  User? userImage;
  dynamic userMobile;
  List<dynamic>? countryOption;

  factory UserDataNdProfileModel.fromJson(Map<String, dynamic> json) => UserDataNdProfileModel(
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    username: User.fromJson(json["username"]),
    userImage: User.fromJson(json["user_image"]),
    userMobile: json["user_mobile"],
    countryOption: List<dynamic>.from(json["country_option"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "username": username!.toJson(),
    "user_image": userImage!.toJson(),
    "user_mobile": userMobile,
    "country_option": List<dynamic>.from(countryOption!.map((x) => x)),
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
    this.username,
  });

  int? id;
  String? uuid;
  int? userId;
  String? image;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? username;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    image: json["image"] == null ? null : json["image"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    username: json["username"] == null ? null : json["username"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "image": image == null ? null : image,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "username": username == null ? null : username,
  };
}
