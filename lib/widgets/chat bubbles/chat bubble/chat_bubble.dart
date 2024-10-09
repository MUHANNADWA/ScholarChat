import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/models/message_info.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    MessageInfo messageInfo = MessageInfo.fromMessage(message);
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: kChatBubbleMargin,
        padding: kChatBubblePadding,
        decoration: const BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.only(
            topLeft: kBigBubbleRadius,
            bottomLeft: kBigBubbleRadius,
            topRight: kSmallBubbleRadius,
            bottomRight: kSmallBubbleRadius,
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
