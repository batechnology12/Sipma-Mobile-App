// To parse this JSON data, do
//
//     final likesListModel = likesListModelFromJson(jsonString);

import 'dart:convert';

LikesListModel likesListModelFromJson(String str) =>
    LikesListModel.fromJson(json.decode(str));

String likesListModelToJson(LikesListModel data) => json.encode(data.toJson());

class LikesListModel {
  String message;
  List<LikesList> likesList;

  LikesListModel({
    required this.message,
    required this.likesList,
  });

  factory LikesListModel.fromJson(Map<String, dynamic> json) => LikesListModel(
        message: json["message"],
        likesList: List<LikesList>.from(
            json["likes_list"].map((x) => LikesList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "likes_list": List<dynamic>.from(likesList.map((x) => x.toJson())),
      };
}

class LikesList {
  int id;
  dynamic userId;
  dynamic postsId;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  String userName;
  String lastName;
  String designation;
  String email;
  String picture;

  LikesList({
    required this.id,
    required this.userId,
    required this.postsId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.lastName,
    required this.designation,
    required this.email,
    required this.picture,
  });

  factory LikesList.fromJson(Map<String, dynamic> json) => LikesList(
        id: json["id"],
        userId: json["user_id"].toString(),
        postsId: json["posts_id"].toString(),
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        userName: json["user_name"],
        lastName: json["last_name"],
        designation: json["designation"],
        email: json["email"],
        picture: json["picture"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "posts_id": postsId,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "user_name": userName,
        "last_name": lastName,
        "designation": designation,
        "email": email,
        "picture": picture,
      };
}
