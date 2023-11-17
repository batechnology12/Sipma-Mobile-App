// // To parse this JSON data, do
// //
// //     final searchPostModel = searchPostModelFromJson(jsonString);

// import 'dart:convert';

// import 'package:simpa/models/get_all_post_modals.dart';

// SearchPostModel searchPostModelFromJson(String str) =>
//     SearchPostModel.fromJson(json.decode(str));

// String searchPostModelToJson(SearchPostModel data) =>
//     json.encode(data.toJson());

// class SearchPostModel {
//   List<Post> posts;

//   SearchPostModel({
//     required this.posts,
//   });

//   factory SearchPostModel.fromJson(Map<String, dynamic> json) =>
//       SearchPostModel(
//         posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
//       };
// }

