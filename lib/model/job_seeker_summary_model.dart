class JobSeekerSummaryModel {
  String? id;
  String? userId;
  String? summary;

  JobSeekerSummaryModel({this.id, this.userId, this.summary});

  JobSeekerSummaryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    summary = json['summary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['summary'] = this.summary;
    return data;
  }
}
