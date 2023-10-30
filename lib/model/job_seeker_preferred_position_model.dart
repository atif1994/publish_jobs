class JobSeekerPreferredPositionModel {
  String? id;
  String? title;
  String? status;
  Pivot? pivot;

  JobSeekerPreferredPositionModel(
      {this.id, this.title, this.status, this.pivot});

  JobSeekerPreferredPositionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    status = json['status'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  String? userId;
  String? jobpositionId;

  Pivot({this.userId, this.jobpositionId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    jobpositionId = json['jobposition_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['jobposition_id'] = this.jobpositionId;
    return data;
  }
}
