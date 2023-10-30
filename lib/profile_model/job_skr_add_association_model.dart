class jobseekerAddAssociationModel {
  int? userId;
  String ?association;
  String? uuid;
  String ?updatedAt;
  String ?createdAt;
  int? id;

  jobseekerAddAssociationModel(
      {this.userId,
        this.association,
        this.uuid,
        this.updatedAt,
        this.createdAt,
        this.id});

  jobseekerAddAssociationModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    association = json['association'];
    uuid = json['uuid'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['association'] = this.association;
    data['uuid'] = this.uuid;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
