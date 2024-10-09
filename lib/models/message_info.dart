import 'package:intl/intl.dart';
import 'package:scholar_chat/models/message.dart';

class MessageInfo {
  final String userName;
  final String messageText;
  final String time;
  MessageInfo(this.userName, this.messageText, this.time);

  factory MessageInfo.fromMessage(Message message) {
    return MessageInfo(
      message.id.substring(0, message.id.indexOf('@')),
      message.message,
      DateFormat.jm().format(message.createdAt.toDate()),
    );
  }
}
