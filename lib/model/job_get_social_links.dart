class GetSocialLinksModel {
  int ?id;
  String? uuid;
  String ?title;
  String ?status;
  String ?createdAt;
  String ?updatedAt;

  GetSocialLinksModel(
      {this.id,
        this.uuid,
        this.title,
        this.status,
        this.createdAt,
        this.updatedAt});

  GetSocialLinksModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    title = json['title'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['uuid'] = this.uuid;
    data['title'] = this.title;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
