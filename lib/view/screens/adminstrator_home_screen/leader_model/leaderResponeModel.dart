// To parse this JSON data, do
//
//     final leaderResponeModel = leaderResponeModelFromJson(jsonString);

import 'dart:convert';

LeaderResponeModel leaderResponeModelFromJson(String str) => LeaderResponeModel.fromJson(json.decode(str));

String leaderResponeModelToJson(LeaderResponeModel data) => json.encode(data.toJson());

class LeaderResponeModel {
  String? id;
  String? fullName;
  String? image;
  String? profession;

  LeaderResponeModel({
    this.id,
    this.fullName,
    this.image,
    this.profession,
  });

  factory LeaderResponeModel.fromJson(Map<String, dynamic> json) => LeaderResponeModel(
    id: json["_id"],
    fullName: json["fullName"],
    image: json["image"],
    profession: json["profession"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "image": image,
    "profession": profession,
  };
}
