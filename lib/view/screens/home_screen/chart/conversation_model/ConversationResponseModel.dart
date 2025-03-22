// To parse this JSON data, do
//
//     final conversationResponseModel = conversationResponseModelFromJson(jsonString);

import 'dart:convert';

ConversationResponseModel conversationResponseModelFromJson(String str) => ConversationResponseModel.fromJson(json.decode(str));

String conversationResponseModelToJson(ConversationResponseModel data) => json.encode(data.toJson());

class ConversationResponseModel {
  Sender? sender;
  Receiver? receiver;
  String? type;
  dynamic lastMessage;
  int? memberCounts;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ConversationResponseModel({
    this.sender,
    this.receiver,
    this.type,
    this.lastMessage,
    this.memberCounts,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ConversationResponseModel.fromJson(Map<String, dynamic> json) => ConversationResponseModel(
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    type: json["type"],
    lastMessage: json["lastMessage"],
    memberCounts: json["memberCounts"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
    "type": type,
    "lastMessage": lastMessage,
    "memberCounts": memberCounts,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Receiver {
  String? name;
  String? receiverId;

  Receiver({
    this.name,
    this.receiverId,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    name: json["name"],
    receiverId: json["receiverId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "receiverId": receiverId,
  };
}

class Sender {
  String? name;
  String? senderId;

  Sender({
    this.name,
    this.senderId,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    name: json["name"],
    senderId: json["senderId"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "senderId": senderId,
  };
}
