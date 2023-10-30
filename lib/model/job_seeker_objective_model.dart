class JobSeekerObjectiveModel {
  String? id;
  String? userId;
  String? objective;

  JobSeekerObjectiveModel({this.id, this.userId, this.objective});

  JobSeekerObjectiveModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    objective = json['objective'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['objective'] = this.objective;
    return data;
  }
}
