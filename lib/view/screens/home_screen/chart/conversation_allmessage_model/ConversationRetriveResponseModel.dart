// To parse this JSON data, do
//
//     final conversationRetriveResponseModel = conversationRetriveResponseModelFromJson(jsonString);

import 'dart:convert';

ConversationRetriveResponseModel conversationRetriveResponseModelFromJson(String str) => ConversationRetriveResponseModel.fromJson(json.decode(str));

String conversationRetriveResponseModelToJson(ConversationRetriveResponseModel data) => json.encode(data.toJson());

class ConversationRetriveResponseModel {
  String? id;
  String? conversation;
  Sender? sender;
  String? type;
  String? content;
  List<String>? attachment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ConversationRetriveResponseModel({
    this.id,
    this.conversation,
    this.sender,
    this.type,
    this.content,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ConversationRetriveResponseModel.fromJson(Map<String, dynamic> json) => ConversationRetriveResponseModel(
    id: json["_id"],
    conversation: json["conversation"],
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    type: json["type"],
    content: json["content"],
    attachment: json["attachment"] == null ? [] : List<String>.from(json["attachment"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "conversation": conversation,
    "sender": sender?.toJson(),
    "type": type,
    "content": content,
    "attachment": attachment == null ? [] : List<dynamic>.from(attachment!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Sender {
  String? id;
  String? fullName;
  String? image;

  Sender({
    this.id,
    this.fullName,
    this.image,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
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
