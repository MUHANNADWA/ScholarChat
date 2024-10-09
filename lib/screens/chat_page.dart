import 'dart:developer';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/constants.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble/chat_bubble_last.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble%20sender/chat_bubble_sender_first.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble/chat_bubble_first.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble%20sender/chat_bubble_sender.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble/chat_bubble.dart';
import 'package:scholar_chat/widgets/chat%20bubbles/chat%20bubble%20sender/chat_bubble_sender_last.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);

  final users = FirebaseFirestore.instance
      .collection(kUsersCollection)
      .get()
      .then((QuerySnapshot querySnapshot) {
    for (var doc in querySnapshot.docs) {
      log(doc["color"].toString());
    }
  });

  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? email;

  @override
  Widget build(BuildContext context) {
    Map settings = ModalRoute.of(context)!.settings.arguments as Map;
    email = settings['email'];

    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagesList = [];
          for (var i = 0; i < snapshot.data!.docs.length; i++) {
            messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }

          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 183, 225, 228),
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    scale: 1.8,
                  ),
                  const Text('Chat')
                ],
              ),
            ),
            body: Column(
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
          );
        } else {
          return const BlurryModalProgressHUD(
              blurEffectIntensity: 4,
              opacity: 0.05,
              inAsyncCall: true,
              child: Center(child: Text('Loading...')));
        }
      },
    );
  }

  StatelessWidget showMessage(int index, List<Message> messagesList) {
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

  sendMessage() {
    _controller.text = _controller.text.trim();
    if (_controller.text.isNotEmpty) {
      messages
          .add({
            kMessage: _controller.text,
            kCreatedAt: DateTime.now(),
            kId: email,
          })
          .then((_) => log(
              'message ${_controller.text.toString()} at ${DateTime.now()} Added'))
          .catchError((error) => log("Failed to add message: $error"));
    }
    _controller.clear();
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }
}
