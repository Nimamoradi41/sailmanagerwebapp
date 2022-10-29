import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';


import '../Constants.dart';
import '../Models/Visitors.dart';
import '../TextApp.dart';
import '../VisitorComponent/MainItemFilterVisitor.dart';
import '../VisitorComponent/ScreenDetailVisitor.dart';
import 'ItemColumn.dart';
import 'ItemListview.dart';
enum TypeSelect { all,certain,uncertain }
enum TypeSelectItem { True,False }
class ScreenReportVisitors extends StatefulWidget {



  @override
  State<ScreenReportVisitors> createState() => _ScreenReportVisitorsState();
}

class _ScreenReportVisitorsState extends State<ScreenReportVisitors> {
  bool FlagFilter=true;

  String Data_From="از تاریخ";
  String Az_Data="";
  String Data_To="تا تاریخ";
  String Ta_Data="";

  Future _showDatePicker_To()async{
    final bool showTitleActions = false;
    Jalali j = Jalali.now();

    Jalali? picked = await showPersianDatePicker(
      context: context,
      initialDate:   Ta_Data.isEmpty? Jalali.now():
      Jalali(
          int.parse(Ta_Data.split('/')[0].toString()),
          int.parse(Ta_Data.split('/')[1].toString()),
          int.parse(Ta_Data.split('/')[2].toString())),
      firstDate: Jalali(1385,8),
      lastDate: Jalali(1450,9),
    );

    if(picked!=null)
    {
      var Data=Convert_DATE(picked.day.toString(), picked.month.toString(), picked.year.toString());
      Ta_Data=Data;
      setState(() {
        Data_To=Data+" تا تاریخ ";
      });
    }


  }
  Future _showDatePicker_From()async {
    final bool showTitleActions = false;



    Jalali j = Jalali.now();
    print(j.toString());





    Jalali? picked = await showPersianDatePicker(
      context: context,
      // initialDate: Jalali.now(),
      initialDate:
      Az_Data.isEmpty? Jalali.now():
      Jalali(
          int.parse(Az_Data.split('/')[0].toString()),
          int.parse(Az_Data.split('/')[1].toString()),
          int.parse(Az_Data.split('/')[2].toString())),
      firstDate: Jalali(1385, 8),
      lastDate: Jalali(1450, 9),
    );

    if(picked!=null)
    {
      var Data=Convert_DATE(picked.day.toString(), picked.month.toString(), picked.year.toString());
      // Az_Data=Data.replaceAll('/', '');
      Az_Data=Data;
      print(Az_Data);
      setState(() {
        Data_From=Data+" از تاریخ ";
      });
    }


  }
  Future GetDataNow () async
  {
    // DateTime dt = DateTime.now();
    Jalali j = Jalali.now();

    setState(() {
      Data_From=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString())+' '+'از';
      Az_Data=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());
      Ta_Data=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());
      Data_To=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString())+' '+'تا';



    });






  }





  List<Visitors>  main=[];
  TextEditingController txtsearch=TextEditingController();

  @override
  void initState() {
    super.initState();
    var sd=Visitors();
    sd.Name="Nima";
    var sd2=Visitors();
    sd2.Name="Faraz";

    var sd3=Visitors();
    sd3.Name="Ali";


    var sd4=Visitors();
    sd4.Name="Ahmad";


    main.add(sd);
    main.add(sd2);
    main.add(sd3);
    main.add(sd4);
    GetDataNow();
  }



  TypeSelect TypeSel = TypeSelect.all;
  TypeSelectItem TypeSelItem = TypeSelectItem.True;

  Future ShowModall_() async
  {
    bool b=await   showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx){

          return Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: StatefulBuilder(
                builder: (context,state){
                  return  SafeArea(
                    child:
                    Stack(
                        children:[
                          Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'جستجو کنید',
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                          hintStyle: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey
                                          )
                                      ),

                                      textAlign: TextAlign.right,
                                      controller: txtsearch,
                                      onChanged: (val){
                                        state(() {
                                          var  s=val.replaceAll('ی','ي');
                                          s=s.replaceAll('ک','ك');
                                          txtsearch.text=s;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    state(() {


                                      IsAllVisitors=!IsAllVisitors;




                                    });


                                      if(IsAllVisitors==true)
                                      {
                                        state(() {
                                          main.forEach((element) {
                                            element.IsCheck=true;
                                          });
                                        });

                                      }else{
                                        state(() {
                                          main.forEach((element) {
                                            element.IsCheck=false;
                                          });
                                        });
                                      }










                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text('انتخاب همه'),
                                      Checkbox(
                                        value:

                                        IsAllVisitors,
                                        activeColor: BaseColor ,
                                        focusColor:BaseColor ,
                                        onChanged: (bool? value) {
                                          state(() {


                                            IsAllVisitors=!IsAllVisitors;




                                          });


                                            if(IsAllVisitors==true)
                                            {


                                              state(() {
                                                main.forEach((element) {
                                                  element.IsCheck=true;
                                                });
                                              });

                                            }else{
                                              state(() {
                                                main.forEach((element) {
                                                  element.IsCheck=false;
                                                });
                                              });
                                            }





                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    // itemCount: Departments.length,
                                    itemCount:  main.length,
                                    itemBuilder: (ctx,item){
                                      return
                                        txtsearch.text.isEmpty?
                                        Container(
                                          child: InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: ()
                                            {


                                                if(IsAllVisitors==false)
                                                {
                                                  state(() {
                                                    main[item].IsCheck= !main[item].IsCheck;
                                                  });
                                                }
                                                // Navigator.pop(context);






                                              FocusScope.of(context).unfocus();

                                              // Navigator.pop(context,Departments[item].toString());
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                 main[item].Name ),
                                                // Text(sa),
                                                Checkbox(
                                                  value:

                                                  main[item].IsCheck,
                                                  activeColor: BaseColor ,
                                                  focusColor:BaseColor ,
                                                  onChanged: (bool? value) {

                                                      if(IsAllVisitors==false)
                                                      {
                                                        state(() {
                                                          main[item].IsCheck=value!;
                                                        });
                                                      }
                                                      // Navigator.pop(context);




                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ) :
                                        txtsearch.text.isNotEmpty &&  main[item].Name.contains(txtsearch.text.toString())?
                                        Container(
                                          child: InkWell(
                                            highlightColor: Colors.transparent,
                                            onTap: ()
                                            {


                                                if(IsAllVisitors==false)
                                                {
                                                  state(() {
                                                    main[item].IsCheck= !main[item].IsCheck;
                                                  });
                                                }
                                                // Navigator.pop(context);

                                              FocusScope.of(context).unfocus();

                                              // Navigator.pop(context,Departments[item].toString());
                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                   main[item].Name ),
                                                // Text(sa),
                                                Checkbox(
                                                  value:
                                                 main[item].IsCheck,
                                                  activeColor: BaseColor ,
                                                  focusColor:BaseColor ,
                                                  onChanged: (bool? value) {


                                                      if(IsAllVisitors==false)
                                                      {
                                                        state(() {
                                                          main[item].IsCheck=value!;
                                                        });
                                                      }
                                                      // Navigator.pop(context);




                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ):Container();



                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                              left: 0,
                              bottom: 0,
                              child: InkWell(
                                onTap: (){
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  Navigator.pop(context);



                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.circular(8)
                                  ),
                                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4),
                                    child: Row(
                                      children: [
                                        Text('بستن',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16
                                          ),),
                                        Icon(Icons.close,color: Colors.white,)
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ]
                    ),
                  );
                }),
          );
        });


    setState(() {

    });


    // if(Flag=='1')
    //   {
    //     if(IsAllProvice)
    //       {
    //        ProviceSelected.addAll(Provice);
    //       }else{
    //       Provice.forEach((element) {
    //         if(element.)
    //       });
    //     }
    //   }


    print(b.toString());
  }


  bool IsAllVisitors=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorBack,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          main.length>0?
          InkWell(
            onTap: (){


              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                  ScreenDetailVisitor()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.info_outline,color: Colors.white,),
            ),
          ):Container()
        ],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('لیست پیش فاکتور های تایید نشده',style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold
          ),),
        ),
        backgroundColor: BaseColor,
        leading: GestureDetector(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child:FlagFilter==true?
        SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 80),
                child: ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (ctx,item){
                    return ItemListview();
                  }
                  ),
              ),

            ],
          ),
        ):
        Container(
          child: Container(
            width: double.infinity,
            child: InkWell
              (
                onTap: (){
                  setState(() {
                    FlagFilter=!FlagFilter;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Expanded(child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: TextApp('تا تاریخ', 10, Colors.grey, true),
                                    ))),
                                Expanded(child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 8.0),
                                      child: TextApp('از تاریخ', 10, Colors.grey, true),
                                    ))),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: InkWell(
                                        onTap:  _showDatePicker_To,
                                        // child:    CardMain(Data_To, BaseColor),
                                        child:    Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: BaseColor,width: 1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: SvgPicture.asset('images/arrow_3.svg',width: 10,height: 10,),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextApp(Data_From,12,Colors.black54,false),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ),
                                    ),
                                  ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: InkWell(
                                        onTap:  _showDatePicker_To,
                                        // child:    CardMain(Data_To, BaseColor),
                                        child:    Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(color: BaseColor,width: 1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: SvgPicture.asset('images/arrow_3.svg',width: 10,height: 10,),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: TextApp(Data_To,12,Colors.black54,false),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextApp('وضعیت', 12, Colors.grey,  true),
                            ),
                            Row(
                              children: [
                                Expanded(child:  InkWell(
                                  onTap: (){
                                    setState(() {
                                      TypeSel = TypeSelect.uncertain;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            setState(() {

                                            });
                                          },
                                          child: Text('غیر قطعی',style: TextStyle(color:
                                          Colors.black54
                                              ,fontSize: 12),)),
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: BaseColor,
                                          ),
                                          child:

                                          Radio<TypeSelect>(
                                            value: TypeSelect.uncertain,
                                            groupValue: TypeSel,
                                            activeColor: BaseColor,
                                            onChanged: (TypeSelect? value) {
                                              setState(() {
                                                TypeSel = value!;

                                              });
                                            },
                                          )

                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(child:  InkWell(
                                  onTap: (){
                                    setState(() {
                                      TypeSel = TypeSelect.certain;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            setState(() {

                                            });
                                          },
                                          child: Text('قطعی',style: TextStyle(color:
                                          Colors.black54
                                              ,fontSize: 12),)),
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: BaseColor,
                                          ),
                                          child:

                                          Radio<TypeSelect>(
                                            value: TypeSelect.certain,
                                            groupValue: TypeSel,
                                            activeColor: BaseColor,
                                            onChanged: (TypeSelect? value) {
                                              setState(() {
                                                TypeSel = value!;
                                              });
                                            },
                                          )

                                      ),
                                    ],
                                  ),
                                )),
                                Expanded(child:  InkWell(
                                  onTap: (){
                                    setState(() {
                                      TypeSel = TypeSelect.all;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            setState(() {

                                            });
                                          },
                                          child: Text('همه',style: TextStyle(color:
                                          Colors.black54
                                              ,fontSize: 12),)),
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: BaseColor,
                                          ),
                                          child: Radio<TypeSelect>(
                                            value: TypeSelect.all,
                                            groupValue: TypeSel,
                                            activeColor: BaseColor,
                                            onChanged: (TypeSelect? value) {
                                              setState(() {
                                                TypeSel = value!;
                                              });
                                            },
                                          )
                                        // Radio(
                                        //   value: 'جدید ترین',
                                        //   groupValue: TypeSel,
                                        //   onChanged: (TypeSelect? value) {
                                        //     setState(() {
                                        //       TypeSel=value;
                                        //       NewItem=false;
                                        //       OldItem=false;
                                        //       DateItem=!DateItem;
                                        //     });
                                        //   },
                                        // ),
                                      ),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextApp('ویزیتور', 12, Colors.grey,  true),
                            ),
                            MainItemFilterVistor(IsAllVisitors,
                                main.where((element) => element.IsCheck==true).toList()

                                // .sort((a, b) => a.someProperty.compareTo(b.someProperty))
                                ,(){
                              // if(main.length==0)
                              // {
                              //   Run('2');
                              // }else{
                              //   ShowModall_("2");
                              // }

                              ShowModall_();
                            },() {







                              setState(() {

                              });




                            }),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextApp('حالت ویزیتور', 12, Colors.grey,  true),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      TypeSelItem = TypeSelectItem.True;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            setState(() {

                                            });
                                          },
                                          child: Text('فروش و برگشتی براساس تاریخ فاکتور',style: TextStyle(color:
                                          Colors.black54
                                              ,fontSize: 12),)),
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: BaseColor,
                                          ),
                                          child:

                                          Radio<TypeSelectItem>(
                                            value: TypeSelectItem.True,
                                            groupValue: TypeSelItem,
                                            activeColor: BaseColor,
                                            onChanged: (TypeSelectItem? value) {
                                              setState(() {
                                                TypeSelItem = value!;

                                              });
                                            },
                                          )

                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    setState(() {
                                      TypeSelItem = TypeSelectItem.False;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: (){
                                            setState(() {
                                            });
                                          },
                                          child: Text('فروش برگشتی براساس تاریخ برگشتی + برگشت مشتری',style: TextStyle(color:
                                          Colors.black54
                                              ,fontSize: 12),)),
                                      Theme(
                                          data: Theme.of(context).copyWith(
                                            unselectedWidgetColor: BaseColor,
                                          ),
                                          child:

                                          Radio<TypeSelectItem>(
                                            value: TypeSelectItem.False,
                                            groupValue: TypeSelItem,
                                            activeColor: BaseColor,
                                            onChanged: (TypeSelectItem? value) {
                                              setState(() {
                                                TypeSelItem = value!;
                                              });
                                            },
                                          )

                                      ),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(child:Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                        Expanded(child: Container(
                          margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                          width: double.maxFinite,
                          child: ElevatedButton(onPressed: (){
                            if(main.length==0)
                            {
                              Navigator.pop(context);
                            }else{
                              setState(() {
                                FlagFilter=!FlagFilter;
                              });
                            }
                          },
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.red),
                              child:
                              Text('بستن',style: TextStyle(
                                  color: Colors.white
                              ),)),
                        )),
                        Expanded(child: Container(
                          margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                          width: double.maxFinite,
                          child: ElevatedButton(
                              onPressed: (){
                                setState(() {
                                  FlagFilter=false;
                                });
                                // PageCounter=1;
                                // PageCounterMain=2;
                                // Customers.clear();
                                // PageCounterCheck=false;

                                // GetCustomers('',false);
                              },
                              style: ElevatedButton.styleFrom(primary: BaseColor),
                              child:
                              Text('نمایش',style: TextStyle(
                                  color: Colors.white
                              ),)),
                        )),
                      ],))
                    ],
                  ),
                )),
          ),
        ),
      ),
      floatingActionButton: FlagFilter==true?
      InkWell(
        onTap: (){
          setState(() {
            FlagFilter=!FlagFilter;
          });
        },
        child:   Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: FloatingActionButton(
            backgroundColor: BaseColor,
            onPressed: (){
              setState(() {
                FlagFilter=!FlagFilter;
              });
            },
            child: InkWell(
              onTap: (){
                setState(() {
                  FlagFilter=!FlagFilter;
                });
              },
              child: Icon(
                Icons.filter_alt_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ):Container(),
    );
  }
}


class CardMain extends StatelessWidget {

  String Data_To;
  Color C;

  CardMain(this.Data_To,this.C);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            child: Card(
              elevation: 8,
              color: C,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_drop_down_circle,  color: Colors.white),
                    Expanded(child: Text(Data_To,
                        textAlign:TextAlign.center ,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color:Colors.white,
                          decoration: TextDecoration.none,)) )
                  ],
                ),
              ),
            ),
          ),
        ),

      ],
    );
  }
}



