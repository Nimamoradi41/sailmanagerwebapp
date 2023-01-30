import 'package:flutter/material.dart';

import '../Calender/TextApp.dart';
import '../Constants.dart';
import '../Models/ModelDayWeek.dart';


class BoxInfoCopy extends StatelessWidget {



  VoidCallback copy;

  ResultDayWeek data;

  BoxInfoCopy(this.copy,this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow:[
            BoxShadow(
                color: BaseColor.withOpacity(0.25),
                spreadRadius: 2,
                blurRadius: 8
            )
          ]
      ),
      margin: EdgeInsets.all(8),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ElevatedButton(onPressed: copy,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(BaseColor),
                    padding: MaterialStateProperty.all(EdgeInsets.all(8)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),

                        )
                    )
                ),
                child:Text('کپی',
                  style: TextStyle(color:Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),)),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Row(
                    children: [
                      TextApp(data.dayOfWeek, 12, Colors.black87, true),
                      TextApp(': روز هفته ', 10, Colors.grey, true),
                    ],
                  ),
                  Row(
                    children: [
                      TextApp(data.date, 12, Colors.black87, true),
                      TextApp(': تاریخ ', 10, Colors.grey, true),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}