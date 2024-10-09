import 'package:flutter/material.dart';
import 'package:scholar_chat/models/user.dart';

class UserInfo {
  final String name;
  final String id;
  final Color color;
  UserInfo(this.name, this.id, this.color);
  factory UserInfo.fromUser(User user) {
    return UserInfo(
      user.name,
      user.id,
      Color(user.color),
    );
  }
}
