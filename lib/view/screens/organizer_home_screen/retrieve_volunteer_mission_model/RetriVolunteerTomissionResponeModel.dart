// To parse this JSON data, do
//
//     final retriVolunteerTomissionResponeModel = retriVolunteerTomissionResponeModelFromJson(jsonString);

import 'dart:convert';

RetriVolunteerTomissionResponeModel retriVolunteerTomissionResponeModelFromJson(String str) => RetriVolunteerTomissionResponeModel.fromJson(json.decode(str));

String retriVolunteerTomissionResponeModelToJson(RetriVolunteerTomissionResponeModel data) => json.encode(data.toJson());

class RetriVolunteerTomissionResponeModel {
  String? fullName;
  String? profession;
  String? image;
  String? id;

  RetriVolunteerTomissionResponeModel({
    this.fullName,
    this.profession,
    this.image,
    this.id,
  });

  factory RetriVolunteerTomissionResponeModel.fromJson(Map<String, dynamic> json) => RetriVolunteerTomissionResponeModel(
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
