// To parse this JSON data, do
//
//     final organizationResponeModel = organizationResponeModelFromJson(jsonString);

import 'dart:convert';

OrganizationResponeModel organizationResponeModelFromJson(String str) => OrganizationResponeModel.fromJson(json.decode(str));

String organizationResponeModelToJson(OrganizationResponeModel data) => json.encode(data.toJson());

class OrganizationResponeModel {
  Creator? creator;
  String? id;
  String? name;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  OrganizationResponeModel({
    this.creator,
    this.id,
    this.name,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory OrganizationResponeModel.fromJson(Map<String, dynamic> json) => OrganizationResponeModel(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator?.toJson(),
    "_id": id,
    "name": name,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Creator {
  String? creatorId;
  String? name;
  String? creatorRole;
  bool? isActive;

  Creator({
    this.creatorId,
    this.name,
    this.creatorRole,
    this.isActive,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    creatorId: json["creatorId"],
    name: json["name"],
    creatorRole: json["creatorRole"],
    isActive: json["isActive"],
  );

  Map<String, dynamic> toJson() => {
    "creatorId": creatorId,
    "name": name,
    "creatorRole": creatorRole,
    "isActive": isActive,
  };
}
