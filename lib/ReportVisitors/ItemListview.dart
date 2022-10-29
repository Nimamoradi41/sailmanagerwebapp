import 'package:flutter/material.dart';

import '../Constants.dart';
import '../TextApp.dart';
import 'ItemColumn.dart';


class ItemListview extends StatelessWidget {
  const ItemListview({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: BoxDecoration(
                color: BaseColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8))
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
              child: TextApp(
                  'نیما مرادی پخش نیکوکار',12,Colors.white,false
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(8),
                  topLeft: Radius.circular(8),bottomLeft: Radius.circular(8),),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 4,
                      spreadRadius: 2
                  )
                ]
            ),
            child: Column(
              children: [
                Container(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: TextApp('پورسانت',11,ColorFirst,false),
                          )),


                      Expanded(
                          flex: 4,
                          child: Container(
                            child:  TextApp('مبلغ',11,ColorFirst,false) ,
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(
                            child: TextApp('جز',11,ColorFirst,false),
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(
                            child:  TextApp('واحد',11,ColorFirst,false),
                          )),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffEDAA6C).withOpacity(0.37),

                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ItemColumn('پورسانت',5484851,true,false),
                          )),


                      Expanded(
                          flex: 4,
                          child: Container(
                            child: ItemColumn('مبلغ',542445844,false,false),
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(
                            child: ItemColumn('جز',14,false,false),
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(
                            child: ItemColumn('واحد',415,true,false),
                          )),
                    ],
                  ),
                ),

                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffCE3030).withOpacity(0.19),

                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ItemColumn('پورسانت',5484851,true,false),
                          )),


                      Expanded(
                          flex: 4,
                          child: Container(
                            child: ItemColumn('مبلغ',542445844,false,false),
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(
                            child: ItemColumn('جز',14,false,false),
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(
                            child: ItemColumn('واحد',415,true,false),
                          )),
                    ],
                  ),
                ),

                Container(

                  decoration: BoxDecoration(
                      color: Color(0xff017013).withOpacity(0.22),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8))
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: ItemColumn('',5484851,true,false),
                          )),


                      Expanded(
                          flex: 4,
                          child: Container(
                            child: ItemColumn('',542445844,false,false),
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(
                            child: ItemColumn('',14,false,false),
                          )),

                      Expanded(
                          flex: 2,
                          child: Container(

                            child: ItemColumn('',415,true,false),
                          )),
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}