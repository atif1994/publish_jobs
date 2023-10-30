class GetJobTypeOptionModel {
  String? id;
  String? title;

  GetJobTypeOptionModel({this.id, this.title});

  GetJobTypeOptionModel.fromJson(Map<String, dynamic> json) {
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
