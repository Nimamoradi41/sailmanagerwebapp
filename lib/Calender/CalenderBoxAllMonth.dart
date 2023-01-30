import 'package:flutter/material.dart';


import '../Constants.dart';
import 'TextApp.dart';

class CalenderBoxAllMonth extends StatelessWidget {




  // List<Detail_Calender> detail=[];


  // CalenderBoxAllMonth(this.detail);
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextApp('برای نمایش اطلاعات, روز تقویم را انتخاب کنید', 12, Color_Calender_Text, false),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp(' تعداد مسیر', 12, Color_Calender_Text, false),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // TextApp(SplitPrice(sumRecivePrice), 14, Color_Calender_Text, false),
                            TextApp(4.toString(), 14, Color_Calender_Text, false),

                          ],
                        ),




                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 20,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextApp(' تعداد ویزیتور', 12, Color_Calender_Text, false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // TextApp(SplitPrice(sumRecivePrice), 14, Color_Calender_Text, false),
                          TextApp(4.toString(), 14, Color_Calender_Text, false),

                        ],
                      ),





                    ],
                  ),
                ),



              ]
          ),
        )
      ],
    );
  }
}
