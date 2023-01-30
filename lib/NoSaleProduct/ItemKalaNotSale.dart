import 'package:flutter/material.dart';

import '../Calender/TextApp.dart';
import '../Constants.dart';
import '../Models/ModelKalaNotSale.dart';




class ItemKalaNotSale extends StatelessWidget {


  ResultKalaNotSale DataMain;


  ItemKalaNotSale(this.DataMain);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: EdgeInsets.only(top: 8,right: 8,left: 8),
          decoration: const BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(

                    children: [
                      TextApp(DataMain.componentInventory.toString(), 14, Colors.white, true),
                      TextApp(' : جز', 12, Colors.white, false),
                    ],
                  ),
                  Row(
                    children: [
                      TextApp(
                  DataMain.unitInventory.round()==DataMain.unitInventory?
                  DataMain.unitInventory.round().toString():
                  DataMain.unitInventory.toString()
                        , 14, Colors.white, true),
                      TextApp(' : واحد', 12, Colors.white, false),
                    ],
                  ),
                  Row(
                    children: [
                      TextApp(DataMain.productCode.toString(), 14, Colors.white, true),
                      TextApp(' : کد کالا', 12, Colors.white, false),
                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 8,left: 8,bottom: 8),
          decoration: AutoBox,

          width: double.maxFinite,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextApp('نام کالا', 12, Colors.grey, false),
                TextApp(DataMain.productName.toString(), 14, Colors.black54, false),
                Container(
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.3),
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                ),
                Row(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextApp('کارتن', 12, Colors.grey, false),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextApp(' : محتوی', 12, Colors.grey, false),
                        ),
                      ],
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 25,
                    ),
                    const Spacer(),
                    Expanded(child: TextApp('قیمت های فروش', 12, Colors.grey, false)),
                  ],
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.3),
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 4,vertical: 8),
                ),
                Row(
                  children: [
                    Expanded(
                      child: BoxInfo_78('پنجم',DataMain.salePrice5),
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 25,
                    ),
                    Expanded(
                      child: BoxInfo_78('چهارم',DataMain.salePrice4),
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 25,
                    ),
                    Expanded(
                      child: BoxInfo_78('سوم',DataMain.salePrice3),
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 25,
                    ),
                    Expanded(
                      child: BoxInfo_78('دوم',DataMain.salePrice2),
                    ),
                    Container(
                      width: 1,
                      color: Colors.grey,
                      height: 25,
                    ),
                    Expanded(
                      child: BoxInfo_78('اول',DataMain.salePrice1),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
class BoxInfo_78 extends StatelessWidget {
  String Title;
  double Value;


  BoxInfo_78(this.Title, this.Value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextApp(Title,10, Colors.grey, false),
        SizedBox(height: 4,),
        TextApp(SplitPrice(Value),12, Colors.grey, true),
      ],
    );
  }
}