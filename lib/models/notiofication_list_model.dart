// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) =>
    NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) =>
    json.encode(data.toJson());

class NotificationListModel {
  String message;
  List<ListElement> list;
  int count;

  NotificationListModel({
    required this.message,
    required this.list,
    required this.count,
  });

  factory NotificationListModel.fromJson(Map<String, dynamic> json) =>
      NotificationListModel(
        message: json["message"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
        count: json["count"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "count": count,
      };
}

class ListElement {
  int id;
  String title;
  String message;
  String recipientId;
  String notifiableType;
  String notifyId;
  Data data;
  dynamic readAt;
  DateTime createdAt;
  DateTime updatedAt;

  ListElement({
    required this.id,
    required this.title,
    required this.message,
    required this.recipientId,
    required this.notifiableType,
    required this.notifyId,
    required this.data,
    this.readAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        title: json["title"],
        message: json["message"],
        recipientId: json["recipient_id"],
        notifiableType: json["notifiable_type"],
        notifyId: json["notify_id"],
        data: Data.fromJson(json["data"]),
        readAt: json["read_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "message": message,
        "recipient_id": recipientId,
        "notifiable_type": notifiableType,
        "notify_id": notifyId,
        "data": data.toJson(),
        "read_at": readAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Data {
  String type;
  int id;
  int userId;
  String profilePicture;
  String designation;

  Data({
    required this.type,
    required this.id,
    required this.userId,
    required this.profilePicture,
    required this.designation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        type: json["type"] ?? "",
        id: int.parse(json["id"].toString()),
        userId: int.parse(json["user_id"].toString()),
        profilePicture: json["profile_picture"] ?? "",
        designation: json["designation"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "user_id": userId,
        "profile_picture": profilePicture,
        "designation": designation,
      };
}
