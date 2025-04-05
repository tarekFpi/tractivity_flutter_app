// To parse this JSON data, do
//
//     final retriveNotificationEventInviteResponeModel = retriveNotificationEventInviteResponeModelFromJson(jsonString);

import 'dart:convert';

RetriveNotificationEventInviteResponeModel retriveNotificationEventInviteResponeModelFromJson(String str) => RetriveNotificationEventInviteResponeModel.fromJson(json.decode(str));

String retriveNotificationEventInviteResponeModelToJson(RetriveNotificationEventInviteResponeModel data) => json.encode(data.toJson());

class RetriveNotificationEventInviteResponeModel {
  String? id;
  String? consumerId;
  String? type;
  String? inviterId;
  ContentId? contentId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  RetriveNotificationEventInviteResponeModel({
    this.id,
    this.consumerId,
    this.type,
    this.inviterId,
    this.contentId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RetriveNotificationEventInviteResponeModel.fromJson(Map<String, dynamic> json) => RetriveNotificationEventInviteResponeModel(
    id: json["_id"],
    consumerId: json["consumerId"],
    type: json["type"],
    inviterId: json["inviterId"],
    contentId: json["contentId"] == null ? null : ContentId.fromJson(json["contentId"]),
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "consumerId": consumerId,
    "type": type,
    "inviterId": inviterId,
    "contentId": contentId?.toJson(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ContentId {
  ContentIdCreator? creator;
  Address? address;
  Cords? cords;
  Report? report;
  String? id;
  MissionId? missionId;
  String? name;
  String? description;
  List<String>? images;
  List<String>? documents;
  String? startTime;
  String? endTime;
  DateTime? date;
  String? mode;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ContentId({
    this.creator,
    this.address,
    this.cords,
    this.report,
    this.id,
    this.missionId,
    this.name,
    this.description,
    this.images,
    this.documents,
    this.startTime,
    this.endTime,
    this.date,
    this.mode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ContentId.fromJson(Map<String, dynamic> json) => ContentId(
    creator: json["creator"] == null ? null : ContentIdCreator.fromJson(json["creator"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    cords: json["cords"] == null ? null : Cords.fromJson(json["cords"]),
    report: json["report"] == null ? null : Report.fromJson(json["report"]),
    id: json["_id"],
    missionId: json["missionId"] == null ? null : MissionId.fromJson(json["missionId"]),
    name: json["name"],
    description: json["description"],
    images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
    documents: json["documents"] == null ? [] : List<String>.from(json["documents"]!.map((x) => x)),
    startTime: json["startTime"],
    endTime: json["endTime"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    mode: json["mode"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator?.toJson(),
    "address": address?.toJson(),
    "cords": cords?.toJson(),
    "report": report?.toJson(),
    "_id": id,
    "missionId": missionId?.toJson(),
    "name": name,
    "description": description,
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x)),
    "startTime": startTime,
    "endTime": endTime,
    "date": date?.toIso8601String(),
    "mode": mode,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Address {
  String? state;
  String? city;
  String? zip;

  Address({
    this.state,
    this.city,
    this.zip,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    state: json["state"],
    city: json["city"],
    zip: json["zip"],
  );

  Map<String, dynamic> toJson() => {
    "state": state,
    "city": city,
    "zip": zip,
  };
}

class Cords {
  double? lat;
  double? lng;

  Cords({
    this.lat,
    this.lng,
  });

  factory Cords.fromJson(Map<String, dynamic> json) => Cords(
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class ContentIdCreator {
  String? creatorId;
  String? name;
  String? creatorRole;
  bool? isActive;

  ContentIdCreator({
    this.creatorId,
    this.name,
    this.creatorRole,
    this.isActive,
  });

  factory ContentIdCreator.fromJson(Map<String, dynamic> json) => ContentIdCreator(
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

class MissionId {
  String? id;
  String? name;
  List<ConnectedOrganization>? connectedOrganizations;
  List<ConnectedOrganizer>? connectedOrganizers;

  MissionId({
    this.id,
    this.name,
    this.connectedOrganizations,
    this.connectedOrganizers,
  });

  factory MissionId.fromJson(Map<String, dynamic> json) => MissionId(
    id: json["_id"],
    name: json["name"],
    connectedOrganizations: json["connectedOrganizations"] == null ? [] : List<ConnectedOrganization>.from(json["connectedOrganizations"]!.map((x) => ConnectedOrganization.fromJson(x))),
    connectedOrganizers: json["connectedOrganizers"] == null ? [] : List<ConnectedOrganizer>.from(json["connectedOrganizers"]!.map((x) => ConnectedOrganizer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "connectedOrganizations": connectedOrganizations == null ? [] : List<dynamic>.from(connectedOrganizations!.map((x) => x.toJson())),
    "connectedOrganizers": connectedOrganizers == null ? [] : List<dynamic>.from(connectedOrganizers!.map((x) => x.toJson())),
  };
}

class ConnectedOrganization {
  ConnectedOrganizationCreator? creator;
  String? id;
  String? name;

  ConnectedOrganization({
    this.creator,
    this.id,
    this.name,
  });

  factory ConnectedOrganization.fromJson(Map<String, dynamic> json) => ConnectedOrganization(
    creator: json["creator"] == null ? null : ConnectedOrganizationCreator.fromJson(json["creator"]),
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator?.toJson(),
    "_id": id,
    "name": name,
  };
}

class ConnectedOrganizationCreator {
  String? creatorRole;

  ConnectedOrganizationCreator({
    this.creatorRole,
  });

  factory ConnectedOrganizationCreator.fromJson(Map<String, dynamic> json) => ConnectedOrganizationCreator(
    creatorRole: json["creatorRole"],
  );

  Map<String, dynamic> toJson() => {
    "creatorRole": creatorRole,
  };
}

class ConnectedOrganizer {
  String? id;
  String? fullName;
  String? image;

  ConnectedOrganizer({
    this.id,
    this.fullName,
    this.image,
  });

  factory ConnectedOrganizer.fromJson(Map<String, dynamic> json) => ConnectedOrganizer(
    id: json["_id"],
    fullName: json["fullName"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "image": image,
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
