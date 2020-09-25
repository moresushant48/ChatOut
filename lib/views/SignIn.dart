import 'package:chatapp/services/auth.dart';
import 'package:chatapp/views/ChatRoom.dart';
import 'package:chatapp/views/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInKey = GlobalKey<FormState>();
  bool isLoading = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthMethods authMethods = AuthMethods();

  _signIn() {
    if (_signInKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signInWithEmailAndPassword(
              _emailController.text.trim(), _passwordController.text.trim())
          .catchError((err) {
        print("theres an errror." + err.toString());
      }).then((value) {
        value != null
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatRoom(),
                ))
            : Fluttertoast.showToast(
                msg: "Wrong Credentials.", backgroundColor: Colors.red);
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              margin: EdgeInsets.all(18.0),
              child: Form(
                  key: _signInKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.grey[200],
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: "Email ID",
                                icon: Icon(Icons.email),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Please enter your email.";
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      //
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.grey[200],
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: "Password",
                                icon: Icon(Icons.vpn_key),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Please enter your password.";
                              else if (value.length < 6)
                                return "Atleast 6 characters required.";
                              return null;
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                      //
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: _signIn,
                          child: Text(
                            "Sign In",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have Account ? "),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                )),
                            child: Text(
                              "Register Now",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
