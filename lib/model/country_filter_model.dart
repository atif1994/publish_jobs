// To parse this JSON data, do
//
//     final countryFilterModel = countryFilterModelFromJson(jsonString);

import 'dart:convert';

List<CountryFilterModel> countryFilterModelFromJson(String str) => List<CountryFilterModel>.from(json.decode(str).map((x) => CountryFilterModel.fromJson(x)));

String countryFilterModelToJson(List<CountryFilterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryFilterModel {
  CountryFilterModel({
    this.id,
    this.uuid,
    this.title,
    this.flag,
    this.code,
    this.shortname,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String ?uuid;
  String? title;
  String? flag;
  String ?code;
  String ?shortname;
  String? status;
  DateTime ?createdAt;
  DateTime? updatedAt;

  factory CountryFilterModel.fromJson(Map<String, dynamic> json) => CountryFilterModel(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    flag: json["flag"],
    code: json["code"],
    shortname: json["shortname"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
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
  };
}
