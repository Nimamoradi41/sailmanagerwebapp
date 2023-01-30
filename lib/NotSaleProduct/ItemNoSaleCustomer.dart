import 'package:flutter/material.dart';

import '../Calender/TextApp.dart';
import '../Models/ModelNotSaleCustomer.dart';


class ItemNoSaleCustomer extends StatelessWidget {


  ResultNotSaleCostomer Data;


  ItemNoSaleCustomer(this.Data);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                offset: Offset(0,0),
                blurRadius: 2,
                spreadRadius: 2
            )
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextApp('نام مشتری', 12, Colors.grey, false),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextApp(Data.customerName, 14, Colors.black54, true),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
              height: 1,
              color: Colors.grey.withOpacity(0.3),
            ),
            Row(
              children: [
                Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: TextApp('تاریخ اخرین خرید', 12, Colors.grey, false),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextApp(Data.lastBuyDate, 14, Colors.black54, true),
                        ),
                      ],
                    )),
                Container(
                  width: 1,
                  height: 25,
                  color: Colors.grey.withOpacity(0.3),
                ),
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: TextApp('تلفن', 12, Colors.grey, false),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextApp(Data.phone, 14, Colors.black54, true),
                        ),
                      ],
                    )),


              ],
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
              height: 1,
              color: Colors.grey.withOpacity(0.3),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextApp('آدرس', 12, Colors.grey, false),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextApp(Data.address, 14, Colors.black54, true),
            ),

          ],
        ),
      ),
    );
  }
}