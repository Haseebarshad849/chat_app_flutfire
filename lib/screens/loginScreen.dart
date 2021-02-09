import 'package:chatting_app/buttons/customButton.dart';
import 'package:chatting_app/screens/chatScreen.dart';
import 'package:chatting_app/services/firebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  //===================TASK FOR TOMORROW==========================
  // PUT A VALIDATOR TO VALIDATE EITHER WRITTEN SOMETHING
  // OR NOT

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Hero(
              tag: 'Chatting App',
              child: Image.asset(
                'assets/images/logo.png',
                scale: 0.9,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _email = value;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      errorStyle: TextStyle(
                        color: Colors.red[600],
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Enter Your Email',
                      labelText: 'Email',
                      hintStyle: TextStyle(fontSize: 18.0),
                      labelStyle: TextStyle(fontSize: 15.0),
                    ),
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Invalid Password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        _password = value;
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.remove_red_eye_outlined),
                      errorStyle: TextStyle(
                        color: Colors.red[900],
                        fontSize: 15.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      hintText: 'Enter Your Password',
                      labelText: 'Password',
                      hintStyle: TextStyle(fontSize: 18.0),
                      labelStyle: TextStyle(fontSize: 15.0),
                    ),
                    style: TextStyle(fontSize: 18.0),
                    obscureText: true,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CustomButton(
                    text: 'Login',
                    callback: () => onSubmitButton(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onSubmitButton() async {
    print('button clicked');
    dynamic result = '';
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      result = await AuthService().signInWithEmailPassword(_email, _password);
      if (_auth.currentUser == null) {
        print('Error Signing In');
        print(result.toString());
        _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: new Text(result),
          ),
        );
      } else {
        print('Signed In Successfull');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(
                user: result,
              ),
            ));
      }
    }
  }
}
