import 'package:flutter/material.dart';




import '../ColumItem.dart';
import '../Constants.dart';
import '../Models/ModelCity.dart';
import '../Models/ModelCitys.dart';
import '../ProviceComponent/ItemGridProvice.dart';

import 'ItemGridCity.dart';

class MainItemFilterCity extends StatefulWidget {

  bool IsAllProvice;
  List<ReC_City> City=[];


  VoidCallback Func;
  VoidCallback Func2;



  double sizetext;



  MainItemFilterCity(this.IsAllProvice,this.City, this.Func,this.Func2,this.sizetext);

  @override
  State<MainItemFilterCity> createState() => _MainItemFilterState();
}

class _MainItemFilterState extends State<MainItemFilterCity> {

  List<ReC_City> Temp=[];
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
                  Expanded(child: ColumItem('شهر')),
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
                        ItemGridCity(()   {
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
                  child: Text('برای مشاهده شهر ها کلیک کنید',
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
