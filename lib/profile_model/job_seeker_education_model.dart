class JobseekerEducationModel {
  String? id;
  String? degreeId;
  String? userId;
  String? institute;
  String? fieldStudy;
  Null? description;
  String? startYear;
  String? endYear;
  String? inProgress;
  Degree? degree;

  JobseekerEducationModel(
      {this.id,
        this.degreeId,
        this.userId,
        this.institute,
        this.fieldStudy,
        this.description,
        this.startYear,
        this.endYear,
        this.inProgress,
        this.degree});

  JobseekerEducationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    degreeId = json['degree_id'];
    userId = json['user_id'];
    institute = json['institute'];
    fieldStudy = json['field_study'];
    description = json['description'];
    startYear = json['start_year'];
    endYear = json['end_year'];
    inProgress = json['in_progress'];
    degree =
    json['degree'] != null ? new Degree.fromJson(json['degree']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['degree_id'] = this.degreeId;
    data['user_id'] = this.userId;
    data['institute'] = this.institute;
    data['field_study'] = this.fieldStudy;
    data['description'] = this.description;
    data['start_year'] = this.startYear;
    data['end_year'] = this.endYear;
    data['in_progress'] = this.inProgress;
    if (this.degree != null) {
      data['degree'] = this.degree!.toJson();
    }
    return data;
  }
}

class Degree {
  String? id;
  String? title;

  Degree({this.id, this.title});

  Degree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
