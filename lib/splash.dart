import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynewflutterapp/signIn.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3)).then((_) async {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    });
    return Container(
      color: Colors.blue,
    );
  }
}
