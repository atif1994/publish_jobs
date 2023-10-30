class JobSeekerWorkAuthorizationModel {
  String? id;
  String? title;
  String? flag;
  String? code;
  String? shortname;
  String? status;

  JobSeekerWorkAuthorizationModel(
      {this.id, this.title, this.flag, this.code, this.shortname, this.status});

  JobSeekerWorkAuthorizationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    flag = json['flag'];
    code = json['code'];
    shortname = json['shortname'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['flag'] = this.flag;
    data['code'] = this.code;
    data['shortname'] = this.shortname;
    data['status'] = this.status;
    return data;
  }
}
