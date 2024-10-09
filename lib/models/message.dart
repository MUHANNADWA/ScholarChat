import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/constants.dart';

class Message {
  final String message;
  final String id;
  final Timestamp createdAt;
  Message(this.message, this.createdAt, this.id);
  factory Message.fromJson(jsonData) {
    return Message(jsonData[kMessage], jsonData[kCreatedAt], jsonData[kId]);
  }
}
