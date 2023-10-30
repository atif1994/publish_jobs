// import 'all_jobs_model.dart';
//
// class JobsDeailsModel {
//   int? id;
//   String? uuid;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   List<BusinessOwner>? businessOwner;
//   List<Address>? address;
//   Null? websites;
//   List<IndustryOptions>? industryOptions;
//   BusinessStatus? businessStatus;
//   BusinessDetails? businessDetails;
//   BusinessImage? businessImage;
//   List<dynamic>? numOfEmployes;
//   List<Jobs>? jobs;
//
//   JobsDeailsModel(
//       {this.id,
//         this.uuid,
//         this.name,
//         this.createdAt,
//         this.updatedAt,
//         this.businessOwner,
//         this.address,
//         this.websites,
//         this.industryOptions,
//         this.businessStatus,
//         this.businessDetails,
//         this.businessImage,
//         this.numOfEmployes,
//         this.jobs});
//
//   JobsDeailsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     name = json['name'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['business_owner'] != null) {
//       businessOwner = <BusinessOwner>[];
//       json['business_owner'].forEach((v) {
//         businessOwner!.add(new BusinessOwner.fromJson(v));
//       });
//     }
//     if (json['address'] != null) {
//       address = <Address>[];
//       json['address'].forEach((v) {
//         address!.add(new Address.fromJson(v));
//       });
//     }
//     websites = json['websites'];
//     if (json['industry_options'] != null) {
//       industryOptions = <IndustryOptions>[];
//       json['industry_options'].forEach((v) {
//         industryOptions!.add(new IndustryOptions.fromJson(v));
//       });
//     }
//     businessStatus = json['business_status'] != null
//         ? new BusinessStatus.fromJson(json['business_status'])
//         : null;
//     businessDetails = json['business_details'] != null
//         ? new BusinessDetails.fromJson(json['business_details'])
//         : null;
//     businessImage = json['business_image'] != null
//         ? new BusinessImage.fromJson(json['business_image'])
//         : null;
//     if (json['num_of_employes'] != null) {
//       numOfEmployes = <dynamic>[];
//       json['num_of_employes'].forEach((v) {
//         numOfEmployes!.add(new num.fromJson(v));
//       });
//     }
//     if (json['jobs'] != null) {
//       jobs = <Jobs>[];
//       json['jobs'].forEach((v) {
//         jobs!.add(new Jobs.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['name'] = this.name;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.businessOwner != null) {
//       data['business_owner'] =
//           this.businessOwner!.map((v) => v.toJson()).toList();
//     }
//     if (this.address != null) {
//       data['address'] = this.address!.map((v) => v.toJson()).toList();
//     }
//     data['websites'] = this.websites;
//     if (this.industryOptions != null) {
//       data['industry_options'] =
//           this.industryOptions!.map((v) => v.toJson()).toList();
//     }
//     if (this.businessStatus != null) {
//       data['business_status'] = this.businessStatus!.toJson();
//     }
//     if (this.businessDetails != null) {
//       data['business_details'] = this.businessDetails!.toJson();
//     }
//     if (this.businessImage != null) {
//       data['business_image'] = this.businessImage!.toJson();
//     }
//     if (this.numOfEmployes != null) {
//       data['num_of_employes'] =
//           this.numOfEmployes!.map((v) => v.toJson()).toList();
//     }
//     if (this.jobs != null) {
//       data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class BusinessOwner {
//   String? email;
//   String? emailVerifiedAt;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   BusinessOwner(
//       {this.email,
//         this.emailVerifiedAt,
//         this.createdAt,
//         this.updatedAt,
//         this.pivot});
//
//   BusinessOwner.fromJson(Map<String, dynamic> json) {
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
// class Pivot {
//   int? employerBusinessId;
//   int? userId;
//   String? createdAt;
//   String? updatedAt;
//
//   Pivot({this.employerBusinessId, this.userId, this.createdAt, this.updatedAt});
//
//   Pivot.fromJson(Map<String, dynamic> json) {
//     employerBusinessId = json['employer_business_id'];
//     userId = json['user_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['employer_business_id'] = this!.employerBusinessId;
//     data['user_id'] = this.userId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Address {
//   int? id;
//   String? uuid;
//   String? address;
//   int? countryId;
//   int? cityId;
//   int? employerBusinessId;
//   int? businessAddressTypeId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   Addresstypes? addresstypes;
//   Country? country;
//   City? city;
//   Contact? contact;
//   Email? email;
//
//   Address(
//       {this.id,
//         this.uuid,
//         this.address,
//         this.countryId,
//         this.cityId,
//         this.employerBusinessId,
//         this.businessAddressTypeId,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.addresstypes,
//         this.country,
//         this.city,
//         this.contact,
//         this.email});
//
//   Address.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     address = json['address'];
//     countryId = json['country_id'];
//     cityId = json['city_id'];
//     employerBusinessId = json['employer_business_id'];
//     businessAddressTypeId = json['business_address_type_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     addresstypes = json['addresstypes'] != null
//         ? new Addresstypes.fromJson(json['addresstypes'])
//         : null;
//     country =
//     json['country'] != null ? new Country.fromJson(json['country']) : null;
//     city = json['city'] != null ? new City.fromJson(json['city']) : null;
//     contact =
//     json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
//     email = json['email'] != null ? new Email.fromJson(json['email']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['address'] = this.address;
//     data['country_id'] = this.countryId;
//     data['city_id'] = this.cityId;
//     data['employer_business_id'] = this.employerBusinessId;
//     data['business_address_type_id'] = this.businessAddressTypeId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.addresstypes != null) {
//       data['addresstypes'] = this.addresstypes!.toJson();
//     }
//     if (this.country != null) {
//       data['country'] = this.country!.toJson();
//     }
//     if (this.city != null) {
//       data['city'] = this.city!.toJson();
//     }
//     if (this.contact != null) {
//       data['contact'] = this.contact!.toJson();
//     }
//     if (this.email != null) {
//       data['email'] = this.email!.toJson();
//     }
//     return data;
//   }
// }
//
// class Addresstypes {
//   int? id;
//   String? uuid;
//   String? title;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Addresstypes(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Addresstypes.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Country {
//   int? id;
//   String? uuid;
//   String? title;
//   String? flag;
//   String? code;
//   String? shortname;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Country(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.flag,
//         this.code,
//         this.shortname,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Country.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     flag = json['flag'];
//     code = json['code'];
//     shortname = json['shortname'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['flag'] = this.flag;
//     data['code'] = this.code;
//     data['shortname'] = this.shortname;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class City {
//   int? id;
//   String? uuid;
//   String? title;
//   int? countryId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   City(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.countryId,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   City.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     countryId = json['country_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['country_id'] = this.countryId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Contact {
//   int? id;
//   String? uuid;
//   String? number;
//   int? businessAddressId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Contact(
//       {this.id,
//         this.uuid,
//         this.number,
//         this.businessAddressId,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Contact.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     number = json['number'];
//     businessAddressId = json['business_address_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['number'] = this.number;
//     data['business_address_id'] = this.businessAddressId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Email {
//   int? id;
//   String? uuid;
//   String? email;
//   String? status;
//   int? businessAddressId;
//   String? createdAt;
//   String? updatedAt;
//
//   Email(
//       {this.id,
//         this.uuid,
//         this.email,
//         this.status,
//         this.businessAddressId,
//         this.createdAt,
//         this.updatedAt});
//
//   Email.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     email = json['email'];
//     status = json['status'];
//     businessAddressId = json['business_address_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['email'] = this.email;
//     data['status'] = this.status;
//     data['business_address_id'] = this.businessAddressId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class IndustryOptions {
//   int? id;
//   String? uuid;
//   String? title;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   IndustryOptions(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.pivot});
//
//   IndustryOptions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
//
//
// class BusinessStatus {
//   int? id;
//   String? uuid;
//   String? status;
//   int? employerBusinessId;
//   String? createdAt;
//   String? updatedAt;
//
//   BusinessStatus(
//       {this.id,
//         this.uuid,
//         this.status,
//         this.employerBusinessId,
//         this.createdAt,
//         this.updatedAt});
//
//   BusinessStatus.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     status = json['status'];
//     employerBusinessId = json['employer_business_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['status'] = this.status;
//     data['employer_business_id'] = this.employerBusinessId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class BusinessDetails {
//   int? id;
//   String? uuid;
//   String? details;
//   int? employerBusinessId;
//   String? createdAt;
//   String? updatedAt;
//
//   BusinessDetails(
//       {this.id,
//         this.uuid,
//         this.details,
//         this.employerBusinessId,
//         this.createdAt,
//         this.updatedAt});
//
//   BusinessDetails.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     details = json['details'];
//     employerBusinessId = json['employer_business_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['details'] = this.details;
//     data['employer_business_id'] = this.employerBusinessId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class BusinessImage {
//   int? id;
//   String? uuid;
//   String? image;
//   int? employerBusinessId;
//   String? createdAt;
//   String? updatedAt;
//
//   BusinessImage(
//       {this.id,
//         this.uuid,
//         this.image,
//         this.employerBusinessId,
//         this.createdAt,
//         this.updatedAt});
//
//   BusinessImage.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     image = json['image'];
//     employerBusinessId = json['employer_business_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['image'] = this.image;
//     data['employer_business_id'] = this.employerBusinessId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class Jobs {
//   int? id;
//   String? uuid;
//   String? title;
//   int? employerBusinessId;
//   String? createdAt;
//   String? updatedAt;
//   List<JobStatus>? jobStatus;
//   List<CityOptions>? cityOptions;
//   List<CountryOptions>? countryOptions;
//   List<JobtypeOptions>? jobtypeOptions;
//   Salary? salary;
//
//   Jobs(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.employerBusinessId,
//         this.createdAt,
//         this.updatedAt,
//         this.jobStatus,
//         this.cityOptions,
//         this.countryOptions,
//         this.jobtypeOptions,
//         this.salary});
//
//   Jobs.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     employerBusinessId = json['employer_business_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     if (json['job_status'] != null) {
//       jobStatus = <JobStatus>[];
//       json['job_status'].forEach((v) {
//         jobStatus!.add(new JobStatus.fromJson(v));
//       });
//     }
//     if (json['city_options'] != null) {
//       cityOptions = <CityOptions>[];
//       json['city_options'].forEach((v) {
//         cityOptions!.add(new CityOptions.fromJson(v));
//       });
//     }
//     if (json['country_options'] != null) {
//       countryOptions = <CountryOptions>[];
//       json['country_options'].forEach((v) {
//         countryOptions!.add(new CountryOptions.fromJson(v));
//       });
//     }
//     if (json['jobtype_options'] != null) {
//       jobtypeOptions = <JobtypeOptions>[];
//       json['jobtype_options'].forEach((v) {
//         jobtypeOptions!.add(new JobtypeOptions.fromJson(v));
//       });
//     }
//     salary =
//     json['salary'] != null ? new Salary.fromJson(json['salary']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['employer_business_id'] = this.employerBusinessId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.jobStatus != null) {
//       data['job_status'] = this.jobStatus!.map((v) => v.toJson()).toList();
//     }
//     if (this.cityOptions != null) {
//       data['city_options'] = this.cityOptions!.map((v) => v.toJson()).toList();
//     }
//     if (this.countryOptions != null) {
//       data['country_options'] =
//           this.countryOptions!.map((v) => v.toJson()).toList();
//     }
//     if (this.jobtypeOptions != null) {
//       data['jobtype_options'] =
//           this.jobtypeOptions!.map((v) => v.toJson()).toList();
//     }
//     if (this.salary != null) {
//       data['salary'] = this.salary!.toJson();
//     }
//     return data;
//   }
// }
//
// class JobStatus {
//   int? id;
//   String? uuid;
//   String? status;
//   String? current;
//   int? jobId;
//   String? createdAt;
//   String? updatedAt;
//
//   JobStatus(
//       {this.id,
//         this.uuid,
//         this.status,
//         this.current,
//         this.jobId,
//         this.createdAt,
//         this.updatedAt});
//
//   JobStatus.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     status = json['status'];
//     current = json['current'];
//     jobId = json['job_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['status'] = this.status;
//     data['current'] = this.current;
//     data['job_id'] = this.jobId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
//
// class CityOptions {
//   int? id;
//   String? uuid;
//   String? title;
//   int? countryId;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   CityOptions(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.countryId,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.pivot});
//
//   CityOptions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     countryId = json['country_id'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['country_id'] = this.countryId;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
//
//
// class CountryOptions {
//   int? id;
//   String? uuid;
//   String? title;
//   String? flag;
//   String? code;
//   String? shortname;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   CountryOptions(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.flag,
//         this.code,
//         this.shortname,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//         this.pivot});
//
//   CountryOptions.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     flag = json['flag'];
//     code = json['code'];
//     shortname = json['shortname'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['flag'] = this.flag;
//     data['code'] = this.code;
//     data['shortname'] = this.shortname;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.pivot != null) {
//       data['pivot'] = this.pivot!.toJson();
//     }
//     return data;
//   }
// }
//
//
//
// class Salary {
//   int? id;
//   String? uuid;
//   int? countryCurrencyId;
//   String? minimum;
//   String? maximum;
//   String? showSalary;
//   int? jobId;
//   int? salarytypeId;
//   String? createdAt;
//   String? updatedAt;
//   Currency? currency;
//   Addresstypes? salaryType;
//
//   Salary(
//       {this.id,
//         this.uuid,
//         this.countryCurrencyId,
//         this.minimum,
//         this.maximum,
//         this.showSalary,
//         this.jobId,
//         this.salarytypeId,
//         this.createdAt,
//         this.updatedAt,
//         this.currency,
//         this.salaryType});
//
//   Salary.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     countryCurrencyId = json['country_currency_id'];
//     minimum = json['minimum'];
//     maximum = json['maximum'];
//     showSalary = json['show_salary'];
//     jobId = json['job_id'];
//     salarytypeId = json['salarytype_id'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     currency = json['currency'] != null
//         ? new Currency.fromJson(json['currency'])
//         : null;
//     salaryType = json['salary_type'] != null
//         ? new Addresstypes.fromJson(json['salary_type'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['country_currency_id'] = this.countryCurrencyId;
//     data['minimum'] = this.minimum;
//     data['maximum'] = this.maximum;
//     data['show_salary'] = this.showSalary;
//     data['job_id'] = this.jobId;
//     data['salarytype_id'] = this.salarytypeId;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     if (this.currency != null) {
//       data['currency'] = this.currency!.toJson();
//     }
//     if (this.salaryType != null) {
//       data['salary_type'] = this.salaryType!.toJson();
//     }
//     return data;
//   }
// }
//
// class Currency {
//   int? id;
//   String? uuid;
//   String? currency;
//   String? currencyCode;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   Currency(
//       {this.id,
//         this.uuid,
//         this.currency,
//         this.currencyCode,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   Currency.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     currency = json['currency'];
//     currencyCode = json['currency_code'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['currency'] = this.currency;
//     data['currency_code'] = this.currencyCode;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }
