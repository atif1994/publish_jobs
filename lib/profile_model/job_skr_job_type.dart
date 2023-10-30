// To parse this JSON data, do
//
//     final jobSeekerJobType = jobSeekerJobTypeFromJson(jsonString);

import 'dart:convert';

List<JobSeekerJobTypeModel> jobSeekerJobTypeFromJson(String str) => List<JobSeekerJobTypeModel>.from(json.decode(str).map((x) => JobSeekerJobTypeModel.fromJson(x)));

String jobSeekerJobTypeToJson(List<JobSeekerJobTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerJobTypeModel {
  JobSeekerJobTypeModel({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int ?id;
  String? uuid;
  String ?title;
  String ?status;
  dynamic? createdAt;
  dynamic? updatedAt;
  Pivot? pivot;

  factory JobSeekerJobTypeModel.fromJson(Map<String, dynamic> json) => JobSeekerJobTypeModel(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "pivot": pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.userId,
    this.jobtypeId,
  });

  int? userId;
  int? jobtypeId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    jobtypeId: json["jobtype_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "jobtype_id": jobtypeId,
  };
}
