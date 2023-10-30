class GetResumeModel {
  int? id;
  String? uuid;
  int? userId;
  String ?resume;
  String ?createdAt;
  String? updatedAt;

  GetResumeModel(
      {this.id,
        this.uuid,
        this.userId,
        this.resume,
        this.createdAt,
        this.updatedAt});

  GetResumeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    userId = json['user_id'];
    resume = json['resume'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['user_id'] = this.userId;
    data['resume'] = this.resume;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
