// class GetWorkAuthorizationModel {
//   int? id;
//   String? uuid;
//   String? title;
//   String? flag;
//   String? code;
//   String? shortname;
//   String? status;
//   String? createdAt;
//   String? updatedAt;
//
//   GetWorkAuthorizationModel(
//       {this.id,
//         this.uuid,
//         this.title,
//         this.flag,
//         this.code,
//         this.shortname,
//         this.status,
//         this.createdAt,
//         this.updatedAt});
//
//   GetWorkAuthorizationModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     uuid = json['uuid'];
//     title = json['title'];
//     flag = json['flag'];
//     code = json['code'];
//     shortname = json['shortname'];
//     status = json['status'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['uuid'] = this.uuid;
//     data['title'] = this.title;
//     data['flag'] = this.flag;
//     data['code'] = this.code;
//     data['shortname'] = this.shortname;
//     data['status'] = this.status;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

class GetWorkAuthorizationModel {
  String? id;
  String? title;
  String? flag;
  String? code;
  String? shortname;

  GetWorkAuthorizationModel(
      {this.id, this.title, this.flag, this.code, this.shortname});

  GetWorkAuthorizationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    flag = json['flag'];
    code = json['code'];
    shortname = json['shortname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['flag'] = this.flag;
    data['code'] = this.code;
    data['shortname'] = this.shortname;
    return data;
  }
}
