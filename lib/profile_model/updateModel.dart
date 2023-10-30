// To parse this JSON data, do
//
//     final jobseekerUpdateWorkExperienceModel = jobseekerUpdateWorkExperienceModelFromJson(jsonString);

import 'dart:convert';

List<JobseekerUpdateWorkExperienceModel> jobseekerUpdateWorkExperienceModelFromJson(String str) => List<JobseekerUpdateWorkExperienceModel>.from(json.decode(str).map((x) => JobseekerUpdateWorkExperienceModel.fromJson(x)));

String jobseekerUpdateWorkExperienceModelToJson(List<JobseekerUpdateWorkExperienceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobseekerUpdateWorkExperienceModel {
  JobseekerUpdateWorkExperienceModel({
    this.id,
    this.uuid,
    this.userId,
    this.title,
    this.company,
    this.description,
    this.startDate,
    this.endDate,
    this.currentlyWork,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  int? userId;
  String ?title;
  String ?company;
  String? description;
  DateTime? startDate;
  dynamic? endDate;
  String? currentlyWork;
  DateTime ?createdAt;
  DateTime ?updatedAt;

  factory JobseekerUpdateWorkExperienceModel.fromJson(Map<String, dynamic> json) => JobseekerUpdateWorkExperienceModel(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    title: json["title"],
    company: json["company"],
    description: json["description"],
    startDate: DateTime.parse(json["start_date"]),
    endDate: json["end_date"],
    currentlyWork: json["currently_work"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "title": title,
    "company": company,
    "description": description,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": endDate,
    "currently_work": currentlyWork,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
