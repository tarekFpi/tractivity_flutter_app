// To parse this JSON data, do
//
//     final requestFriendsResponeModel = requestFriendsResponeModelFromJson(jsonString);

import 'dart:convert';

RequestFriendsResponeModel requestFriendsResponeModelFromJson(String str) => RequestFriendsResponeModel.fromJson(json.decode(str));

String requestFriendsResponeModelToJson(RequestFriendsResponeModel data) => json.encode(data.toJson());

class RequestFriendsResponeModel {
  Requester? requester;
  Responder? responder;
  String? id;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  RequestFriendsResponeModel({
    this.requester,
    this.responder,
    this.id,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory RequestFriendsResponeModel.fromJson(Map<String, dynamic> json) => RequestFriendsResponeModel(
    requester: json["requester"] == null ? null : Requester.fromJson(json["requester"]),
    responder: json["responder"] == null ? null : Responder.fromJson(json["responder"]),
    id: json["_id"],
    status: json["status"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "requester": requester?.toJson(),
    "responder": responder?.toJson(),
    "_id": id,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Requester {
  ErId? requesterId;
  String? name;

  Requester({
    this.requesterId,
    this.name,
  });

  factory Requester.fromJson(Map<String, dynamic> json) => Requester(
    requesterId: json["requesterId"] == null ? null : ErId.fromJson(json["requesterId"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "requesterId": requesterId?.toJson(),
    "name": name,
  };
}

class ErId {
  String? id;
  String? fullName;
  String? profession;
  String? image;

  ErId({
    this.id,
    this.fullName,
    this.profession,
    this.image,
  });

  factory ErId.fromJson(Map<String, dynamic> json) => ErId(
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

class Responder {
  ErId? responderId;
  String? name;

  Responder({
    this.responderId,
    this.name,
  });

  factory Responder.fromJson(Map<String, dynamic> json) => Responder(
    responderId: json["responderId"] == null ? null : ErId.fromJson(json["responderId"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "responderId": responderId?.toJson(),
    "name": name,
  };
}
