class JobSeekerGalleryModel {
  String? id;
  String? userId;
  String? image;

  JobSeekerGalleryModel({this.id, this.userId, this.image});

  JobSeekerGalleryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    return data;
  }
}
