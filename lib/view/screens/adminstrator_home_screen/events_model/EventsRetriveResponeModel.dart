// To parse this JSON data, do
//
//     final eventsRetriveResponeModel = eventsRetriveResponeModelFromJson(jsonString);

import 'dart:convert';

EventsRetriveResponeModel eventsRetriveResponeModelFromJson(String str) => EventsRetriveResponeModel.fromJson(json.decode(str));

String eventsRetriveResponeModelToJson(EventsRetriveResponeModel data) => json.encode(data.toJson());

class EventsRetriveResponeModel {
  Creator? creator;
  Cords? cords;
  String? id;
  String? missionId;
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

  EventsRetriveResponeModel({
    this.creator,
    this.cords,
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

  factory EventsRetriveResponeModel.fromJson(Map<String, dynamic> json) => EventsRetriveResponeModel(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    cords: json["cords"] == null ? null : Cords.fromJson(json["cords"]),
    id: json["_id"],
    missionId: json["missionId"],
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
    "cords": cords?.toJson(),
    "_id": id,
    "missionId": missionId,
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
