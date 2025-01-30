// To parse this JSON data, do
//
//     final userProfileResponeModel = userProfileResponeModelFromJson(jsonString);

import 'dart:convert';

UserProfileResponeModel userProfileResponeModelFromJson(String str) => UserProfileResponeModel.fromJson(json.decode(str));

String userProfileResponeModelToJson(UserProfileResponeModel data) => json.encode(data.toJson());

class UserProfileResponeModel {
  Verification? verification;
  Cords? cords;
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? profession;
  bool? isEmailVerified;
  List<String>? roles;
  String? status;
  String? image;
  String? address;
  bool? isSocial;
  dynamic fcmToken;
  dynamic totalVolunteeHours;
  dynamic topDistance;
  String? role;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  UserProfileResponeModel({
    this.verification,
    this.cords,
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.profession,
    this.isEmailVerified,
    this.roles,
    this.status,
    this.image,
    this.address,
    this.isSocial,
    this.fcmToken,
    this.totalVolunteeHours,
    this.topDistance,
    this.role,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory UserProfileResponeModel.fromJson(Map<String, dynamic> json) => UserProfileResponeModel(
    verification: json["verification"] == null ? null : Verification.fromJson(json["verification"]),
    cords: json["cords"] == null ? null : Cords.fromJson(json["cords"]),
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    phone: json["phone"],
    profession: json["profession"],
    isEmailVerified: json["isEmailVerified"],
    roles: json["roles"] == null ? [] : List<String>.from(json["roles"]!.map((x) => x)),
    status: json["status"],
    image: json["image"],
    address: json["address"],
    isSocial: json["isSocial"],
    fcmToken: json["fcmToken"],
    totalVolunteeHours: json["totalVolunteeHours"],
    topDistance: json["topDistance"],
    role: json["role"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "verification": verification?.toJson(),
    "cords": cords?.toJson(),
    "_id": id,
    "fullName": fullName,
    "email": email,
    "phone": phone,
    "profession": profession,
    "isEmailVerified": isEmailVerified,
    "roles": roles == null ? [] : List<dynamic>.from(roles!.map((x) => x)),
    "status": status,
    "image": image,
    "address": address,
    "isSocial": isSocial,
    "fcmToken": fcmToken,
    "totalVolunteeHours": totalVolunteeHours,
    "topDistance": topDistance,
    "role": role,
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

class Verification {
  String? code;
  DateTime? expireDate;

  Verification({
    this.code,
    this.expireDate,
  });

  factory Verification.fromJson(Map<String, dynamic> json) => Verification(
    code: json["code"],
    expireDate: json["expireDate"] == null ? null : DateTime.parse(json["expireDate"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "expireDate": expireDate?.toIso8601String(),
  };
}
