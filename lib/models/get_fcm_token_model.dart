// To parse this JSON data, do
//
//     final getFcmModel = getFcmModelFromJson(jsonString);

import 'dart:convert';

GetFcmModel getFcmModelFromJson(String str) =>
    GetFcmModel.fromJson(json.decode(str));

String getFcmModelToJson(GetFcmModel data) => json.encode(data.toJson());

class GetFcmModel {
  String message;
  List<String> list;

  GetFcmModel({
    required this.message,
    required this.list,
  });

  factory GetFcmModel.fromJson(Map<String, dynamic> json) => GetFcmModel(
        message: json["message"],
        list: List<String>.from(json["list"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "list": List<dynamic>.from(list.map((x) => x)),
      };
}
