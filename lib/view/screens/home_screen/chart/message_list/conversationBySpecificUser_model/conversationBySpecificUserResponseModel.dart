// To parse this JSON data, do
//
//     final conversationBySpecificUserResponseModel = conversationBySpecificUserResponseModelFromJson(jsonString);

import 'dart:convert';

ConversationBySpecificUserResponseModel conversationBySpecificUserResponseModelFromJson(String str) => ConversationBySpecificUserResponseModel.fromJson(json.decode(str));

String conversationBySpecificUserResponseModelToJson(ConversationBySpecificUserResponseModel data) => json.encode(data.toJson());

class ConversationBySpecificUserResponseModel {
  Sender? sender;
  Receiver? receiver;
  String? id;
  String? type;
  LastMessage? lastMessage;
  int? memberCounts;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<String>? conversationMembers;

  ConversationBySpecificUserResponseModel({
    this.sender,
    this.receiver,
    this.id,
    this.type,
    this.lastMessage,
    this.memberCounts,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.conversationMembers,
  });

  factory ConversationBySpecificUserResponseModel.fromJson(Map<String, dynamic> json) => ConversationBySpecificUserResponseModel(
    sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    id: json["_id"],
    type: json["type"],
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    memberCounts: json["memberCounts"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    conversationMembers: json["conversationMembers"] == null ? [] : List<String>.from(json["conversationMembers"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
    "_id": id,
    "type": type,
    "lastMessage": lastMessage?.toJson(),
    "memberCounts": memberCounts,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "conversationMembers": conversationMembers == null ? [] : List<dynamic>.from(conversationMembers!.map((x) => x)),
  };
}

class LastMessage {
  String? id;
  String? conversation;
  String? sender;
  String? type;
  String? content;
  List<dynamic>? attachment;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LastMessage({
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

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    id: json["_id"],
    conversation: json["conversation"],
    sender: json["sender"],
    type: json["type"],
    content: json["content"],
    attachment: json["attachment"] == null ? [] : List<dynamic>.from(json["attachment"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "conversation": conversation,
    "sender": sender,
    "type": type,
    "content": content,
    "attachment": attachment == null ? [] : List<dynamic>.from(attachment!.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class Receiver {
  String? name;
  ErId? receiverId;

  Receiver({
    this.name,
    this.receiverId,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    name: json["name"],
    receiverId: json["receiverId"] == null ? null : ErId.fromJson(json["receiverId"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "receiverId": receiverId?.toJson(),
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

class Sender {
  String? name;
  ErId? senderId;

  Sender({
    this.name,
    this.senderId,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    name: json["name"],
    senderId: json["senderId"] == null ? null : ErId.fromJson(json["senderId"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "senderId": senderId?.toJson(),
  };
}
