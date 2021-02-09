import 'package:chatting_app/models/messageModel.dart';
import 'package:chatting_app/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudStore {
  final User user;

  // Create a CollectionReference called users that references the firestore collection
  final users = FirebaseFirestore.instance.collection('users');
  final messages = FirebaseFirestore.instance.collection('messages');

  CloudStore({this.user});
  //users = users.orderBy('name');

  Future<void> registerUser(String email, String password, String name,String uid) async{
    Person p = Person(password: password,email: email,name: name,uid: uid);
    // Call the user's CollectionReference to add a new user
    return await users.doc(uid).set(
      p.createMap());
  }

  Future updateUserList(
      String name, String uid, String profilePicUrl) async {
    return await users
        .doc(uid)
        .update({'name': name, 'profilePic': profilePicUrl});
  }

  Future getUsersList() async {
    List itemsList = [];

    try {
      await users.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });

      return itemsList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future onSendButton(String message, String from)async {
    var msgmodel = Messages();
    if(message!=null && message.length>0){
      await messages.add(msgmodel.createMap());
    }
    return null;
  }
}
