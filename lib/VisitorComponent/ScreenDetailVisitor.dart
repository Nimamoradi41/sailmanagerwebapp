import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Constants.dart';
import '../ReportVisitors/ItemListviewSum.dart';



class ScreenDetailVisitor extends StatelessWidget {
  // List<Detail> detail;


  ScreenDetailVisitor();

  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('###,###,###,###',"fa_IR");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: BaseColor,
        title:Column(
          children: [
            Text('آتیران ', textAlign: TextAlign.center),
            Text('سرجمع',style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
          ],
        ),
        leading: InkWell
          (
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ItemListviewSum('ناخالص')),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ItemListviewSum('برگشتی')),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ItemListviewSum('خالص')),
          ],
        ),
      ),
    );
  }
}