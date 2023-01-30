import 'package:flutter/material.dart';




import '../ColumItem.dart';
import '../Constants.dart';
import '../Models/CustGroup.dart';
import '../Models/CustomerGroupModel.dart';
import '../Models/ModelCustomerNew.dart';
import '../ProviceComponent/ItemGridProvice.dart';

import 'ItemGridCustomer.dart';

class MainItemFilterCustomer extends StatefulWidget {

  bool IsAllProvice;
  // List<ReCustGroup_2> CustomerGroup=[];
  List<ResultModelCustomerNew> CustomerGroup=[];

  VoidCallback Func;
  VoidCallback Func2;






  MainItemFilterCustomer(this.IsAllProvice,this.CustomerGroup, this.Func,this.Func2);

  @override
  State<MainItemFilterCustomer> createState() => _MainItemFilterState();
}

class _MainItemFilterState extends State<MainItemFilterCustomer> {

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
                  Expanded(child: ColumItem('مشتری')),
                ],
              ),
              widget.IsAllProvice==true|| widget.CustomerGroup.length>0?
              Container(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    itemCount: widget.IsAllProvice==true?1:
                    widget.CustomerGroup.length==0?0:
                    widget.CustomerGroup.length,
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
                        ItemGridCustomer(()   {
                          if(widget.IsAllProvice)
                          {
                            widget.CustomerGroup.forEach((element) {
                              element.IsCheck=true;
                            });
                            widget.Func2();
                          }else{
                            // var temp=  widget.City.where((element) => element.IsCheck==true).toList()[index];
                            var dat=   widget.CustomerGroup[index];
                            dat.IsCheck=false;
                            widget.CustomerGroup[index]=dat;
                            widget.Func2();
                          }
                        },  widget.IsAllProvice,  widget.CustomerGroup, index);
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
                  child: Text('برای مشاهده مشتری ها کلیک کنید',
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
