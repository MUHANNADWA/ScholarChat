import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubbleSenderLast extends StatelessWidget {
  const ChatBubbleSenderLast({Key? key, required this.message})
      : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Align(
        alignment: Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.837,
          ),
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
                    message.message,
                    style: const TextStyle(height: 1.7),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: min(
                            textWidth(message.message) -
                                min(43, textWidth(message.message)),
                            251)),
                    child: Text(
                      message.createdAt,
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
        ),
      ),
    );
  }
}
