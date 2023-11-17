// To parse this JSON data, do
//
//     final cityListModel = cityListModelFromJson(jsonString);

import 'dart:convert';

CityListModel cityListModelFromJson(String str) =>
    CityListModel.fromJson(json.decode(str));

String cityListModelToJson(CityListModel data) => json.encode(data.toJson());

class CityListModel {
  CityListModel({
    required this.message,
    required this.cityList,
  });

  String message;
  List<CityList> cityList;

  factory CityListModel.fromJson(Map<String, dynamic> json) => CityListModel(
        message: json["message"],
        cityList: List<CityList>.from(
            json["cityList"].map((x) => CityList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "cityList": List<dynamic>.from(cityList.map((x) => x.toJson())),
      };
}

class CityList {
  CityList({
    required this.id,
    required this.city,
    required this.state,
    required this.status,
  });

  int id;
  String city;
  String state;
  int status;

  factory CityList.fromJson(Map<String, dynamic> json) => CityList(
        id: json["id"],
        city: json["city"],
        state: json["state"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "state": state,
        "status": status,
      };
}
