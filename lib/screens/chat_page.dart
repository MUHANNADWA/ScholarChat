import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble/chat_bubble_last.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble%20sender/chat_bubble_sender_first.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble/chat_bubble_first.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble%20sender/chat_bubble_sender.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble/chat_bubble.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble%20sender/chat_bubble_sender_last.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  // final user = FirebaseAuth.instance.currentUser.;

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            backgroundColor: kBackgroundColor,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              actions: <Widget>[
                PopupMenuButton<String>(
                  color: kPrimaryColor,
                  offset: const Offset(0, 53),
                  onSelected: (String value) async {
                    if (value == 'Log out') {
                      await signOut(context);
                    }
                    if (value == 'Clear messages') {
                      showSnackBar(context, 'This is not available now');
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Log out',
                        child: Text(
                          'Log out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Clear messages',
                        child: Text(
                          'Clear messages',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ];
                  },
                ),
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    scale: 1.8,
                  ),
                  const Text('Chat'),
                ],
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/doodles.png"),
                  repeat: ImageRepeat.repeat,
                  opacity: 0.12,
                  scale: 20,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return showMessage(index, messagesList);
                      },
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 5,
                    controller: _controller,
                    onSubmitted: (value) async {
                      await sendMessage();
                    },
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          sendMessage();
                        },
                      ),
                      suffixIconColor: Colors.white,
                      border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.zero),
                      hintText: 'send message',
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(150, 255, 255, 255)),
                      filled: true,
                      fillColor: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const BlurryModalProgressHUD(
            blurEffectIntensity: 4,
            opacity: 0.05,
            inAsyncCall: true,
            child: Scaffold(
              backgroundColor: Colors.black,
            ),
          );
        }
      },
    );
  }

  Future<void> signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    showSnackBar(context, 'Logged out successfully');
    Navigator.pushNamedAndRemoveUntil(context, kSignInPageId, (route) => false);
  }

  showMessage(int index, List<Message> messagesList) {
    if (messageIsFirst(index, messagesList)) {
      return amITheSender(index, messagesList)
          ? ChatBubbleFirst(
              message: messagesList[index],
              isAlsoLast: messageIsFirstAndLast(index, messagesList))
          : ChatBubbleSenderFirst(
              message: messagesList[index],
              isAlsoLast: messageIsFirstAndLast(index, messagesList));
    } else if (messageIsLast(index, messagesList)) {
      return amITheSender(index, messagesList)
          ? ChatBubbleLast(message: messagesList[index])
          : ChatBubbleSenderLast(message: messagesList[index]);
    } else {
      return amITheSender(index, messagesList)
          ? ChatBubble(message: messagesList[index])
          : ChatBubbleSender(message: messagesList[index]);
    }
  }

  bool messageIsLast(int index, List<Message> messagesList) {
    return index == 0 || messagesList[index].id != messagesList[index - 1].id;
  }

  bool messageIsFirst(int index, List<Message> messagesList) {
    return index == messagesList.length - 1 ||
        messagesList[index].id != messagesList[index + 1].id;
  }

  bool amITheSender(int index, List<Message> messagesList) =>
      messagesList[index].id == email;

  bool messageIsFirstAndLast(int index, List<Message> messagesList) {
    return (index == messagesList.length - 1 ||
            messagesList[index].id != messagesList[index + 1].id) &&
        (index == 0 || messagesList[index].id != messagesList[index - 1].id);
  }

  sendMessage() async {
    log('message');
    _controller.text = _controller.text.trim();
    if (_controller.text.isNotEmpty) {
      messages.add({
        kMessage: _controller.text,
        kCreatedAt: Timestamp.now(),
        kId: email,
        kUser: await user as Map,
      }).then((_) {
        log('message ${_controller.text.toString()} at ${DateTime.now()} Added');
      }).catchError((error) {
        log("Failed to add message: $error");
      });
      _controller.clear();
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }
}
