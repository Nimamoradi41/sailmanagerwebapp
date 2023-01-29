
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sailmanagerwebapp/ApiService.dart';
import 'package:sailmanagerwebapp/DataBseFile.dart';
import 'package:sailmanagerwebapp/ScreensArts/Art1.dart';
import 'package:sailmanagerwebapp/teeeee.dart';
import 'package:sailmanagerwebapp/tetstst.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../Responsive.dart';
import '../ScreensArts/Art2.dart';


import '../Constants.dart';
import 'MainMap.dart';
class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {




  TextEditingController txt_1 =TextEditingController();
  TextEditingController txt_2 =TextEditingController();
  TextEditingController txt_3 =TextEditingController();


  Future Run ()async{

    if(!address.startsWith('https://')&&!address.startsWith('http://'))
    {
      ApiService.ShowSnackbar('آدرس سرور اشتباه وارد شده است');
      return;
    }




    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(txt_2.text.isEmpty)
    {
      ApiService.ShowSnackbar('نام کاربری را وارد کنید');
      return;
    }


    if(txt_3.text.isEmpty)
    {
      ApiService.ShowSnackbar('رمز عبور را وارد کنید');
      return;
    }




    var  Login= await ApiService.Login(pr,address,txt_2.text,txt_3.text);


    if(Login!=null)
    {
       if(Login.res)
         {


           // prefs.setString("Baseurl", txt_1.text.toString());
           prefs.setString("Baseurl", address);
           prefs.setString("UserName", txt_2.text.toString());
           prefs.setString("Password", txt_3.text.toString());
           prefs.setBool("Login",true);
           prefs.setBool("Remember",Remember);
           pr.hide();
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (context) => MainMap()),
             // MaterialPageRoute(builder: (context) => LoginScreen()),
                 (Route<dynamic> route) => false,
           );




         }else
           {
             ApiService.ShowSnackbar(Login.msg);
           }
    }else{
      ApiService.ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }
      {}
  }





  bool Remember=false ;
  bool Personels=false ;
  var pr;

 String address='';
 Future  GetUser()async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   address = await rootBundle.loadString('AddressFolder/address.txt');
   address=address.trim();
   var UserName =prefs.getString('UserName');
   var login =prefs.getBool('Login');
   if(prefs.getBool('Personels')!=null)
     {
       Personels =prefs.getBool('Personels')!;
     }




   if(login!=null)
     {
       Remember=login;
     }


   if(UserName!=null)
   {
     txt_2.text=UserName;
   }




   setState(() {

   });
 }


  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Align(
            alignment: Alignment.topRight,
            child: Text('مجوز',textAlign: TextAlign.right,)),
        content:
        SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
                Text('برای خروج از فرم اطمینان دارید?',textAlign: TextAlign.end,),
              ],
            ),
          ),
        )
        ,
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('نه',style: TextStyle(fontSize: 16)),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('بله',style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    )) ?? false;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = ProgressDialog(context,type: ProgressDialogType.Normal,isDismissible: false);

    GetUser();
  }




  @override
  Widget build(BuildContext context) {
    final SizeApp=MediaQuery.of(context).size;
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Material(
           child:  Container(
             color: ColorBack,
             child: Stack(
               children: [
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     CustomPaint(
                       size: Size(SizeApp.width, (SizeApp.height*0.15).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                       painter: Art1(),
                     ),
                     CustomPaint(
                       size: Size(SizeApp.width, (SizeApp.height*0.15).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                       painter: Art3(),
                     ),
                   ],
                 ),
                 Align(
                   alignment: Alignment.topCenter,
                   child: Container(
                     width: Responsive.isDesktop(context)||Responsive.isTablet(context)?MediaQuery.of(context).size.width*2/4:double.infinity,
                     margin: EdgeInsets.only(top:SizeApp.height*0.07 ),
                     child: SingleChildScrollView(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Image.asset('images/slma.png',   width: SizeApp.height>=600 ? 100:50,
                               height: SizeApp.height>=600 ? 100:60),
                           Text('گروه نرم افزاری آتیران',
                             style: TextStyle(color: Color(0xff575757),
                                 fontSize: SizeApp.height>=600 ? 16:12 ,
                                 fontWeight: FontWeight.bold),),
                           // BoxInput('images/svg_aser.svg','آدرس سرور خود را وارد کنید','آدرس سرور',txt_1,SizeApp.height),
                           BoxInput('images/admin2.svg','نام کاربری خود را وارد کنید','نام کاربری',txt_2,SizeApp.height,false),
                           BoxInput('images/ghofl.svg','کلمه عبور خود را وارد کنید','کلمه عبور',txt_3,SizeApp.height,true),
                           Container(
                             margin: EdgeInsets.symmetric(horizontal: 16),
                             width: double.infinity,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.end,
                               children: [
                                 Expanded(child: Text(
                                   'مرا به خاطر بسپار',
                                   textAlign: TextAlign.end,
                                   style: TextStyle(
                                       color: BaseColor,
                                       fontSize: SizeApp.height>=600 ? 16:12  ,
                                       fontWeight: FontWeight.bold
                                   ),
                                 )),
                                 Theme(
                                   data: ThemeData(unselectedWidgetColor:  BaseColor),
                                   child: Checkbox(
                                       value: Remember,
                                       onChanged: (val){
                                         setState(() {
                                           Remember=!Remember;
                                         });
                                       }),
                                 )
                               ],
                             ),
                           ),
                           Container(
                             width:SizeApp.width>= 359? SizeApp.width/2:   double.infinity,
                             margin: EdgeInsets.only(right: 16,left: 16,top: 32),
                             child: ElevatedButton(onPressed: Run,
                                 style: ButtonStyle(
                                   backgroundColor: MaterialStateProperty.all(BaseColor),
                                   padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                         RoundedRectangleBorder(
                                             borderRadius: BorderRadius.circular(24.0),

                                         )
                                     )
                                 ),
                                 child:Text('ورود',
                               style: TextStyle(color:Colors.white,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold),)),
                           )
                         ],
                       ),
                     ),
                   ),
                 ),
                 Positioned(
                   right: 8,
                   bottom: 8,
                   child: Text('نسخه 2.0.4',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                     color: Colors.white,
                     fontSize: SizeApp.height>=600 ? 16:12
                   ),),
                 )
               ],
             ),
           )

      ),
    );




  }
}



class BoxInput extends StatelessWidget {
   String  Icone;

   String Hint;

   String Title;


   TextEditingController txtc;
   double SizeApp;
   bool Flagc;


   BoxInput(this.Icone, this.Hint, this.Title,this.txtc,this.SizeApp,this.Flagc);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal:  SizeApp>=600 ? 24:8  ,vertical: SizeApp>=600 ? 8:8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: BaseColor,width: 2),
        boxShadow: [
          BoxShadow(
            color: BaseColor.withOpacity(0.25),
            spreadRadius: 2,
            blurRadius: 8
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(Title,
              style: TextStyle(color: BaseColor,
                  fontSize: SizeApp>=600 ? 14:12  ,
                  fontWeight: FontWeight.bold),),
            Divider(height: 10,),
            Row(
              children: [
                Expanded(child: TextField(
                  controller: txtc,
                  obscureText: Flagc,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
              border: InputBorder.none,
              hintText:Hint,
                    hintStyle: TextStyle(
                        fontSize: SizeApp>=600 ? 12:10  ,
                      color: Color(0xffAEAEAE)
                    )
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(Icone,width: 15,height: 15,color: BaseColor,),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


