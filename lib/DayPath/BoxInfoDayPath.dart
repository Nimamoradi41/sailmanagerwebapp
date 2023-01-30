import 'package:flutter/material.dart';
import '../Calender/TextApp.dart';
import '../Constants.dart';
import '../Models/ModelReportVisitordaypath.dart';


class BoxInfoDayPath extends StatelessWidget {


  ResultDaypath data;


  BoxInfoDayPath(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
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
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp('کد ویزیتور', 10, Colors.grey, false),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0,top: 4),
                          child: TextApp(data.visitorId.toString(), 12, Colors.black87, false),
                        ),
                      ],
                    )),
                Container(
                  width: 1,
                  color: Colors.grey.withOpacity(0.2),
                  height: 25,
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                ),
                Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp('نام ویزیتور', 10, Colors.grey, false),
                        Padding(
                          padding: const EdgeInsets.only(right: 4.0,top: 4),
                          child: TextApp(data.visitorName, 12, Colors.black87, false),
                        ),
                      ],
                    )),
              ],
            ),


            Container(
              width: double.infinity,
              color: Colors.grey.withOpacity(0.2),
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            ),
            Row(
              children: [
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextApp('منطقه', 10, Colors.grey, false),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0,top: 4),
                      child: TextApp(data.regionName, 12, Colors.black87, false),
                    ),
                  ],
                ) ),
                Container(
                  width: 1,
                  color: Colors.grey.withOpacity(0.2),
                  height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                ),
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextApp('شهر', 10, Colors.grey, false),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0,top: 4),
                      child: TextApp(data.cityName, 12, Colors.black87, false),
                    ),
                  ],
                ) )
              ],
            ),
            Container(
              width: double.infinity,
              color: Colors.grey.withOpacity(0.2),
              height: 1,
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
            ),
            Row(
              children: [
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextApp('تعداد مشتریان', 10, Colors.grey, false),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0,top: 4),
                      child: TextApp(data.customerCount.toString(), 12, Colors.black87, false),
                    ),
                  ],
                ) ),
                Container(
                  width: 1,
                  color: Colors.grey.withOpacity(0.2),
                  height: 30,
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                ),
                Expanded(child:Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextApp('مسیر', 10, Colors.grey, false),
                    Padding(
                      padding: const EdgeInsets.only(right: 4.0,top: 4),
                      child: TextApp(data.pathName, 12, Colors.black87, false),
                    ),
                  ],
                ) )
              ],
            ),


          ],
        ),
      ),
    );
  }
}