import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BoxItemCalender extends StatelessWidget {


  Color mainColor;
   String Count;

   double Price;

   Color TextColor ;

  BoxItemCalender(this.mainColor, this.Count, this.Price,this.TextColor);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,###,###',"fa_IR");
    return Container(
      width: double.infinity,
      color:mainColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Expanded(child: Text(Count,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: TextColor,
                        fontSize: 12
                    ),)),
                  Text(' : تعداد',style: TextStyle(
                      color: TextColor,
                      fontSize: 10
                  ),),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Expanded(child: Text(formatter.format(Price.abs()),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: TextColor,
                        fontSize: 12
                    ),)),
                  Text(' : تعداد',style: TextStyle(
                      color: TextColor,
                      fontSize: 10
                  ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}