import 'package:flutter/material.dart';


import '../ColumItem.dart';
import '../Constants.dart';
import '../Models/ModelWay.dart';
import '../ProviceComponent/ItemGridProvice.dart';

import 'ItemGridPath.dart';

class MainItemFilterPath extends StatefulWidget {

  bool IsAllProvice;
  List<ReWay> Path=[];

  VoidCallback Func;
  VoidCallback Func2;





  double sizetext;

  MainItemFilterPath(this.IsAllProvice,this.Path, this.Func,this.Func2,this.sizetext);

  @override
  State<MainItemFilterPath> createState() => _MainItemFilterState();
}

class _MainItemFilterState extends State<MainItemFilterPath> {

  List<ReWay> Temp=[];
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
                  Expanded(child: ColumItem('مسیر')),
                ],
              ),
              widget.IsAllProvice==true|| widget.Path.length>0?
              Container(

                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: GridView.builder(
                    itemCount: widget.IsAllProvice==true?1:
                    widget.Path.length==0?0:
                    widget.Path.length,
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
                        ItemGridPath(()   {
                          if(widget.IsAllProvice)
                          {
                            widget.Path.forEach((element) {
                              element.IsCheck=true;
                            });
                            widget.Func2();
                          }else{
                            // var temp=  widget.City.where((element) => element.IsCheck==true).toList()[index];
                            var dat=   widget.Path[index];
                            dat.IsCheck=false;
                            widget.Path[index]=dat;
                            widget.Func2();
                          }
                        },  widget.IsAllProvice,  widget.Path, index);
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
                  child: Text('برای مشاهده مسیر ها کلیک کنید',
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
