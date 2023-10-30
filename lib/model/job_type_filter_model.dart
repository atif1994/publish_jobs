// To parse this JSON data, do
//
//     final jobTypeFilterModel = jobTypeFilterModelFromJson(jsonString);

import 'dart:convert';

List<JobTypeFilterModel> jobTypeFilterModelFromJson(String str) => List<JobTypeFilterModel>.from(json.decode(str).map((x) => JobTypeFilterModel.fromJson(x)));

String jobTypeFilterModelToJson(List<JobTypeFilterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobTypeFilterModel {
  JobTypeFilterModel({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int ?id;
  String ?uuid;
  String? title;
  String ?status;
  dynamic? createdAt;
  dynamic? updatedAt;

  factory JobTypeFilterModel.fromJson(Map<String, dynamic> json) => JobTypeFilterModel(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
