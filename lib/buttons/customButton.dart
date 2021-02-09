import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback callback;

  const CustomButton({Key key, this.text, this.callback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(bottom: 40.0,top: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        elevation: 10.0,
        color: Colors.blueGrey,
        child: MaterialButton(
          minWidth: 225.0,
          height: 60.0,
          child: Text(
            text,
            style: TextStyle(fontSize: 26.0),
          ),
          onPressed: callback,
        )
      ),
    );
  }
}
