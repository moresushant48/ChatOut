import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/views/SearchUser.dart';
import 'package:chatapp/views/SplashScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final auth = AuthMethods();

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
      body: Text(FirebaseAuth.instance.currentUser.displayName),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          showSearch(context: context, delegate: SearchUserDelegate());
        },
      ),
    );
  }
}
