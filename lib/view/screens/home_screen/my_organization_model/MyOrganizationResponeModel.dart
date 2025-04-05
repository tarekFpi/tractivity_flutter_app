// To parse this JSON data, do
//
//     final myOrganizationResponeModel = myOrganizationResponeModelFromJson(jsonString);

import 'dart:convert';

MyOrganizationResponeModel myOrganizationResponeModelFromJson(String str) => MyOrganizationResponeModel.fromJson(json.decode(str));

String myOrganizationResponeModelToJson(MyOrganizationResponeModel data) => json.encode(data.toJson());

class MyOrganizationResponeModel {
  Creator? creator;
  Report? report;
  String? id;
  String? name;
  String? description;
  List<String>? connectedVolunteers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MyOrganizationResponeModel({
    this.creator,
    this.report,
    this.id,
    this.name,
    this.description,
    this.connectedVolunteers,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MyOrganizationResponeModel.fromJson(Map<String, dynamic> json) => MyOrganizationResponeModel(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    report: json["report"] == null ? null : Report.fromJson(json["report"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    connectedVolunteers: json["connectedVolunteers"] == null ? [] : List<String>.from(json["connectedVolunteers"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator?.toJson(),
    "report": report?.toJson(),
    "_id": id,
    "name": name,
    "description": description,
    "connectedVolunteers": connectedVolunteers == null ? [] : List<dynamic>.from(connectedVolunteers!.map((x) => x)),
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

class Report {
  double? hours;
  double? mileage;

  Report({
    this.hours,
    this.mileage,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    hours: json["hours"]?.toDouble(),
    mileage: json["mileage"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "hours": hours,
    "mileage": mileage,
  };
}
