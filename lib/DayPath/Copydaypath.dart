import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService.dart';
import '../Calender/TextApp.dart';
import '../Constants.dart';
import '../Models/ModelDayWeek.dart';
import 'BoxInfoCopy.dart';
import 'BoxInfoDayPath.dart';

class Copydaypath extends StatefulWidget {



  String DataConst;


  Copydaypath(this.DataConst);
  @override
  State<Copydaypath> createState() => _CopydaypathState();
}

class _CopydaypathState extends State<Copydaypath> {
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



  List<ResultDayWeek> listmain=[];


  Dia_Copy(String DataNew){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return  Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(

                  margin: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextApp('مجوز',16,Colors.black87,true),
                      ),
                      TextApp('عملیات کپی انجام شود ؟',14,Colors.grey,true),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);

                                },
                                child: TextApp('بستن',16,BaseColor,true)),
                            ElevatedButton(onPressed: (){
                              Navigator.pop(context);
                              CopyDayPath(DataNew);
                            },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(BaseColor),
                                    padding: MaterialStateProperty.all(EdgeInsets.all(4)),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8.0),

                                        )
                                    )
                                ),
                                child:Text('بله',
                                  style: TextStyle(color:Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),)),
                          ],
                        ),
                      )
                    ],
                  ),

                )
              ],
            ),
          ),
        );
      },
    );

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


    // GetData();


  }





  Future GetData()async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');






    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);


    var Data=await ApiService.DayWeek( base!, UserName!, Password!,Az_Data,Ta_Data
    );


    debugPrint(Data.toJson().toString());
    pr.hide();
    if(Data!=null)
    {
      if(Data.code=='200')
      {
        if(Data.result.isNotEmpty)
        {
          setState(() {
            listmain=Data.result;
          });
        }
      }else{
        Navigator.pop(context);
        ApiService.ShowSnackbar(Data.msg);
      }
    }else{
      Navigator.pop(context);
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }


    FocusManager.instance.primaryFocus?.unfocus();

  }


  Future CopyDayPath(String DataNew)async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');





    debugPrint(widget.DataConst);
    debugPrint(DataNew);

    var  pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);


    var Data=await ApiService.CopyDayPath( base!, UserName!, Password!,widget.DataConst,DataNew
    );


    debugPrint(Data.toJson().toString());
    pr.hide();
    if(Data!=null)
    {
      if(Data.code=='200')
      {
          ApiService.ShowSnackbar('عملیات با موفقیت انجام شد');
      }else{
        ApiService.ShowSnackbar(Data.msg);
      }
    }else{
      Navigator.pop(context);
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده');
    }


    FocusManager.instance.primaryFocus?.unfocus();

  }




  @override
  void initState() {
    super.initState();
    GetDataNow();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 9,
              child: Container(
                  child: ListView.builder(
                  itemCount: listmain.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx,item){
                      return Column(
                        children: [
                          BoxInfoCopy((){
                            Dia_Copy(listmain[item].date);
                          },listmain[item]),
                        ],
                      );
                    }
                ),
          )),
          Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.all(8),
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
                                          child: TextApp(Data_To,12,Colors.black54,false),
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
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                        width: double.maxFinite,
                        child: ElevatedButton(
                            onPressed: (){

                              // // PageCounter=1;
                              // // PageCounterMain=2;
                              // // Customers.clear();
                              // // PageCounterCheck=false;
                              GetData();
                              // // GetCustomers('',false);
                            },
                            style: ElevatedButton.styleFrom(primary: BaseColor),
                            child:
                            Text('نمایش',style: TextStyle(
                                color: Colors.white
                            ),)),
                      ),
                    ),

                  ],
                ),
              ))
        ],
      ),
    );
  }
}


