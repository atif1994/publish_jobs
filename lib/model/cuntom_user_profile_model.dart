class UserCustomDataModel {
  String? email;
  Null? emailVerifiedAt;
  Username? username;
  UserInfo? userInfo;
  UserImage? userImage;
  UserMobile? userMobile;
  List<CountryOption>? countryOption;
  List<CityOption>? cityOption;

  UserCustomDataModel(
      {this.email,
        this.emailVerifiedAt,
        this.username,
        this.userInfo,
        this.userImage,
        this.userMobile,
        this.countryOption,
        this.cityOption});

  UserCustomDataModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    username = json['username'] != null
        ? new Username.fromJson(json['username'])
        : null;
    userInfo = json['user_info'] != null
        ? new UserInfo.fromJson(json['user_info'])
        : null;
    userImage = json['user_image'] != null
        ? new UserImage.fromJson(json['user_image'])
        : null;
    userMobile = json['user_mobile'] != null
        ? new UserMobile.fromJson(json['user_mobile'])
        : null;
    if (json['country_option'] != null) {
      countryOption = <CountryOption>[];
      json['country_option'].forEach((v) {
        countryOption!.add(new CountryOption.fromJson(v));
      });
    }
    if (json['city_option'] != null) {
      cityOption = <CityOption>[];
      json['city_option'].forEach((v) {
        cityOption!.add(new CityOption.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    if (this.username != null) {
      data['username'] = this.username!.toJson();
    }
    if (this.userInfo != null) {
      data['user_info'] = this.userInfo!.toJson();
    }
    if (this.userImage != null) {
      data['user_image'] = this.userImage!.toJson();
    }
    if (this.userMobile != null) {
      data['user_mobile'] = this.userMobile!.toJson();
    }
    if (this.countryOption != null) {
      data['country_option'] =
          this.countryOption!.map((v) => v.toJson()).toList();
    }
    if (this.cityOption != null) {
      data['city_option'] = this.cityOption!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Username {
  String? id;
  String? userId;
  String? username;

  Username({this.id, this.userId, this.username});

  Username.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['username'] = this.username;
    return data;
  }
}

class UserInfo {
  String? id;
  String? userId;
  String? firstName;
  String? lastName;

  UserInfo({this.id, this.userId, this.firstName, this.lastName});

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    return data;
  }
}

class UserImage {
  String? id;
  String? userId;
  String? image;

  UserImage({this.id, this.userId, this.image});

  UserImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    return data;
  }
}

class UserMobile {
  String? id;
  String? userId;
  String? codeCountryId;
  String? mobile;
  CountryMobCode? countryMobCode;

  UserMobile(
      {this.id,
        this.userId,
        this.codeCountryId,
        this.mobile,
        this.countryMobCode});

  UserMobile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    codeCountryId = json['code_country_id'];
    mobile = json['mobile'];
    countryMobCode = json['country_mob_code'] != null
        ? new CountryMobCode.fromJson(json['country_mob_code'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['code_country_id'] = this.codeCountryId;
    data['mobile'] = this.mobile;
    if (this.countryMobCode != null) {
      data['country_mob_code'] = this.countryMobCode!.toJson();
    }
    return data;
  }
}

class CountryMobCode {
  String? id;
  String? title;
  String? flag;
  String? code;
  String? shortname;

  CountryMobCode({this.id, this.title, this.flag, this.code, this.shortname});

  CountryMobCode.fromJson(Map<String, dynamic> json) {
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

class CountryOption {
  String? id;
  String? title;
  String? flag;
  String? code;
  String? shortname;
  List<Currency>? currency;

  CountryOption(
      {this.id,
        this.title,
        this.flag,
        this.code,
        this.shortname,
        this.currency});

  CountryOption.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    flag = json['flag'];
    code = json['code'];
    shortname = json['shortname'];
    if (json['currency'] != null) {
      currency = <Currency>[];
      json['currency'].forEach((v) {
        currency!.add(new Currency.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['flag'] = this.flag;
    data['code'] = this.code;
    data['shortname'] = this.shortname;
    if (this.currency != null) {
      data['currency'] = this.currency!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Currency {
  String? id;
  String? currency;
  String? currencyCode;
  String? countryId;

  Currency({this.id, this.currency, this.currencyCode, this.countryId});

  Currency.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    currency = json['currency'];
    currencyCode = json['currency_code'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['currency'] = this.currency;
    data['currency_code'] = this.currencyCode;
    data['country_id'] = this.countryId;
    return data;
  }
}

class CityOption {
  String? id;
  String? title;
  String? countryId;

  CityOption({this.id, this.title, this.countryId});

  CityOption.fromJson(Map<String, dynamic> json) {
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
