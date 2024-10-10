import 'dart:ui';

import 'package:scholar_chat/constants.dart';

class User {
  final String name;
  final String id;
  final Color color;
  User(this.name, this.id, this.color);
  factory User.fromJson(jsonData) {
    return User(
      jsonData[kUserName],
      jsonData[kId],
      Color(jsonData[kUserColor]),
    );
  }
}
