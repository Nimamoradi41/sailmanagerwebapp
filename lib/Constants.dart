import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final Color Color_ListCustomerLight=const   Color(0xff7B7B7B);
final Color Color_ListCustomerDark=const   Color(0xff211F1F);
final Color Color_ListCustomerLine=const   Color(0xffEFEFEF);

final BoxDecoration AutoBox=BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8)),
    boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            offset: Offset(0,0),
            blurRadius: 2,
            spreadRadius: 2
        )
    ]
);
final Color Color_Mosbat=const Color(0xff2ccb10);
final Color Color_Manfi=const   Color(0xffc60000);
final Color Color_Calender_Text=const   Color(0xff494949);
final Color Color_Calender_Red=const   Color(0xffFF0505);
final Color Color_Calender_Blue=const   Color(0xff0ead69);
    final Color BaseColor=const Color(0xff3D4785);
    final Color ColorLine=const Color(0xffEFEFEF);
    final Color ColorBack=const Color(0xffF1F7FE);
    final Color ColorFirst=const Color(0xff8E8E8E);
    final Color ColorSecond=const Color(0xff414141);
    final double SizeFirst=  11;
    final double SizeSecond=  13;
    final double SizeResponsive=  9;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;


String SplitPrice2(dynamic price){
    var f = NumberFormat("##.##", "en_US");
    return   f.format(price).toString();
}

String SplitPrice(dynamic price){
    var f = NumberFormat("###,###,###,###", "en_US");
    return   f.format(price).toString();
}
String    Convert_DATE(String day,String month,String year)
{
    var temp_day="";
    var temp_mont="";
    if (day.length==1)
    {
        temp_day="0"+day;
    }else{
        temp_day=day;
    }
    if (month.length==1)
    {
        temp_mont="0"+month;
    }else{
        temp_mont=month;
    }





    return  (year+"/"+temp_mont+"/"+temp_day).toString();


}

