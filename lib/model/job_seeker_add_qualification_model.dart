// To parse this JSON data, do
//
//     final jobSeekerAddQualificationModel = jobSeekerAddQualificationModelFromJson(jsonString);

import 'dart:convert';

List<JobSeekerQualificationModel> jobSeekerQualificationModelFromJson(String str) => List<JobSeekerQualificationModel>.from(json.decode(str).map((x) => JobSeekerQualificationModel.fromJson(x)));

String jobSeekerQualificationModelToJson(List<JobSeekerQualificationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerQualificationModel {
  JobSeekerQualificationModel({
    this.id,
    this.uuid,
    this.degreeId,
    this.userId,
    this.institute,
    this.fieldStudy,
    this.description,
    this.startYear,
    this.endYear,
    this.inProgress,
    this.createdAt,
    this.updatedAt,
    this.degree,
  });

  int? id;
  String? uuid;
  int? degreeId;
  int? userId;
  String? institute;
  String? fieldStudy;
  String? description;
  DateTime? startYear;
  DateTime? endYear;
  String? inProgress;
  DateTime? createdAt;
  DateTime? updatedAt;
  Degree? degree;

  factory JobSeekerQualificationModel.fromJson(Map<String, dynamic> json) => JobSeekerQualificationModel(
    id: json["id"],
    uuid: json["uuid"],
    degreeId: json["degree_id"],
    userId: json["user_id"],
    institute: json["institute"],
    fieldStudy: json["field_study"],
    description: json["description"] == null ? null : json["description"],
    startYear: DateTime.parse(json["start_year"]),
    endYear: DateTime.parse(json["end_year"]),
    inProgress: json["in_progress"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    degree: Degree.fromJson(json["degree"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "degree_id": degreeId,
    "user_id": userId,
    "institute": institute,
    "field_study": fieldStudy,
    "description": description == null ? null : description,
    "start_year": "${startYear!.year.toString().padLeft(4, '0')}-${startYear!.month.toString().padLeft(2, '0')}-${startYear!.day.toString().padLeft(2, '0')}",
    "end_year": "${endYear!.year.toString().padLeft(4, '0')}-${endYear!.month.toString().padLeft(2, '0')}-${endYear!.day.toString().padLeft(2, '0')}",
    "in_progress": inProgress,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "degree": degree!.toJson(),
  };
}

class Degree {
  Degree({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  String? title;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Degree.fromJson(Map<String, dynamic> json) => Degree(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
