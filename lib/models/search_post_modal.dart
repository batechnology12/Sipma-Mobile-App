// To parse this JSON data, do
//
//     final searchPostModal = searchPostModalFromJson(jsonString);

import 'dart:convert';

SearchPostModal searchPostModalFromJson(String str) =>
    SearchPostModal.fromJson(json.decode(str));

String searchPostModalToJson(SearchPostModal data) =>
    json.encode(data.toJson());

class SearchPostModal {
  List<SearchPost> posts;

  SearchPostModal({
    required this.posts,
  });

  factory SearchPostModal.fromJson(Map<String, dynamic> json) =>
      SearchPostModal(
        posts: List<SearchPost>.from(
            json["posts"].map((x) => SearchPost.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class SearchPost {
  int id;
  dynamic userId;
  String title;
  String description;
  dynamic status;
  String mediaUrl;
  dynamic departmentId;
  String type;
  DateTime createdAt;
  DateTime updatedAt;

  SearchPost({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.status,
    required this.mediaUrl,
    required this.departmentId,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SearchPost.fromJson(Map<String, dynamic> json) => SearchPost(
        id: json["id"],
        userId: json["user_id"].toString(),
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        status: json["status"].toString(),
        mediaUrl: json["media_url"] ?? "",
        departmentId: json["department_id"].toString(),
        type: json["type"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "status": status,
        "media_url": mediaUrl,
        "department_id": departmentId,
        "type": type,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
