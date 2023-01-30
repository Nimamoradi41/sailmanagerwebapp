import 'package:flutter/material.dart';


import '../Constants.dart';
import '../Models/CustGroup.dart';
import '../Models/CustomerGroupModel.dart';
import '../Models/ModelGroupProduct.dart';


class ItemGridProductGroup extends StatelessWidget {

  VoidCallback Func;
  bool IsAllProvice;
  List<ResultGroupProduct> Product=[];

  int index;


  ItemGridProductGroup(this.Func, this.IsAllProvice, this.Product, this.index);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Func,
      child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              border: Border.all(color: Color_ListCustomerDark, width: 1),
              color: BaseColor,
              borderRadius: BorderRadius.circular(8)
          ),
          child:IsAllProvice==true
              ?Center(
            child: Text('انتخاب همه',textAlign: TextAlign.center,style: TextStyle(
                color: Colors.white,
                fontSize: 10
            ),),
          ):
          Product.isNotEmpty?
          Center(
            child: Row(
              children: [
                Icon(Icons.close,color: Colors.white,size: 15,),
                Expanded(
                  child: Text(
                    Product[index].groupName.toString(),
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
