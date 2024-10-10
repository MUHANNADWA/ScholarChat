import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({Key? key, required this.message}) : super(key: key);

  final Message message;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Align(
        alignment: Alignment.centerRight,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.837,
          ),
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
                    message.message,
                    style: const TextStyle(height: 1.7),
                  ),
                  Text(
                    message.createdAt,
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
        ),
      ),
    );
  }
}
