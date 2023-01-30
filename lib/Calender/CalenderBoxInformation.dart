import 'package:flutter/material.dart';


import '../Constants.dart';
import 'TextApp.dart';

class CalenderBoxInformation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextApp('مسیر', 12, Color_Calender_Text, false),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color:Color_Calender_Red,
                shape: BoxShape.circle
            ),
          ),
          TextApp('ویزیتور', 12, Color_Calender_Text, false),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            width: 10,
            height: 10,
            decoration: BoxDecoration(
                color:Color_Calender_Blue,
                shape: BoxShape.circle
            ),
          ),
        ],
      ),
    );
  }
}