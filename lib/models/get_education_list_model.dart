// To parse this JSON data, do
//
//     final geteducationListModel = geteducationListModelFromJson(jsonString);

import 'dart:convert';

GeteducationListModel geteducationListModelFromJson(String str) =>
    GeteducationListModel.fromJson(json.decode(str));

String geteducationListModelToJson(GeteducationListModel data) =>
    json.encode(data.toJson());

class GeteducationListModel {
  List<Educationlistdata> data;

  GeteducationListModel({
    required this.data,
  });

  factory GeteducationListModel.fromJson(Map<String, dynamic> json) =>
      GeteducationListModel(
        data: List<Educationlistdata>.from(
            json["data"].map((x) => Educationlistdata.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Educationlistdata {
  int id;
  String title;
  dynamic description;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  List<Educationlist> educationlist;

  Educationlistdata({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.educationlist,
  });

  factory Educationlistdata.fromJson(Map<String, dynamic> json) =>
      Educationlistdata(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        educationlist: List<Educationlist>.from(
            json["educationlist"].map((x) => Educationlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "educationlist":
            List<dynamic>.from(educationlist.map((x) => x.toJson())),
      };
}

class Educationlist {
  int id;
  int category;
  String name;
  int status;
  DateTime createdAt;
  DateTime updatedAt;

  Educationlist({
    required this.id,
    required this.category,
    required this.name,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Educationlist.fromJson(Map<String, dynamic> json) => Educationlist(
        id: json["id"],
        category: json["category"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
