// To parse this JSON data, do
//
//     final searchFriendsModel = searchFriendsModelFromJson(jsonString);

import 'dart:convert';

SearchFriendsModel searchFriendsModelFromJson(String str) =>
    SearchFriendsModel.fromJson(json.decode(str));

String searchFriendsModelToJson(SearchFriendsModel data) =>
    json.encode(data.toJson());

class SearchFriendsModel {
  List<SearchFriendsList> friendList;

  SearchFriendsModel({
    required this.friendList,
  });

  factory SearchFriendsModel.fromJson(Map<String, dynamic> json) =>
      SearchFriendsModel(
        friendList: List<SearchFriendsList>.from(
            json["friend_list"].map((x) => SearchFriendsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "friend_list": List<dynamic>.from(friendList.map((x) => x.toJson())),
      };
}

class SearchFriendsList {
  int friendId;
  String name;
  String email;
  dynamic profile;
  String? designation;
  bool isFriend;

  SearchFriendsList({
    required this.friendId,
    required this.name,
    required this.email,
    this.profile,
    this.designation,
    required this.isFriend,
  });

  factory SearchFriendsList.fromJson(Map<String, dynamic> json) => SearchFriendsList(
        friendId: json["friend_id"],
        name: json["name"],
        email: json["email"],
        profile: json["profile"],
        designation: json["designation"],
        isFriend: json["is_friend"],
      );

  Map<String, dynamic> toJson() => {
        "friend_id": friendId,
        "name": name,
        "email": email,
        "profile": profile,
        "designation": designation,
        "is_friend": isFriend,
      };
}
