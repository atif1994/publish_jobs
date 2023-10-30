class GetjobseekerExpectedSalaryModel {
  String? id;
  String? userId;
  String? salarytypeId;
  String? currencyId;
  String? desiredPay;
  Currencies? currencies;
  Salarytypes? salarytypes;

  GetjobseekerExpectedSalaryModel(
      {this.id,
        this.userId,
        this.salarytypeId,
        this.currencyId,
        this.desiredPay,
        this.currencies,
        this.salarytypes});

  GetjobseekerExpectedSalaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    salarytypeId = json['salarytype_id'];
    currencyId = json['currency_id'];
    desiredPay = json['desired_pay'];
    currencies = json['currencies'] != null
        ? new Currencies.fromJson(json['currencies'])
        : null;
    salarytypes = json['salarytypes'] != null
        ? new Salarytypes.fromJson(json['salarytypes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['salarytype_id'] = this.salarytypeId;
    data['currency_id'] = this.currencyId;
    data['desired_pay'] = this.desiredPay;
    if (this.currencies != null) {
      data['currencies'] = this.currencies!.toJson();
    }
    if (this.salarytypes != null) {
      data['salarytypes'] = this.salarytypes!.toJson();
    }
    return data;
  }
}

class Currencies {
  String? id;
  String? currency;
  String? currencyCode;

  Currencies({this.id, this.currency, this.currencyCode});

  Currencies.fromJson(Map<String, dynamic> json) {
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

class Salarytypes {
  String? id;
  String? title;

  Salarytypes({this.id, this.title});

  Salarytypes.fromJson(Map<String, dynamic> json) {
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
