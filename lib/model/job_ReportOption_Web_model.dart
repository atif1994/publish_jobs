// To parse this JSON data, do
//
//     final jobReportOptionWeb = jobReportOptionWebFromJson(jsonString);

import 'dart:convert';

List<JobReportOptionWebModel> jobReportOptionWebFromJson(String str) => List<JobReportOptionWebModel>.from(json.decode(str).map((x) => JobReportOptionWebModel.fromJson(x)));

String jobReportOptionWebToJson(List<JobReportOptionWebModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobReportOptionWebModel {
  JobReportOptionWebModel({
    this.id,
    this.uuid,
    this.statement,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  String? statement;
  String ?status;
  DateTime? createdAt;
  DateTime ?updatedAt;

  factory JobReportOptionWebModel.fromJson(Map<String, dynamic> json) => JobReportOptionWebModel(
    id: json["id"],
    uuid: json["uuid"],
    statement: json["statement"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "statement": statement,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
