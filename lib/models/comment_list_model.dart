// To parse this JSON data, do
//
//     final commentsListModel = commentsListModelFromJson(jsonString);

import 'dart:convert';

CommentsListModel commentsListModelFromJson(String str) =>
    CommentsListModel.fromJson(json.decode(str));

String commentsListModelToJson(CommentsListModel data) =>
    json.encode(data.toJson());

class CommentsListModel {
  String message;
  List<CommentsList> commentsList;

  CommentsListModel({
    required this.message,
    required this.commentsList,
  });

  factory CommentsListModel.fromJson(Map<String, dynamic> json) =>
      CommentsListModel(
        message: json["message"],
        commentsList: List<CommentsList>.from(
            json["comments_list"].map((x) => CommentsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "comments_list":
            List<dynamic>.from(commentsList.map((x) => x.toJson())),
      };
}

class CommentsList {
  int id;
  dynamic userId;
  dynamic postsId;
  String comment;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  String userName;
  String lastName;
  String designation;
  String email;
  dynamic picture;

  CommentsList({
    required this.id,
    required this.userId,
    required this.postsId,
    required this.comment,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.userName,
    required this.lastName,
    required this.designation,
    required this.email,
    required this.picture,
  });

  factory CommentsList.fromJson(Map<String, dynamic> json) => CommentsList(
        id: json["id"],
        userId: json["user_id"].toString(),
        postsId: json["posts_id"].toString(),
        comment: json["comment"],
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
        "comment": comment,
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
