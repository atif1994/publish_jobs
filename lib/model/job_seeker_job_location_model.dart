class JobSeekerJobLocationModel {
  String? id;
  String? userId;
  String? countryId;
  String? cityId;
  Country? country;
  City? city;

  JobSeekerJobLocationModel(
      {this.id,
        this.userId,
        this.countryId,
        this.cityId,
        this.country,
        this.city});

  JobSeekerJobLocationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    cityId = json['city_id'];
    country =
    json['country'] != null ? new Country.fromJson(json['country']) : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['country_id'] = this.countryId;
    data['city_id'] = this.cityId;
    if (this.country != null) {
      data['country'] = this.country!.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}

class Country {
  String? id;
  String? title;
  String? flag;
  String? code;
  String? shortname;

  Country({this.id, this.title, this.flag, this.code, this.shortname});

  Country.fromJson(Map<String, dynamic> json) {
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

class City {
  String? id;
  String? title;
  String? countryId;

  City({this.id, this.title, this.countryId});

  City.fromJson(Map<String, dynamic> json) {
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
