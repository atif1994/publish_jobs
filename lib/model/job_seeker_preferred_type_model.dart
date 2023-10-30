class JobSeekerPreferredTypeModel {
  String? id;
  String? title;
  String? status;

  JobSeekerPreferredTypeModel({this.id, this.title, this.status});

  JobSeekerPreferredTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    return data;
  }
}
