// To parse this JSON data, do
//
//     final specificIdEventsResponeModel = specificIdEventsResponeModelFromJson(jsonString);

import 'dart:convert';

SpecificIdEventsResponeModel specificIdEventsResponeModelFromJson(String str) => SpecificIdEventsResponeModel.fromJson(json.decode(str));

String specificIdEventsResponeModelToJson(SpecificIdEventsResponeModel data) => json.encode(data.toJson());

class SpecificIdEventsResponeModel {
  Creator? creator;
  Cords? cords;
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
  List<EdVolunteer>? invitedVolunteer;
  List<EdVolunteer>? joinedVolunteer;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  SpecificIdEventsResponeModel({
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
    this.invitedVolunteer,
    this.joinedVolunteer,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory SpecificIdEventsResponeModel.fromJson(Map<String, dynamic> json) => SpecificIdEventsResponeModel(
    creator: json["creator"] == null ? null : Creator.fromJson(json["creator"]),
    cords: json["cords"] == null ? null : Cords.fromJson(json["cords"]),
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
    invitedVolunteer: json["invitedVolunteer"] == null ? [] : List<EdVolunteer>.from(json["invitedVolunteer"]!.map((x) => EdVolunteer.fromJson(x))),
    joinedVolunteer: json["joinedVolunteer"] == null ? [] : List<EdVolunteer>.from(json["joinedVolunteer"]!.map((x) => EdVolunteer.fromJson(x))),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "creator": creator?.toJson(),
    "cords": cords?.toJson(),
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
    "invitedVolunteer": invitedVolunteer == null ? [] : List<dynamic>.from(invitedVolunteer!.map((x) => x.toJson())),
    "joinedVolunteer": joinedVolunteer == null ? [] : List<dynamic>.from(joinedVolunteer!.map((x) => x.toJson())),
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

class EdVolunteer {
  StartInfo? startInfo;
  Volunteer? volunteer;
  String? workTitle;
  String? workStatus;
  int? totalWorkedHour;
  String? id;

  EdVolunteer({
    this.startInfo,
    this.volunteer,
    this.workTitle,
    this.workStatus,
    this.totalWorkedHour,
    this.id,
  });

  factory EdVolunteer.fromJson(Map<String, dynamic> json) => EdVolunteer(
    startInfo: json["startInfo"] == null ? null : StartInfo.fromJson(json["startInfo"]),
    volunteer: json["volunteer"] == null ? null : Volunteer.fromJson(json["volunteer"]),
    workTitle: json["workTitle"],
    workStatus: json["workStatus"],
    totalWorkedHour: json["totalWorkedHour"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "startInfo": startInfo?.toJson(),
    "volunteer": volunteer?.toJson(),
    "workTitle": workTitle,
    "workStatus": workStatus,
    "totalWorkedHour": totalWorkedHour,
    "_id": id,
  };
}

class StartInfo {
  bool? isStart;

  StartInfo({
    this.isStart,
  });

  factory StartInfo.fromJson(Map<String, dynamic> json) => StartInfo(
    isStart: json["isStart"],
  );

  Map<String, dynamic> toJson() => {
    "isStart": isStart,
  };
}

class Volunteer {
  String? id;
  String? fullName;
  String? profession;
  String? image;

  Volunteer({
    this.id,
    this.fullName,
    this.profession,
    this.image,
  });

  factory Volunteer.fromJson(Map<String, dynamic> json) => Volunteer(
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

class MissionId {
  String? id;
  String? name;
  List<ConnectedOrganization>? connectedOrganizations;
  List<Volunteer>? connectedOrganizers;

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
    connectedOrganizers: json["connectedOrganizers"] == null ? [] : List<Volunteer>.from(json["connectedOrganizers"]!.map((x) => Volunteer.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "connectedOrganizations": connectedOrganizations == null ? [] : List<dynamic>.from(connectedOrganizations!.map((x) => x.toJson())),
    "connectedOrganizers": connectedOrganizers == null ? [] : List<dynamic>.from(connectedOrganizers!.map((x) => x.toJson())),
  };
}

class ConnectedOrganization {
  String? id;
  String? name;

  ConnectedOrganization({
    this.id,
    this.name,
  });

  factory ConnectedOrganization.fromJson(Map<String, dynamic> json) => ConnectedOrganization(
    id: json["_id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
  };
}
