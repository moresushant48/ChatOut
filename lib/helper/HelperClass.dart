import 'package:flutter/material.dart';

class HelperClass {
  String trimChatRoomId({String chatRoomId, String currentUserName}) {
    return chatRoomId.replaceAll("_", "").replaceAll(currentUserName, "") == ""
        ? "Me"
        : chatRoomId.replaceAll("_", "").replaceAll(currentUserName, "");
  }
}
