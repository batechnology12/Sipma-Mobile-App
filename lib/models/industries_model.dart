// To parse this JSON data, do
//
//     final industriesModel = industriesModelFromJson(jsonString);

import 'dart:convert';

IndustriesModel industriesModelFromJson(String str) =>
    IndustriesModel.fromJson(json.decode(str));

String industriesModelToJson(IndustriesModel data) =>
    json.encode(data.toJson());

class IndustriesModel {
  String message;
  List<Industry> industries;

  IndustriesModel({
    required this.message,
    required this.industries,
  });

  factory IndustriesModel.fromJson(Map<String, dynamic> json) =>
      IndustriesModel(
        message: json["message"],
        industries: List<Industry>.from(
            json["Industries"].map((x) => Industry.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "Industries": List<dynamic>.from(industries.map((x) => x.toJson())),
      };
}

class Industry {
  int id;
  String name;
  String? description;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Industry({
    required this.id,
    required this.name,
    this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Industry.fromJson(Map<String, dynamic> json) => Industry(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
