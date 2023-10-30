class JobSeekerLanguageModel {
  String? id;
  String? title;
  String? status;

  JobSeekerLanguageModel({this.id, this.title, this.status});

  JobSeekerLanguageModel.fromJson(Map<String, dynamic> json) {
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
