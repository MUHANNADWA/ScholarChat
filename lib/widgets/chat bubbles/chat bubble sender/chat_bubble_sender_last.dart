import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/models/message_info.dart';

class ChatBubbleSenderLast extends StatelessWidget {
  const ChatBubbleSenderLast({Key? key, required this.message})
      : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    MessageInfo messageInfo = MessageInfo.fromMessage(message);
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: kChatBubbleSenderMargin,
        padding: kChatBubblePadding,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topRight: kBigBubbleRadius,
            topLeft: kSmallBubbleRadius,
            bottomRight: kBigBubbleRadius,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                messageInfo.messageText,
                style: const TextStyle(height: 1.7),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: min(
                        textWidth(messageInfo.messageText) -
                            min(50, textWidth(messageInfo.messageText)),
                        257)),
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
