import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/views/Coversation.dart';
import 'package:chatapp/views/SearchUser.dart';
import 'package:chatapp/views/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final auth = AuthMethods();
  final databaseMethods = DatabaseMethods();
  Stream chatRoomStream;

  Widget chatRoomList() {
    return StreamBuilder(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Conversation(snapshot
                                .data.documents[index]
                                .get('chatRoomId')),
                          ))
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          child: Text(
                            snapshot.data.documents[index]
                                .get('chatRoomId')
                                .toString()
                                .replaceAll("_", "")
                                .replaceAll(
                                    FirebaseAuth
                                        .instance.currentUser.displayName,
                                    "")
                                .substring(0, 1),
                            style: TextStyle(fontSize: 24.0),
                          ),
                        ),
                        title: Text(snapshot.data.documents[index]
                            .get('chatRoomId')
                            .toString()
                            .replaceAll("_", "")
                            .replaceAll(
                                FirebaseAuth.instance.currentUser.displayName,
                                "")),
                      ),
                    ),
                  );
                },
              )
            : LinearProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    databaseMethods
        .getChatRooms(FirebaseAuth.instance.currentUser.displayName)
        .then((value) {
      setState(() {
        chatRoomStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChatOut"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SplashScreen(),
                  ));
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: chatRoomList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: SearchUserDelegate());
        },
      ),
    );
  }
}
