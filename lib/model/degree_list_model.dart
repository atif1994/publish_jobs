// To parse this JSON data, do
//
//     final degreeListModel = degreeListModelFromJson(jsonString);

import 'dart:convert';

List<DegreeListModel> degreeListModelFromJson(String str) => List<DegreeListModel>.from(json.decode(str).map((x) => DegreeListModel.fromJson(x)));

String degreeListModelToJson(List<DegreeListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DegreeListModel {
  DegreeListModel({
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

  factory DegreeListModel.fromJson(Map<String, dynamic> json) => DegreeListModel(
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
