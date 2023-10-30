// To parse this JSON data, do
//
//     final jobSeekerAddObjectiveModel = jobSeekerAddObjectiveModelFromJson(jsonString);

import 'dart:convert';

JobSeekerAddObjectiveModel jobSeekerAddObjectiveModelFromJson(String str) => JobSeekerAddObjectiveModel.fromJson(json.decode(str));

String jobSeekerAddObjectiveModelToJson(JobSeekerAddObjectiveModel data) => json.encode(data.toJson());

class JobSeekerAddObjectiveModel {
  JobSeekerAddObjectiveModel({
    this.id,
    this.uuid,
    this.userId,
    this.objective,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  int ?userId;
  String ?objective;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory JobSeekerAddObjectiveModel.fromJson(Map<String, dynamic> json) => JobSeekerAddObjectiveModel(
    id: json["id"],
    uuid: json["uuid"],
    userId: json["user_id"],
    objective: json["objective"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "user_id": userId,
    "objective": objective,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!
        .toIso8601String(),
  };
}
