import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

class UserInfo extends JsonSerializable {

  static var skeleton_data = UserInfo(0,"abc@mail.com", "firstName", "lastName", "123456780","displayName", "", "", false);

  final int id;
  final String email;
  final String firstName;
  final String lastName;
	final String mobilePhone;
  final String displayName;
  final String avatar;
  final String username;
  final bool isDeleted;

  UserInfo(this.id,
      this.email,
      this.firstName,
      this.lastName,
      this.mobilePhone,
      this.displayName,
      this.avatar,
      this.username,
      this.isDeleted);

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      json['id'],
      json["email"],
      json["firstName"] ?? '',
      json["lastName"] ?? '',
      json["mobilePhone"] ?? '',
      json["displayName"] ?? '',
      json["avatar"] ?? '',
      json["username"] ?? '',
      json["isDeleted"] ?? false
    );
  }

  Map<String, dynamic> toFormMap() => {
    'id' : id,
    'mobilePhone' : mobilePhone,
    'firstName' : firstName,
    'lastName' : lastName
  };
}