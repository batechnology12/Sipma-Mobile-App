// To parse this JSON data, do
//
//     final friendRequestListModel = friendRequestListModelFromJson(jsonString);

import 'dart:convert';

FriendRequestListModel friendRequestListModelFromJson(String str) =>
    FriendRequestListModel.fromJson(json.decode(str));

String friendRequestListModelToJson(FriendRequestListModel data) =>
    json.encode(data.toJson());

class FriendRequestListModel {
  List<FriendRequestList> friendRequestList;

  FriendRequestListModel({
    required this.friendRequestList,
  });

  factory FriendRequestListModel.fromJson(Map<String, dynamic> json) =>
      FriendRequestListModel(
        friendRequestList: List<FriendRequestList>.from(
            json["friend_request_list"]
                .map((x) => FriendRequestList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "friend_request_list":
            List<dynamic>.from(friendRequestList.map((x) => x.toJson())),
      };
}

class FriendRequestList {
  int friendId;
  String name;
  String email;
  dynamic profile;
  dynamic designation;

  FriendRequestList({
    required this.friendId,
    required this.name,
    required this.email,
    required this.profile,
    this.designation,
  });

  factory FriendRequestList.fromJson(Map<String, dynamic> json) =>
      FriendRequestList(
        friendId: json["friend_id"],
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        profile: json["profile"] ?? "",
        designation: json["designation"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "friend_id": friendId,
        "name": name,
        "email": email,
        "profile": profile,
        "designation": designation,
      };
}
