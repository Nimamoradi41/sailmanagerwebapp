import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


    final Color BaseColor=const Color(0xff3D4785);
    final Color ColorLine=const Color(0xffEFEFEF);
    final Color ColorBack=const Color(0xffF1F7FE);
    final Color ColorFirst=const Color(0xff8E8E8E);
    final Color ColorSecond=const Color(0xff414141);
    final double SizeFirst=  11;
    final double SizeSecond=  13;
    final double SizeResponsive=  9;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

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

