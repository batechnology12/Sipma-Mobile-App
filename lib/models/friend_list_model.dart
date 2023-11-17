// To parse this JSON data, do
//
//     final friendListModel = friendListModelFromJson(jsonString);

import 'dart:convert';

FriendListModel friendListModelFromJson(String str) =>
    FriendListModel.fromJson(json.decode(str));

String friendListModelToJson(FriendListModel data) =>
    json.encode(data.toJson());

class FriendListModel {
  List<FriendList> friendList;

  FriendListModel({
    required this.friendList,
  });

  factory FriendListModel.fromJson(Map<String, dynamic> json) =>
      FriendListModel(
        friendList: List<FriendList>.from(
            json["friend_list"].map((x) => FriendList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "friend_list": List<dynamic>.from(friendList.map((x) => x.toJson())),
      };
}

class FriendList {
  int friendId;
  String name;
  String email;
  dynamic profile;
  String designation;
  String status;

  FriendList({
    required this.friendId,
    required this.name,
    required this.email,
    required this.profile,
    required this.designation,
    required this.status,
  });

  factory FriendList.fromJson(Map<String, dynamic> json) => FriendList(
        friendId: json["friend_id"],
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        profile: json["profile"] ?? "",
        designation: json["designation"] ?? "",
        status: json["status"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "friend_id": friendId,
        "name": name,
        "email": email,
        "profile": profile,
        "designation": designation,
        "status": status,
      };
}
