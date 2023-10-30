
class AllJobsModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;
 dynamic? prevPageUrl;
  int? to;
  int? total;

  AllJobsModel(
      {this.currentPage,
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
        this.total});

  AllJobsModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url']??'';
    from = json['from'];
    lastPage = json['last_page']??'';
    lastPageUrl = json['last_page_url']??'';
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url']??'';
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url']??'';
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  int? id;
  String? uuid;
  String? title;
  int? employerBusinessId;
  String? createdAt;
  String? updatedAt;
  Business? business;
  JobDescription? jobDescription;
  List<JobStatus>? jobStatus;
  List<CityOptions>? cityOptions;
  List<CountryOptions>? countryOptions;
  List<JobtypeOptions>? jobtypeOptions;
  Salary? salary;

  Data(
      {this.id,
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
        this.salary});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    employerBusinessId = json['employer_business_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
        : null;
    jobDescription = json['job_description'] != null
        ? new JobDescription.fromJson(json['job_description'])
        : null;
    if (json['job_status'] != null) {
      jobStatus = <JobStatus>[];
      json['job_status'].forEach((v) {
        jobStatus!.add(new JobStatus.fromJson(v));
      });
    }
    if (json['city_options'] != null) {
      cityOptions = <CityOptions>[];
      json['city_options'].forEach((v) {
        cityOptions!.add(new CityOptions.fromJson(v));
      });
    }
    if (json['country_options'] != null) {
      countryOptions = <CountryOptions>[];
      json['country_options'].forEach((v) {
        countryOptions!.add(new CountryOptions.fromJson(v));
      });
    }
    if (json['jobtype_options'] != null) {
      jobtypeOptions = <JobtypeOptions>[];
      json['jobtype_options'].forEach((v) {
        jobtypeOptions!.add(new JobtypeOptions.fromJson(v));
      });
    }
    salary =
    json['salary'] != null ? new Salary.fromJson(json['salary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['employer_business_id'] = this.employerBusinessId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    if (this.jobDescription != null) {
      data['job_description'] = this.jobDescription!.toJson();
    }
    if (this.jobStatus != null) {
      data['job_status'] = this.jobStatus!.map((v) => v.toJson()).toList();
    }
    if (this.cityOptions != null) {
      data['city_options'] = this.cityOptions!.map((v) => v.toJson()).toList();
    }
    if (this.countryOptions != null) {
      data['country_options'] =
          this.countryOptions!.map((v) => v.toJson()).toList();
    }
    if (this.jobtypeOptions != null) {
      data['jobtype_options'] =
          this.jobtypeOptions!.map((v) => v.toJson()).toList();
    }
    if (this.salary != null) {
      data['salary'] = this.salary!.toJson();
    }
    return data;
  }
}

class Business {
  int? id;
  String? uuid;
  String? name;
  String? createdAt;
  String? updatedAt;
  BusinessImage? businessImage;

  Business(
      {this.id,
        this.uuid,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.businessImage});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    businessImage = json['business_image'] != null
        ? new BusinessImage.fromJson(json['business_image'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.businessImage != null) {
      data['business_image'] = this.businessImage!.toJson();
    }
    return data;
  }
}

class BusinessImage {
  int? id;
  String? uuid;
  String? image;
  int? employerBusinessId;
  String? createdAt;
  String? updatedAt;

  BusinessImage(
      {this.id,
        this.uuid,
        this.image,
        this.employerBusinessId,
        this.createdAt,
        this.updatedAt});

  BusinessImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    image = json['image'];
    employerBusinessId = json['employer_business_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['image'] = this.image;
    data['employer_business_id'] = this.employerBusinessId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class JobDescription {
  int? id;
  String? uuid;
  String? description;
  int? jobId;
  String? createdAt;
  String? updatedAt;

  JobDescription(
      {this.id,
        this.uuid,
        this.description,
        this.jobId,
        this.createdAt,
        this.updatedAt});

  JobDescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    description = json['description'];
    jobId = json['job_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['description'] = this.description;
    data['job_id'] = this.jobId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class JobStatus {
  int? id;
  String? uuid;
  String? status;
  String? current;
  int? jobId;
  String? createdAt;
  String? updatedAt;

  JobStatus(
      {this.id,
        this.uuid,
        this.status,
        this.current,
        this.jobId,
        this.createdAt,
        this.updatedAt});

  JobStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    status = json['status'];
    current = json['current'];
    jobId = json['job_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['status'] = this.status;
    data['current'] = this.current;
    data['job_id'] = this.jobId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class CityOptions {
  int? id;
  String? uuid;
  String? title;
  int? countryId;
  String? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  CityOptions(
      {this.id,
        this.uuid,
        this.title,
        this.countryId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  CityOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    countryId = json['country_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['country_id'] = this.countryId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  int? jobId;
  int? cityId;

  Pivot({this.jobId, this.cityId});

  Pivot.fromJson(Map<String, dynamic> json) {
    jobId = json['job_id'];
    cityId = json['city_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_id'] = this.jobId;
    data['city_id'] = this.cityId;
    return data;
  }
}

class CountryOptions {
  int? id;
  String? uuid;
  String? title;
  String? flag;
  String? code;
  String? shortname;
  String? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  CountryOptions(
      {this.id,
        this.uuid,
        this.title,
        this.flag,
        this.code,
        this.shortname,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  CountryOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    flag = json['flag'];
    code = json['code'];
    shortname = json['shortname'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['flag'] = this.flag;
    data['code'] = this.code;
    data['shortname'] = this.shortname;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}



class JobtypeOptions {
  int? id;
  String? uuid;
  String? title;
  String? status;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  JobtypeOptions(
      {this.id,
        this.uuid,
        this.title,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  JobtypeOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}



class Salary {
  int? id;
  String? uuid;
  int? countryCurrencyId;
  String? minimum;
  String? maximum;
  String? showSalary;
  int? jobId;
  int? salarytypeId;
  String? createdAt;
  String? updatedAt;
  Currency? currency;
  SalaryType? salaryType;

  Salary(
      {this.id,
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
        this.salaryType});

  Salary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    countryCurrencyId = json['country_currency_id'];
    minimum = json['minimum'];
    maximum = json['maximum'];
    showSalary = json['show_salary'];
    jobId = json['job_id'];
    salarytypeId = json['salarytype_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
    salaryType = json['salary_type'] != null
        ? new SalaryType.fromJson(json['salary_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['country_currency_id'] = this.countryCurrencyId;
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    data['show_salary'] = this.showSalary;
    data['job_id'] = this.jobId;
    data['salarytype_id'] = this.salarytypeId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    if (this.salaryType != null) {
      data['salary_type'] = this.salaryType!.toJson();
    }
    return data;
  }
}

class Currency {
  int? id;
  String? uuid;
  String? currency;
  String? currencyCode;
  String? status;
  String? createdAt;
  String? updatedAt;

  Currency(
      {this.id,
        this.uuid,
        this.currency,
        this.currencyCode,
        this.status,
        this.createdAt,
        this.updatedAt});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SalaryType {
  int? id;
  String? uuid;
  String? title;
  String? status;
  String? createdAt;
  String? updatedAt;

  SalaryType(
      {this.id,
        this.uuid,
        this.title,
        this.status,
        this.createdAt,
        this.updatedAt});

  SalaryType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url']??'';
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}















