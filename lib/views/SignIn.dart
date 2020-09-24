import 'package:chatapp/views/SignUp.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _signInKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        if (value.isEmpty) return "Please enter your email.";
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
                        if (value.isEmpty) return "Please enter your password.";
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
                    onPressed: () {},
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
                      onTap: () => Navigator.push(
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
