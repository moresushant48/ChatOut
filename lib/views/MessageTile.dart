import 'dart:async';

import 'package:flutter/material.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final bool isSentByMe;
  final num time;
  MessageTile(this.message, this.isSentByMe, this.time);

  @override
  _MessageTileState createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  bool showTime = false;

  void showTimeOnlyForSeconds() {
    setState(() {
      showTime = !showTime;
    });
    if (showTime) {
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          showTime = !showTime;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        alignment:
            widget.isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
        child: Column(
          children: [
            InkWell(
              onTap: () => showTimeOnlyForSeconds(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: widget.isSentByMe
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
                  color: widget.isSentByMe ? Colors.blue : Colors.grey[300],
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: Text(widget.message,
                    style: TextStyle(
                        color: widget.isSentByMe ? Colors.white : Colors.black,
                        fontSize: 16)),
              ),
            ),
            Visibility(
              visible: showTime,
              child: Text(DateTime.fromMillisecondsSinceEpoch(widget.time)
                      .hour
                      .toString() +
                  ":" +
                  DateTime.fromMillisecondsSinceEpoch(widget.time)
                      .minute
                      .toString()),
            )
          ],
        ));
  }
}
