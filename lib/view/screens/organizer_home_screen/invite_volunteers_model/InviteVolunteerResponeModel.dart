// To parse this JSON data, do
//
//     final inviteVolunteerResponeModel = inviteVolunteerResponeModelFromJson(jsonString);

import 'dart:convert';

InviteVolunteerResponeModel inviteVolunteerResponeModelFromJson(String str) => InviteVolunteerResponeModel.fromJson(json.decode(str));

String inviteVolunteerResponeModelToJson(InviteVolunteerResponeModel data) => json.encode(data.toJson());

class InviteVolunteerResponeModel {
  String? fullName;
  String? profession;
  String? image;
  String? id;

  InviteVolunteerResponeModel({
    this.fullName,
    this.profession,
    this.image,
    this.id,
  });

  factory InviteVolunteerResponeModel.fromJson(Map<String, dynamic> json) => InviteVolunteerResponeModel(
    fullName: json["fullName"],
    profession: json["profession"],
    image: json["image"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "profession": profession,
    "image": image,
    "_id": id,
  };
}
