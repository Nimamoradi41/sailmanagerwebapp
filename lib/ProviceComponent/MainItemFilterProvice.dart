import 'package:flutter/material.dart';



import '../ColumItem.dart';
import '../Constants.dart';
import '../Models/ModelProvice.dart';
import '../Models/ModelProvinces.dart';
import 'ItemGridProvice.dart';


class MainItemFilterProvice extends StatefulWidget {

  bool IsAllProvice;
  List<Re_Provice> Provice=[];


  VoidCallback Func;
  VoidCallback Func2;


  double sizetext;




  MainItemFilterProvice(this.IsAllProvice, this.Provice, this.Func,this.Func2,this.sizetext);




  @override
  State<MainItemFilterProvice> createState() => _MainItemFilterState();
}

class _MainItemFilterState extends State<MainItemFilterProvice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap:  widget.Func,
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: ColumItem('استان')),
                ],
              ),
              widget.IsAllProvice==true|| widget.Provice.where((element) => element.IsCheck==true).toList().length>0?
              Directionality(
                textDirection: TextDirection.rtl,
                child: GridView.builder(
                  itemCount:widget.IsAllProvice==true?1:
                  widget.Provice.length==0?0:
                  widget.Provice.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4.0,
                      childAspectRatio: 2.5,
                      mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (BuildContext context, int index){

                    print(widget.IsAllProvice.toString());
                    return
                      ItemGridProvice(()
                      {
                        if(widget.IsAllProvice)
                        {
                          widget.Provice.forEach((element){
                            element.IsCheck=true;
                          });
                          widget.Func2();
                        }else{
                          var dat=   widget.Provice[index];
                          dat.IsCheck=false;
                          widget.Provice[index]=dat;
                          widget.Func2();
                        }
                      },widget.IsAllProvice,
                          widget.Provice, index);
                  },
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
                  child: Text('برای مشاهده استان ها کلیک کنید',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                      fontSize: widget.sizetext
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
