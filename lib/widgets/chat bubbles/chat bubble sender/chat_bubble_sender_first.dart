import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubbleSenderFirst extends StatelessWidget {
  ChatBubbleSenderFirst({Key? key, required this.message, this.isAlsoLast})
      : super(key: key);

  final Message message;
  bool? isAlsoLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
      child: Row(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.837,
              ),
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
                          message.user.name,
                          style: TextStyle(
                            color: message.user.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        message.message,
                        style: const TextStyle(height: 1.7),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: max(
                          textWidth(message.user.name) - 28,
                          min(textWidth(message.message) - 43, 251),
                        )),
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
        ],
      ),
    );
  }
}
