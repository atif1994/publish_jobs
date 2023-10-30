class JobSeekerCertificationsModel {
  String? id;
  String? userId;
  String? certificate;
  String? institute;
  String? description;
  String? startDate;
  String? endDate;

  JobSeekerCertificationsModel(
      {this.id,
        this.userId,
        this.certificate,
        this.institute,
        this.description,
        this.startDate,
        this.endDate});

  JobSeekerCertificationsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    certificate = json['certificate'];
    institute = json['institute'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['certificate'] = this.certificate;
    data['institute'] = this.institute;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}
