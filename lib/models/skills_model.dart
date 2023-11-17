// To parse this JSON data, do
//
//     final skillsModel = skillsModelFromJson(jsonString);

import 'dart:convert';

SkillsModel skillsModelFromJson(String str) =>
    SkillsModel.fromJson(json.decode(str));

String skillsModelToJson(SkillsModel data) => json.encode(data.toJson());

class SkillsModel {
  List<SkillsData> data;

  SkillsModel({
    required this.data,
  });

  factory SkillsModel.fromJson(Map<String, dynamic> json) => SkillsModel(
        data: List<SkillsData>.from(
            json["data"].map((x) => SkillsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class SkillsData {
  String name;

  SkillsData({
    required this.name,
  });

  factory SkillsData.fromJson(Map<String, dynamic> json) => SkillsData(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
