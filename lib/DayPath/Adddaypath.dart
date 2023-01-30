import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:shared_preferences/shared_preferences.dart';


import '../ApiService.dart';
import '../Calender/TextApp.dart';

import '../CityComponentOneChoose/MainItemFilterCityOneChoose.dart';
import '../Constants.dart';
import '../Models/ModelCity.dart';

import '../Models/ModelCitys.dart';
import '../Models/ModelPaths.dart';
import '../Models/ModelProvice.dart';

import '../Models/ModelProvinces.dart';
import '../Models/ModelRegion.dart';

import '../Models/ModelRegions.dart';
import '../Models/ModelVisitorsAll.dart';
import '../Models/ModelWay.dart';

import '../PathComponentOneChoose/MainItemFilterPath.dart';
import '../ProviceComponentOneChoose/MainItemFilterProvice.dart';
import '../RegionComponentOneChoose/MainItemFilterRegionOneChoose.dart';
import '../VisitorComponent/MainItemFilterVisitor.dart';

class Adddaypath extends StatefulWidget {


  String DataConst;


  Adddaypath(this.DataConst);

  @override
  State<Adddaypath> createState() => _AllinfodaypathState();
}

class _AllinfodaypathState extends State<Adddaypath> {

  bool IsAllProvice=false;
  bool IsAllCity=false;
  bool IsAllRegion=false;
  bool IsAllPath=false;
  bool IsAllVisitors=false;


  List<Result_ModelProvinces> Provice=[];


  List<Result_Cityss> City=[];


  List<ResultModelRegions> Region=[];


  List<ResultPaths> Path=[];


  List<Re_VisitorsAll> Visitors=[];

  List<Re_VisitorsAll> main=[];

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
                                    debugPrint(element.IsCheck.toString());
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
        if(Data.res!=null)
        {

          setState(() {
            main=Data.res;
          });
          debugPrint(main.length.toString());
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




  TextEditingController txtsearch=TextEditingController();
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
                                          Flag=='4'?IsAllPath:false,
                                          activeColor: BaseColor ,
                                          focusColor:BaseColor ,
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


                                          },
                                        ),
                                      ],
                                    ),
                                  ):Container(),
                                  Expanded(
                                    child: ListView.builder(
                                      // itemCount: Departments.length,
                                      itemCount: Flag=='1'? Provice.length:Flag=='2'?
                                      City.length:Flag=='3'?Region.length:Path.length,
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
                                                      Region[item].regionName:Path[item].pathName ),
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
      debugPrint(data.toString());
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

      debugPrint(Provice.toList().toString());
      debugPrint(idProvice.toString());

      var data=await ApiService.GetCityAll(base!,UserName!,Password!,idProvice);
      PRo.hide();

      debugPrint(data.toString());
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
      print(data.toJson().toString());

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
    // if(Flag=='5')
    // {
    //
    //   var data=await ApiService.GetCustomerGroup(widget.SYSID);
    //   PRo.hide();
    //   print(data.toJson().toString());
    //
    //   if(data.result.length!=0)
    //   {
    //
    //     CustomerGroup=data.result;
    //     setState(() {
    //
    //     });
    //     ShowModall_("5");
    //   }
    // }




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




  Future AddPath()async{
    List<int> Visitors=[];
    List<int> Patss=[];


    if(Provice.isEmpty)
    {
      ApiService.ShowSnackbar('استان  را انتخاب کنید');
      return;
    }

    if(City.isEmpty)
    {
      ApiService.ShowSnackbar('شهر  را انتخاب  کنید');
      return;
    }

    if(Region.isEmpty)
    {
      ApiService.ShowSnackbar('منطقه  را انتخاب کنید');
      return;
    }

    if(Path.isEmpty)
    {
      ApiService.ShowSnackbar('مسیر  را انتخاب کنید');
      return;
    }





    main.forEach((element) {
      if(element.IsCheck)
      {
        Visitors.add(element.visRdf);
      }
    });


    Path.forEach((element) {
      if(element.IsCheck)
      {
        Patss.add(element.pathId);
      }
    });






    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');
    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);
    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();
    print(widget.DataConst.toString());
    var Data=await ApiService.AddPath( base!, UserName!, Password!!,Visitors,widget.DataConst,Patss);
    pr.hide();
    if(Data!=null)
    {
      if(Data.code=='200')
      {
        ApiService.ShowSnackbar('مسیر با موفقیت ایجاد شد');
        setState(() {

        });

        }else{
          ApiService.ShowSnackbar(Data.msg.toString());
        }


    }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }




    pr.hide();
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
            color: Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 4),
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
                                  IsAllCity,Path.where((element) => element.IsCheck==true).toList(),(){
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

                                   debugPrint('Nimaa');



                                setState(() {

                                });





                                   // setState(() {
                                   // });




                                  },11),


                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Row(children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                    width: double.maxFinite,
                    child: ElevatedButton(
                        onPressed: (){
                          AddPath();
                        },
                        style: ElevatedButton.styleFrom(primary: BaseColor),
                        child:
                        Text('ثبت',style: TextStyle(
                            color: Colors.white
                        ),)),
                  )),
                ],),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
