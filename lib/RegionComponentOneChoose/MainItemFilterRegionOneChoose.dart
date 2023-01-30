import 'package:flutter/material.dart';


import '../ColumItem.dart';
import '../Constants.dart';
import '../Models/ModelRegion.dart';
import '../Models/ModelRegions.dart';
import '../ProviceComponent/ItemGridProvice.dart';

import 'ItemGridRegionOneChoose.dart';

class MainItemFilterRegionOneChoose extends StatefulWidget {

  bool IsAllProvice;
  List<ResultModelRegions> Region=[];

  VoidCallback Func;
  VoidCallback Func2;



  double sizetext;



  MainItemFilterRegionOneChoose(this.IsAllProvice,this.Region, this.Func,this.Func2,this.sizetext);

  @override
  State<MainItemFilterRegionOneChoose> createState() => _MainItemFilterState();
}

class _MainItemFilterState extends State<MainItemFilterRegionOneChoose> {

  List<ReRegion> Temp=[];
  @override
  void initState() {
    // TODO: implement initState
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
                  Expanded(child: ColumItem('منطقه')),
                ],
              ),
              widget.IsAllProvice==true|| widget.Region.length>0?
              Container(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    itemCount: widget.IsAllProvice==true?1:
                    widget.Region.length==0?0:
                    widget.Region.length,
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
                        ItemGridRegionOneChoose(()   {
                          if(widget.IsAllProvice)
                          {
                            widget.Region.forEach((element) {
                              element.IsCheck=true;
                            });
                            widget.Func2();
                          }else{
                            // var temp=  widget.City.where((element) => element.IsCheck==true).toList()[index];
                            var dat=   widget.Region[index];
                            dat.IsCheck=false;
                            widget.Region[index]=dat;
                            widget.Func2();
                          }
                        },  widget.IsAllProvice,  widget.Region, index);
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
                  child: Text('برای مشاهده منطقه ها کلیک کنید',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: widget.sizetext,
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
