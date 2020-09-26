import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:chatapp/views/MessageTile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  final String chatRoomId;
  Conversation(this.chatRoomId);
  @override
  _ConversationState createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  DatabaseMethods databaseMethods = DatabaseMethods();

  final messageController = TextEditingController();
  Stream chatMessagesStream;

  Widget chatMessageList() {
    return StreamBuilder(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return MessageTile(
                      snapshot.data.documents[index].get('message'),
                      snapshot.data.documents[index].get('sentBy') ==
                          FirebaseAuth.instance.currentUser.displayName);
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": messageController.text.trim(),
        "sentBy": FirebaseAuth.instance.currentUser.displayName,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      messageController.text = ''; // Clear the message field once sent.
    }
  }

  @override
  void initState() {
    getMessages();
    super.initState();
  }

  getMessages() {
    databaseMethods.getConversationMessages(widget.chatRoomId).then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatRoomId
            .replaceAll("_", "")
            .replaceAll(FirebaseAuth.instance.currentUser.displayName, "")),
      ),
      body: Container(
          child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: chatMessageList(),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Card(
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(38.0),
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: messageController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintText: "Type Something..",
                              border: InputBorder.none),
                          validator: (value) {
                            if (value.isEmpty)
                              return "Please enter your email.";
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                    ),
                    onPressed: sendMessage,
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
