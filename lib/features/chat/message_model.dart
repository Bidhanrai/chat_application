import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final String senderId;
  final String receiverId;
  final String receiverName;
  final Timestamp createdAt;

  MessageModel(
      {required this.receiverId,
      required this.message,
      required this.createdAt,
      required this.receiverName,
      required this.senderId});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      receiverId: json["receiverId"],
      receiverName: json["receiverName"],
      message: json["message"],
      createdAt: json["createdAt"],
      senderId: json["senderId"],
    );
  }

  Map<String, Object?> toJson() {
    return {
      "message": message,
      "receiverId": receiverId,
      "receiverName": receiverName,
      "senderId": senderId,
      "createdAt": createdAt,
    };
  }
}
