// To parse this JSON data, do
//
//     final cityModel = cityModelFromJson(jsonString);

import 'dart:convert';

List<CityModel> cityModelFromJson(String str) => List<CityModel>.from(json.decode(str).map((x) => CityModel.fromJson(x)));

String cityModelToJson(List<CityModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CityModel {
  CityModel({
    this.id,
    this.uuid,
    this.title,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  String? title;
  int? countryId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    countryId: json["country_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "country_id": countryId,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
