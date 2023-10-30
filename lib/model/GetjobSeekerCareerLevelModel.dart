class JobSeekerCareerLevelModel {
  String? id;
  String? title;

  JobSeekerCareerLevelModel({this.id, this.title});

  JobSeekerCareerLevelModel.fromJson(Map<String, dynamic> json) {
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