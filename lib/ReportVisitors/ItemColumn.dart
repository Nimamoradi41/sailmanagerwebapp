import 'package:flutter/material.dart';

import '../Constants.dart';
import '../TextApp.dart';

class ItemColumn extends StatelessWidget {



  String Text;
  double Price;

  bool Flag;
  bool Flag2;


  ItemColumn(this.Text, this.Price,this.Flag,this.Flag2);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flag2==true?
          Column(
            children: [
              TextApp(Text,11,ColorFirst,false),
              Container(
                margin: EdgeInsets.symmetric(vertical: 2),
                width: double.infinity,
                color: ColorFirst.withOpacity(0.5),
                height: 0.5,
              ),
            ],
          ):Container(),

          Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextApp( Flag?  SplitPrice(Price):Price.toInt().toString(),12,ColorSecond,false),
          ),
        ],
      ),
    );
  }
}