import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart'as http;
import 'package:sailmanagerwebapp/Models/CustGroup.dart';
import 'package:sailmanagerwebapp/Models/LoginModel.dart';

import 'Models/CustGroup.dart';
import 'Models/CustomerGroupModel.dart';
import 'Models/ListCustomer.dart';
import 'Models/ListPersonel.dart';
import 'Models/ModelAddPath.dart';
import 'Models/ModelCity.dart';
import 'Models/ModelCitys.dart';
import 'Models/ModelConfirm.dart';
import 'Models/ModelCopyDayPath.dart';
import 'Models/ModelCustomerNew.dart';
import 'Models/ModelDayPathCalendar.dart';
import 'Models/ModelDayWeek.dart';
import 'Models/ModelDetailFactor.dart';
import 'Models/ModelFactorsAll.dart';
import 'Models/ModelGroupProduct.dart';
import 'Models/ModelKalaNotSale.dart';
import 'Models/ModelNotSaleCustomer.dart';
import 'Models/ModelPIshfactorsNotAccept.dart';
import 'Models/ModelPathSumVis.dart';
import 'Models/ModelPaths.dart';
import 'Models/ModelProductSearch.dart';
import 'Models/ModelProvice.dart';
import 'Models/ModelProvinces.dart';
import 'Models/ModelRegion.dart';
import 'Models/ModelRegions.dart';
import 'Models/ModelReportVisitordaypath.dart';
import 'Models/ModelVisitorsAll.dart';
import 'Models/ModelVisitorsReport.dart';
import 'Models/ModelWay.dart';
import 'Models/ModelmassageVisitor.dart';
import 'Models/Modelpathvisitor.dart';
import 'Models/OfflineModel.dart';
import 'Models/OnlineModel.dart';
import 'Models/PishCustomer.dart';


class ApiService{

  static ShowSnackbar(String Msg){
    Fluttertoast.showToast(
        msg: Msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.black,
        backgroundColor: Colors.white,
        fontSize: 16.0
    );
  }



  static Future<LoginModel> Login(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;




    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl.trim().toString()+"/"+"Api/Atiran/login/login");

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=loginModelFromJson(data);

        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }

    pr.hide();
    return login;
  }




  static Future<OnlineModel> OnlinePeson(ProgressDialog pr,String Baseurl,String User,String Pass,String  VisRdf) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode(
        { "username":User,
      "password":Pass}) ;
    map['visId'] = VisRdf;



    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Online/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=onlineModelFromJson(data);

        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }

    pr.hide();
    return login;
  }



  static Future<OfflineModel> OfflinePeson(ProgressDialog pr,String Baseurl,String User,String Pass,String  VisRdf,String  Start, String End,String  Start_En, String End_En,String Page) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode(
        { "username":User,
          "password":Pass}) ;
    map['date'] = jsonEncode(
        {
          "fromDate":Start_En,
          "toDate":End_En,
          "fromDateFarsi":Start,
          "toDateFarsi":End}) ;
    map['visId'] = VisRdf;
    map['counter'] = Page;





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Ofline/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=offlineModelFromJson(data);


        if(DATA!=null)
        {
          // if(DATA.code==300)
          //   {
          //     if(DATA.msg.isNotEmpty)
          //     {
          //       ShowSnackbar(DATA.msg);
          //     }
          //   }

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }


    return login;
  }





  static Future<OfflineModel> OfflinePesona(ProgressDialog pr,String Baseurl,String User,String Pass,String  VisRdf) async{
    var login;



    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال ارتباط با سرور..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode(
        { "username":User,
          "password":Pass}) ;
    map['date'] = jsonEncode(
        {
          "fromDate":'2021/01/03',
          "toDate":'2021/10/03',
          "fromDateFarsi":'1400/10/10',
          "toDateFarsi":'1400/10/10'}) ;
    map['visId'] = VisRdf;
    map['counter'] = "0";





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Ofline/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=offlineModelFromJson(data);

        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }

    pr.hide();
    return login;
  }





  static Future<CustGroup2> CustGroup(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال دریافت گروه پرسنل..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;




    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
      final url = Uri.parse(Baseurl+'/'+'Api/Atiran/CustGroup/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=custGroupFromJson(data);

        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }

    pr.hide();
    return login;
  }




  static Future<ModelProvice> GetProvice(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال دریافت استان ها..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;




    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.127:33224/manager'+'/'+'Api/Atiran/Provice/List');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Provice/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=modelProviceFromJson(data);

        if(DATA.res==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }

    pr.hide();
    return login;
  }



  static Future<ModelCity> GetCity(String Baseurl,String User,String Pass,String proviceId,String name) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    // if(!pr.isShowing())
    // {
    //   pr.style(
    //     textAlign: TextAlign.center,
    //     message: 'درحال دریافت شهر ها..',
    //     messageTextStyle: TextStyle(
    //         fontFamily:  'iransans',
    //         fontSize: 14,
    //         color: Colors.black87),
    //   );
    //   await  pr.show();
    // }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;



    map['proviceId']=jsonEncode(proviceId);
    map['name']=jsonEncode(name);





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/City/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {


        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=modelCityFromJson(data);
        // var DATA=modelCityFromJson(data);
        // var DATA = json.decode(response.body);
        // var DATA=ModelCity.fromJson();

        if(DATA.res==true)
        {
          login= DATA;
        }else{
          login= DATA;
        }
      }else{


        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    } on SocketException catch (e)
    {


      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }


    return login;
  }



  static Future<ModelWay> GetWay(String Baseurl,String User,String Pass,String proviceId,String name) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    // if(!pr.isShowing())
    // {
    //   pr.style(
    //     textAlign: TextAlign.center,
    //     message: 'درحال دریافت شهر ها..',
    //     messageTextStyle: TextStyle(
    //         fontFamily:  'iransans',
    //         fontSize: 14,
    //         color: Colors.black87),
    //   );
    //   await  pr.show();
    // }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;



    map['idRegion']=jsonEncode(proviceId);
    map['name']=jsonEncode(name);





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Masir/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {


        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=modelWayFromJson(data);
        // var DATA=modelCityFromJson(data);
        // var DATA = json.decode(response.body);
        // var DATA=ModelCity.fromJson();

        if(DATA.res==true)
        {
          login= DATA;
        }else{
          login= DATA;
        }
      }else{


        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    } on SocketException catch (e)
    {


      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }


    return login;
  }

  static Future<ModelmassageVisitor> MessageTovisitor(ProgressDialog pr,String Baseurl,String User,String Pass,String Title,String Textms,bool ForcUpdate,List<int> visitors) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SendMessageVisitors');



    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['listVisId'] = visitors.toString() ;
    map['textMSG'] = jsonEncode(Textms);
    map['titleMSG'] = jsonEncode(Title);
    map['forceUPDATE'] = ForcUpdate.toString() ;






    print(map);

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        debugPrint("!!22");
        String data=response.body;

        print(data);
        var DATA=modelmassageVisitorFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        debugPrint("878787");
        debugPrint(response.statusCode.toString());

        String data=response.body;
        debugPrint(data.toString());
        pr.hide();
      }
    }catch (e)
    {

      debugPrint("!!");
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }
  static Future<ModelVisitorsAll> GetVisitorsAll(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/ListVisitors');



    debugPrint(url.toString());


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;







    debugPrint(map.toString());


    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        debugPrint("!!22");
        String data=response.body;

        print(data);
        var DATA=modelVisitorsAllFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        debugPrint("878787");
        debugPrint(response.statusCode.toString());
        String data=response.body;
        debugPrint(data.toString());
        pr.hide();
      }
    }catch (e)
    {

      debugPrint("!!");
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }
  static Future<ModelRegion> GetRegion(String Baseurl,String User,String Pass,String idCity,String name) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    // if(!pr.isShowing())
    // {
    //   pr.style(
    //     textAlign: TextAlign.center,
    //     message: 'درحال دریافت شهر ها..',
    //     messageTextStyle: TextStyle(
    //         fontFamily:  'iransans',
    //         fontSize: 14,
    //         color: Colors.black87),
    //   );
    //   await  pr.show();
    // }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;



    map['idCity']=jsonEncode(idCity);
    map['name']=jsonEncode(name);





    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Region/List');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {


        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=modelRegionFromJson(data);
        // var DATA=modelCityFromJson(data);
        // var DATA = json.decode(response.body);
        // var DATA=ModelCity.fromJson();

        if(DATA.res==true)
        {
          login= DATA;
        }else{
          login= DATA;
        }
      }else{


        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    } on SocketException catch (e)
    {


      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }


    return login;
  }
  static Future<ModelNotSaleCustomer> GetCustomerNotSale(ProgressDialog pr,String Baseurl,String User,String Pass,
      String toDate,String fromDate,List<int> productGroup,List<int> path,
      List<int> product,List<int> customerGroup,List<int> visitor) async{
    var login;


    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/CustomerNotSale');



    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();









    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;



    map['fromDate'] =
        jsonEncode(fromDate) ;


    map['toDate'] =
        jsonEncode(toDate) ;

    map['productGroup'] =
        jsonEncode(productGroup) ;

    map['visitor'] =
        jsonEncode(visitor) ;


    map['customerGroup'] =
        jsonEncode(customerGroup) ;


    map['product'] =
        jsonEncode(product) ;


    map['customerGroup'] =
        jsonEncode(customerGroup) ;

    map['path'] =
        jsonEncode(path) ;

























    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        print(data);

        var DATA=modelNotSaleCustomerFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.result!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{

        String data=response.body;

        pr.hide();
      }
    }catch (e)
    {

      debugPrint("!!");
      debugPrint(e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }
  static Future<ModelRegions> GetRegionsAll(String Baseurl,String User,String Pass,List<int> cityId) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/Regions');
    // final url = Uri.parse('http://172.10.10.186/AtiranKing/Cities');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'cityId': cityId.length==0?'': cityId.toString()
    });


    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {

        String data=await response.stream.bytesToString();
        var DATA=modelRegionsFromJson(data);


        if(DATA.result==true)
        {
          login= DATA;
        }else{

          login= DATA;
        }
      }else{
        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ModelCustomerNew> GetCustomerNew(ProgressDialog pr,String Baseurl,
      String User,String Pass,List<int> productGroup,String text) async{
    var login;








    var request = http.MultipartRequest('POST', Uri.parse('http://172.10.10.186/managersale/Api/Atiran/Customers'));
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'customerGroup': '$productGroup',
      'text': '$text'
    });


    print(request.fields.toString());

    http.StreamedResponse response = await request.send().timeout(
      const Duration(seconds: 30),
      onTimeout: () {

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      },
    );

    if (response.statusCode == 200) {
      String data=await response.stream.bytesToString();
      var DATA=modelCustomerNewFromJson(data);
      login=DATA;
    }
    else {
      print(response.reasonPhrase);
    }

    return login;
  }
  static Future<ModelProductSearch> GetProductNew(ProgressDialog pr,String Baseurl,
      String User,String Pass,List<int> productGroup,String text) async{
    var login;








    var request = http.MultipartRequest('POST', Uri.parse('http://172.10.10.186/managersale/Api/Atiran/Products'));
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'kaGroup': '$productGroup',
      'text': '$text'
    });


    print(request.fields.toString());

    http.StreamedResponse response = await request.send().timeout(
      const Duration(seconds: 30),
      onTimeout: () {

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      },
    );

    if (response.statusCode == 200) {
      String data=await response.stream.bytesToString();
      var DATA=modelProductSearchFromJson(data);
      login=DATA;
    }
    else {
      print(response.reasonPhrase);
    }

    return login;
  }
  static Future<ModelGroupProduct> GetGroupProduct(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/ProductGroups');



    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();









    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User, "password":Pass}) ;




















    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        debugPrint("!!22");
        String data=response.body;

        print(data);
        var DATA=modelGroupProductFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.result!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        debugPrint("878787");
        debugPrint(response.statusCode.toString());
        String data=response.body;
        debugPrint(data.toString());
        pr.hide();
      }
    }catch (e)
    {
      debugPrint(e.toString());
      debugPrint("!!");
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }
  static Future<CustomerGroupModel> CustomerGroup(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال دریافت گروه مشتری..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }



    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;




    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.38:33221/CRM'+'/'+'Api/Atiran/login/login');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/CustomerGroup');
    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 15),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=customerGroupModelFromJson(data);

        if(DATA.result!=null)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }

    pr.hide();
    return login;
  }
  static Future<ModelCopyDayPath> CopyDayPath(String Baseurl,String User,String Pass,String oldDate,String newDate) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/CopyDayPath');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'oldDate': oldDate.toString(),
      'newDate': newDate.toString(),
    });



    debugPrint(request.fields.toString());

    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {
        String data=await response.stream.bytesToString();
        var DATA=modelCopyDayPathFromJson(data);
        login=DATA;
      }else{
        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ModelKalaNotSale> GetProductNotSale(ProgressDialog pr,String Baseurl,String User,String Pass,
      String toDate,String fromDate,List<int> customerGroup,
      List<int> customers,List<int> path,List<int> visitor) async{
    var login;


    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/NotSoldProducts');



    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();









    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;



    map['fromDate'] =
        jsonEncode(fromDate) ;


    map['toDate'] =
        jsonEncode(toDate) ;

    map['customerGroup'] =
        jsonEncode(customerGroup) ;

    map['visitor'] =
        jsonEncode(visitor) ;


    map['path'] =
        jsonEncode(path) ;


    map['customers'] =
        jsonEncode(customers) ;


    map['customerGroup'] =
        jsonEncode(customerGroup) ;























    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        print(data);

        var DATA=modelKalaNotSaleFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.result!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{

        String data=response.body;

        pr.hide();
      }
    }catch (e)
    {

      debugPrint("!!");
      debugPrint(e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }
  static Future<ModelDayWeek> DayWeek(String Baseurl,String User,String Pass,String fromDate,String toDate) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/DayWeek');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'fromDate': fromDate.toString(),
      'toDate': toDate.toString(),
    });


    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {
        String data=await response.stream.bytesToString();
        var DATA=modelDayWeekFromJson(data);
        login=DATA;
      }else{
        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ModelReportVisitordaypath> VisitorDayPath(String Baseurl,String User,String Pass,String date) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/VisitorDayPath');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'date': date.toString(),
    });


    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {
        String data=await response.stream.bytesToString();
        var DATA=modelReportVisitordaypathFromJson(data);

        login=DATA;

      }else{

        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ModelAddPath> AddPath(String Baseurl,String User,String Pass,List<int> visitorId,String date,List<int> pathId) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/AddPath');
    // final url = Uri.parse('http://172.10.10.186/AtiranKing/Cities');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'pathId': pathId.length==0?'': pathId.toString(),
      'date': date.toString(),
      'visitorId': visitorId.toString(),
    });


    print(request.fields.toString());
    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {
        String data=await response.stream.bytesToString();
        var DATA=modelAddPathFromJson(data);

        login=DATA;

      }else{

        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ModelPaths> GetPathsAll(String Baseurl,String User,String Pass,List<int> regionId) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/Path');
    // final url = Uri.parse('http://172.10.10.186/AtiranKing/Cities');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'regionId': regionId.length==0?'': regionId.toString()
    });


    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {

        String data=await response.stream.bytesToString();
        var DATA=modelPathsFromJson(data);


        if(DATA.result==true)
        {
          login= DATA;
        }else{

          login= DATA;
        }
      }else{
        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ModelProvinces> GetProvices(ProgressDialog pr,String Baseurl,String User,String Pass) async{
    var login;
    // String Base= await  Getbaseurl();

    // final url = Uri.parse(Base+'/Sales');




    if(!pr.isShowing())
    {
      pr.style(
        textAlign: TextAlign.center,
        message: 'درحال دریافت استان ها..',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "username":User,
      "password":Pass}) ;





    debugPrint(map.toString());
    // final url = Uri.parse('http://172.10.10.3:9595/king/Sales');
    // print(url.toString());
    // final url = Uri.parse('http://91.108.148.127:33224/manager'+'/'+'Api/Atiran/Provice/List');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Provinces');

    try{
      Response response = await http.post(url,  body:map,
      ).timeout(
        Duration(seconds: 30),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        // return   ShowSnackbar(error.toString());
        // throw("some arbitrary error");
      }) ;


      if(response.statusCode==200)
      {

        String data=response.body;
        var DATA=modelProvincesFromJson(data);

        if(DATA.result==true)
        {

          login= DATA;
        }else{

          login= DATA;
        }
      }else{

        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');

      }
    } on SocketException catch (e)
    {

      pr.hide();
      login= null;
    }
    on TimeoutException catch (e) {


    } on Error catch (e) {

    }

    pr.hide();
    return login;
  }
  static Future<ModelCitys> GetCityAll(String Baseurl,String User,String Pass,List<int> Provice) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/Cities');
    // final url = Uri.parse('http://172.10.10.186/AtiranKing/Cities');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'provinceId': Provice.length==0?'': Provice.toString()
    });


    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {

        String data=await response.stream.bytesToString();
        var DATA=modelCitysFromJson(data);


        if(DATA.result==true)
        {
          login= DATA;
        }else{

          login= DATA;
        }
      }else{
        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ModelDayPathCalendar> DayPathCalendar(String Baseurl,String User,String Pass,String year,String month) async{
    var login;


    final url = Uri.parse(Baseurl+'/Api/Atiran/DayPathCalendar');
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({
      'login': '{"username" : "$User", "password": $Pass}',
      'year': year.toString(),
      'month': month.toString(),
    });



    print(request.fields.toString());

    try{
      http.StreamedResponse response = await request.send().timeout(
        Duration(seconds: 15),
        onTimeout: () {
          // pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        return   ShowSnackbar(error.toString());
      }) ;
      if(response.statusCode==200)
      {
        String data=await response.stream.bytesToString();
        var DATA=modelDayPathCalendarFromJson(data);
        login=DATA;
      }else{
        ShowSnackbar(response.reasonPhrase!!);
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      }
    }catch(E)
    {
      return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
    }












    // pr.hide();
    return login;
  }
  static Future<ListCustomer> GetCustomer(String Baseurl,String User,String Pass,
      String groupId,String provinceId,String cityId,
      String regeinId,String masirId,String name,String flagAccount,bool flagg,ProgressDialog pr,bool falgc) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Customer/List');

    // print('PageCounterCustomer is'+PageCounterCustomer.toString());
    // ignore: unrelated_type_equality_checks
    if(flagg==true)
    {
      pr.style(
        textAlign: TextAlign.center,
        message: ' درحال دریافت لیست مشتری    ',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      if (falgc)
      {
        await  pr.show();
      }
    }

    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;

    map['groupId']=jsonEncode(groupId);
    map['flagAccount']=jsonEncode(flagAccount);
    map['provinceId']=jsonEncode(provinceId);
    map['cityId']=jsonEncode(cityId);
    map['regeinId']=jsonEncode(regeinId);
    map['masirId']=jsonEncode(masirId);
    map['name']=jsonEncode(name);
    // map['countpage']=PageCounterCustomer;





    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {

          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {


        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=listCustomerFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        // pr.hide();
      }
    }

    catch (e)
    {

      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;


    }
    pr.hide();
    return login;
  }





  static Future<ListPersonel> GetPerson(String Baseurl,String User,String Pass) async{
    var login;

    // final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Personle/ListOnline');
    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Personle/ListOnline');


    // ignore: unrelated_type_equality_checks

      // pr.style(
      //   textAlign: TextAlign.center,
      //   message: ' درحال دریافت لیست پرسنل',
      //   messageTextStyle: TextStyle(
      //       fontFamily:  'iransans',
      //       fontSize: 14,
      //       color: Colors.black87),
      // );
      // await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;







    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),

      ).catchError((error) {
        // pr.hide();


        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=listPersonelFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{

        // pr.hide();
      }
    }catch (e)
    {

      login= null;
      // pr.hide();

    }
    return login;
  }



  static Future<PishCustomer> GetPishCustomer(ProgressDialog pr,String Baseurl,String User,String Pass,String custId) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/ListCustomer');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال دریافت لیست پیش دریافت های مشتری',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['custId'] =custId ;




    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=pishCustomerFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {

      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }


  static Future<ModelDetailFactor> GetDetailFactor(ProgressDialog pr,String Baseurl,String User,String Pass,String shFacfo) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/Details');


    // ignore: unrelated_type_equality_checks

      pr.style(
        textAlign: TextAlign.center,
        message: ' درحال دریافت اطلاعات فاکتور',
        messageTextStyle: TextStyle(
            fontFamily:  'iransans',
            fontSize: 14,
            color: Colors.black87),
      );
      await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['shFacfo'] =shFacfo ;




    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=modelDetailFactorFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {

      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }


  static Future<ModelConfirm> Confirm(ProgressDialog pr,String Baseurl,String User,String Pass,String shFacfo,bool Flag,String comment) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/Confirm/Confirm');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['confirm'] =
        jsonEncode({
          "flag":Flag,
          "shfacfo":shFacfo,
          "comment":comment}) ;





    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=modelConfirmFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {

      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }



  static Future<ModelFactorsAll> PishFactorsAlls(ProgressDialog pr,String Baseurl,String User,String Pass,String fromDate,String toDate,int flag) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/Report');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['date'] =
        jsonEncode({
          "fromDate":fromDate,
          "flag":flag,
          "toDate":toDate}) ;





    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=modelFactorsAllFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {

      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }



  static Future<ModelPIshfactorsNotAccept> PishFactorsNotAccept(ProgressDialog pr,String Baseurl,String User,String Pass,String DataFrom,String DateTo) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/SalePish/List');


    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال دریافت لیست پیش فاکتور های تایید تشده',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;


    map['date'] = jsonEncode({ "fromDate":DataFrom,
      "toDate":DateTo}) ;







    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();

        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {

        String data=response.body;

        var DATA=modelPIshfactorsNotAcceptFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        pr.hide();
      }
    }catch (e)
    {



      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }



  // ** /*************************************************


  static Future<Modelpathvisitor> GetVisitorsPath(ProgressDialog pr,String Baseurl,String User,String Pass,
      String toDate,String fromDate,List<int> listVisId,bool FlagMasirDay) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/ReportMasirDay');



    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();









    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;



    map['date'] =
        jsonEncode({ "toDate":toDate,
          "fromDate":fromDate}) ;


    map['listVisId'] = jsonEncode(listVisId);
    map['FlagMasirDay'] = jsonEncode(FlagMasirDay);







    print(map);




    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        debugPrint("!!22");
        String data=response.body;

        print(data);
        var DATA=ModelpathvisitorFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        debugPrint("878787");
        debugPrint(response.statusCode.toString());
        String data=response.body;
        debugPrint(data.toString());
        pr.hide();
      }
    }catch (e)
    {

      debugPrint("!!");
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }



  static Future<ModelPathSumVis> GetVisitorsPathSum(ProgressDialog pr,String Baseurl,String User,String Pass,
      String toDate,String fromDate,String listVisId) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/ReportMasirSumKalaDay');



    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();









    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;



    map['date'] =
        jsonEncode({ "toDate":toDate,
          "fromDate":fromDate}) ;


    map['VisId'] = jsonEncode(listVisId);








    print(map);




    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        debugPrint("!!22");
        String data=response.body;

        print(data);
        var DATA=ModelPathSumVisFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        debugPrint("878787");
        debugPrint(response.statusCode.toString());
        String data=response.body;
        debugPrint(data.toString());
        pr.hide();
      }
    }catch (e)
    {

      debugPrint("!!");
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }




  static Future<ModelVisitorsReport> GetVisitorsReport(ProgressDialog pr,String Baseurl,String User,
      String Pass,String toDate,String fromDate,List<int> listVisId,int
      FlagGhatee,bool FlagBargashti) async{
    var login;

    final url = Uri.parse(Baseurl+'/'+'Api/Atiran/TotalVisitorSales');



    // ignore: unrelated_type_equality_checks

    pr.style(
      textAlign: TextAlign.center,
      message: ' درحال ارتباط با سرور',
      messageTextStyle: TextStyle(
          fontFamily:  'iransans',
          fontSize: 14,
          color: Colors.black87),
    );
    await  pr.show();


    var map = new Map<String, dynamic>();
    map['login'] = jsonEncode({ "userName":User,
      "password":Pass}) ;

    map['date'] = jsonEncode({ "toDate":toDate,
      "fromDate":fromDate}) ;


    map['listVisId'] = jsonEncode(listVisId);
    map['FlagGhatee'] = jsonEncode(FlagGhatee);
    map['FlagBargashti'] = jsonEncode(FlagBargashti);







    print(map);

    try{
      Response response = await post(url,  body:map
        ,).timeout(
        Duration(seconds: 50),
        onTimeout: () {
          pr.hide();
          return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        },
      ).catchError((error) {
        pr.hide();
        debugPrint("!!444");
        return   ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
        throw("some arbitrary error");
      });;
      if(response.statusCode==200)
      {
        debugPrint("!!22");
        String data=response.body;

        print(data);
        var DATA=ModelVisitorsReportFromJson(data);

        // ignore: unnecessary_null_comparison

        if(DATA.res!=null)
        {
          // pr.hide();
          login= DATA;
        }else{
          // pr.hide();
          login= DATA;
        }
      }else{
        debugPrint("878787");
        debugPrint(response.statusCode.toString());
        String data=response.body;
        debugPrint(data.toString());
        pr.hide();
      }
    }catch (e)
    {

      debugPrint("!!");
      debugPrint(e.toString());
      ShowSnackbar('مشکلی در ارتباط با سرور به وجود آمده است');
      login= null;
      pr.hide();

    }
    return login;
  }



}