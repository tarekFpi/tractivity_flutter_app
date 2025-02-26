// To parse this JSON data, do
//
//     final eventsRetriveResponeModel = eventsRetriveResponeModelFromJson(jsonString);

import 'dart:convert';

retriveSpecificMissionByMissionResponeModel eventsRetriveResponeModelFromJson(String str) => retriveSpecificMissionByMissionResponeModel.fromJson(json.decode(str));

String eventsRetriveResponeModelToJson(retriveSpecificMissionByMissionResponeModel data) => json.encode(data.toJson());

class retriveSpecificMissionByMissionResponeModel {
  Creator? creator;
  Report? report;
  String? id;
  String? name;
  String? description;
  List<ConnectedOrganization>? connectedOrganizations;
  List<dynamic>? requestedOrganizers;
  List<ConnectedOrganizer>? connectedOrganizers;
  List<dynamic>? requestedVolunteers;
  List<dynamic>? connectedVolunteers;
  String? mode;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  retriveSpecificMissionByMissionResponeModel({
    this.creator,
    this.report,
    this.id,
    this.name,
    this.description,
    this.connectedOrganizations,
    this.requestedOrganizers,
    this.connectedOrganizers,
    this.requestedVolunteers,
    this.connectedVolunteers,
    this.mode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory retriveSpecificMissionByMissionResponeModel.fromJson(Map<String, dynamic> json) => retriveSpecificMissionByMissionResponeModel(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    report: json["report"] == null ? null : Report.fromJson(json["report"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    connectedOrganizations: json["connectedOrganizations"] == null ? [] : List<ConnectedOrganization>.from(json["connectedOrganizations"]!.map((x) => ConnectedOrganization.fromJson(x))),
    requestedOrganizers: json["requestedOrganizers"] == null ? [] : List<dynamic>.from(json["requestedOrganizers"]!.map((x) => x)),
    connectedOrganizers: json["connectedOrganizers"] == null ? [] : List<ConnectedOrganizer>.from(json["connectedOrganizers"]!.map((x) => ConnectedOrganizer.fromJson(x))),
    requestedVolunteers: json["requestedVolunteers"] == null ? [] : List<dynamic>.from(json["requestedVolunteers"]!.map((x) => x)),
    connectedVolunteers: json["connectedVolunteers"] == null ? [] : List<dynamic>.from(json["connectedVolunteers"]!.map((x) => x)),
    mode: json["mode"],
    status: json["status"],
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
    "connectedOrganizations": connectedOrganizations == null ? [] : List<dynamic>.from(connectedOrganizations!.map((x) => x.toJson())),
    "requestedOrganizers": requestedOrganizers == null ? [] : List<dynamic>.from(requestedOrganizers!.map((x) => x)),
    "connectedOrganizers": connectedOrganizers == null ? [] : List<dynamic>.from(connectedOrganizers!.map((x) => x.toJson())),
    "requestedVolunteers": requestedVolunteers == null ? [] : List<dynamic>.from(requestedVolunteers!.map((x) => x)),
    "connectedVolunteers": connectedVolunteers == null ? [] : List<dynamic>.from(connectedVolunteers!.map((x) => x)),
    "mode": mode,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ConnectedOrganization {
  Creator? creator;
  Report? report;
  String? id;
  String? name;
  String? description;
  List<dynamic>? connectedVolunteers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ConnectedOrganization({
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

  factory ConnectedOrganization.fromJson(Map<String, dynamic> json) => ConnectedOrganization(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    report: json["report"] == null ? null : Report.fromJson(json["report"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    connectedVolunteers: json["connectedVolunteers"] == null ? [] : List<dynamic>.from(json["connectedVolunteers"]!.map((x) => x)),
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
  int? hours;
  int? mileage;

  Report({
    this.hours,
    this.mileage,
  });

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    hours: json["hours"],
    mileage: json["mileage"],
  );

  Map<String, dynamic> toJson() => {
    "hours": hours,
    "mileage": mileage,
  };
}

class ConnectedOrganizer {
  String? id;
  String? fullName;
  String? profession;
  String? image;

  ConnectedOrganizer({
    this.id,
    this.fullName,
    this.profession,
    this.image,
  });

  factory ConnectedOrganizer.fromJson(Map<String, dynamic> json) => ConnectedOrganizer(
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
