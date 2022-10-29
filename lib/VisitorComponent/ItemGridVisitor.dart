import 'package:flutter/material.dart';



import '../Constants.dart';
import '../Models/Visitors.dart';


class ItemGridVisitor extends StatelessWidget {

  VoidCallback Func;
  bool IsAllProvice;
  List<Visitors> Provice=[];

  int index;


  ItemGridVisitor(this.Func, this.IsAllProvice, this.Provice, this.index);



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Func,
      child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.black54, width: 1),
              color: BaseColor,
              borderRadius: BorderRadius.circular(8)
          ),
          child:IsAllProvice==true
              ?Center(
            child: Row(
              children: [
                Icon(Icons.close,color: Colors.white,size: 15,),
                Expanded(
                  child: Text('انتخاب همه',textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.white,
                      fontSize: 10
                  ),),
                ),
              ],
            ),
          ):
          Provice.length>0?
          Center(
            child: Row(
              children: [
                Icon(Icons.close,color: Colors.white,size: 15,),
                Expanded(
                  child: Text(
                    Provice[index].Name.toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  ),),
                ),

              ],
            ),
          ):Container()
      ),
    );
  }
}
