import 'package:flutter/material.dart';

const Radius kBigBubbleRadius = Radius.circular(20);
const Radius kSmallBubbleRadius = Radius.circular(8);
const Color kPrimaryColor = Color(0xff2b475e);
const Color kSecondaryColor = Color(0xFF2B5B5E);
const String kLogo = 'assets/images/scholar.png';
const String kSignInPageId = '/signIn';
const String kSignUpPageId = '/signUP';
const String kChatPageId = '/chat';
const String kMessagesCollection = 'messages';
const String kUsersCollection = 'users';
const String kMessage = 'message';
const String kUserName = 'userName';
const String kUserColor = 'color';
const String kCreatedAt = 'createdAt';
const String kId = 'id';

const List<int> kUserColors = [
  0xff5DADDE,
  0xff79CA7B,
  0xffE39652,
  0xffE35A62,
  0xffA380DC,
  0xff5AC1D0,
  0xffE85089,
];

const EdgeInsets kChatBubblePadding =
    EdgeInsets.only(left: 8.0, top: 6.0, right: 8.0, bottom: 2.0);
const EdgeInsets kChatBubbleMargin =
    EdgeInsets.only(bottom: 1, right: 10.0, left: 64.0);
const EdgeInsets kChatBubbleSenderMargin =
    EdgeInsets.only(bottom: 1, left: 10.0, right: 64.0);
const EdgeInsets kChatBubbleFirstMargin =
    EdgeInsets.only(top: 4, bottom: 1, right: 10.0, left: 64.0);
const EdgeInsets kChatBubbleFirstSenderMargin =
    EdgeInsets.only(top: 4, bottom: 1, left: 10.0, right: 64.0);

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Center(
          child: Text(
        message,
        style: const TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
      )),
      backgroundColor: const Color(0x82000000),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 1),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    ),
  );
}

double textWidth(String text) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(height: 1.7)),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size.width;
}
