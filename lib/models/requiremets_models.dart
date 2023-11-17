// To parse this JSON data, do
//
//     final requirementsModel = requirementsModelFromJson(jsonString);

import 'dart:convert';

RequirementsModel requirementsModelFromJson(String str) =>
    RequirementsModel.fromJson(json.decode(str));

String requirementsModelToJson(RequirementsModel data) =>
    json.encode(data.toJson());

class RequirementsModel {
  String message;
  List<Requirement> requirement;

  RequirementsModel({
    required this.message,
    required this.requirement,
  });

  factory RequirementsModel.fromJson(Map<String, dynamic> json) =>
      RequirementsModel(
        message: json["message"],
        requirement: List<Requirement>.from(
            json["Requirement"].map((x) => Requirement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "Requirement": List<dynamic>.from(requirement.map((x) => x.toJson())),
      };
}

class Requirement {
  int id;
  int departmentId;
  String name;
  dynamic description;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Requirement({
    required this.id,
    required this.departmentId,
    required this.name,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Requirement.fromJson(Map<String, dynamic> json) => Requirement(
        id: json["id"],
        departmentId: json["department_id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_id": departmentId,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
