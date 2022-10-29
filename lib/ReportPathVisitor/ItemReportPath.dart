import 'package:flutter/material.dart';

import '../Constants.dart';
import '../TextApp.dart';


class ItemReportPath extends StatelessWidget {
  const ItemReportPath({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                                            TextApp('عدد',10, Colors.grey,false),
                                            TextApp('۱۵۴۱۵',10, Colors.grey,false),
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
                                  10,Colors.grey,false
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
                                            TextApp('درصد',10, Colors.grey,false),
                                            TextApp('15%',10, Colors.grey,false),
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
                                          TextApp('عدد',10, Colors.grey,false),
                                          TextApp('۱۵۴۱۵',10, Colors.grey,false),
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
                                  10,Colors.grey,false
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
                                          TextApp('مبلغ',10, Colors.grey,false),
                                          TextApp('154658547845',10, Colors.grey,false),
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
                                          TextApp('درصد',10, Colors.grey,false),
                                          TextApp('15%',10, Colors.grey,false),
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
                                          TextApp('عدد',10, Colors.grey,false),
                                          TextApp('۱۵۴۱۵',10, Colors.grey,false),
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
                                  10,Colors.grey,false
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
                                            TextApp('درصد',10, Colors.grey,false),
                                            TextApp('15%',10, Colors.grey,false),
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
                                          TextApp('عدد',10, Colors.grey,false),
                                          TextApp('۱۵۴۱۵',10, Colors.grey,false),
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
                                  10,Colors.grey,false
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
                                          TextApp('از کل محصولات',10, Colors.grey,false),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextApp('48% - ',10, Colors.grey,false),
                                              SizedBox(width: 3,),
                                              TextApp('12',10, Colors.grey,false),
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
                                          TextApp('درصد',10, Colors.grey,false),
                                          TextApp('15%',10, Colors.grey,false),
                                        ],
                                      )),

                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // TextApp('عدد',10, Colors.grey,false),
                                          TextApp('در فاکتور ها',10, Colors.grey,false),
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
                                  10,Colors.grey,false
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
                                          TextApp('مبلغ',10, Colors.grey,false),
                                          TextApp('154658547845',10, Colors.grey,false),
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
                                          TextApp('درصد',10, Colors.grey,false),
                                          TextApp('15%',10, Colors.grey,false),
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
                                          TextApp('عدد',10, Colors.grey,false),
                                          TextApp('۱۵۴۱۵',10, Colors.grey,false),
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
                                  10,Colors.grey,false
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
    );
  }
}