import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/models/message_info.dart';

class ChatBubbleSenderFirst extends StatelessWidget {
  ChatBubbleSenderFirst({Key? key, required this.message, this.isAlsoLast})
      : super(key: key);

  final Message message;
  bool? isAlsoLast;

  @override
  Widget build(BuildContext context) {
    MessageInfo messageInfo = MessageInfo.fromMessage(message);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: kChatBubbleFirstSenderMargin,
        padding: kChatBubblePadding,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: kBigBubbleRadius,
            bottomRight: kBigBubbleRadius,
            topLeft: kBigBubbleRadius,
            bottomLeft: isAlsoLast == null || isAlsoLast == false
                ? kSmallBubbleRadius
                : const Radius.circular(0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Text(
                  messageInfo.userName,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 141, 185, 189),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SelectableText(
                messageInfo.messageText,
                style: const TextStyle(height: 1.7),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: max(
                  messageInfo.userName.length.toDouble() * 4,
                  min(textWidth(messageInfo.messageText) - 43, 251),
                )),
                child: Text(
                  messageInfo.time,
                  style: const TextStyle(
                    height: 1.5,
                    color: Color.fromARGB(150, 255, 255, 255),
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
