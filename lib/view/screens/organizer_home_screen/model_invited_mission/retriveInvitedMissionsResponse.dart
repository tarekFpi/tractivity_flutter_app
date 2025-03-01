// To parse this JSON data, do
//
//     final retriveInvitedMissionsResponse = retriveInvitedMissionsResponseFromJson(jsonString);

import 'dart:convert';

RetriveInvitedMissionsResponse retriveInvitedMissionsResponseFromJson(String str) => RetriveInvitedMissionsResponse.fromJson(json.decode(str));

String retriveInvitedMissionsResponseToJson(RetriveInvitedMissionsResponse data) => json.encode(data.toJson());

class RetriveInvitedMissionsResponse {
  String? id;
  String? consumerId;
  String? type;
  InviterId? inviterId;
  ContentId? contentId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  RetriveInvitedMissionsResponse({
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

  factory RetriveInvitedMissionsResponse.fromJson(Map<String, dynamic> json) => RetriveInvitedMissionsResponse(
    id: json["_id"],
    consumerId: json["consumerId"],
    type: json["type"],
    inviterId: json["inviterId"] == null ? null : InviterId.fromJson(json["inviterId"]),
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
    "inviterId": inviterId?.toJson(),
    "contentId": contentId?.toJson(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class ContentId {
  Creator? creator;
  String? id;
  String? name;
  String? description;
  DateTime? createdAt;

  ContentId({
    this.creator,
    this.id,
    this.name,
    this.description,
    this.createdAt,
  });

  factory ContentId.fromJson(Map<String, dynamic> json) => ContentId(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    id: json["_id"],
    name: json["name"],
    description: json["description"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "creator": creator?.toJson(),
    "_id": id,
    "name": name,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Creator {
  String? creatorRole;

  Creator({
    this.creatorRole,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    creatorRole: json["creatorRole"],
  );

  Map<String, dynamic> toJson() => {
    "creatorRole": creatorRole,
  };
}

class InviterId {
  String? id;
  String? fullName;
  String? image;

  InviterId({
    this.id,
    this.fullName,
    this.image,
  });

  factory InviterId.fromJson(Map<String, dynamic> json) => InviterId(
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
