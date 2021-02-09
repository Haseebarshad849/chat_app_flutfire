import 'package:chatting_app/screens/chatScreen.dart';
import 'package:chatting_app/screens/homePage.dart';
import 'package:chatting_app/services/firebaseAuth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      // ignore: deprecated_member_use
      home: StreamBuilder<User>(
        stream: AuthService().auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ChatScreen(user: FirebaseAuth.instance.currentUser);
          } else {
            return HomePage();
          }
        },
      ),
    );
  }
}

