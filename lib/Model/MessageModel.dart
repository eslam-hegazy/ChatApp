// To parse this JSON data, do
//
//     final messageModel = messageModelFromJson(jsonString);

import 'dart:convert';

MessageModel messageModelFromJson(String str) =>
    MessageModel.fromJson(json.decode(str));

String messageModelToJson(MessageModel data) => json.encode(data.toJson());

class MessageModel {
  MessageModel({
    this.sendId,
    this.reciveId,
    this.dataTime,
    this.text,
  });

  String sendId;
  String reciveId;
  String dataTime;
  String text;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        sendId: json["sendId"],
        reciveId: json["reciveId"],
        dataTime: json["dataTime"],
        text: json["Text"],
      );

  Map<String, dynamic> toJson() => {
        "sendId": sendId,
        "reciveId": reciveId,
        "dataTime": dataTime,
        "Text": text,
      };
}
