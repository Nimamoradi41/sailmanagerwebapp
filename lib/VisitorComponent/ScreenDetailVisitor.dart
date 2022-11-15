import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Constants.dart';
import '../Models/ModelVisitorsReport.dart';
import '../ReportVisitors/ItemListviewSum.dart';



class ScreenDetailVisitor extends StatelessWidget {
  // List<Detail> detail;


  ModelVisitorsReport  dataa;


  ScreenDetailVisitor(this.dataa);

  @override
  Widget build(BuildContext context) {
    var Sizewid=MediaQuery.of(context).size.width;
    var formatter = NumberFormat('###,###,###,###',"fa_IR");
    return Center(
      child: Container(
        width: Sizewid>600?600:Sizewid,
        child: Scaffold(
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
                    child: ItemListviewSum('ناخالص',1,dataa)),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ItemListviewSum('برگشتی',2,dataa)),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ItemListviewSum('خالص',3,dataa)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
