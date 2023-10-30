class CountriesListModel {
  String? id;
  String? title;
  String? flag;
  String? code;
  String? shortname;

  CountriesListModel(
      {this.id, this.title, this.flag, this.code, this.shortname});

  CountriesListModel.fromJson(Map<String, dynamic> json) {
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
