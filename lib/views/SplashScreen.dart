import 'dart:async';

import 'package:chatapp/views/ChatRoom.dart';
import 'package:chatapp/views/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateUser();
  }

  navigateUser() {
    Timer(Duration(seconds: 3), () {
      FirebaseAuth.instance.currentUser != null
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ChatRoom(),
              ))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignIn(),
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white, child: Center(child: CircularProgressIndicator()));
  }
}
