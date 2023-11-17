// To parse this JSON data, do
//
//     final getAllPostModel = getAllPostModelFromJson(jsonString);

import 'dart:convert';

GetAllPostModel getAllPostModelFromJson(String str) =>
    GetAllPostModel.fromJson(json.decode(str));

String getAllPostModelToJson(GetAllPostModel data) =>
    json.encode(data.toJson());

class GetAllPostModel {
  String message;
  List<Post> posts;

  GetAllPostModel({
    required this.message,
    required this.posts,
  });

  factory GetAllPostModel.fromJson(Map<String, dynamic> json) =>
      GetAllPostModel(
        message: json["message"],
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
      };
}

class Post {
  int id;
  String title;
  DateTime createdAt;
  String body;
  PostUser user;
  int likeCount;
  bool likedByUser;
  int comment;

  Post({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.body,
    required this.user,
    required this.likeCount,
    required this.likedByUser,
    required this.comment,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"] ?? "",
        body: json["body"] ?? "",
        user: json["user"] == null
            ? PostUser(
                id: 0,
                roleId: 0,
                name: "",
                email: "",
                mobile: "",
                isVerrifiedMobile: "",
                lastName: "",
                userName: "",
                otp: "",
                keyStatus: "",
                status: "",
                createdAt: DateTime.now(),
                updatedAt: DateTime.now())
            : PostUser.fromJson(json["user"]),
        createdAt: DateTime.parse(json["created_at"]),
        likeCount: json["like_count"],
        likedByUser: json["liked_by_user"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "user": user.toJson(),
        "like_count": likeCount,
        "liked_by_user": likedByUser,
        "comment": comment,
      };
}

class PostUser {
  int id;
  dynamic roleId;
  String name;
  String email;
  String mobile;
  dynamic isVerrifiedMobile;
  String lastName;
  String userName;
  dynamic otp;
  dynamic currentCompany;
  dynamic department;
  dynamic designation;
  dynamic qualification;
  dynamic officialEmail;
  dynamic profilePicture;
  dynamic clientSecret;
  dynamic clientId;
  dynamic keyName;
  String keyStatus;
  dynamic emailVerifiedAt;
  dynamic address;
  dynamic pincode;
  dynamic city;
  dynamic state;
  dynamic status;
  DateTime createdAt;
  DateTime updatedAt;

  PostUser({
    required this.id,
    required this.roleId,
    required this.name,
    required this.email,
    required this.mobile,
    required this.isVerrifiedMobile,
    required this.lastName,
    required this.userName,
    required this.otp,
    this.currentCompany,
    this.department,
    this.designation,
    this.qualification,
    this.officialEmail,
    this.profilePicture,
    this.clientSecret,
    this.clientId,
    this.keyName,
    required this.keyStatus,
    this.emailVerifiedAt,
    this.address,
    this.pincode,
    this.city,
    this.state,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostUser.fromJson(Map<String, dynamic> json) => PostUser(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        mobile: json["mobile"],
        isVerrifiedMobile: json["is_verrified_mobile"],
        lastName: json["last_name"] ?? "",
        userName: json["user_name"],
        otp: json["otp"] ?? "",
        currentCompany: json["current_company"],
        department: json["department"],
        designation: json["designation"],
        qualification: json["qualification"],
        officialEmail: json["official_email"],
        profilePicture: json["profile_picture"],
        clientSecret: json["client_secret"],
        clientId: json["client_id"],
        keyName: json["Key_name"] ?? "",
        keyStatus: json["Key_status"] ?? "",
        emailVerifiedAt: json["email_verified_at"],
        address: json["address"],
        pincode: json["pincode"],
        city: json["city"],
        state: json["state"] ?? "",
        status: json["status"].toString(),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "email": email,
        "mobile": mobile,
        "is_verrified_mobile": isVerrifiedMobile,
        "last_name": lastName,
        "user_name": userName,
        "otp": otp,
        "current_company": currentCompany,
        "department": department,
        "designation": designation,
        "qualification": qualification,
        "official_email": officialEmail,
        "profile_picture": profilePicture,
        "client_secret": clientSecret,
        "client_id": clientId,
        "Key_name": keyName,
        "Key_status": keyStatus,
        "email_verified_at": emailVerifiedAt,
        "address": address,
        "pincode": pincode,
        "city": city,
        "state": state,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
