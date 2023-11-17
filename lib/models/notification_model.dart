// To parse this JSON data, do
//
//     final notificationDataModel = notificationDataModelFromJson(jsonString);

import 'dart:convert';

NotificationDataModel notificationDataModelFromJson(String str) =>
    NotificationDataModel.fromJson(json.decode(str));

String notificationDataModelToJson(NotificationDataModel data) =>
    json.encode(data.toJson());

class NotificationDataModel {
  dynamic id;
  String type;

  NotificationDataModel({
    required this.id,
    required this.type,
  });

  factory NotificationDataModel.fromJson(Map<String, dynamic>? json) =>
      NotificationDataModel(
        id: json!["id"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
      };
}
