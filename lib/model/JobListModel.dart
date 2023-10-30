// To parse this JSON data, do
//
//     final jobListModel = jobListModelFromJson(jsonString);

import 'dart:convert';

JobListModel jobListModelFromJson(String str) => JobListModel.fromJson(json.decode(str));

String jobListModelToJson(JobListModel data) => json.encode(data.toJson());

class JobListModel {
  JobListModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory JobListModel.fromJson(Map<String, dynamic> json) => JobListModel(
    currentPage: json["current_page"],
    data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Data {
  Data({
    this.id,
    this.uuid,
    this.title,
    this.employerBusinessId,
    this.createdAt,
    this.updatedAt,
    this.business,
    this.jobDescription,
    this.jobStatus,
    this.cityOptions,
    this.countryOptions,
    this.jobtypeOptions,
    this.salary,
  });

  int? id;
  String? uuid;
  String? title;
  int? employerBusinessId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Business? business;
  Job? jobDescription;
  List<Job>? jobStatus;
  List<CityOption>? cityOptions;
  List<CountryOption>? countryOptions;
  List<JobtypeOption>? jobtypeOptions;
  Salary? salary;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    employerBusinessId: json["employer_business_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    business: Business.fromJson(json["business"]),
    jobDescription: Job.fromJson(json["job_description"]),
    jobStatus: List<Job>.from(json["job_status"].map((x) => Job.fromJson(x))),
    cityOptions: List<CityOption>.from(json["city_options"].map((x) => CityOption.fromJson(x))),
    countryOptions: List<CountryOption>.from(json["country_options"].map((x) => CountryOption.fromJson(x))),
    jobtypeOptions: List<JobtypeOption>.from(json["jobtype_options"].map((x) => JobtypeOption.fromJson(x))),
    salary: json["salary"] == null ? null : Salary.fromJson(json["salary"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "employer_business_id": employerBusinessId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "business": business!.toJson(),
    "job_description": jobDescription!.toJson(),
    "job_status": List<dynamic>.from(jobStatus!.map((x) => x.toJson())),
    "city_options": List<dynamic>.from(cityOptions!.map((x) => x.toJson())),
    "country_options": List<dynamic>.from(countryOptions!.map((x) => x.toJson())),
    "jobtype_options": List<dynamic>.from(jobtypeOptions!.map((x) => x.toJson())),
    "salary": salary == null ? null : salary!.toJson(),
  };
}

class Business {
  Business({
    this.id,
    this.uuid,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class CityOption {
  CityOption({
    this.id,
    this.uuid,
    this.title,
    this.countryId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int? id;
  String? uuid;
  String? title;
  int? countryId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  CityOptionPivot? pivot;

  factory CityOption.fromJson(Map<String, dynamic> json) => CityOption(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : CityOptionPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "country_id": countryId == null ? null : countryId,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

class CityOptionPivot {
  CityOptionPivot({
    this.jobId,
    this.cityId,
  });

  int? jobId;
  int? cityId;

  factory CityOptionPivot.fromJson(Map<String, dynamic> json) => CityOptionPivot(
    jobId: json["job_id"],
    cityId: json["city_id"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "city_id": cityId,
  };
}

class CountryOption {
  CountryOption({
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
  String? uuid;
  String? title;
  String? flag;
  String? code;
  String? shortname;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  CountryOptionPivot? pivot;

  factory CountryOption.fromJson(Map<String, dynamic> json) => CountryOption(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    flag: json["flag"],
    code: json["code"],
    shortname: json["shortname"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: CountryOptionPivot.fromJson(json["pivot"]),
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

class CountryOptionPivot {
  CountryOptionPivot({
    this.jobId,
    this.countryId,
  });

  int? jobId;
  int? countryId;

  factory CountryOptionPivot.fromJson(Map<String, dynamic> json) => CountryOptionPivot(
    jobId: json["job_id"],
    countryId: json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "country_id": countryId,
  };
}

class Job {
  Job({
    this.id,
    this.uuid,
    this.description,
    this.jobId,
    this.createdAt,
    this.updatedAt,
    this.status,
  });

  int? id;
  String? uuid;
  String? description;
  int? jobId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
    id: json["id"],
    uuid: json["uuid"],
    description: json["description"] == null ? null : json["description"],
    jobId: json["job_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "description": description == null ? null : description,
    "job_id": jobId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "status": status == null ? null : status,
  };
}

class JobtypeOption {
  JobtypeOption({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int? id;
  String? uuid;
  String? title;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  JobtypeOptionPivot? pivot;

  factory JobtypeOption.fromJson(Map<String, dynamic> json) => JobtypeOption(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    pivot: JobtypeOptionPivot.fromJson(json["pivot"]),
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

class JobtypeOptionPivot {
  JobtypeOptionPivot({
    this.jobId,
    this.jobtypeId,
  });

  int? jobId;
  int? jobtypeId;

  factory JobtypeOptionPivot.fromJson(Map<String, dynamic> json) => JobtypeOptionPivot(
    jobId: json["job_id"],
    jobtypeId: json["jobtype_id"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "jobtype_id": jobtypeId,
  };
}

class Salary {
  Salary({
    this.id,
    this.uuid,
    this.countryCurrencyId,
    this.minimum,
    this.maximum,
    this.jobId,
    this.salarytypeId,
    this.createdAt,
    this.updatedAt,
    this.country,
    this.salaryType,
  });

  int? id;
  String? uuid;
  int? countryCurrencyId;
  String? minimum;
  String? maximum;
  int? jobId;
  int? salarytypeId;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic country;
  CityOption? salaryType;

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
    id: json["id"],
    uuid: json["uuid"],
    countryCurrencyId: json["country_currency_id"],
    minimum: json["minimum"],
    maximum: json["maximum"],
    jobId: json["job_id"],
    salarytypeId: json["salarytype_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    country: json["country"],
    salaryType: CityOption.fromJson(json["salary_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "country_currency_id": countryCurrencyId,
    "minimum": minimum,
    "maximum": maximum,
    "job_id": jobId,
    "salarytype_id": salarytypeId,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "country": country,
    "salary_type": salaryType!.toJson(),
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
