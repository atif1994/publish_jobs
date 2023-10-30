// To parse this JSON data, do
//
//     final emailCheckModel = emailCheckModelFromJson(jsonString);

import 'dart:convert';

EmailCheckModel emailCheckModelFromJson(String str) => EmailCheckModel.fromJson(json.decode(str));

String emailCheckModelToJson(EmailCheckModel data) => json.encode(data.toJson());

class EmailCheckModel {
  EmailCheckModel({
    this.emailCheck,
  });

  bool? emailCheck;

  factory EmailCheckModel.fromJson(Map<String, dynamic> json) => EmailCheckModel(
    emailCheck: json["emailCheck"],
  );

  Map<String, dynamic> toJson() => {
    "emailCheck": emailCheck,
  };
}
