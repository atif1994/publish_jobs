// To parse this JSON data, do
//
//     final jobSeekerPreferredJobPosition = jobSeekerPreferredJobPositionFromJson(jsonString);

import 'dart:convert';

List<JobSeekerPreferredJobPosition> jobSeekerPreferredJobPositionFromJson(String str) => List<JobSeekerPreferredJobPosition>.from(json.decode(str).map((x) => JobSeekerPreferredJobPosition.fromJson(x)));

String jobSeekerPreferredJobPositionToJson(List<JobSeekerPreferredJobPosition> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerPreferredJobPosition {
  JobSeekerPreferredJobPosition({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int ?id;
  String ?uuid;
  String ?title;
  String ?status;
  DateTime? createdAt;
  DateTime ?updatedAt;
  Pivot? pivot;

  factory JobSeekerPreferredJobPosition.fromJson(Map<String, dynamic> json) => JobSeekerPreferredJobPosition(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "pivot": pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.userId,
    this.jobpositionId,
  });

  int? userId;
  int? jobpositionId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    jobpositionId: json["jobposition_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "jobposition_id": jobpositionId,
  };
}
