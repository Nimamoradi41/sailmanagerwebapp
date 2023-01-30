import 'package:flutter/material.dart';

import '../Calender/TextApp.dart';
import '../Constants.dart';
import '../Models/ModelUncoveredPaths.dart';


class Boxinfonotsupportproduct extends StatelessWidget {


  ResultUncoveredPaths data;


  Boxinfonotsupportproduct(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(right: 8),
          decoration: BoxDecoration(
              color: BaseColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8) )
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextApp(data.customerCount.toString(),12,Colors.white,true),
                TextApp(' : تعداد مشتری',10,Colors.white,false),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),
              boxShadow:[
                BoxShadow(
                    color: BaseColor.withOpacity(0.25),
                    spreadRadius: 2,
                    blurRadius: 8
                )
              ]
          ),
          margin: EdgeInsets.only(right: 8,left: 8,bottom: 8),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp('شهر', 10, Colors.grey, false),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextApp(data.cityName, 12, Colors.black87, false),
                        ),
                      ],
                    )),
                    Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 25,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp('استان', 10, Colors.grey, false),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextApp(data.provinceName, 12, Colors.black87, false),
                        ),
                      ],
                    )),
                  ],
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                  color: Colors.grey.withOpacity(0.2),
                ),
                Row(
                  children: [
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp('مسیر', 10, Colors.grey, false),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextApp(data.pathName, 12, Colors.black87, false),
                        ),
                      ],
                    )),
                    Container(
                      width: 1,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      height: 25,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextApp('منطقه', 10, Colors.grey, false),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextApp(data.regionName, 12, Colors.black87, false),
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}