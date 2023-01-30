import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:persian_datetime_picker/persian_datetime_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../ApiService.dart';
import '../Constants.dart';

import '../DayPath/daypath.dart';
import '../Models/ModelDayPathCalendar.dart';
import 'BoxCheckCalender.dart';
import 'BoxItemCalender.dart';
import 'BoxItemCalender2.dart';
import 'BoxTextCalender.dart';
import 'CalenderBoxAllMonth.dart';
import 'CalenderBoxInformation.dart';
import 'CustomPageViewScrollPhysics.dart';
import 'RowBoxalender.dart';
import 'TextApp.dart';

class CalenderRecivePayment extends StatefulWidget {



  CalenderRecivePayment();





  @override
  State<CalenderRecivePayment> createState() => _CalenderRecivePaymentState();

}

class _CalenderRecivePaymentState extends State<CalenderRecivePayment> {
  var _controllerMonth = PageController(viewportFraction: 0.4, );
  var _controllerYear = PageController(viewportFraction: 0.4, );

  List<String> Months=[
    'فروردین',
    'اردیهشت',
    'خرداد',
    'تیر',
    'مرداد',
    'شهریور',
    'مهر',
    'آبان',
    'آذر',
    'دی',
    'بهمن',
    'اسفند',
  ];


  List<String> Year=[];


  late DetailDayPath Payment_Ceck;
  late ResultDayPathCalendar DataCalender;


  int C_Year=0;
  int C_Month=0;
  int C_Day=0;
  Future Run()async{
    for(int i=1380;i<=1420;i++)
    {
      Year.add(i.toString());
    }
    DateTime dt = DateTime.now();
    Jalali j = dt.toJalali();
    YearCounter=   Year.indexOf(j.year.toString());
    // YearCounter=YearCounter+1;
    MonthCounter=j.month;
    // MonthCounter=8;
    DayCounter=j.day;
    // DayCounter=25;
    print('day'+j.day.toString());
    print('month'+j.month.toString());
    print('month'+j.year.toString());

    C_Year=j.year;
    C_Month=j.month;
    C_Day=j.day;
    _controllerYear=PageController(viewportFraction: 0.4,initialPage:YearCounter);
    _controllerMonth=PageController(viewportFraction: 0.4,initialPage:MonthCounter-1);

    GetData();
  }
  Future GetData()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var base =prefs.getString('Baseurl');
    var UserName =prefs.getString('UserName');
    var Password =prefs.getString('Password');

    SelectedItem=-8;
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
    var data=await ApiService.DayPathCalendar(base!,UserName!,Password!,Year[YearCounter].toString(),(MonthCounter).toString());
    await  PRo.hide();
    print(data.toJson().toString());
    if(data.result!=null)
    {
      CounterCalender=0;
      DataCalender=data.result;
      FlagPayment=false;
      setState(() {
      });
    }else{
      Navigator.pop(context);
    }


  }
  @override
  void initState() {
    super.initState();
    Payment_Ceck=DetailDayPath(visitorCount: 0, pathCount: 0, day: 0);


    DataCalender=ResultDayPathCalendar(details: [], startDayOfWeek: 0,);
    Run();

  }

  int  CounterCalender=0;
  int MonthCounter=6;
  int YearCounter=6;
  int DayCounter=6;

  int CurrentDay=0;








  int SelectedItem=-8;
  bool FlagRecive=false;
  bool FlagPayment=false;

  @override
  Widget build(BuildContext context) {
    double Widdd=MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          DataCalender.details!=null?
                          Container(
                            decoration: BoxDecoration(
                              color: BaseColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                                  child: TextApp(Months[MonthCounter], 10, Colors.white, true),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2),
                                  child: TextApp(Year[YearCounter], 10, Colors.white, true),
                                ),

                              ],
                            ),
                          ):Container(),
                          DataCalender.details!=null?
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Expanded(child: TextApp('جمعه',Widdd>550?16:12,BaseColor,true)),
                                Expanded(child: TextApp('پنجشنبه',Widdd>550?16:12,BaseColor,true)),
                                Expanded(child: TextApp('چهارشنبه',Widdd>550?16:12,BaseColor,true)),
                                Expanded(child: TextApp('سه شنبه',Widdd>550?16:12,BaseColor,true)),
                                Expanded(child: TextApp('دوشنبه',Widdd>550?16:12,BaseColor,true)),
                                Expanded(child: TextApp('یکشنبه',Widdd>550?16:12,BaseColor,true)),
                                Expanded(child: TextApp('شنبه',Widdd>550?16:12,BaseColor,true)),
                              ],
                            ),
                          ):Container(),

                          DataCalender.details!=null?
                          Container(
                            height:(MediaQuery.of(context).size.width/8)*6+10 ,
                            // height:(MediaQuery.of(context).size.width/7)*(DataCalender.detail.length+DataCalender.startDayOfWeek/7)+10 ,
                            color: Color(0xffF5F5F5),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: GridView.builder(
                                itemCount: 42,
                                // itemCount: DataCalender.detail.length+DataCalender.startDayOfWeek,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 7,
                                    mainAxisExtent: (MediaQuery.of(context).size.width/8),
                                    // mainAxisExtent: 40,
                                    crossAxisSpacing: 2.0,
                                    mainAxisSpacing: 2.0
                                ),
                                itemBuilder: (BuildContext context, int index)
                                {
                                  if(index>=(DataCalender.startDayOfWeek-1)&&index<=((DataCalender.details.length-1)+(DataCalender.startDayOfWeek-1)))
                                  {
                                    CounterCalender=CounterCalender+1;
                                  }
                                  int s=0;



                                  return Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: index>=(DataCalender.startDayOfWeek-1)&&index<=((DataCalender.details.length-1)+(DataCalender.startDayOfWeek-1))?
                                    InkWell(
                                      onTap: (){

                                        s=    index-(DataCalender.startDayOfWeek-1);

                                        SelectedItem=index;
                                        if(DataCalender.details[s].pathCount>0)
                                        {
                                          Payment_Ceck=DataCalender.details[s];
                                          FlagPayment=true;
                                        }else{
                                          FlagPayment=false;
                                        }





                                        if(FlagPayment)
                                          {
                                            CurrentDay= DataCalender.details[s].day;
                                          }
                                        setState(() {
                                          CounterCalender=0;
                                        });


                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(4),
                                            decoration:
                                            index-(DataCalender.startDayOfWeek-2)==DayCounter&&DayCounter==C_Day&&MonthCounter==C_Month&&Year[YearCounter].toString()==(C_Year).toString()?
                                            BoxDecoration(
                                                border: Border.all(color: Color(0xffFF782C),width: 1),
                                                borderRadius: BorderRadius.circular(8)
                                            ):
                                            SelectedItem==index?
                                            BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(8)
                                            ):BoxDecoration(),
                                            child: Center(child: TextApp(
                                                DataCalender.details[CounterCalender-1].day.toString(),Widdd>550?20:18,
                                                index==6||index==13||index==20||index==27||index==34||index==41?Color(0xffFF782C):
                                                Color_Calender_Text,false)),
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                DataCalender.details[CounterCalender-1].pathCount>0?
                                                Container(
                                                  margin: EdgeInsets.only(top: 18,right: 2,),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:Color_Calender_Red
                                                  ),
                                                  width: 8,
                                                  height: 8,
                                                ):Container(),
                                                DataCalender.details[CounterCalender-1].visitorCount>0?
                                                Container(

                                                  margin: EdgeInsets.only(top: 18,left: 2),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:Color_Calender_Blue
                                                  ),
                                                  width: 8,
                                                  height: 8,
                                                ):Container()
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ):Container(),
                                  );
                                },
                              ),
                            ),
                          ):Container(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlagPayment==true?
                              InkWell(
                                onTap: (){
                                  debugPrint(Year[YearCounter].toString());
                                  debugPrint((MonthCounter).toString());
                                  debugPrint((CurrentDay).toString());
                                  String m='';
                                  String d='';

                                  m=MonthCounter.toString().length==1?'0'+MonthCounter.toString():MonthCounter.toString();
                                  d=CurrentDay.toString().length==1?'0'+CurrentDay.toString():CurrentDay.toString();


                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  daypath(Year[YearCounter].toString()+'/'+m+'/'+d)),
                                  );

                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                                  child: Container(
                                     decoration: BoxDecoration(
                                       border: Border.all(color: BaseColor,width: 2),
                                       borderRadius: BorderRadius.circular(8)
                                     )
                                    , child:Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                          child: Icon(Icons.remove_red_eye_outlined,color: BaseColor,),
                                        ),
                                        Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 4),
                                        child: TextApp('نمایش اطلاعات',10
                                            ,BaseColor,false),
                                  ),
                                      ],
                                    ) ),
                                ),
                              ):Container(),
                              CalenderBoxInformation(),
                            ],
                          ),
                          Payment_Ceck.pathCount>0&&FlagPayment==true?
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: BoxItemCalender2(Payment_Ceck.pathCount,Payment_Ceck.visitorCount),
                          ):Container(),


                          // DataCalender.details!=null?
                          // Padding(
                          //   padding: const EdgeInsets.all(4.0),
                          //   // child: CalenderBoxAllMonth( DataCalender.details),
                          // ):Container(),

                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
            Expanded(child:  Row(
              children: [
                // Icon(Icons.arrow_circle_left_sharp,size: 35,color:Color(0xffFFBC0F)),
                Expanded(
                    child: Container(
                      height: 60,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: 0.5,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          Container(
                            height: 40,
                            margin: EdgeInsets.all(4),

                            child: PageView.builder(
                                physics: CustomPageViewScrollPhysics(),
                                controller: _controllerMonth,
                                itemCount: Months.length,
                                onPageChanged: (Vall){
                                  MonthCounter=Vall+1;
                                },
                                reverse: true,
                                itemBuilder: (ctx,index){
                                  return  Container(child: Center(child: TextApp(Months[index],10,Color_Calender_Text,true)),margin: EdgeInsets.all(4));
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: 0.5,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: RotatedBox(
                                  quarterTurns: 90,
                                  child: Icon(Icons.arrow_drop_down,color: Colors.pinkAccent,size: 20,)),
                            ),
                          )
                        ],
                      ),)),
                Expanded(
                    child: Container(
                      height: 60,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: 0.5,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          Container(
                            height: 40,
                            margin: EdgeInsets.all(4),
                            child: PageView.builder(
                                physics: CustomPageViewScrollPhysics(),
                                controller: _controllerYear,
                                reverse: true,
                                onPageChanged: (Vall){
                                  YearCounter=Vall;
                                },
                                itemCount: Year.length,
                                itemBuilder: (ctx,index){
                                  return  Container(child: Center(child: TextApp(Year[index],10,Color_Calender_Text,true)),margin: EdgeInsets.all(4));
                                }),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            height: 0.5,
                            color: Colors.grey.withOpacity(0.5),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: RotatedBox(
                                  quarterTurns: 90,
                                  child: Icon(Icons.arrow_drop_down,color: Colors.red,size: 20,)),
                            ),
                          )
                        ],
                      ),)),
              ],
            ),),
            Expanded(
                flex: 1,
                child:
                Container(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: BaseColor),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  }, child:Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextApp('بستن',14,Colors.white,false),
                              ) ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: BaseColor),
                                  onPressed: (){

                                    GetData();
                                  }, child:Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: TextApp('نمایش',14,Colors.white,false),
                              ) ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}








