import 'package:flutter/material.dart';
class BoxTextCalender extends StatelessWidget {

  String Title;


  BoxTextCalender(this.Title);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: RotatedBox(
      child: Text(Title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),),
      quarterTurns: 135,
    ));
  }
}