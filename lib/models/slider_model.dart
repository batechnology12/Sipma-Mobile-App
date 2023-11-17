// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromJson(jsonString);

import 'dart:convert';

SliderModel sliderModelFromJson(String str) =>
    SliderModel.fromJson(json.decode(str));

String sliderModelToJson(SliderModel data) => json.encode(data.toJson());

class SliderModel {
  String message;
  List<SliderList> sliderList;

  SliderModel({
    required this.message,
    required this.sliderList,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        message: json["message"],
        sliderList: List<SliderList>.from(
            json["slider_list"].map((x) => SliderList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "slider_list": List<dynamic>.from(sliderList.map((x) => x.toJson())),
      };
}

class SliderList {
  int id;
  String title;
  String description;
  String image;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  SliderList({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SliderList.fromJson(Map<String, dynamic> json) => SliderList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        image: json["image"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "image": image,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
