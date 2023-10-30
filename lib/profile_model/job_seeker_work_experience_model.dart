class JobseekerWorkExperienceModel {
  String? id;
  String? userId;
  String? title;
  String? company;
  String? description;
  String? startDate;
  String? endDate;
  String? currentlyWork;

  JobseekerWorkExperienceModel(
      {this.id,
        this.userId,
        this.title,
        this.company,
        this.description,
        this.startDate,
        this.endDate,
        this.currentlyWork});

  JobseekerWorkExperienceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    company = json['company'];
    description = json['description'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    currentlyWork = json['currently_work'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['company'] = this.company;
    data['description'] = this.description;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['currently_work'] = this.currentlyWork;
    return data;
  }
}
