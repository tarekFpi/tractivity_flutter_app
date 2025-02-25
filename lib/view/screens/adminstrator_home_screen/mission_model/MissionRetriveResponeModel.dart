// To parse this JSON data, do
//
//     final missionRetriveResponeModel = missionRetriveResponeModelFromJson(jsonString);

import 'dart:convert';

MissionRetriveResponeModel missionRetriveResponeModelFromJson(String str) => MissionRetriveResponeModel.fromJson(json.decode(str));

String missionRetriveResponeModelToJson(MissionRetriveResponeModel data) => json.encode(data.toJson());

class MissionRetriveResponeModel {
  String? id;
  String? name;
  String? description;
  List<ConnectedOrganizer>? connectedOrganizers;
  String? mode;
  DateTime? updatedAt;

  MissionRetriveResponeModel({
    this.id,
    this.name,
    this.description,
    this.connectedOrganizers,
    this.mode,
    this.updatedAt,
  });

  factory MissionRetriveResponeModel.fromJson(Map<String, dynamic> json) => MissionRetriveResponeModel(
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    connectedOrganizers: json["connectedOrganizers"] == null ? [] : List<ConnectedOrganizer>.from(json["connectedOrganizers"]!.map((x) => ConnectedOrganizer.fromJson(x))),
    mode: json["mode"],
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "connectedOrganizers": connectedOrganizers == null ? [] : List<dynamic>.from(connectedOrganizers!.map((x) => x.toJson())),
    "mode": mode,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class ConnectedOrganizer {
  String? id;
  String? fullName;

  ConnectedOrganizer({
    this.id,
    this.fullName,
  });

  factory ConnectedOrganizer.fromJson(Map<String, dynamic> json) => ConnectedOrganizer(
    id: json["_id"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
  };
}
