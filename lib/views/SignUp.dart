import 'package:chatapp/services/DatabaseMethods.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/views/ChatRoom.dart';
import 'package:chatapp/views/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpKey = GlobalKey<FormState>();
  bool isLoading = false;
  String _lowercaseUsername = "";

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  _signUp() {
    if (_signUpKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(
              _emailController.text.trim(), _passwordController.text.trim())
          .then((value) {
        Map<String, String> userMap = {
          "name": _usernameController.text.trim().toLowerCase(),
          "email": _emailController.text.trim()
        };

        databaseMethods.uploadUserInfo(userMap);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatRoom(),
            ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(18.0),
              child: Form(
                  key: _signUpKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.grey[200],
                          child: TextFormField(
                            controller: _usernameController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                alignLabelWithHint: true,
                                hintText: "Username (ex. johnbuyer)",
                                icon: Icon(Icons.person),
                                border: InputBorder.none),
                            validator: (value) {
                              if (value.isEmpty)
                                return "Please enter your username.";
                              else if (value.length < 4)
                                return "Atleast 4 characters required.";
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _lowercaseUsername = value.trim().toLowerCase();
                              });
                            },
                          ),
                        ),
                      ),

                      Text(
                        _lowercaseUsername,
                        style: TextStyle(color: Colors.green),
                      ),
                      SizedBox(height: 8.0),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: MaterialButton(
                          color: Colors.blue,
                          onPressed: _signUp,
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      //
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an Account ? "),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                )),
                            child: Text(
                              "Login Now",
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
