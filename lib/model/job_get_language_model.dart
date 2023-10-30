// To parse this JSON data, do
//
//     final jobGetLanguage = jobGetLanguageFromJson(jsonString);

import 'dart:convert';

List<JobGetLanguageModel> jobGetLanguageFromJson(String str) => List<JobGetLanguageModel>.from(json.decode(str).map((x) => JobGetLanguageModel.fromJson(x)));

String jobGetLanguageToJson(List<JobGetLanguageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobGetLanguageModel {
  JobGetLanguageModel({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int ?id;
  String? uuid;
  String? title;
  String ?status;
  DateTime ?createdAt;
  DateTime ?updatedAt;

  factory JobGetLanguageModel.fromJson(Map<String, dynamic> json) => JobGetLanguageModel(
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
