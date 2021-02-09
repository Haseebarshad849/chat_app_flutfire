import 'package:chatting_app/buttons/sendButton.dart';
import 'package:chatting_app/models/messageModel.dart';
import 'package:chatting_app/screens/homePage.dart';
import 'package:chatting_app/screens/messageContainer.dart';
import 'package:chatting_app/services/firebaseAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  const ChatScreen({Key key, this.user}) : super(key: key);
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override
  void initState(){
    super.initState();
    print(widget.user.email);
    loadingState();
  }

  String msg;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore store = FirebaseFirestore.instance;

  var _formKey= GlobalKey<FormState>();
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future onSendButton() async {



    if (_formKey.currentState.validate()) {
      setState(() {
        _formKey.currentState.save();
      });

      var msgModel = Messages(message: msg,from: widget.user.email,timeStamp: DateTime.now());
      setState(() {
        messageController.clear();
      });
      await store.collection('messages').add(msgModel.createMap());

      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 100), curve: Curves.easeOut);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10.0,
        leading: Hero(
          tag: 'Chatting App',
          child: Image.asset(
            'assets/images/logo.png',
            scale: 6,
          ),
        ),
        title: Text('HaseeChat'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthService().signOut();
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> HomePage()));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: store.collection('messages').orderBy('timestamp').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
                List<DocumentSnapshot> docs= snapshot.data.docs;
                List<Widget> messages = docs.map((doc) => MessageContainer(
                  from: doc.data()['from']??"",
                  text: doc.data()['message']??"",
                  me: widget.user.email==doc.data()['from'],
                )).toList();
                return Container(
                  height: MediaQuery.of(context).size.height * 0.78,
                  child: ListView(
                    controller: scrollController,
                    children: [
                          // Text('Hello'),
                      ...messages,
                    ],
                  ),
                );
              },
            ),
            Container(
              child: Form(
                key:_formKey,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.emoji_emotions_outlined),
                          errorStyle: TextStyle(
                            color: Colors.red[600],
                            fontSize: 15.0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          hintText: 'Type your message here',
                          hintStyle: TextStyle(fontSize: 18.0),
                        ),
                        style: TextStyle(fontSize: 18.0),
                        controller: messageController,
                        validator: (val){
                          if(val.isEmpty)return 'Please enter some text';
                          return null;
                        },
                        onSaved: (value){
                          setState(() {
                            msg = value;
                          });
                        },
                      ),
                    ),
                    SendButton(
                      text: 'Send',
                      callback: onSendButton,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  loadingState()async{
  User user = FirebaseAuth.instance.currentUser;
  return user;
  }
}

