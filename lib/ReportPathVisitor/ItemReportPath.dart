import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Models/Modelpathvisitor.dart';
import '../TextApp.dart';
import 'ReportSumPathVisitor.dart';


class ItemReportPath extends StatelessWidget {
  Res_Vis_Path  data;


  ItemReportPath(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
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
                  data.visName+' - مشاهده جمع اقلام ',12,Colors.white,false
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

            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: BaseColor,width: 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8)
                      )
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextApp('عدد',10, Colors.black54,false),
                                              TextApp(data.numAllCustomers.toInt().toString(),10, Colors.black87,false),
                                            ],
                                          ),
                                        )),
                                  ],
                                )),
                            Container(
                              width: 1,
                              height: 25,
                              color: Colors.grey,
                            ),
                            Expanded(
                                flex: 4,
                                child: TextApp(
                                    'تعداد کل مشتریان مسیر',
                                    10,Colors.black54,false
                                )
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [

                                    Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextApp('درصد',10, Colors.black87,false),
                                              TextApp(data.numCustomersVisitedPercent.toInt()
                                                  .toString()+' % ',10, Colors.grey,false),
                                            ],
                                          ),
                                        )),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('عدد',10, Colors.black87,false),
                                            TextApp(data.numCustomersVisited.toInt()
                                                .toString(),10, Colors.grey,false),
                                          ],
                                        )),
                                  ],
                                )),
                            Container(
                              width: 1,
                              height: 25,
                              color: Colors.grey,
                            ),
                            Expanded(
                                flex: 4,
                                child: TextApp(
                                    'پوشش مشتریان ویزیت شده',
                                    10,Colors.black54,false
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('مبلغ',10, Colors.black54,false),
                                            TextApp(SplitPrice(data.priceOrders),10, Colors.black87,false),
                                          ],
                                        )),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('درصد',10, Colors.black54,false),
                                            TextApp(data.numCustomersVisitedPercentWithOrder.toInt().toString()+'%',10, Colors.black87,false),
                                          ],
                                        )),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('عدد',10, Colors.black54,false),
                                            TextApp(data.numCustomersVisitedWithOrder.toInt().toString(),10, Colors.black87,false),
                                          ],
                                        )),
                                  ],
                                )),
                            Container(
                              width: 1,
                              height: 25,
                              color: Colors.grey,
                            ),
                            Expanded(
                                flex: 4,
                                child: TextApp(
                                    'ویزیت های دارای سفارش',
                                    10,Colors.black54,false
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [

                                    Expanded(
                                        flex: 4,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextApp('درصد',10, Colors.black54,false),
                                              TextApp(data.numCustomersVisitedPercentWithOutOrder.toInt().toString()+'%',10, Colors.black87,false),
                                            ],
                                          ),
                                        )),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('عدد',10, Colors.black54,false),
                                            TextApp(data.numCustomersVisitedWithOutOrder.toInt().toString(),10, Colors.black87,false),
                                          ],
                                        )),
                                  ],
                                )),
                            Container(
                              width: 1,
                              height: 25,
                              color: Colors.grey,
                            ),
                            Expanded(
                                flex: 4,
                                child: TextApp(
                                    'ویزیت بدون سفارش',
                                    10,Colors.black54,false
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('پوشش فروش محصولات',10, Colors.black54,false),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                TextApp('('+data.numAllInventory.toInt().toString()+' کالا '+')'
                                                    // +'از'+'کالا'+data.numAllInventory .toInt().toString()
                                                    ,10, Colors.black87,false),
                                                TextApp('از '
                                                    // +'از'+'کالا'+data.numAllInventory .toInt().toString()
                                                    ,10, Colors.black87,false),
                                                TextApp(' کالا '
                                                    // +'از'+'کالا'+data.numAllInventory .toInt().toString()
                                                    ,10, Colors.black87,false),
                                                TextApp(data.numCoverProduct.toInt().toString()
                                                    // +'از'+'کالا'+data.numAllInventory .toInt().toString()
                                                    ,10, Colors.black87,false),


                                              ],
                                            ),
                                          ],
                                        )),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('عدد',10, Colors.black54,false),
                                            TextApp(data.avgProductOrder.toInt().toString()+'%',10, Colors.black87,false),
                                          ],
                                        )),

                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            // TextApp('عدد',10, Colors.grey,false),
                                            TextApp('در فاکتور ها',10, Colors.black54,false),
                                          ],
                                        )),
                                  ],
                                )),
                            Container(
                              width: 1,
                              height: 25,
                              color: Colors.grey,
                            ),
                            Expanded(
                                flex: 4,
                                child: TextApp(
                                    'میانگین خط',
                                    10,Colors.black54,false
                                ))
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.5),
                        margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Expanded(
                                flex: 7,
                                child: Row(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('مبلغ',10, Colors.black54,false),
                                            TextApp(SplitPrice(data.pricePishSaleToSale),10, Colors.black87,false),
                                          ],
                                        )),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('درصد',10, Colors.black54,false),
                                            TextApp(data.percentPishSaleToSale.toInt().toString()+'%',10, Colors.black87,false),
                                          ],
                                        )),
                                    Container(
                                      width: 1,
                                      height: 25,
                                      color: Colors.grey,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            TextApp('عدد',10, Colors.black54,false),
                                            TextApp(data.numPishSaleToSale.toInt().toString(),10, Colors.black87,false),
                                          ],
                                        )),
                                  ],
                                )),
                            Container(
                              width: 1,
                              height: 25,
                              color: Colors.grey,
                            ),
                            Expanded(
                                flex: 4,
                                child: TextApp(
                                    'میزان تبدیل سفارش به فاکتور',
                                    10,Colors.black54,false
                                ))
                          ],
                        ),
                      ),
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