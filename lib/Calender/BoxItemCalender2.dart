import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class BoxItemCalender2 extends StatelessWidget {



  int Count;

   int Vis;



  BoxItemCalender2( this.Count, this.Vis);

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,###,###',"fa_IR");
    return Container(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('تعداد ویزیتور',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10
                  ),),
                  Text(Vis.toInt().toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12
                    ),),

                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('تعداد مسیر',style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10
                  ),),
                  Text(Count.toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12
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