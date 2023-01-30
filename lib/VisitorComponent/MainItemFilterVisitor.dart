import 'package:flutter/material.dart';


import '../ColumItem.dart';
import '../Constants.dart';
import '../Models/ModelVisitorsAll.dart';

import 'ItemGridVisitor.dart';



class MainItemFilterVistor extends StatefulWidget {

  bool IsAllProvice;
  List<Re_VisitorsAll> City=[];

  VoidCallback Func;
  VoidCallback Func2;




  double sizetext;

  MainItemFilterVistor(this.IsAllProvice,this.City, this.Func,this.Func2,this.sizetext);

  @override
  State<MainItemFilterVistor> createState() => _MainItemFilterState();
}

class _MainItemFilterState extends State<MainItemFilterVistor> {

  List<Re_VisitorsAll> Temp=[];
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
                  Expanded(child: ColumItem('ویزیتور')),
                ],
              ),
              widget.IsAllProvice==true|| widget.City.length>0?
              Container(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    itemCount: widget.IsAllProvice==true?1:
                    widget.City.length==0?0:
                    widget.City.length,
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
                        ItemGridVisitor(()   {
                          if(widget.IsAllProvice)
                          {
                            widget.City.forEach((element) {
                              element.IsCheck=true;
                            });
                            widget.Func2();
                          }else{
                            // var temp=  widget.City.where((element) => element.IsCheck==true).toList()[index];
                            var dat=   widget.City[index];
                            dat.IsCheck=false;
                            widget.City[index]=dat;
                            widget.Func2();
                          }
                        },  widget.IsAllProvice,  widget.City, index);
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
                  child: Text('برای مشاهده ویزیتور ها کلیک کنید',
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
