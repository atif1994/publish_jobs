// To parse this JSON data, do
//
//     final jobsDetailsModel = jobsDetailsModelFromJson(jsonString);

import 'dart:convert';

List<JobsDetailsModel> jobsDetailsModelFromJson(String str) => List<JobsDetailsModel>.from(json.decode(str).map((x) => JobsDetailsModel.fromJson(x)));

String jobsDetailsModelToJson(List<JobsDetailsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JobsDetailsModel {
  JobsDetailsModel({
    this.id,
    this.uuid,
    this.title,
    this.employerBusinessId,
    this.createdAt,
    this.updatedAt,
    this.business,
    this.jobDescription,
    this.jobExpiry,
    this.jobtypeOptions,
    this.salary,
    this.genderOptions,
    this.allowanceOptions,
    this.workplaceOptions,
    this.benefitOptions,
    this.degreeOptions,
    this.maxDegreeOptions,
    this.careerlevelOptions,
    this.skillOptionsJob,
    this.urgentHiring,
  });

  int? id;
  String? uuid;
  String? title;
  int? employerBusinessId;
  DateTime ?createdAt;
  DateTime? updatedAt;
  Business? business;
  JobDescription? jobDescription;
  List<dynamic>? jobExpiry;
  List<AllowanceOption>? jobtypeOptions;
  Salary ?salary;
  List<AllowanceOption>? genderOptions;
  List<AllowanceOption>? allowanceOptions;
  List<AllowanceOption>? workplaceOptions;
  List<BenefitOption>? benefitOptions;
  List<AllowanceOption> ?degreeOptions;
  List<AllowanceOption> ?maxDegreeOptions;
  List<AllowanceOption>? careerlevelOptions;
  List<BenefitOption>? skillOptionsJob;
  dynamic? urgentHiring;

  factory JobsDetailsModel.fromJson(Map<String, dynamic> json) => JobsDetailsModel(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    employerBusinessId: json["employer_business_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    business: Business.fromJson(json["business"]),
    jobDescription: JobDescription.fromJson(json["job_description"]),
    jobExpiry: List<dynamic>.from(json["job_expiry"].map((x) => x)),
    jobtypeOptions: List<AllowanceOption>.from(json["jobtype_options"].map((x) => AllowanceOption.fromJson(x))),
    salary: Salary.fromJson(json["salary"]),
    genderOptions: List<AllowanceOption>.from(json["gender_options"].map((x) => AllowanceOption.fromJson(x))),
    allowanceOptions: List<AllowanceOption>.from(json["allowance_options"].map((x) => AllowanceOption.fromJson(x))),
    workplaceOptions: List<AllowanceOption>.from(json["workplace_options"].map((x) => AllowanceOption.fromJson(x))),
    benefitOptions: List<BenefitOption>.from(json["benefit_options"].map((x) => BenefitOption.fromJson(x))),
    degreeOptions: List<AllowanceOption>.from(json["degree_options"].map((x) => AllowanceOption.fromJson(x))),
    maxDegreeOptions: List<AllowanceOption>.from(json["max_degree_options"].map((x) => AllowanceOption.fromJson(x))),
    careerlevelOptions: List<AllowanceOption>.from(json["careerlevel_options"].map((x) => AllowanceOption.fromJson(x))),
    skillOptionsJob: List<BenefitOption>.from(json["skill_options_job"].map((x) => BenefitOption.fromJson(x))),
    urgentHiring: json["urgent_hiring"],
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
    "job_expiry": List<dynamic>.from(jobExpiry!.map((x) => x)),
    "jobtype_options": List<dynamic>.from(jobtypeOptions!.map((x) => x.toJson())),
    "salary": salary!.toJson(),
    "gender_options": List<dynamic>.from(genderOptions!.map((x) => x.toJson())),
    "allowance_options": List<dynamic>.from(allowanceOptions!.map((x) => x.toJson())),
    "workplace_options": List<dynamic>.from(workplaceOptions!.map((x) => x.toJson())),
    "benefit_options": List<dynamic>.from(benefitOptions!.map((x) => x.toJson())),
    "degree_options": List<dynamic>.from(degreeOptions!.map((x) => x.toJson())),
    "max_degree_options": List<dynamic>.from(maxDegreeOptions!.map((x) => x.toJson())),
    "careerlevel_options": List<dynamic>.from(careerlevelOptions!.map((x) => x.toJson())),
    "skill_options_job": List<dynamic>.from(skillOptionsJob!.map((x) => x.toJson())),
    "urgent_hiring": urgentHiring,
  };
}

class AllowanceOption {
  AllowanceOption({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
    this.countryId,
  });

  int? id;
  String? uuid;
  String ?title;
  Status? status;
  DateTime? createdAt;
  DateTime ?updatedAt;
  AllowanceOptionPivot? pivot;
  int? countryId;

  factory AllowanceOption.fromJson(Map<String, dynamic> json) => AllowanceOption(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    status: statusValues.map![json["status"]],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : AllowanceOptionPivot.fromJson(json["pivot"]),
    countryId: json["country_id"] == null ? null : json["country_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "status": statusValues.reverse![status],
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "pivot": pivot == null ? null : pivot!.toJson(),
    "country_id": countryId == null ? null : countryId,
  };
}

class AllowanceOptionPivot {
  AllowanceOptionPivot({
    this.jobId,
    this.allowanceId,
    this.careerlevelId,
    this.degreeId,
    this.genderId,
    this.jobtypeId,
    this.workplaceId,
  });

  int ?jobId;
  int? allowanceId;
  int ?careerlevelId;
  int? degreeId;
  int? genderId;
  int ?jobtypeId;
  int? workplaceId;

  factory AllowanceOptionPivot.fromJson(Map<String, dynamic> json) => AllowanceOptionPivot(
    jobId: json["job_id"],
    allowanceId: json["allowance_id"] == null ? null : json["allowance_id"],
    careerlevelId: json["careerlevel_id"] == null ? null : json["careerlevel_id"],
    degreeId: json["degree_id"] == null ? null : json["degree_id"],
    genderId: json["gender_id"] == null ? null : json["gender_id"],
    jobtypeId: json["jobtype_id"] == null ? null : json["jobtype_id"],
    workplaceId: json["workplace_id"] == null ? null : json["workplace_id"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "allowance_id": allowanceId == null ? null : allowanceId,
    "careerlevel_id": careerlevelId == null ? null : careerlevelId,
    "degree_id": degreeId == null ? null : degreeId,
    "gender_id": genderId == null ? null : genderId,
    "jobtype_id": jobtypeId == null ? null : jobtypeId,
    "workplace_id": workplaceId == null ? null : workplaceId,
  };
}

enum Status { ACTIVE }

final statusValues = EnumValues({
  "active": Status.ACTIVE
});

class BenefitOption {
  BenefitOption({
    this.id,
    this.uuid,
    this.title,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  int? id;
  String ?uuid;
  String ?title;
  Status? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  BenefitOptionPivot? pivot;

  factory BenefitOption.fromJson(Map<String, dynamic> json) => BenefitOption(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    status: statusValues.map![json["status"]],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : BenefitOptionPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "status": statusValues.reverse![status],
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "pivot": pivot == null ? null : pivot!.toJson(),
  };
}

class BenefitOptionPivot {
  BenefitOptionPivot({
    this.jobId,
    this.benefitId,
    this.skillId,
  });

  int? jobId;
  int? benefitId;
  int? skillId;

  factory BenefitOptionPivot.fromJson(Map<String, dynamic> json) => BenefitOptionPivot(
    jobId: json["job_id"],
    benefitId: json["benefit_id"] == null ? null : json["benefit_id"],
    skillId: json["skill_id"] == null ? null : json["skill_id"],
  );

  Map<String, dynamic> toJson() => {
    "job_id": jobId,
    "benefit_id": benefitId == null ? null : benefitId,
    "skill_id": skillId == null ? null : skillId,
  };
}

class Business {
  Business({
    this.id,
    this.uuid,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  int? id;
  String? uuid;
  String? name;
  DateTime? createdAt;
  DateTime ?updatedAt;
  List<Address>? address;

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    id: json["id"],
    uuid: json["uuid"],
    name: json["name"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    address: List<Address>.from(json["address"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "name": name,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "address": List<dynamic>.from(address!.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.id,
    this.uuid,
    this.address,
    this.countryId,
    this.cityId,
    this.employerBusinessId,
    this.businessAddressTypeId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.country,
    this.city,
    this.addresstypes,
    this.contact,
    this.email,
  });

  int? id;
  String ?uuid;
  String? address;
  int? countryId;
  int? cityId;
  int? employerBusinessId;
  int? businessAddressTypeId;
  Status? status;
  DateTime?createdAt;
  DateTime? updatedAt;
  Country ?country;
  AllowanceOption? city;
  AllowanceOption? addresstypes;
  Contact? contact;
  Contact? email;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    uuid: json["uuid"],
    address: json["address"],
    countryId: json["country_id"],
    cityId: json["city_id"],
    employerBusinessId: json["employer_business_id"],
    businessAddressTypeId: json["business_address_type_id"],
    status: statusValues.map![json["status"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    country: Country.fromJson(json["country"]),
    city: AllowanceOption.fromJson(json["city"]),
    addresstypes: AllowanceOption.fromJson(json["addresstypes"]),
    contact: Contact.fromJson(json["contact"]),
    email: json["email"] == null ? null : Contact.fromJson(json["email"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "address": address,
    "country_id": countryId,
    "city_id": cityId,
    "employer_business_id": employerBusinessId,
    "business_address_type_id": businessAddressTypeId,
    "status": statusValues.reverse![status],
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "country": country!.toJson(),
    "city": city!.toJson(),
    "addresstypes": addresstypes!.toJson(),
    "contact": contact!.toJson(),
    "email": email == null ? null : email!.toJson(),
  };
}

class Contact {
  Contact({
    this.id,
    this.uuid,
    this.number,
    this.businessAddressId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.email,
  });

  int? id;
  String ?uuid;
  String ?number;
  int? businessAddressId;
  Status ?status;
  DateTime ?createdAt;
  DateTime? updatedAt;
  String ?email;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    id: json["id"],
    uuid: json["uuid"],
    number: json["number"] == null ? null : json["number"],
    businessAddressId: json["business_address_id"],
    status: statusValues.map![json["status"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    email: json["email"] == null ? null : json["email"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "number": number == null ? null : number,
    "business_address_id": businessAddressId,
    "status": statusValues.reverse![status],
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "email": email == null ? null : email,
  };
}

class Country {
  Country({
    this.id,
    this.uuid,
    this.title,
    this.flag,
    this.code,
    this.shortname,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  String? title;
  String ?flag;
  String? code;
  String? shortname;
  Status? status;
  DateTime ?createdAt;
  DateTime? updatedAt;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    uuid: json["uuid"],
    title: json["title"],
    flag: json["flag"],
    code: json["code"],
    shortname: json["shortname"],
    status: statusValues.map![json["status"]],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "title": title,
    "flag": flag,
    "code": code,
    "shortname": shortname,
    "status": statusValues.reverse![status],
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class JobDescription {
  JobDescription({
    this.id,
    this.uuid,
    this.description,
    this.jobId,
    this.createdAt,
    this.updatedAt,
  });

  int ?id;
  String? uuid;
  String? description;
  int? jobId;
  DateTime ?createdAt;
  DateTime ?updatedAt;

  factory JobDescription.fromJson(Map<String, dynamic> json) => JobDescription(
    id: json["id"],
    uuid: json["uuid"],
    description: json["description"],
    jobId: json["job_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "description": description,
    "job_id": jobId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

class Salary {
  Salary({
    this.id,
    this.uuid,
    this.countryCurrencyId,
    this.minimum,
    this.maximum,
    this.showSalary,
    this.jobId,
    this.salarytypeId,
    this.createdAt,
    this.updatedAt,
    this.currency,
    this.salaryType,
  });

  int? id;
  String? uuid;
  int? countryCurrencyId;
  String? minimum;
  String ?maximum;
  String? showSalary;
  int? jobId;
  int? salarytypeId;
  DateTime ?createdAt;
  DateTime? updatedAt;
  Currency? currency;
  BenefitOption? salaryType;

  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
    id: json["id"],
    uuid: json["uuid"],
    countryCurrencyId: json["country_currency_id"],
    minimum: json["minimum"],
    maximum: json["maximum"],
    showSalary: json["show_salary"],
    jobId: json["job_id"],
    salarytypeId: json["salarytype_id"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    currency: Currency.fromJson(json["currency"]),
    salaryType: BenefitOption.fromJson(json["salary_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "country_currency_id": countryCurrencyId,
    "minimum": minimum,
    "maximum": maximum,
    "show_salary": showSalary,
    "job_id": jobId,
    "salarytype_id": salarytypeId,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
    "currency": currency!.toJson(),
    "salary_type": salaryType!.toJson(),
  };
}

class Currency {
  Currency({
    this.id,
    this.uuid,
    this.currency,
    this.currencyCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? uuid;
  String? currency;
  String? currencyCode;
  Status? status;
  dynamic ?createdAt;
  dynamic? updatedAt;

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
    id: json["id"],
    uuid: json["uuid"],
    currency: json["currency"],
    currencyCode: json["currency_code"],
    status: statusValues.map![json["status"]],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "uuid": uuid,
    "currency": currency,
    "currency_code": currencyCode,
    "status": statusValues.reverse![status],
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
