// To parse this JSON data, do
//
//     final jobSeekerExecutiveModel = jobSeekerExecutiveModelFromJson(jsonString);

import 'dart:convert';

List<JobSeekerExecutiveModel> jobSeekerExecutiveModelFromJson(String str) => List<JobSeekerExecutiveModel>.from(json.decode(str).map((x) => JobSeekerExecutiveModel.fromJson(x)));

String jobSeekerExecutiveModelToJson(List<JobSeekerExecutiveModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerExecutiveModel {
  JobSeekerExecutiveModel({
    this.id,
    this.uuid,
    this.userId,
    this.executive,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  int? userId;
  String? executive;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory JobSeekerExecutiveModel.fromJson(Map<String, dynamic> json) => JobSeekerExecutiveModel(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    executive: json["objective"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "executive": executive,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
