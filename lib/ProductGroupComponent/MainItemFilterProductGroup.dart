import 'package:flutter/material.dart';




import '../ColumItem.dart';
import '../Constants.dart';
import '../Models/CustGroup.dart';
import '../Models/CustomerGroupModel.dart';
import '../Models/ModelGroupProduct.dart';
import '../ProviceComponent/ItemGridProvice.dart';

import 'ItemGridProductGroup.dart';

class MainItemFilterProductGroup extends StatefulWidget {

  bool IsAllProvice;
  // List<ReCustGroup_2> CustomerGroup=[];
  List<ResultGroupProduct> ProductGroup=[];

  VoidCallback Func;
  VoidCallback Func2;






  MainItemFilterProductGroup(this.IsAllProvice,this.ProductGroup, this.Func,this.Func2);

  @override
  State<MainItemFilterProductGroup> createState() => _MainItemFilterState();
}

class _MainItemFilterState extends State<MainItemFilterProductGroup> {

  List<ReCustGroup_2> Temp=[];
  @override
  void initState() {
    super.initState();
  }

  Run(){
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap:  widget.Func,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ColumItem('گروه کالا')),
                ],
              ),
              widget.IsAllProvice==true|| widget.ProductGroup.length>0?
              Container(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    itemCount: widget.IsAllProvice==true?1:
                    widget.ProductGroup.length==0?0:
                    widget.ProductGroup.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        childAspectRatio: 2.5,
                        mainAxisSpacing: 4.0
                    ),
                    itemBuilder: (BuildContext context, int index){
                      return
                        ItemGridProductGroup(()   {
                          if(widget.IsAllProvice)
                          {
                            widget.ProductGroup.forEach((element) {
                              element.IsCheck=true;
                            });
                            widget.Func2();
                          }else{
                            // var temp=  widget.City.where((element) => element.IsCheck==true).toList()[index];
                            var dat=   widget.ProductGroup[index];
                            dat.IsCheck=false;
                            widget.ProductGroup[index]=dat;
                            widget.Func2();
                          }
                        },  widget.IsAllProvice,  widget.ProductGroup, index);
                    },
                  ),
                ),
              ):
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: BaseColor,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                  child: Text('برای مشاهده گروه محصولات کلیک کنید',
                    style: TextStyle(
                        color: Colors.white
                    ),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
