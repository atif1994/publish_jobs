class jobseekerSalaryTypeModel {
  String? id;
  String? title;

  jobseekerSalaryTypeModel({this.id, this.title});

  jobseekerSalaryTypeModel.fromJson(Map<String, dynamic> json) {
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
