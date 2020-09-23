import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _signUpKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: "Username",
                          icon: Icon(Icons.person),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) return "Please enter your username.";
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
                      controller: _emailController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          alignLabelWithHint: true,
                          hintText: "Email ID",
                          icon: Icon(Icons.email),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value.isEmpty) return "Please enter your email.";
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
                        if (value.isEmpty) return "Please enter your password.";
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
                    onPressed: () {},
                    child: Text(
                      "Sign Up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
