import 'package:flutter/material.dart';

import '../Constants.dart';
import '../Models/ModelPathSumVis.dart';
import '../TextApp.dart';
import 'ReportSumPathVisitor.dart';


class BoxSumPath extends StatelessWidget {


  Res_ModelPathSumVis data;


  BoxSumPath(this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
              color: BaseColor.withOpacity(0.25),
              spreadRadius: 2,
              blurRadius: 8
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextApp('نام کالا', 12,Colors.grey,false),
            TextApp(data.nameKala, 12,Colors.grey,false),
            Container(
              height: 0.5,
              margin: EdgeInsets.all(4),
              color: Colors.grey.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Expanded(child:
                  BoxInfo89('محتوی',data.mohvah.toString())),
                  Container(
                    height: 25,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Expanded(child:
                  BoxInfo89('شماره کالا',data.shka.toString())),
                  Container(
                    height: 25,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Expanded(child:
                  BoxInfo89('جز',data.tedJoz.toString())),
                  Container(
                    height: 25,
                    width: 1,
                    color: Colors.grey,
                  ),
                  Expanded(child:
                  BoxInfo89('واحد',data.tedVah.toInt().toString())),
                ],
              ),
            )



          ],
        ),
      ),
    );
  }
}