import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/models/message_info.dart';

class ChatBubbleFirst extends StatelessWidget {
  ChatBubbleFirst({Key? key, required this.message, this.isAlsoLast})
      : super(key: key);

  final Message message;
  bool? isAlsoLast;

  @override
  Widget build(BuildContext context) {
    MessageInfo messageInfo = MessageInfo.fromMessage(message);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: kChatBubbleFirstMargin,
        padding: kChatBubblePadding,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: kBigBubbleRadius,
            bottomLeft: kBigBubbleRadius,
            topRight: kBigBubbleRadius,
            bottomRight: isAlsoLast == null || isAlsoLast == false
                ? kSmallBubbleRadius
                : const Radius.circular(0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                messageInfo.messageText,
                style: const TextStyle(height: 1.7),
              ),
              Text(
                messageInfo.time,
                style: const TextStyle(
                  height: 1.7,
                  color: Color.fromARGB(150, 255, 255, 255),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
