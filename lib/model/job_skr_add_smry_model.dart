class jobseekerAddSummaryModel {
  int? userId;
  String? summary;
  String? uuid;
  String? updatedAt;
  String? createdAt;
  int? id;

  jobseekerAddSummaryModel(
      {this.userId,
        this.summary,
        this.uuid,
        this.updatedAt,
        this.createdAt,
        this.id});

  jobseekerAddSummaryModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    summary = json['summary'];
    uuid = json['uuid'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['summary'] = this.summary;
    data['uuid'] = this.uuid;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
