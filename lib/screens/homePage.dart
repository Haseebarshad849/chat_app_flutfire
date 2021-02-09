import 'package:chatting_app/buttons/customButton.dart';
import 'package:chatting_app/screens/loginScreen.dart';
import 'package:chatting_app/screens/signUpScreen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle _headlineTextStyle = TextStyle(fontSize: 45.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Hero(
                tag: 'Chatting App',
                child: Image.asset(
                  'assets/images/logo.png',
                  scale: 2.5,
                ),
              ),
              Text(
                'HaseeChat',
                style: _headlineTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),
          CustomButton(
            text: 'Login',
            callback: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Login(),
                ),
              );
            },
          ),
          CustomButton(
            text: 'Sign Up',
            callback: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => SignUp(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
