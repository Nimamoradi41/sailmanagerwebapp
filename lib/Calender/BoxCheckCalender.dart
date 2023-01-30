import 'package:flutter/material.dart';


import '../Constants.dart';
import 'TextApp.dart';

class BoxCheckCalender extends StatelessWidget {


  String Title;
  Color MainColor;
  String Count;
  double Price;


  BoxCheckCalender(this.Title, this.MainColor, this.Count, this.Price);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4,horizontal: 8),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2
            )
          ]

      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
                color:MainColor,
                shape: BoxShape.circle
            ),
          ),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextApp(Title, 14, MainColor, false),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextApp(SplitPrice(Price), 14, Color_Calender_Text, false),
                            TextApp(': مبلغ ', 12, Color_Calender_Text, false)
                          ],
                        )),
                        Container(
                          margin: EdgeInsets.only(right: 8,bottom: 4,left: 8),
                          height: 20,
                          width: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextApp(Count, 14, Color_Calender_Text, false),
                        ),
                        TextApp(': تعداد', 12, Color_Calender_Text, false),

                      ]
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
