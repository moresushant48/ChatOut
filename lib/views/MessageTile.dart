import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSentByMe;
  MessageTile(this.message, this.isSentByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        alignment: isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: isSentByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                    bottomLeft: Radius.circular(18.0),
                  )
                : BorderRadius.only(
                    topLeft: Radius.circular(18.0),
                    topRight: Radius.circular(18.0),
                    bottomRight: Radius.circular(18.0),
                  ),
            color: isSentByMe ? Colors.blue : Colors.grey[300],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
          child: Text(message,
              style: TextStyle(
                  color: isSentByMe ? Colors.white : Colors.black,
                  fontSize: 16)),
        ));
  }
}
