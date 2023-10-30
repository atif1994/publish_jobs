// To parse this JSON data, do
//
//     final jobSeekerWorkAuthorization = jobSeekerWorkAuthorizationFromJson(jsonString);

import 'dart:convert';

List<JobSeekerWorkAuthorization> jobSeekerWorkAuthorizationFromJson(String str) => List<JobSeekerWorkAuthorization>.from(json.decode(str).map((x) => JobSeekerWorkAuthorization.fromJson(x)));

String jobSeekerWorkAuthorizationToJson(List<JobSeekerWorkAuthorization> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobSeekerWorkAuthorization {
  JobSeekerWorkAuthorization({
    this.id,
    this.uuid,
    this.title,
    this.flag,
    this.code,
    this.shortname,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int? id;
  String ?uuid;
  String ?title;
  String? flag;
  String ?code;
  String ?shortname;
  String ?status;
  DateTime ?createdAt;
  DateTime? updatedAt;
  Pivot ?pivot;

  factory JobSeekerWorkAuthorization.fromJson(Map<String, dynamic> json) => JobSeekerWorkAuthorization(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    flag: json["flag"],
    code: json["code"],
    shortname: json["shortname"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "flag": flag,
    "code": code,
    "shortname": shortname,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "pivot": pivot!.toJson(),
  };
}

class Pivot {
  Pivot({
    this.userId,
    this.countryId,
  });

  int ?userId;
  int? countryId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "country_id": countryId,
  };
}
