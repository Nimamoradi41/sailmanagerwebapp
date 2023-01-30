

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../ApiService.dart';
import '../Calender/TextApp.dart';
import '../CityComponentOneChoose/MainItemFilterCityOneChoose.dart';
import '../ColumItem.dart';
import '../Constants.dart';

import '../CustomerComponent/ItemGridCustomer.dart';
import '../CustomerGroupComponent/MainItemFilterCustomerGroup.dart';
import '../DayPath/BoxInfoCopy.dart';
import '../Models/CustGroup.dart';
import '../Models/CustomerGroupModel.dart';
import '../Models/ModelCitys.dart';
import '../Models/ModelCustomerNew.dart';
import '../Models/ModelKalaNotSale.dart';
import '../Models/ModelPaths.dart';
import '../Models/ModelProvinces.dart';
import '../Models/ModelRegions.dart';
import '../Models/ModelUncoveredPaths.dart';
import '../Models/ModelVisitorsAll.dart';
import '../Models/Modelpathvisitor.dart';
import '../NoSaleProduct/ItemKalaNotSale.dart';
import '../PathComponentOneChoose/MainItemFilterPath.dart';
import '../ProviceComponentOneChoose/MainItemFilterProvice.dart';
import '../RegionComponentOneChoose/MainItemFilterRegionOneChoose.dart';
import '../ReportPathVisitor/ItemReportPath.dart';
import '../ReportPathVisitor/ReportSumPathVisitor.dart';
import '../ScreenCustomerNew.dart';
import '../VisitorComponent/MainItemFilterVisitor.dart';
import 'ItemNoSaleCustomer.dart';



class ScreenNotSaleProductMain extends StatefulWidget {
  @override
  State<ScreenNotSaleProductMain> createState() => _ScreenNoSupportProductState();
}



class _ScreenNoSupportProductState extends State<ScreenNotSaleProductMain> {
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
  bool FlagFilter=false;
  bool IsAllVisitors=false;
  bool FlagCheckOneDay=false;
  bool One=false;


  bool IsAllProvice=false;
  bool IsAllCity=false;
  bool IsAllRegion=false;
  bool IsAllPath=false;
  bool IsAllCustomer=false;



  List<Result_ModelProvinces> Provice=[];


  List<Result_Cityss> City=[];


  List<ResultModelRegions> Region=[];


  List<ResultPaths> Path=[];


  List<Re_VisitorsAll> Visitors=[];
  List<ResultModelCustomerNew> Customers=[];



  Future ShowModall_3() async
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
                                      const Text('انتخاب همه'),
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

                                  main.forEach((element) {

                                  });


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



  }





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
        if(Data.res.isNotEmpty)
        {

          setState(() {
            main=Data.res;
          });

          ShowModall_3();
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







  Future ShowModall_(String Flag) async
  {
    bool b=await   showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx){
          return SafeArea(
            child: Padding(
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
                                        onTap: (){
                                          if(txtsearch.selection == TextSelection.fromPosition(TextPosition(offset: txtsearch.text.length -1))){
                                            setState(() {
                                              txtsearch.selection = TextSelection.fromPosition(TextPosition(offset: txtsearch.text.length));
                                            });
                                          }
                                        },
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
                                  Flag=='4'||Flag=='5'?
                                  InkWell(
                                    onTap: (){
                                      state(() {

                                        if(Flag=='4')
                                        {
                                          IsAllPath=!IsAllPath;
                                        }




                                      });




                                      if(Flag=='4')
                                      {
                                        if(IsAllPath==true)
                                        {
                                          state(() {
                                            Path.forEach((element) {
                                              element.IsCheck=true;
                                            });
                                          });

                                        }else{
                                          state(() {
                                            Path.forEach((element) {
                                              element.IsCheck=false;
                                            });
                                          });
                                        }
                                      }

                                      if(Flag=='5')
                                      {
                                        if(IsAllCustomerGroup==true)
                                        {
                                          state(() {
                                            CustomerGroup.forEach((element) {
                                              element.IsCheck=true;
                                            });
                                          });

                                        }else{
                                          state(() {
                                            CustomerGroup.forEach((element) {
                                              element.IsCheck=false;
                                            });
                                          });
                                        }
                                      }


                                      if(Flag=='6')
                                      {
                                        if(IsAllCustomer==true)
                                        {
                                          state(() {
                                            Customers.forEach((element) {
                                              element.IsCheck=true;
                                            });
                                          });

                                        }else{
                                          state(() {
                                            Customers.forEach((element) {
                                              element.IsCheck=false;
                                            });
                                          });
                                        }
                                      }




                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('انتخاب همه'),
                                        Checkbox(
                                          value:
                                          Flag=='1'?IsAllProvice:
                                          Flag=='2'?IsAllCity:
                                          Flag=='3'?IsAllRegion:
                                          Flag=='4'?IsAllPath:
                                          Flag=='5'?IsAllCustomerGroup:
                                          IsAllCustomer,
                                          activeColor: BaseColor ,
                                          focusColor:BaseColor,
                                          onChanged: (bool? value) {
                                            state(() {
                                              if(Flag=='1')
                                              {
                                                City.clear();
                                                Region.clear();
                                                Path.clear();
                                                IsAllProvice=!IsAllProvice;
                                              }

                                              if(Flag=='2')
                                              {
                                                Region.clear();
                                                Path.clear();
                                                IsAllCity=!IsAllCity;
                                              }

                                              if(Flag=='3')
                                              {
                                                Path.clear();
                                                IsAllRegion=!IsAllRegion;
                                              }

                                              if(Flag=='4')
                                              {
                                                IsAllPath=!IsAllPath;
                                              }


                                              if(Flag=='5')
                                              {
                                                IsAllCustomerGroup=!IsAllCustomerGroup;
                                              }


                                              if(Flag=='6')
                                              {
                                                IsAllCustomer=!IsAllCustomer;
                                              }



                                            });

                                            if(Flag=='1')
                                            {
                                              if(IsAllProvice==true)
                                              {


                                                state(() {
                                                  Provice.forEach((element) {
                                                    element.IsCheck=true;
                                                  });
                                                });

                                              }else{
                                                state(() {
                                                  Provice.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                });
                                              }
                                            }


                                            if(Flag=='2')
                                            {
                                              if(IsAllCity==true)
                                              {
                                                state(() {
                                                  City.forEach((element) {
                                                    element.IsCheck=true;
                                                  });
                                                });

                                              }else{
                                                state(() {
                                                  City.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                });
                                              }
                                            }

                                            if(Flag=='3')
                                            {
                                              if(IsAllRegion==true)
                                              {
                                                state(() {
                                                  Region.forEach((element) {
                                                    element.IsCheck=true;
                                                  });
                                                });

                                              }else{
                                                state(() {
                                                  Region.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                });
                                              }
                                            }


                                            if(Flag=='4')
                                            {
                                              if(IsAllPath==true)
                                              {
                                                state(() {
                                                  Path.forEach((element) {
                                                    element.IsCheck=true;
                                                  });
                                                });

                                              }else{
                                                state(() {
                                                  Path.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                });
                                              }
                                            }


                                            if(Flag=='5')
                                            {
                                              if(IsAllCustomerGroup==true)
                                              {
                                                state(() {
                                                  CustomerGroup.forEach((element) {
                                                    element.IsCheck=true;
                                                  });
                                                });

                                              }else{
                                                state(() {
                                                  CustomerGroup.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                });
                                              }
                                            }


                                            if(Flag=='6')
                                            {
                                              if(IsAllCustomer==true)
                                              {
                                                state(() {
                                                  Customers.forEach((element) {
                                                    element.IsCheck=true;
                                                  });
                                                });

                                              }else{
                                                state(() {
                                                  Customers.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                });
                                              }
                                            }


                                          },
                                        ),
                                      ],
                                    ),
                                  ):Container(),
                                  Expanded(
                                    child: ListView.builder(
                                      // itemCount: Departments.length,
                                      itemCount: Flag=='1'? Provice.length:Flag=='2'?
                                      City.length:Flag=='3'?Region.length:
                                      Flag=='4'?
                                      Path.length:
                                      Flag=='5'?
                                      CustomerGroup.length:
                                      Customers.length,
                                      itemBuilder: (ctx,item){
                                        return
                                          txtsearch.text.isEmpty?
                                          Container(
                                            child: InkWell(
                                              highlightColor: Colors.transparent,
                                              onTap: ()
                                              {


                                                if(Flag=='1')
                                                {
                                                  City.clear();
                                                  Region.clear();
                                                  Path.clear();
                                                  Provice.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                  if(IsAllProvice==false)
                                                  {
                                                    state(() {
                                                      Provice[item].IsCheck= !Provice[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);
                                                }



                                                if(Flag=='2')
                                                {
                                                  Region.clear();
                                                  Path.clear();
                                                  City.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                  if(IsAllCity==false)
                                                  {
                                                    state(() {
                                                      City[item].IsCheck= !City[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }



                                                if(Flag=='3')
                                                {
                                                  Path.clear();
                                                  if(IsAllRegion==false)
                                                  {
                                                    state(() {
                                                      Region[item].IsCheck= !Region[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }



                                                if(Flag=='4')
                                                {
                                                  if(IsAllPath==false)
                                                  {
                                                    state(() {
                                                      Path[item].IsCheck= !Path[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }


                                                if(Flag=='5')
                                                {
                                                  if(IsAllCustomerGroup==false)
                                                  {
                                                    state(() {
                                                      CustomerGroup[item].IsCheck= !CustomerGroup[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }


                                                if(Flag=='6')
                                                {
                                                  if(IsAllCustomer==false)
                                                  {
                                                    state(() {
                                                      Customers[item].IsCheck= !Customers[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }






                                                FocusScope.of(context).unfocus();

                                                // Navigator.pop(context,Departments[item].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      Flag=='1'?
                                                      Provice[item].name :
                                                      Flag=='2'?City[item].cityName:
                                                      Flag=='3' ?
                                                      Region[item].regionName:
                                                      Flag=='4' ?
                                                      Path[item].pathName:
                                                      Flag=='5' ?
                                                      CustomerGroup[item].groupName:
                                                      Customers[item].customerName ),
                                                  // Text(sa),
                                                  Checkbox(
                                                    value:
                                                    Flag=='1'?
                                                    Provice[item].IsCheck:
                                                    Flag=='2'?
                                                    City[item].IsCheck:
                                                    Flag=='3'?
                                                    Region[item].IsCheck:
                                                    Flag=='4'?
                                                    Path[item].IsCheck:
                                                    Flag=='5'?
                                                    CustomerGroup[item].IsCheck:
                                                    Customers[item].IsCheck,
                                                    activeColor: BaseColor ,
                                                    focusColor:BaseColor ,
                                                    onChanged: (bool? value) {
                                                      if(Flag=='1')
                                                      {
                                                        Provice.forEach((element) {
                                                          element.IsCheck=false;
                                                        });
                                                        if(IsAllProvice==false)
                                                        {
                                                          state(() {
                                                            Provice[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }
                                                      if(Flag=='2')
                                                      {
                                                        City.forEach((element) {
                                                          element.IsCheck=false;
                                                        });
                                                        if(IsAllCity==false)
                                                        {
                                                          state(() {
                                                            City[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }
                                                      if(Flag=='3')
                                                      {
                                                        if(IsAllRegion==false)
                                                        {
                                                          state(() {
                                                            Region[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);
                                                      }

                                                      if(Flag=='4')
                                                      {

                                                        if(IsAllPath==false)
                                                        {
                                                          state(() {
                                                            Path[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }

                                                      if(Flag=='5')
                                                      {

                                                        if(IsAllCustomerGroup==false)
                                                        {
                                                          state(() {
                                                            CustomerGroup[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }


                                                      if(Flag=='6')
                                                      {

                                                        if(IsAllCustomer==false)
                                                        {
                                                          state(() {
                                                            Customers[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }



                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ) :
                                          txtsearch.text.isNotEmpty && Flag=='1'&&  Provice[item].name.contains(txtsearch.text.toString())?
                                          Container(
                                            child: InkWell(
                                              highlightColor: Colors.transparent,
                                              onTap: ()
                                              {
                                                if(Flag=='1')
                                                {
                                                  City.clear();
                                                  Region.clear();
                                                  Path.clear();
                                                  Provice.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                  if(IsAllProvice==false)
                                                  {
                                                    state(() {
                                                      Provice[item].IsCheck= !Provice[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }
                                                if(Flag=='2')
                                                {

                                                  Region.clear();
                                                  Path.clear();
                                                  if(IsAllCity==false)
                                                  {
                                                    state(() {
                                                      City[item].IsCheck= !City[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }


                                                if(Flag=='3')
                                                {

                                                  Path.clear();
                                                  if(IsAllRegion==false)
                                                  {
                                                    state(() {
                                                      Region[item].IsCheck= !Region[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }



                                                if(Flag=='4')
                                                {
                                                  if(IsAllPath==false)
                                                  {
                                                    state(() {
                                                      Path[item].IsCheck= !Path[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }









                                                FocusScope.of(context).unfocus();

                                                // Navigator.pop(context,Departments[item].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      Flag=='1'?
                                                      Provice[item].name :
                                                      Flag=='2'?City[item].cityName: Flag=='3' ?
                                                      Region[item].regionName:Path[item].pathName),
                                                  // Text(sa),
                                                  Checkbox(
                                                    value:
                                                    Flag=='1'?
                                                    Provice[item].IsCheck:
                                                    Flag=='2'?
                                                    City[item].IsCheck:
                                                    Flag=='3'?
                                                    Region[item].IsCheck:
                                                    Path[item].IsCheck,
                                                    activeColor: BaseColor ,
                                                    focusColor:BaseColor ,
                                                    onChanged: (bool? value) {
                                                      if(Flag=='1')
                                                      {
                                                        Provice.forEach((element) {
                                                          element.IsCheck=false;
                                                        });

                                                        if(IsAllProvice==false)
                                                        {
                                                          state(() {
                                                            Provice[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }
                                                      if(Flag=='2')
                                                      {

                                                        if(IsAllCity==false)
                                                        {
                                                          state(() {
                                                            City[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }
                                                      if(Flag=='3')
                                                      {

                                                        if(IsAllCity==false)
                                                        {
                                                          state(() {
                                                            City[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }

                                                      if(Flag=='4')
                                                      {

                                                        if(IsAllPath==false)
                                                        {
                                                          state(() {
                                                            Path[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }



                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):
                                          txtsearch.text.isNotEmpty && Flag=='2'&&  City[item].cityName.contains(txtsearch.text.toString())?
                                          Container(
                                            child: InkWell(
                                              highlightColor: Colors.transparent,
                                              onTap: ()
                                              {

                                                if(Flag=='2')
                                                {

                                                  Region.clear();
                                                  Path.clear();
                                                  City.forEach((element) {
                                                    element.IsCheck=false;
                                                  });
                                                  if(IsAllCity==false)
                                                  {
                                                    state(() {
                                                      City[item].IsCheck= !City[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }


                                                if(Flag=='3')
                                                {
                                                  if(IsAllRegion==false)
                                                  {
                                                    state(() {
                                                      Region[item].IsCheck= !Region[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }



                                                if(Flag=='4')
                                                {
                                                  if(IsAllPath==false)
                                                  {
                                                    state(() {
                                                      Path[item].IsCheck= !Path[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }







                                                FocusScope.of(context).unfocus();

                                                // Navigator.pop(context,Departments[item].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      Flag=='2'?City[item].cityName: Flag=='3' ?
                                                      Region[item].regionName:Path[item].pathName ),
                                                  // Text(sa),
                                                  Checkbox(
                                                    value:
                                                    Flag=='2'?
                                                    City[item].IsCheck:
                                                    Flag=='3'?
                                                    Region[item].IsCheck:
                                                    Path[item].IsCheck,
                                                    activeColor: BaseColor ,
                                                    focusColor:BaseColor ,
                                                    onChanged: (bool? value) {

                                                      if(Flag=='2')
                                                      {

                                                        if(IsAllCity==false)
                                                        {
                                                          state(() {
                                                            City[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }
                                                      if(Flag=='3')
                                                      {

                                                        if(IsAllCity==false)
                                                        {
                                                          state(() {
                                                            City[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }

                                                      if(Flag=='4')
                                                      {

                                                        if(IsAllPath==false)
                                                        {
                                                          state(() {
                                                            Path[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }



                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):
                                          txtsearch.text.isNotEmpty && Flag=='3'&&  Region[item].regionName.contains(txtsearch.text.toString())?
                                          Container(
                                            child: InkWell(
                                              highlightColor: Colors.transparent,
                                              onTap: ()
                                              {




                                                if(Flag=='3')
                                                {

                                                  Path.clear();
                                                  if(IsAllRegion==false)
                                                  {
                                                    state(() {
                                                      Region[item].IsCheck= !Region[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }











                                                FocusScope.of(context).unfocus();

                                                // Navigator.pop(context,Departments[item].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(

                                                      Flag=='3' ?
                                                      Region[item].regionName:Path[item].pathName ),
                                                  // Text(sa),
                                                  Checkbox(
                                                    value:

                                                    Flag=='3'?
                                                    Region[item].IsCheck:
                                                    Path[item].IsCheck,
                                                    activeColor: BaseColor ,
                                                    focusColor:BaseColor ,
                                                    onChanged: (bool? value) {


                                                      if(Flag=='3')
                                                      {

                                                        if(IsAllRegion==false)
                                                        {
                                                          state(() {
                                                            Region[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }



                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):
                                          txtsearch.text.isNotEmpty && Flag=='4'&&  Path[item].pathName.contains(txtsearch.text.toString())?
                                          Container(
                                            child: InkWell(
                                              highlightColor: Colors.transparent,
                                              onTap: ()
                                              {








                                                if(Flag=='4')
                                                {
                                                  if(IsAllPath==false)
                                                  {
                                                    state(() {
                                                      Path[item].IsCheck= !Path[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }









                                                FocusScope.of(context).unfocus();

                                                // Navigator.pop(context,Departments[item].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      Flag=='4'?Path[item].pathName:'' ),
                                                  // Text(sa),
                                                  Checkbox(
                                                    value:
                                                    Flag=='4'?
                                                    Path[item].IsCheck:false,
                                                    activeColor: BaseColor,
                                                    focusColor:BaseColor,
                                                    onChanged: (bool? value) {




                                                      if(Flag=='4')
                                                      {

                                                        if(IsAllPath==false)
                                                        {
                                                          state(() {
                                                            Path[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }




                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):
                                          txtsearch.text.isNotEmpty && Flag=='5'&&  CustomerGroup[item].groupName.contains(txtsearch.text.toString())?
                                          Container(
                                            child: InkWell(
                                              highlightColor: Colors.transparent,
                                              onTap: ()
                                              {








                                                if(Flag=='5')
                                                {
                                                  if(IsAllCustomerGroup==false)
                                                  {
                                                    state(() {
                                                      CustomerGroup[item].IsCheck= !CustomerGroup[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }









                                                FocusScope.of(context).unfocus();

                                                // Navigator.pop(context,Departments[item].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      Flag=='5'?CustomerGroup[item].groupName:'' ),
                                                  // Text(sa),
                                                  Checkbox(
                                                    value:
                                                    Flag=='5'?
                                                    CustomerGroup[item].IsCheck:false,
                                                    activeColor: BaseColor,
                                                    focusColor:BaseColor,
                                                    onChanged: (bool? value) {




                                                      if(Flag=='5')
                                                      {

                                                        if(IsAllCustomerGroup==false)
                                                        {
                                                          state(() {
                                                            CustomerGroup[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }




                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):
                                          txtsearch.text.isNotEmpty && Flag=='6'&&  Customers[item].customerName.contains(txtsearch.text.toString())?
                                          Container(
                                            child: InkWell(
                                              highlightColor: Colors.transparent,
                                              onTap: ()
                                              {








                                                if(Flag=='6')
                                                {
                                                  if(IsAllCustomer==false)
                                                  {
                                                    state(() {
                                                      Customers[item].IsCheck= !Customers[item].IsCheck;
                                                    });
                                                  }
                                                  // Navigator.pop(context);

                                                }









                                                FocusScope.of(context).unfocus();

                                                // Navigator.pop(context,Departments[item].toString());
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                      Flag=='5'?CustomerGroup[item].groupName:'' ),
                                                  // Text(sa),
                                                  Checkbox(
                                                    value:
                                                    Flag=='5'?
                                                    CustomerGroup[item].IsCheck:false,
                                                    activeColor: BaseColor,
                                                    focusColor:BaseColor,
                                                    onChanged: (bool? value) {




                                                      if(Flag=='5')
                                                      {

                                                        if(IsAllCustomerGroup==false)
                                                        {
                                                          state(() {
                                                            CustomerGroup[item].IsCheck=value!;
                                                          });
                                                        }
                                                        // Navigator.pop(context);

                                                      }




                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ):
                                          Container();
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
                                        color: Color_ListCustomerDark,
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
            ),
          );
        });


    setState(() {

    });






  }


  Future Run(String Flag) async{
    ProgressDialog   PRo = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);



    PRo.style(
      textAlign: TextAlign.center,
      message: 'درحال ارتباط با سرور..',
      messageTextStyle: TextStyle(
          fontFamily:  'iranyekanbold',
          fontSize: 14,
          color: Colors.black87),
    );
    await PRo.show();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');




    if(Flag=='1')
    {

      var data=await ApiService.GetProvices(PRo,base!,UserName!,Password!);

      PRo.hide();


      if(data.result.isNotEmpty)
      {
        Provice=data.result;
        setState(() {
        });
        ShowModall_("1");

      }


    }


    if(Flag=='2')
    {
      List<int> idProvice=[];
      Provice.forEach((element) {
        if(element.IsCheck)
        {
          idProvice.add(element.provinceId);
        }
      });




      var data=await ApiService.GetCityAll(base!,UserName!,Password!,idProvice);
      PRo.hide();


      if(data.result.isNotEmpty)
      {
        City=data.result;
        setState(() {

        });
        ShowModall_("2");
      }
    }
    //
    //
    if(Flag=='3')
    {
      List<int> idCity=[];


      City.forEach((element) {
        if(element.IsCheck)
        {
          idCity.add(element.rdf);
        }
      });

      var data=await ApiService.GetRegionsAll(base!,UserName!,Password!,idCity);
      PRo.hide();

      if(data.result.length!=0)
      {
        Region=data.result;
        setState(() {

        });
        ShowModall_("3");
      }
    }
    //
    if(Flag=='4')
    {
      List<int> idRegion=[];

      Region.forEach((element) {
        if(element.IsCheck)
        {
          idRegion.add(element.regionId);
        }
      });


      var data=await ApiService.GetPathsAll(base!,UserName!,Password!,idRegion);
      PRo.hide();


      if(data.result.isNotEmpty)
      {

        Path=data.result;
        setState(() {

        });
        ShowModall_("4");
      }
    }
    //
    //
    if(Flag=='5')
    {
      var data=await ApiService.CustomerGroup(PRo,base!,UserName!,Password!);
      PRo.hide();

      if(data.result.isNotEmpty)
      {

        CustomerGroup=data.result;
        setState(() {

        });
        ShowModall_("5");
      }
    }

    if(Flag=='6')
    {
      List<int> idCustomerGroup=[];
      CustomerGroup.forEach((element) {
        if(element.IsCheck)
        {
          idCustomerGroup.add(element.id);
        }
      });
      // var data=await ApiService.GetCustomerNew(PRo,base!,UserName!,Password!,idCustomerGroup);
      // PRo.hide();


      // if(data.result.isNotEmpty)
      // {
      //
      //   Customers=data.result;
      //   setState(() {
      //
      //   });
      //   ShowModall_("6");
      // }
    }





  }



  Future RefreshItems()async{


    List<int> prr=Provice.where((element) => element.IsCheck==true).toList().map((e) => e.provinceId).cast<int>().toList();
    var data= City.where((element) => element.IsCheck==true).toList().where((element) => prr.contains(element.provinceId)).toList();
    City=data;


    List<int> prr3=City.where((element) => element.IsCheck==true).toList().map((e) => e.rdf).cast<int>().toList();
    var data2= Region.where((element) => element.IsCheck==true).toList().where((element) => prr3.contains(element.cityId)).toList();
    Region=data2;




    List<int> prr4=Region.where((element) => element.IsCheck==true).toList().map((e) => e.regionId).toList();
    var data3= Path.where((element) => element.IsCheck==true).toList().where((element) => prr4.contains(element.regionId)).toList();
    Path=data3;







    setState(() {

    });
  }
  @override
  void initState() {
    super.initState();
    GetDataNow();
  }

  List<ResultKalaNotSale>  mainItems=[];

  Future GetData()async{
    List<int> visid=[];
    List<int> Cusgroup=[];
    List<int> Cus=[];
    List<int> Pathh=[];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');

    if(IsAllVisitors)
    {
      main.forEach((element) {
        visid.add(element.visRdf);
      });
    }else if(main.isNotEmpty)
    {
      main.forEach((element) {
        if(element.IsCheck)
        {
          visid.add(element.visRdf);
        }
      });
    }


    if(IsAllCustomerGroup)
    {
      CustomerGroup.forEach((element) {
        Cusgroup.add(element.id);
      });
    }else if(CustomerGroup.isNotEmpty)
    {
      CustomerGroup.forEach((element) {
        if(element.IsCheck)
        {
          Cusgroup.add(element.id);
        }
      });
    }

    if(IsAllCustomer)
    {
      Customers.forEach((element) {
        Cus.add(element.id);
      });
    }else if(Customers.isNotEmpty)
    {
      Customers.forEach((element) {
        if(element.IsCheck)
        {
          Cus.add(element.id);
        }
      });
    }



    if(IsAllPath)
    {
      Path.forEach((element) {
        Pathh.add(element.pathId);
      });
    }else if(Path.isNotEmpty)
    {
      Path.forEach((element) {
        if(element.IsCheck)
        {
          Pathh.add(element.pathId);
        }
      });
    }






    setState(() {
      FlagFilter=false;
    });

    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);


    var Data= await ApiService.GetProductNotSale(pr,base!,UserName!,Password!,Ta_Data,Az_Data,Cusgroup,Cus,Pathh,visid);
    pr.hide();


    if(Data!=null)
    {
      if(Data.code=='200')
      {
        if(Data.result!=null)
        {
          setState(() {
            mainItems=Data.result;
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
  bool IsAllCustomerGroup=false;
  TextEditingController txtsearch=TextEditingController();
  List<ResultCustomerGroupModel> CustomerGroup=[];
  @override
  Widget build(BuildContext context) {
    var Sizewidth=MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop:_onWillPop2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: BaseColor,
          title:Column(
            children: [
              Text('گزارش کالا های فروش نرفته',
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
        Container(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      MainItemFilterProviceOneChoose(
                          IsAllProvice,
                          Provice.where((element)=>element.IsCheck==true).toList(),
                              (){



                            if(Provice.length==0)
                            {
                              Run('1');
                            }else{
                              ShowModall_("1");
                            }


                          },() {



                        RefreshItems();




                      },11),
                      MainItemFilterCityOneChoose(
                          IsAllCity,City.where((element) => element.IsCheck==true).toList(),(){
                        var datae=Provice.where((element) => element.IsCheck==true).toList();
                        if(datae.length==1)
                        {
                          Run('2');
                        }
                      },(){
                        RefreshItems();
                      },11),
                      MainItemFilterRegionOneChoose(
                          IsAllCity,Region.where((element) => element.IsCheck==true).toList(),(){
                        var datae=City.where((element) => element.IsCheck==true).toList();
                        if(datae.length==1)
                        {
                          Run('3');
                        }
                      },(){
                        RefreshItems();
                      },11),
                      MainItemFilterPathOneChoose(
                          IsAllPath,Path.where((element) => element.IsCheck==true).toList(),(){
                        var datae=Region.where((element) => element.IsCheck==true).toList();
                        if(datae.length==1)
                        {
                          Run('4');
                        }

                      },(){
                        RefreshItems();
                      },11),
                      MainItemFilterVistor(IsAllVisitors,
                          main.where((element) => element.IsCheck==true).toList()
                          // .sort((a, b) => a.someProperty.compareTo(b.someProperty))
                          ,(){
                            if(main.length==0)
                            {
                              RunVisitors();
                            }else{
                              ShowModall_3();
                            }

                          },() {





                            setState(() {

                            });





                            // setState(() {
                            // });




                          },11),
                      MainItemFilterCustomerGroup(
                          IsAllCustomerGroup,CustomerGroup.where((element) => element.IsCheck==true).toList(),(){

                        Run('5');
                      },(){
                        IsAllCustomerGroup=false;
                        Customers.clear();
                        setState(() {
                        });
                      }),
                      InkWell(
                        onTap: ()async{

                          List<int> datamainCusGroup=[];
                          if(CustomerGroup.isEmpty)
                          {
                            ApiService.ShowSnackbar('گروه مشتری را انتخاب کنید');
                            return;
                          }






                          if(IsAllCustomerGroup==true)
                          {
                            datamainCusGroup.add(-100);
                          }else
                          {
                            CustomerGroup.forEach((element) {
                              if(element.IsCheck)
                              {
                                datamainCusGroup.add(element.id);
                              }
                            });
                          }

                          if(datamainCusGroup.isEmpty&&IsAllCustomerGroup==false)
                          {
                            ApiService.ShowSnackbar('گروه مشتری را انتخاب کنید');
                            return;
                          }

                          List<ResultModelCustomerNew> cuids=Customers.where((element) => element.IsCheck==true).toList();






                          var datatemp   = await  Navigator.of(context).
                          push(
                              MaterialPageRoute(builder: (context) =>
                                  ScreenCustomerNew(datamainCusGroup,cuids.map((e) => e.id).toList())));


                          if(datatemp!=null)
                          {
                            Customers=datatemp;
                            setState(() {

                            });
                          }





                          // setState(() {
                          //
                          // });





                        },
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
                              IsAllCustomer==true|| Customers.length>0?
                              Container(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: GridView.builder(
                                    itemCount: IsAllCustomer==true?1:
                                    Customers.isEmpty?0:
                                    Customers.length,
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
                                          Customers.removeAt(index);
                                          setState(() {

                                          });
                                        },  IsAllCustomer,  Customers, index);
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
                          )),
                          Expanded(
                            child: Padding(
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
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                        width: double.maxFinite,
                        child: ElevatedButton(onPressed: (){

                          if(mainItems.length==0)
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
          ),
        ):
        RefreshIndicator(
          onRefresh: _refresh,
          child: Container(
            width: double.infinity,
            child: ListView.builder(
                itemCount: mainItems.length,
                // itemCount: 3,
                itemBuilder: (ctx,item){
                  // return ItemNoSaleCustomer();
                  return ItemKalaNotSale(mainItems[item]);
                  // return  InkWell(
                  //     onTap: (){
                  //
                  //     },
                  //     child: Container(
                  //         margin: item==mainItems.length-1?EdgeInsets.only(bottom: 80):null,
                  //         child: ItemReportPath(mainItems[item])));
                }
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








