import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mynewflutterapp/signIn.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _username = "";
  String _password = "";
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Builder(
        builder: (context) => Form(
          key: _key,
          child: Center(
              child: Container(
                  width: 300.0,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Sign up',
                          style: TextStyle(fontSize: 20.0),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email",
                            ),
                            onSaved: (val) {
                              _username = val;
                            },
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Email can't be empty";
                              }
                            }),
                        SizedBox(
                          height: 10.0,
                        ),
                        TextFormField(
                            decoration: InputDecoration(labelText: "Password"),
                            onSaved: (val) {
                              _password = val;
                            },
                            obscureText: true,
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Password can't be empty";
                              } else if (val.length < 6) {
                                return "Password length must be 6 characters or more";
                              }
                            }),
                        SizedBox(
                          height: 10.0,
                        ),
                        FlatButton(
                          color: Colors.blue,
                          textColor: Colors.white,
                          child: Text(
                            'Sign Up',
                          ),
                          onPressed: () {
                            submitForm(context);
                          },
                        ),
                        InkWell(
                            child:
                                Text("Already have an account? Sign in here!"),
                            onTap: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            }),
                      ]))),
        ),
      ),
    );
  }

  Future<void> submitForm(BuildContext context) async {
    final formState = _key.currentState;
    if (formState.validate()) {
      formState.save();
      try {
        AuthResult res =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _username,
          password: _password,
        );
        viewSnackBar(context);
      } catch (signInError) {
        if (signInError is PlatformException) {
          if (signInError.code == "ERROR_INVALID_EMAIL") {
            viewErrorSnackBar(context, "Wrong Email");
          } else if (signInError.code == "ERROR_WRONG_PASSWORD") {
            viewErrorSnackBar(context, "Wrong Password");
          }
        }
      }
    }
  }

  void viewSnackBar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Account creation success'),
      ),
    );
  }

  void viewErrorSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}
