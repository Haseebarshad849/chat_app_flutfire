import 'package:flutter/material.dart';

class MessageContainer extends StatelessWidget {
  final String from;
  final String text;
  final String time;
  final bool me;

  MessageContainer({Key key, this.from, this.text,this.time, this.me})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: me? CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.0,right: 6.0,left: 6.0,bottom: 6.0),
            child: Text(
              from,
            ),
          ),
          Material(
            color: me? Colors.teal:Colors.black,
            elevation: 8.0,
            borderRadius: BorderRadius.circular(9.0),
            child: Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 16.0),
                child: Text(
                  text,
                ),
              ),
            ),
          ),
          // Text(
          //   time,
          // ),
        ],
      ),
    );
  }
}
