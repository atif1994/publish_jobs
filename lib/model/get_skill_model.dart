// To parse this JSON data, do
//
//     final getSkillModel = getSkillModelFromJson(jsonString);

import 'dart:convert';

List<GetSkillModel> getSkillModelFromJson(String str) => List<GetSkillModel>.from(json.decode(str).map((x) => GetSkillModel.fromJson(x)));

String getSkillModelToJson(List<GetSkillModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetSkillModel {
  GetSkillModel({
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

  factory GetSkillModel.fromJson(Map<String, dynamic> json) => GetSkillModel(
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
