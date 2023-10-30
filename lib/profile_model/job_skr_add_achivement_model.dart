class jobSeekerAddAchievementModel {
  int? userId;
  String? achievement;
  String? uuid;
  String? updatedAt;
  String? createdAt;
  int? id;

  jobSeekerAddAchievementModel(
      {this.userId,
        this.achievement,
        this.uuid,
        this.updatedAt,
        this.createdAt,
        this.id});

  jobSeekerAddAchievementModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    achievement = json['achievement'];
    uuid = json['uuid'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['achievement'] = this.achievement;
    data['uuid'] = this.uuid;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}