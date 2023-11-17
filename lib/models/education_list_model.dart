// To parse this JSON data, do
//
//     final educationListModel = educationListModelFromJson(jsonString);

import 'dart:convert';

EducationListModel educationListModelFromJson(String str) => EducationListModel.fromJson(json.decode(str));

String educationListModelToJson(EducationListModel data) => json.encode(data.toJson());

class EducationListModel {
    List<EducationData> data;

    EducationListModel({
        required this.data,
    });

    factory EducationListModel.fromJson(Map<String, dynamic> json) => EducationListModel(
        data: List<EducationData>.from(json["data"].map((x) => EducationData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class EducationData {
    int id;
    String title;
    dynamic description;
    int status;
    DateTime createdAt;
    DateTime updatedAt;

    EducationData({
        required this.id,
        required this.title,
        required this.description,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    factory EducationData.fromJson(Map<String, dynamic> json) => EducationData(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
