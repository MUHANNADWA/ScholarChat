import 'package:intl/intl.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/user.dart';

class Message {
  final String message;
  final String createdAt;
  final String id;
  final User user;
  Message(this.message, this.createdAt, this.id, this.user);
  factory Message.fromJson(jsonData) {
    return Message(
      jsonData[kMessage],
      DateFormat.jm().format(jsonData[kCreatedAt].toDate()),
      jsonData[kId],
      User.fromJson(jsonData[kUser]),
    );
  }
}
