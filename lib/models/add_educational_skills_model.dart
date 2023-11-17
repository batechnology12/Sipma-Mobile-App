// To parse this JSON data, do
//
//     final addEducationalSkillsModel = addEducationalSkillsModelFromJson(jsonString);

import 'dart:convert';

AddEducationalSkillsModel addEducationalSkillsModelFromJson(String str) => AddEducationalSkillsModel.fromJson(json.decode(str));

String addEducationalSkillsModelToJson(AddEducationalSkillsModel data) => json.encode(data.toJson());

class AddEducationalSkillsModel {
    String message;
    Data data;

    AddEducationalSkillsModel({
        required this.message,
        required this.data,
    });

    factory AddEducationalSkillsModel.fromJson(Map<String, dynamic> json) => AddEducationalSkillsModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String userId;
    String institutionName;
    String educationTitle;
    String city;
    String state;
    String fromBatch;
    DateTime updatedAt;
    DateTime createdAt;
    int id;

    Data({
        required this.userId,
        required this.institutionName,
        required this.educationTitle,
        required this.city,
        required this.state,
        required this.fromBatch,
        required this.updatedAt,
        required this.createdAt,
        required this.id,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["user_id"],
        institutionName: json["institution_name"],
        educationTitle: json["education_title"],
        city: json["city"],
        state: json["state"],
        fromBatch: json["from_batch"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "institution_name": institutionName,
        "education_title": educationTitle,
        "city": city,
        "state": state,
        "from_batch": fromBatch,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
    };
}
