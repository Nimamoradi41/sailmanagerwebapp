import 'package:flutter/material.dart';

class ColumItem extends StatelessWidget {


  String Valuee;


  ColumItem( this.Valuee);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 2),
                  child: Text(Valuee,textAlign: TextAlign.end,style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14,
                      fontWeight: FontWeight.bold
                  ),),
                ),
              ),
              RotatedBox(
                  quarterTurns: 135,
                  child: Icon(Icons.arrow_back_ios_outlined,size: 15,))
            ],)
        ],),
    );
  }
}