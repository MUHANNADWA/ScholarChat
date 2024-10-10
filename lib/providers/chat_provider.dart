import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  Color? _messageColor;
  set messageColor(Color? messageColor) {
    _messageColor = messageColor;
    notifyListeners();
  }

  Color? get messageColor => _messageColor;
}
