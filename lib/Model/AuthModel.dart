// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  AuthModel({
    this.name,
    this.email,
    this.uid,
    this.cover,
    this.image,
    this.bio,
  });

  String name;
  String email;
  String uid;
  String cover;
  String image;
  String bio;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        name: json["name"],
        email: json["email"],
        uid: json["uid"],
        cover: json["cover"],
        image: json["image"],
        bio: json["bio"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "uid": uid,
        "cover": cover,
        "image": image,
        "bio": bio,
      };
}
