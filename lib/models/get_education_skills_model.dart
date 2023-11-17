// To parse this JSON data, do
//
//     final getEducationalSkillsModel = getEducationalSkillsModelFromJson(jsonString);

import 'dart:convert';

GetEducationalSkillsModel getEducationalSkillsModelFromJson(String str) =>
    GetEducationalSkillsModel.fromJson(json.decode(str));

String getEducationalSkillsModelToJson(GetEducationalSkillsModel data) =>
    json.encode(data.toJson());

class GetEducationalSkillsModel {
  String message;
  List<educationskillsdata> departments;

  GetEducationalSkillsModel({
    required this.message,
    required this.departments,
  });

  factory GetEducationalSkillsModel.fromJson(Map<String, dynamic> json) =>
      GetEducationalSkillsModel(
        message: json["message"],
        departments: List<educationskillsdata>.from(
            json["departments"].map((x) => educationskillsdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "departments": List<dynamic>.from(departments.map((x) => x.toJson())),
      };
}

class educationskillsdata {
  int id;
  int userId;
  String institutionName;
  String educationTitle;
  String? educationDescription;
  String city;
  String state;
  String fromBatch;
  String? tillDate;
  dynamic flag;
  DateTime createdAt;
  DateTime updatedAt;

  educationskillsdata({
    required this.id,
    required this.userId,
    required this.institutionName,
    required this.educationTitle,
    required this.educationDescription,
    required this.city,
    required this.state,
    required this.fromBatch,
    required this.flag,
    required this.tillDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory educationskillsdata.fromJson(Map<String, dynamic> json) =>
      educationskillsdata(
        id: json["id"],
        userId: json["user_id"],
        institutionName: json["institution_name"],
        educationTitle: json["education_title"],
        educationDescription: json["education_description"],
        city: json["city"],
        state: json["state"],
        fromBatch: json["from_batch"],
        tillDate: json["till_date"],
        flag: json["flag"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "institution_name": institutionName,
        "education_title": educationTitle,
        "education_description": educationDescription,
        "city": city,
        "state": state,
        "from_batch": fromBatch,
        "till_date": tillDate,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
