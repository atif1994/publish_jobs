class SavedJobModel {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  Null nextPageUrl;
  String? path;
  int? perPage;
  Null? prevPageUrl;
  int? to;
  int? total;

  SavedJobModel(
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

  SavedJobModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
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
  String? id;
  String? title;
  String? employerBusinessId;
  Business? business;
  List<JobStatus>? jobStatus;
  List<CityOptions>? cityOptions;
  List<JobtypeOptions>? jobtypeOptions;
  List<JobsApplied>? jobsApplied;
  List? jobsSaved;
  List<CountryOptions>? countryOptions;
  Salary? salary;

  Data(
      {this.id,
        this.title,
        this.employerBusinessId,
        this.business,
        this.jobStatus,
        this.cityOptions,
        this.jobtypeOptions,
        this.jobsApplied,
        this.jobsSaved,
        this.countryOptions,
        this.salary});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    employerBusinessId = json['employer_business_id'];
    business = json['business'] != null
        ? new Business.fromJson(json['business'])
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
    if (json['jobtype_options'] != null) {
      jobtypeOptions = <JobtypeOptions>[];
      json['jobtype_options'].forEach((v) {
        jobtypeOptions!.add(new JobtypeOptions.fromJson(v));
      });
    }
    if (json['jobs_applied'] != null) {
      jobsApplied = <JobsApplied>[];
      json['jobs_applied'].forEach((v) {
        jobsApplied!.add(new JobsApplied.fromJson(v));
      });
    }
    if (json['jobs_saved'] != null) {
      jobsSaved = [];
      json['jobs_saved'].forEach((v) {
        //jobsSaved!.add(new JobsSaved.fromJson(v));
      });
    }
    if (json['country_options'] != null) {
      countryOptions = <CountryOptions>[];
      json['country_options'].forEach((v) {
        countryOptions!.add(new CountryOptions.fromJson(v));
      });
    }
    salary =
    json['salary'] != null ? new Salary.fromJson(json['salary']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['employer_business_id'] = this.employerBusinessId;
    if (this.business != null) {
      data['business'] = this.business!.toJson();
    }
    if (this.jobStatus != null) {
      data['job_status'] = this.jobStatus!.map((v) => v.toJson()).toList();
    }
    if (this.cityOptions != null) {
      data['city_options'] = this.cityOptions!.map((v) => v.toJson()).toList();
    }
    if (this.jobtypeOptions != null) {
      data['jobtype_options'] =
          this.jobtypeOptions!.map((v) => v.toJson()).toList();
    }
    if (this.jobsApplied != null) {
      data['jobs_applied'] = this.jobsApplied!.map((v) => v.toJson()).toList();
    }
    if (this.jobsSaved != null) {
      data['jobs_saved'] = this.jobsSaved!.map((v) => v.toJson()).toList();
    }
    if (this.countryOptions != null) {
      data['country_options'] =
          this.countryOptions!.map((v) => v.toJson()).toList();
    }
    if (this.salary != null) {
      data['salary'] = this.salary!.toJson();
    }
    return data;
  }
}

class Business {
  String? id;
  String? name;
  Null businessImage;

  Business({this.id, this.name, this.businessImage});

  Business.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    businessImage = json['business_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['business_image'] = this.businessImage;
    return data;
  }
}

class JobStatus {
  String? id;
  String? status;
  String? current;
  String? jobId;
  String? createdAt;
  int? daysSinceActive;

  JobStatus(
      {this.id,
        this.status,
        this.current,
        this.jobId,
        this.createdAt,
        this.daysSinceActive});

  JobStatus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    current = json['current'];
    jobId = json['job_id'];
    createdAt = json['created_at'];
    daysSinceActive = json['days_since_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['current'] = this.current;
    data['job_id'] = this.jobId;
    data['created_at'] = this.createdAt;
    data['days_since_active'] = this.daysSinceActive;
    return data;
  }
}

class CityOptions {
  String? id;
  String? title;
  String? countryId;

  CityOptions({this.id, this.title, this.countryId});

  CityOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['country_id'] = this.countryId;
    return data;
  }
}

class JobtypeOptions {
  String? id;
  String? title;

  JobtypeOptions({this.id, this.title});

  JobtypeOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}

class JobsApplied {
  String? email;

  JobsApplied({this.email});

  JobsApplied.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    return data;
  }
}

class CountryOptions {
  String? id;
  String? title;
  String? flag;
  String? code;
  String? shortname;

  CountryOptions({this.id, this.title, this.flag, this.code, this.shortname});

  CountryOptions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    flag = json['flag'];
    code = json['code'];
    shortname = json['shortname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['flag'] = this.flag;
    data['code'] = this.code;
    data['shortname'] = this.shortname;
    return data;
  }
}

class Salary {
  String? id;
  String? countryCurrencyId;
  String? minimum;
  String? maximum;
  String? jobId;
  String? salarytypeId;
  JobtypeOptions? salarytype;
  Currency? currency;

  Salary(
      {this.id,
        this.countryCurrencyId,
        this.minimum,
        this.maximum,
        this.jobId,
        this.salarytypeId,
        this.salarytype,
        this.currency});

  Salary.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryCurrencyId = json['country_currency_id'];
    minimum = json['minimum'];
    maximum = json['maximum'];
    jobId = json['job_id'];
    salarytypeId = json['salarytype_id'];
    salarytype = json['salarytype'] != null
        ? new JobtypeOptions.fromJson(json['salarytype'])
        : null;
    currency = json['currency'] != null
        ? new Currency.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['country_currency_id'] = this.countryCurrencyId;
    data['minimum'] = this.minimum;
    data['maximum'] = this.maximum;
    data['job_id'] = this.jobId;
    data['salarytype_id'] = this.salarytypeId;
    if (this.salarytype != null) {
      data['salarytype'] = this.salarytype!.toJson();
    }
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    return data;
  }
}

class Currency {
  String? id;
  String? currency;
  String? currencyCode;

  Currency({this.id, this.currency, this.currencyCode});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
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