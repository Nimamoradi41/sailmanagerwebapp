import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../Constants.dart';
import '../Models/ModelVisitorsAll.dart';

import '../Models/Modelpathvisitor.dart';
import '../ReportVisitors/ItemColumn.dart';
import '../TextApp.dart';
import '../VisitorComponent/MainItemFilterVisitor.dart';
import 'ItemReportPath.dart';
import 'ReportSumPathVisitor.dart';

class ReportPathVisitor extends StatefulWidget {

  @override
  State<ReportPathVisitor> createState() => _ReportPathVisitorState();
}

class _ReportPathVisitorState extends State<ReportPathVisitor> {
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
        Data_To=Data;
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
        Data_From=Data;
      });
    }


  }


  Future GetDataNow () async
  {
    // DateTime dt = DateTime.now();
    Jalali j = Jalali.now();

    setState(() {
      Data_From=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString())+' ';
      Az_Data=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());
      Ta_Data=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString());
      Data_To=Convert_DATE(j.day.toString(),j.month.toString(),j.year.toString())+' ';
    });






  }
  List<Re_VisitorsAll>  main=[];
  bool FlagFilter=true;
  bool IsAllVisitors=false;
  bool FlagCheckOneDay=false;
  bool One=false;
  @override
  void initState() {
    super.initState();
    GetDataNow();
  }

  List<Res_Vis_Path>  mainItems=[];
  Future RunVisitors()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    var Data=await ApiService.GetVisitorsAll(pr, base!, UserName!, Password!);
    pr.hide();
    if(Data!=null)
    {
      if(Data.code==200)
      {
        if(Data.res!=null)
        {
          main=Data.res;
          setState(() {

          });
          ShowModall_();
        }else{
          ApiService.ShowSnackbar(Data.msg.toString());
        }

      }else{
        ApiService.ShowSnackbar(Data.msg.toString());
      }

    }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }
  }
  Future GetData()async{
    List<int> visid=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');

    if(IsAllVisitors)
    {
      main.forEach((element) {
        visid.add(element.visRdf);
      });
    }else if(main.length>0)
    {
      main.forEach((element) {
        if(element.IsCheck)
        {
          visid.add(element.visRdf);
        }
      });
    }


    setState(() {
      FlagFilter=false;
    });

    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);

    var Data=await ApiService.GetVisitorsPath(pr, base!, UserName!, Password!,
        Ta_Data,Az_Data,visid,FlagCheckOneDay
        );
    pr.hide();
    if(Data!=null)
    {
      if(Data.code==200)
      {
        if(Data.res!=null)
        {
          setState(() {
            mainItems=Data.res;
          });
        }else{
          ApiService.ShowSnackbar(Data.msg.toString());
        }
      }else{
        ApiService.ShowSnackbar(Data.msg);
      }

    }else{

      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }
  }


  Future<Null> _refresh() {
    mainItems.clear();
    return GetData().then((_user) {
    });
  }
  Future<bool> _onWillPop2() async {

    if(FlagFilter==false)
    {
      Navigator.pop(context);
      return false;
    }else{
      if(mainItems.length==0)
      {
        Navigator.pop(context);
        return false;
      }else{
        setState(() {
          FlagFilter=false;
        });
      }

    }

    return false;


  }

  TextEditingController txtsearch=TextEditingController();
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
                                                    main[item].name ),
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
                                        txtsearch.text.isNotEmpty &&  main[item].name.contains(txtsearch.text.toString())?
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
                                                    main[item].name ),
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:_onWillPop2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: BaseColor,
          title:Column(
            children: [
              Text('گزارش روز مسیر ویزیتور',
                style: TextStyle(fontSize: 10),textAlign: TextAlign.center,)
            ],
          ),
          leading: InkWell
            (
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back,color: Colors.white,)),
        ),
        body: FlagFilter==true?
         Column(
           children: [
             SingleChildScrollView(
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Row(
                       children: [
                         Expanded(child: Align(
                             alignment: Alignment.centerRight,
                             child:
                             Padding(
                               padding: const EdgeInsets.only(right: 8.0),
                               child: TextApp('تا تاریخ', 10, Colors.grey, true),
                             ))),
                             Expanded(child:Align(
                             alignment: Alignment.centerRight,
                             child: Padding(
                               padding: const EdgeInsets.only(right: 8.0),
                               child: TextApp('از تاریخ', 10, Colors.grey, true),
                             ))),
                       ],
                     ),
                   ),
                   Row(
                     children: [
                       Expanded(child:  Padding(
                           padding: const EdgeInsets.all(8),
                           child: InkWell(
                               onTap:  _showDatePicker_From,
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
                         )),
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
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       TextApp('براساس روز مسیر',12,Colors.grey,true),
                       Checkbox(
                         value:
                         FlagCheckOneDay,
                         activeColor: BaseColor ,
                         focusColor:BaseColor ,
                         onChanged: (bool? value) {
                           setState(() {
                             FlagCheckOneDay=!FlagCheckOneDay;
                           });



                         },
                       ),
                     ],
                   ),
                   MainItemFilterVistor(IsAllVisitors,
                       main.where((element) => element.IsCheck==true).toList()

                       // .sort((a, b) => a.someProperty.compareTo(b.someProperty))
                       ,(){
                         if(main.length==0)
                         {
                           RunVisitors();
                         }else{
                           ShowModall_();
                         }

                         // ShowModall_();
                       },() {







                         setState(() {});
                       }),
                 ],
               ),
             ),
             Expanded(
                 child:
                 Row(
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



                         GetData();
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
               ],)
             )
           ],
         ):
        RefreshIndicator(
          onRefresh: _refresh,
           child: Container(
        width: double.infinity,

        child: Padding(
          padding: EdgeInsets.only(right: 4,bottom: 90,left: 4,top: 4),
          child: ListView.builder(
                itemCount: mainItems.length,
                itemBuilder: (ctx,item){
                  return  InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context)
                                => ReportSumPathVisitor(mainItems[item].visRdf.toString(),Az_Data,Ta_Data)));
                      },
                      child: Container(
                          margin: item==mainItems.length-1?EdgeInsets.only(bottom: 100):null,
                          child: ItemReportPath(mainItems[item])));
                }
                ),
        ),
      ),
         ),
        floatingActionButton: FlagFilter==false?
        Padding(
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
        ):Container(),
      ),
    );
  }
}


