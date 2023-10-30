class jobseekerAssociationModel {
  String? id;
  String? userId;
  String? association;

  jobseekerAssociationModel({this.id, this.userId, this.association});

  jobseekerAssociationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    association = json['association'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['association'] = this.association;
    return data;
  }
}
