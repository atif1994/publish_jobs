class JobSeekerReadyToWorkModel {
  String? id;
  String? userId;
  String? checked;

  JobSeekerReadyToWorkModel({this.id, this.userId, this.checked});

  JobSeekerReadyToWorkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    checked = json['checked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['checked'] = this.checked;
    return data;
  }
}
