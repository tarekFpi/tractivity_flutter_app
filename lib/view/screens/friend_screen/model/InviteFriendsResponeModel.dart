// To parse this JSON data, do
//
//     final inviteFriendsResponeModel = inviteFriendsResponeModelFromJson(jsonString);

import 'dart:convert';

InviteFriendsResponeModel inviteFriendsResponeModelFromJson(String str) => InviteFriendsResponeModel.fromJson(json.decode(str));

String inviteFriendsResponeModelToJson(InviteFriendsResponeModel data) => json.encode(data.toJson());

class InviteFriendsResponeModel {
  String? id;
  String? fullName;
  String? profession;
  String? image;

  InviteFriendsResponeModel({
    this.id,
    this.fullName,
    this.profession,
    this.image,
  });

  factory InviteFriendsResponeModel.fromJson(Map<String, dynamic> json) => InviteFriendsResponeModel(
    id: json["_id"],
    fullName: json["fullName"],
    profession: json["profession"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "profession": profession,
    "image": image,
  };
}
