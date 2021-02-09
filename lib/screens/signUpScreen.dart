import 'package:chatting_app/buttons/customButton.dart';
import 'package:chatting_app/screens/loginScreen.dart';
import 'package:chatting_app/services/firebaseAuth.dart';
import 'package:chatting_app/services/firebaseCloudStore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String name = '';
  String email = '';
  String password = '';
  String uid = '';

  final _auth = FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'Chatting App',
            child: Image.asset(
              'assets/images/logo.png',
              height: MediaQuery.of(context).size.height / 2.2,
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //========= NAME TEXT FORM FIELD========
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 3) {
                      return 'Please enter correct name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    name = value;
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
                    hintText: 'Enter your name',
                    labelText: 'Name',
                    hintStyle: TextStyle(fontSize: 18.0),
                    labelStyle: TextStyle(fontSize: 15.0),
                  ),
                  style: TextStyle(fontSize: 18.0),
                ),
                //========= SPACING  ========
                SizedBox(
                  height: 30.0,
                ),
                //========= EMAIL TEXT FORM FIELD========
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
                    email = value;
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
                //========= SPACING  ========
                SizedBox(
                  height: 30.0,
                ),
                //========= PASSWORD TEXT FORM FIELD========
                TextFormField(
                  keyboardType: TextInputType.text,
                  validator: (String value) {
                    if (value.length < 6 && value.isEmpty) {
                      return 'Enter Strong Password';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    password = value;
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
                //========= SPACING  ========
                SizedBox(
                  height: 20.0,
                ),
                //===============================
                // CUSTOM BUTTON FOR ALL DISPLAY
                //===============================
                CustomButton(
                  text: 'Register',
                  callback: () => onSubmitButton(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onSubmitButton() async {
    dynamic result = '';
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      result =
          await AuthService().registerAccountWithEmailPassword(email, password);

      if (_auth.currentUser == null) {
        print('Error Creating Account');
        print(result);
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(result)));
      } else {
        String uid = _auth.currentUser.uid;
        await CloudStore().registerUser(email,password,name,uid);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ));
      }
    }
  }
}
