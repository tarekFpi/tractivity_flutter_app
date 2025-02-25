// To parse this JSON data, do
//
//     final missionRetriveResponeModel = missionRetriveResponeModelFromJson(jsonString);

import 'dart:convert';

MissionRetriveResponeModel missionRetriveResponeModelFromJson(String str) => MissionRetriveResponeModel.fromJson(json.decode(str));

String missionRetriveResponeModelToJson(MissionRetriveResponeModel data) => json.encode(data.toJson());

class MissionRetriveResponeModel {
  Creator? creator;
  String? id;
  String? name;
  String? description;
  List<String>? connectedOrganizations;
  List<String>? requestedOrganizers;
  List<dynamic>? connectedOrganizers;
  DateTime? updatedAt;
  int? v;

  MissionRetriveResponeModel({
    this.creator,
    this.id,
    this.name,
    this.description,
    this.connectedOrganizations,
    this.requestedOrganizers,
    this.connectedOrganizers,
    this.updatedAt,
    this.v,
  });

  factory MissionRetriveResponeModel.fromJson(Map<String, dynamic> json) => MissionRetriveResponeModel(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    connectedOrganizations: json["connectedOrganizations"] == null ? [] : List<String>.from(json["connectedOrganizations"]!.map((x) => x)),
    requestedOrganizers: json["requestedOrganizers"] == null ? [] : List<String>.from(json["requestedOrganizers"]!.map((x) => x)),
    connectedOrganizers: json["connectedOrganizers"] == null ? [] : List<dynamic>.from(json["connectedOrganizers"]!.map((x) => x)),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator?.toJson(),
    "_id": id,
    "name": name,
    "description": description,
    "connectedOrganizations": connectedOrganizations == null ? [] : List<dynamic>.from(connectedOrganizations!.map((x) => x)),
    "requestedOrganizers": requestedOrganizers == null ? [] : List<dynamic>.from(requestedOrganizers!.map((x) => x)),
    "connectedOrganizers": connectedOrganizers == null ? [] : List<dynamic>.from(connectedOrganizers!.map((x) => x)),
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
